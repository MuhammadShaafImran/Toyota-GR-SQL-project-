/*==============================================================
   PROCEDURE: Load Silver Layer from Bronze (Race 1 Example)
==============================================================*/

DROP PROCEDURE IF EXISTS silver.sp_load_race1;
GO

CREATE PROCEDURE silver.sp_load_race1
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        /*==========================================================
          STEP 1: Insert Race Record
        ==========================================================*/

        IF NOT EXISTS (
            SELECT 1 FROM silver.dim_race 
            WHERE race_number = 1
        )
        BEGIN
            INSERT INTO silver.dim_race (race_name, race_number, race_date)
            VALUES ('Barber Motorsport Race', 1, GETDATE());
        END

        DECLARE @race_id INT =
            (SELECT race_id FROM silver.dim_race WHERE race_number = 1);


        /*==========================================================
          STEP 2: Load Drivers (Unique)
        ==========================================================*/

        INSERT INTO silver.dim_driver (car_number, vehicle, class, manufacturer)
        SELECT DISTINCT
            b.number,
            b.vehicle,
            b.class,
            b.vehicle  -- placeholder manufacturer
        FROM bronze.barber_prov_res_r1 b
        WHERE NOT EXISTS (
            SELECT 1
            FROM silver.dim_driver d
            WHERE d.car_number = b.number
        );


        /*==========================================================
          STEP 3: Load Race Results
        ==========================================================*/

        INSERT INTO silver.fact_race_result (
            race_id,
            driver_id,
            finishing_position,
            laps_completed,
            total_time_sec,
            status,
            fastest_lap_sec
        )
        SELECT
            @race_id,
            d.driver_id,
            b.position,
            b.laps,

            -- Convert total_time VARCHAR ? seconds
            NULL,  -- placeholder, needs parsing logic

            b.status,

            -- Convert fastest lap VARCHAR ? seconds
            NULL
        FROM bronze.barber_prov_res_r1 b
        JOIN silver.dim_driver d
            ON d.car_number = b.number
        WHERE NOT EXISTS (
            SELECT 1 FROM silver.fact_race_result r
            WHERE r.race_id = @race_id
              AND r.driver_id = d.driver_id
        );


        /*==========================================================
          STEP 4: Load Lap Performance Data
        ==========================================================*/

        INSERT INTO silver.fact_lap (
            race_id,
            driver_id,
            lap_number,
            lap_time_sec,
            s1_sec,
            s2_sec,
            s3_sec,
            avg_speed_kph,
            top_speed_kph,
            pit_time_sec,
            flag
        )
        SELECT
            @race_id,
            d.driver_id,
            a.lap_number,

            -- Convert lap_time VARCHAR ? seconds
            TRY_CAST(REPLACE(a.lap_time, ':', '.') AS DECIMAL(8,3)),

            TRY_CAST(a.s1_seconds AS DECIMAL(8,3)),
            TRY_CAST(a.s2_seconds AS DECIMAL(8,3)),
            TRY_CAST(a.s3_seconds AS DECIMAL(8,3)),

            a.kph,
            a.top_speed,

            NULL,  -- pit_time conversion later
            a.flag_at_fl

        FROM bronze.barber_analysis_r1 a
        JOIN silver.dim_driver d
            ON d.car_number = a.number
        WHERE NOT EXISTS (
            SELECT 1 FROM silver.fact_lap f
            WHERE f.race_id = @race_id
              AND f.driver_id = d.driver_id
              AND f.lap_number = a.lap_number
        );


        /*==========================================================
          STEP 5: Load Weather Data
        ==========================================================*/

        INSERT INTO silver.dim_weather (
            race_id,
            time_utc,
            air_temp,
            track_temp,
            humidity,
            wind_speed,
            rain
        )
        SELECT
            @race_id,
            TRY_CAST(time_utc_str AS DATETIME2),
            air_temp,
            track_temp,
            humidity,
            wind_speed,
            rain
        FROM bronze.baber_weather_r1;


        COMMIT TRANSACTION;

        PRINT 'Silver Load Completed Successfully for Race 1';

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT 'Silver Load Failed';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO
