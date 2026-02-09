
---------------------------------------------------------------------
-- Table: Events
---------------------------------------------------------------------
IF OBJECT_ID('bronze.events', 'U') IS NULL
        BEGIN
    CREATE TABLE silver.events
    (
        event_id INT IDENTITY(1,1) PRIMARY KEY,
        event_name NVARCHAR(200),
        load_datetime DATETIME DEFAULT GETDATE()
    );
END

---------------------------------------------------------------------
-- Table: Races
---------------------------------------------------------------------
IF OBJECT_ID('bronze.races', 'U') IS NULL
        BEGIN
    CREATE TABLE bronze.races
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        -- event_id INT FOREIGN KEY REFERENCES silver.events(event_id),
        race_number INT,
        load_datetime DATETIME DEFAULT GETDATE()
    );
END