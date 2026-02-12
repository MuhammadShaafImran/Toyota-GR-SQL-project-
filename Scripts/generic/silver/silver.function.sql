
-------------------------------------------------------------
-- Function : Convert time string to seconds
-------------------------------------------------------------
create or alter function silver.fn_time_to_seconds
(
    @time_str nvarchar(50)
)
returns decimal(10,3)
as
begin
    declare @seconds decimal(10,3);

    if @time_str is null
        return null;

    SET @time_str = REPLACE(@time_str, '''', ':');

    -- count how many ':' are in the string
    declare @colon_count int = len(@time_str) - len(replace(@time_str, ':', ''));

    if @colon_count = 0
    begin
        -- format: ss.mmm
        set @seconds = cast(parsename(@time_str, 2) + '.' + parsename(@time_str,1) as decimal(10,3));
    end
    else if @colon_count = 1
    begin
        -- format: m:ss.mmm
        set @seconds = cast(parsename(replace(@time_str, ':', '.'), 2) as int) * 60 +
                    cast(parsename(replace(@time_str, ':', '.'), 1) as decimal(10,3));
    end
    else if @colon_count = 2
    begin
        -- format: h:mm:ss.mmm
        set @seconds = cast(parsename(replace(@time_str, ':', '.'), 3) as int) * 3600 +
                    cast(parsename(replace(@time_str, ':', '.'), 2) as int) * 60 +
                    cast(parsename(replace(@time_str, ':', '.'), 1) as decimal(10,3));
    end
    else
    begin
        -- unexpected format, return NULL
        set @seconds = null;
    end

    return @seconds;
end;

GO

-------------------------------------------------------------
-- View : Build dynamic event 
-------------------------------------------------------------

CREATE OR ALTER PROCEDURE silver.Build_Event_View
    (
    @SourceSchema SYSNAME,
    @SourceTable  SYSNAME,
    @ViewSchema   SYSNAME,
    @ViewName     SYSNAME
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @cols NVARCHAR(MAX);
    DECLARE @sql  NVARCHAR(MAX);

    -------------------------------------------------------------
    -- Step 1: Build dynamic column list
    -------------------------------------------------------------
    SELECT @cols = STRING_AGG(
            CAST(
                '(''' + COLUMN_NAME + ''', CAST(' + QUOTENAME(COLUMN_NAME) + ' AS NVARCHAR(MAX)))'
                AS NVARCHAR(MAX)
            ),
            ','
        )
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @SourceSchema
        AND TABLE_NAME   = @SourceTable
        AND (
            COLUMN_NAME LIKE '%\_points' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_pole_points' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_fastest_lap_points' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_status' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_total_extra_points' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_extra_participation_points' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_extra_participation_invalid' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_extra_not_started_points' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_extra_not_started_invalid' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_extra_not_classified_points' ESCAPE '\'
        OR COLUMN_NAME LIKE '%\_extra_not_classified_invalid' ESCAPE '\'
    );

    -------------------------------------------------------------
    -- Step 2: Build dynamic transformation query
    -------------------------------------------------------------
    SET @sql = '
    CREATE OR ALTER VIEW ' + QUOTENAME(@ViewSchema) + '.' + QUOTENAME(@ViewName) + ' AS
    WITH Unpivoted AS (
        SELECT 
            m.Id,
            v.ColName,
            v.Value,
            LEFT(v.ColName, CHARINDEX(''_'', v.ColName) - 1) AS EventName,
            SUBSTRING(v.ColName, CHARINDEX(''_'', v.ColName) + 1, LEN(v.ColName)) AS RemainingPart
        FROM ' + QUOTENAME(@SourceSchema) + '.' + QUOTENAME(@SourceTable) + ' m
        CROSS APPLY (VALUES ' + @cols + ') v(ColName, Value)
    ),
    Parsed AS (
        SELECT
            Id,
            EventName,
            LEFT(RemainingPart, CHARINDEX(''_'', RemainingPart) - 1) AS RaceCode,
            SUBSTRING(RemainingPart, CHARINDEX(''_'', RemainingPart) + 1, LEN(RemainingPart)) AS AttributeName,
            Value
        FROM Unpivoted
    )
    SELECT
        Id,
        EventName,
        CAST(SUBSTRING(RaceCode, 2, LEN(RaceCode)) AS INT) AS race_no,

        MAX(CASE 
            WHEN AttributeName = ''points'' THEN 
                CASE WHEN Value = ''/'' THEN -1 ELSE TRY_CAST(Value AS INT) END
        END) AS event_points,

        MAX(CASE WHEN AttributeName = ''pole_points'' THEN TRY_CAST(Value AS INT) END) AS pole_points,
        MAX(CASE WHEN AttributeName = ''fastest_lap_points'' THEN TRY_CAST(Value AS INT) END) AS fastest_lap_points,

        MAX(CASE 
            WHEN AttributeName = ''status'' THEN 
                CASE WHEN Value = ''/'' THEN ''DNS'' ELSE Value END
        END) AS event_status,

        MAX(CASE WHEN AttributeName = ''total_extra_points'' THEN TRY_CAST(Value AS INT) END) AS total_extra_points,
        MAX(CASE WHEN AttributeName = ''extra_participation_points'' THEN TRY_CAST(Value AS INT) END) AS extra_participation_points,
        MAX(CASE WHEN AttributeName = ''extra_participation_invalid'' THEN TRY_CAST(Value AS INT) END) AS extra_participation_invalid,
        MAX(CASE WHEN AttributeName = ''extra_not_started_points'' THEN TRY_CAST(Value AS INT) END) AS extra_not_started_points,
        MAX(CASE WHEN AttributeName = ''extra_not_started_invalid'' THEN TRY_CAST(Value AS INT) END) AS extra_not_started_invalid,
        MAX(CASE WHEN AttributeName = ''extra_not_classified_points'' THEN TRY_CAST(Value AS INT) END) AS extra_not_classified_points,
        MAX(CASE WHEN AttributeName = ''extra_not_classified_invalid'' THEN TRY_CAST(Value AS INT) END) AS extra_not_classified_invalid

    FROM Parsed
    GROUP BY Id, EventName, RaceCode;
    ';

    EXEC sp_executesql @sql;
END