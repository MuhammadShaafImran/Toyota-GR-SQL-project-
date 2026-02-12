DECLARE @TableName SYSNAME;
DECLARE @SQL NVARCHAR(MAX);

-- Cursor declaration
DECLARE drop_table_cursor CURSOR LOCAL FAST_FORWARD FOR
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'bronze' -- Specify your schema here (bronze, silver, gold)
  AND TABLE_TYPE = 'BASE TABLE';

-- Open cursor
OPEN drop_table_cursor;

-- Fetch first table
FETCH NEXT FROM drop_table_cursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'DROP TABLE bronze.' + QUOTENAME(@TableName);
    
    PRINT @SQL;      -- For debugging
    EXEC sp_executesql @SQL;

    FETCH NEXT FROM drop_table_cursor INTO @TableName;
END;

-- Cleanup
CLOSE drop_table_cursor;
DEALLOCATE drop_table_cursor;
PRINT 'All bronze tables dropped successfully.';
