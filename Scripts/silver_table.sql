/*==============================================================
   SILVER LAYER TABLE CREATION
==============================================================*/

BEGIN TRY
    BEGIN TRANSACTION;

    /*----------------------------------------------------------
      Create Schema
    ----------------------------------------------------------*/
    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver')
        EXEC('CREATE SCHEMA silver');


    /*==========================================================
      DIMENSION TABLES
    ==========================================================*/

    /*----------------------------------------------------------
      Race Dimension
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS silver.dim_race;
    CREATE TABLE silver.dim_race (
        race_id        INT IDENTITY PRIMARY KEY,
        race_name      VARCHAR(100),
        race_number    INT,       
        race_date      DATE
    );


    /*----------------------------------------------------------
      Driver Dimension
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS silver.dim_driver;
    CREATE TABLE silver.dim_driver (
        driver_id      INT IDENTITY PRIMARY KEY,
        car_number     INT NOT NULL,
        vehicle        VARCHAR(50),
        class          VARCHAR(10),
        manufacturer   VARCHAR(50)
    );


    /*----------------------------------------------------------
      Weather Dimension
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS silver.dim_weather;
    CREATE TABLE silver.dim_weather (
        weather_id     INT IDENTITY PRIMARY KEY,
        race_id        INT NOT NULL,

        time_utc       DATETIME2,
        air_temp       DECIMAL(5,2),
        track_temp     DECIMAL(5,2),
        humidity       DECIMAL(5,2),
        wind_speed     DECIMAL(5,2),
        rain           BIT,

        CONSTRAINT fk_weather_race
            FOREIGN KEY (race_id)
            REFERENCES silver.dim_race(race_id)
    );


    /*==========================================================
      FACT TABLES
    ==========================================================*/

    /*----------------------------------------------------------
      Race Results Fact Table
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS silver.fact_race_result;
    CREATE TABLE silver.fact_race_result (
        race_id              INT NOT NULL,
        driver_id            INT NOT NULL,

        finishing_position   INT,
        laps_completed       INT,
        total_time_sec       DECIMAL(10,3),
        status               VARCHAR(25),

        fastest_lap_sec      DECIMAL(8,3),

        PRIMARY KEY (race_id, driver_id),

        CONSTRAINT fk_result_race
            FOREIGN KEY (race_id)
            REFERENCES silver.dim_race(race_id),
        CONSTRAINT fk_result_driver
            FOREIGN KEY (driver_id)
            REFERENCES silver.dim_driver(driver_id)
    );


    /*----------------------------------------------------------
      Lap Performance Fact Table
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS silver.fact_lap;
    CREATE TABLE silver.fact_lap (
        race_id         INT NOT NULL,
        driver_id       INT NOT NULL,
        lap_number      INT NOT NULL,

        lap_time_sec    DECIMAL(8,3),
        s1_sec          DECIMAL(8,3),
        s2_sec          DECIMAL(8,3),
        s3_sec          DECIMAL(8,3),

        avg_speed_kph   DECIMAL(6,2),
        top_speed_kph   DECIMAL(6,2),

        pit_time_sec    DECIMAL(8,3),
        flag            VARCHAR(10),

        PRIMARY KEY (race_id, driver_id, lap_number),

        CONSTRAINT fk_lap_race
            FOREIGN KEY (race_id)
            REFERENCES silver.dim_race(race_id),

        CONSTRAINT fk_lap_driver
            FOREIGN KEY (driver_id)
            REFERENCES silver.dim_driver(driver_id)
    );


    /*----------------------------------------------------------
      Telemetry Fact Table
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS silver.fact_telemetry;
    CREATE TABLE silver.fact_telemetry (
        telemetry_id     BIGINT IDENTITY PRIMARY KEY,

        race_id          INT NOT NULL,
        driver_id        INT NOT NULL,
        lap_number       INT,

        timestamp_utc    DATETIME2,

        telemetry_name   VARCHAR(50),
        telemetry_value  FLOAT,

        CONSTRAINT fk_tel_race
            FOREIGN KEY (race_id)
            REFERENCES silver.dim_race(race_id),

        CONSTRAINT fk_tel_driver
            FOREIGN KEY (driver_id)
            REFERENCES silver.dim_driver(driver_id)
    );


    /*==========================================================
      AGGREGATED SILVER SUMMARY TABLES
    ==========================================================*/

    /*----------------------------------------------------------
      Driver Pace Summary
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS silver.driver_pace_summary;
    CREATE TABLE silver.driver_pace_summary (
        race_id            INT NOT NULL,
        driver_id          INT NOT NULL,

        avg_lap_time_sec   DECIMAL(8,3),
        best_lap_time_sec  DECIMAL(8,3),
        lap_std_dev_sec    DECIMAL(8,3),

        PRIMARY KEY (race_id, driver_id),

        CONSTRAINT fk_summary_race
            FOREIGN KEY (race_id)
            REFERENCES silver.dim_race(race_id),

        CONSTRAINT fk_summary_driver
            FOREIGN KEY (driver_id)
            REFERENCES silver.dim_driver(driver_id)
    );


    COMMIT TRANSACTION;
    PRINT 'Silver Layer Created Successfully.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;

    PRINT 'Silver Layer Creation Failed.';
    PRINT ERROR_MESSAGE();
END CATCH;
