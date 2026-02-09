---------------------------------------------------
-- Procedure: bronze.load_raw_data
-- Description: Loads raw data files into corresponding bronze tables based on file naming conventions.
---------------------------------------------------

CREATE OR ALTER PROCEDURE bronze.load_raw_data
(
    @file_path NVARCHAR(500)
)
AS
BEGIN

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE 
            @sql NVARCHAR(MAX),
            @file_name NVARCHAR(260),
            @table_name NVARCHAR(128),
            @staging_table NVARCHAR(128),
            @relative_path NVARCHAR(500),
            @data_folder NVARCHAR(50) = '\data\',
            @race_id INT,
            @column_list NVARCHAR(MAX),
            @pos INT,
            @race_no INT,
            @insert_sql NVARCHAR(MAX);

        ---------------------------------------------------------
        -- 1. Extract file name
        ---------------------------------------------------------
        SET @file_name = RIGHT(@file_path, CHARINDEX('\', REVERSE(@file_path)) - 1);

        ---------------------------------------------------------
        -- 2. Extract relative path
        ---------------------------------------------------------
        SET @pos = CHARINDEX(@data_folder, @file_path);

        IF @pos > 0
            SET @relative_path = SUBSTRING(@file_path, @pos + LEN(@data_folder), LEN(@file_path));
        ELSE
            SET @relative_path = @file_path;

        PRINT 'Relative path: ' + @relative_path;

        ---------------------------------------------------------
        -- 3. Determine target table
        ---------------------------------------------------------
        IF LOWER(@file_name) LIKE '%weather%'
            SET @table_name = 'bronze.weather';
        ELSE IF LOWER(@file_name) LIKE '%analysis%'
            SET @table_name = 'bronze.analysis_endurance';
        ELSE IF LOWER(@file_name) LIKE '%class%'
            SET @table_name = 'bronze.prov_off_results_class';
        ELSE IF LOWER(@file_name) LIKE '%provisional%' OR LOWER(@file_name) LIKE '%official%'
            SET @table_name = 'bronze.prov_off_results';
        ELSE IF LOWER(@file_name) LIKE '%99_best_10_laps_by_driver%'
            SET @table_name = 'bronze.top_10_laps';
        ELSE IF LOWER(@file_name) LIKE '%gr_teams%'
            SET @table_name = 'bronze.teams_championship';
        ELSE
            BEGIN
                PRINT 'Skipping unknown file type: ' + @file_name;
                ROLLBACK TRANSACTION;
                RETURN;
            END;

        PRINT 'Target table: ' + @table_name;

        ---------------------------------------------------------
        -- 4. Extract race_no (supports multi-digit)
        ---------------------------------------------------------
        IF @table_name <> 'bronze.teams_championship'
        BEGIN
            SET @race_no = SUBSTRING(@file_path, CHARINDEX('RACE ', @file_path) + 5, 1)

            IF @race_no IS NULL
                THROW 50003, 'Could not parse race_no.', 1;

            PRINT 'Detected race_no: ' + CAST(@race_no AS NVARCHAR(10));
        END

        ---------------------------------------------------------
        -- 5. Get column mapping
        ---------------------------------------------------------
        SELECT @column_list = column_list
        FROM bronze.bulk_map
        WHERE target_table = @table_name;

        IF @column_list IS NULL
            THROW 50004, 'Column mapping missing in bronze.bulk_map.', 1;

        ---------------------------------------------------------
        -- 6. Build, Load, Insert
        ---------------------------------------------------------

        IF @table_name = 'bronze.teams_championship'
        BEGIN
            SET @insert_sql = '
                INSERT INTO ' + @table_name + '
                (' + @column_list + ', source_file)
                SELECT ' + @column_list + ',
                    ''' + @relative_path + '''
                FROM #staging;
            ';
        END
        ELSE
        BEGIN
            SET @insert_sql = '
                INSERT INTO ' + @table_name + '
                (race_no, ' + @column_list + ', source_file)
                SELECT ' + CAST(@race_no AS NVARCHAR(10)) + ',
                    ' + @column_list + ',
                    ''' + @relative_path + '''
                FROM #staging;
            ';
        END


        SET @sql = '
            BEGIN TRY

                SELECT TOP 0 ' + @column_list + '
                INTO #staging
                FROM ' + @table_name + ';

                BULK INSERT #staging
                FROM ''' + @file_path + '''
                WITH (
                    FIRSTROW = 2,
                    FIELDTERMINATOR = '';'',
                    ROWTERMINATOR = '';\n'',
                    TABLOCK
                );

                ' + @insert_sql + '
            END TRY
            BEGIN CATCH
                PRINT ''Error in dynamic SQL: '' + ERROR_MESSAGE();
                THROW;
            END CATCH
        ';

        IF @sql IS NULL
            THROW 50000, 'Dynamic SQL is NULL', 1;
            
        EXEC sp_executesql @sql;

        ---------------------------------------------------------
        -- 9. Cleanup
        ---------------------------------------------------------
        SET @sql = 'DROP TABLE ' + @staging_table + ';';
        EXEC sp_executesql @sql;

        COMMIT TRANSACTION;
        PRINT 'Load completed successfully.';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        THROW 50010, @Err, 1;
    END CATCH
END;

GO 

---------------------------------------------------
-- Procedure: bronze.load_drivers_championship
-- Description: Loads raw data files into corresponding bronze tables based on file naming conventions.
---------------------------------------------------

CREATE OR ALTER PROCEDURE bronze.load_drivers_championship
(
    @file_path NVARCHAR(500),
    @file_type INT = 1 -- 1 for regular, 2 for missing data format
)
AS
BEGIN

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE 
            @sql NVARCHAR(MAX),
            @table_name NVARCHAR(128),
            @data_folder NVARCHAR(50) = '\data\',
            @relative_path NVARCHAR(500),
            @column_list NVARCHAR(MAX),
            @pos INT;

        ---------------------------------------------------------
        -- 2. Extract relative path
        ---------------------------------------------------------
        SET @pos = CHARINDEX(@data_folder, @file_path);

        IF @pos > 0
            SET @relative_path = SUBSTRING(@file_path, @pos + LEN(@data_folder), LEN(@file_path));
        ELSE
            SET @relative_path = @file_path;

        PRINT 'Relative path: ' + @relative_path;

        ---------------------------------------------------------
        -- 3. Determine target table
        ---------------------------------------------------------
        
        SET @table_name = 'bronze.drivers_championship';
        PRINT 'Target table: ' + @table_name;

        ---------------------------------------------------------
        -- 5. Get column mapping
        ---------------------------------------------------------
        SELECT @column_list = column_list
        FROM bronze.bulk_map
        WHERE target_table = @table_name;

        IF @column_list IS NULL
            THROW 50004, 'Column mapping missing in bronze.bulk_map.', 1;
        
        IF @file_type = 2
        BEGIN
            SET @column_list = REPLACE(@column_list, ',name', '');
            SET @column_list = REPLACE(@column_list, ',surname', '');
            SET @column_list = REPLACE(@column_list, ',country', '');
            SET @column_list = REPLACE(@column_list, ',team', '');
            SET @column_list = REPLACE(@column_list, ',manufacturer', '');
            SET @column_list = REPLACE(@column_list, ',class', '');
        END
        ---------------------------------------------------------
        -- 6. Build, Load, Insert
        ---------------------------------------------------------

        SET @sql = '
            BEGIN TRY

                SELECT TOP 0 ' + @column_list + '
                INTO #staging
                FROM ' + @table_name + ';

                BULK INSERT #staging
                FROM ''' + @file_path + '''
                WITH (
                    FIRSTROW = 2,
                    FIELDTERMINATOR = '';'',
                    ROWTERMINATOR = '';\n'',
                    TABLOCK
                );

                INSERT INTO ' + @table_name + '
                (' + @column_list + ', source_file)
                SELECT
                    ' + @column_list + ',
                    ''' + @relative_path + '''
                FROM #staging;

            END TRY
            BEGIN CATCH
                PRINT ''Error in dynamic SQL: '' + ERROR_MESSAGE();
                THROW;
            END CATCH
        ';

        IF @sql IS NULL
            THROW 50000, 'Dynamic SQL is NULL in driver championship', 1;
            
        EXEC sp_executesql @sql;

        COMMIT TRANSACTION;
        PRINT 'Driver load completed successfully.';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        THROW 50010, @Err, 1;
    END CATCH
END;

