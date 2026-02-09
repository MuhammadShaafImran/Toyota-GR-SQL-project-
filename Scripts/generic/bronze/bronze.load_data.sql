-----------------------------------------------------------------
-- Create bronze tables
-----------------------------------------------------------------

EXEC bronze.create_tables;

-----------------------------------------------------------------
-- Insert into bronze.bulk_map
-----------------------------------------------------------------
TRUNCATE TABLE bronze.bulk_map;

INSERT INTO bronze.bulk_map(target_table, column_list)
SELECT
    TABLE_SCHEMA + '.' + TABLE_NAME AS target_table,
    STRING_AGG(CAST(COLUMN_NAME AS VARCHAR(MAX)), ',') WITHIN GROUP (ORDER BY ORDINAL_POSITION)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'bronze'
AND TABLE_NAME <> 'bulk_map'
AND COLUMN_NAME NOT IN ('race_no','id','source_file','load_datetime')
GROUP BY TABLE_SCHEMA, TABLE_NAME
ORDER BY TABLE_NAME;


-----------------------------------------------------------------
-- Load data though load_script.ps1
-----------------------------------------------------------------
-- ./load_script.ps1

-----------------------------------------------------------------
-- Insert to bronze.driver_championship
-----------------------------------------------------------------

EXEC bronze.load_drivers_championship 'D:\Toyota GR (SQL project)\data\Barber Motorsports Park\GR_Driver_Championship.csv';
EXEC bronze.load_drivers_championship 'D:\Toyota GR (SQL project)\data\Indianapolis Motor Speedway RC\GR_Drivers_Championship_1.csv';
EXEC bronze.load_drivers_championship 'D:\Toyota GR (SQL project)\data\Road America\GR_Drivers_Championship.csv';

--------------------------------------------------------------------------------------
-- some missing data columns
--------------------------------------------------------------------------------------
EXEC bronze.load_drivers_championship 'D:\Toyota GR (SQL project)\data\Circuit of the Americas\GR_Drivers_Championship.csv', 2;
EXEC bronze.load_drivers_championship 'D:\Toyota GR (SQL project)\data\VIRginia International Raceway\GR_Drivers_Championship.csv', 2;
