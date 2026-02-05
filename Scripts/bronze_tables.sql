/*==============================================================
  BRONZE LAYER TABLE CREATION
==============================================================*/

BEGIN TRY
    BEGIN TRANSACTION;

    /*----------------------------------------------------------
      Check Schema Exists
    ----------------------------------------------------------*/
    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
        EXEC('CREATE SCHEMA bronze');

    -- TABLES

    /*----------------------------------------------------------
      Provisional Results - Race 1
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_prov_res_r1;
    CREATE TABLE bronze.barber_prov_res_r1 (
        position            INT,
        number              INT,
        status              VARCHAR(25),
        laps                INT,
        total_time          VARCHAR(25),
        gap_first           VARCHAR(25),
        gap_previous        VARCHAR(25),
        fl_lapnum           INT,
        fl_time             VARCHAR(25),
        fl_kph              FLOAT,
        class               VARCHAR(10),
        [group]             VARCHAR(25),
        division            VARCHAR(25),
        vehicle             VARCHAR(25),
        tires               VARCHAR(50),
        ecm_participant_id  VARCHAR(50),
        ecm_team_id         VARCHAR(50),
        ecm_category_id     VARCHAR(50),
        ecm_car_id          VARCHAR(50),
        ecm_brand_id        VARCHAR(50),
        ecm_country_id      VARCHAR(50),
        extra_7             VARCHAR(50),
        extra_8             VARCHAR(50),
        extra_9             VARCHAR(50),
        sort_key            VARCHAR(50),
        driver_extra_3      VARCHAR(50),
        driver_extra_4      VARCHAR(50),
        driver_extra_5      VARCHAR(50)
    );

    /*----------------------------------------------------------
      Provisional Results - Race 2
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_prov_res_r2;
    CREATE TABLE bronze.barber_prov_res_r2 (
        position            INT,
        number              INT,
        status              VARCHAR(25),
        laps                INT,
        total_time          VARCHAR(25),
        gap_first           VARCHAR(25),
        gap_previous        VARCHAR(25),
        fl_lapnum           INT,
        fl_time             VARCHAR(25),
        fl_kph              FLOAT,
        class               VARCHAR(10),
        [group]             VARCHAR(25),
        division            VARCHAR(25),
        vehicle             VARCHAR(25),
        tires               VARCHAR(50),
        ecm_participant_id  VARCHAR(50),
        ecm_team_id         VARCHAR(50),
        ecm_category_id     VARCHAR(50),
        ecm_car_id          VARCHAR(50),
        ecm_brand_id        VARCHAR(50),
        ecm_country_id      VARCHAR(50),
        extra_7             VARCHAR(50),
        extra_8             VARCHAR(50),
        extra_9             VARCHAR(50),
        sort_key            VARCHAR(50),
        driver_extra_3      VARCHAR(50),
        driver_extra_4      VARCHAR(50),
        driver_extra_5      VARCHAR(50)
    );

    /*----------------------------------------------------------
      Official Results - Race 2
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_res_r2;
    CREATE TABLE bronze.barber_res_r2 (
        position            INT,
        number              INT,
        status              VARCHAR(25),
        laps                INT,
        total_time          VARCHAR(25),
        gap_first           VARCHAR(25),
        gap_previous        VARCHAR(25),
        fl_lapnum           INT,
        fl_time             VARCHAR(25),
        fl_kph              FLOAT,
        class               VARCHAR(10),
        [group]             VARCHAR(25),
        division            VARCHAR(25),
        vehicle             VARCHAR(25),
        tires               VARCHAR(50),
        ecm_participant_id  VARCHAR(50),
        ecm_team_id         VARCHAR(50),
        ecm_category_id     VARCHAR(50),
        ecm_car_id          VARCHAR(50),
        ecm_brand_id        VARCHAR(50),
        ecm_country_id      VARCHAR(50),
        extra_7             VARCHAR(50),
        extra_8             VARCHAR(50),
        extra_9             VARCHAR(50),
        sort_key            VARCHAR(50),
        driver_extra_3      VARCHAR(50),
        driver_extra_4      VARCHAR(50),
        driver_extra_5      VARCHAR(50)
    );

    /*----------------------------------------------------------
      Provisional Results By Class - Race 1
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_prov_res_class_r1;
    CREATE TABLE bronze.barber_prov_res_class_r1 (
        class_type      VARCHAR(10),
        pos             INT,
        pic             INT,
        number          INT,
        vehicle         VARCHAR(50),
        laps            INT,
        elapsed         VARCHAR(20),
        gap_first       VARCHAR(20),
        gap_previous    VARCHAR(20),
        best_lap_num    INT,
        best_lap_time   VARCHAR(20),
        best_lap_kph    DECIMAL(6,2)
    );

    /*----------------------------------------------------------
      Provisional Results By Class - Race 2
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_prov_res_class_r2;
    CREATE TABLE bronze.barber_prov_res_class_r2 (
        class_type      VARCHAR(10),
        pos             INT,
        pic             INT,
        number          INT,
        vehicle         VARCHAR(50),
        laps            INT,
        elapsed         VARCHAR(20),
        gap_first       VARCHAR(20),
        gap_previous    VARCHAR(20),
        best_lap_num    INT,
        best_lap_time   VARCHAR(20),
        best_lap_kph    DECIMAL(6,2)
    );

    /*----------------------------------------------------------
      Official Results By Class - Race 1
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_res_class_r1;
    CREATE TABLE bronze.barber_res_class_r1 (
        class_type      VARCHAR(10),
        pos             INT,
        pic             INT,
        number          INT,
        vehicle         VARCHAR(50),
        laps            INT,
        elapsed         VARCHAR(20),
        gap_first       VARCHAR(20),
        gap_previous    VARCHAR(20),
        best_lap_num    INT,
        best_lap_time   VARCHAR(20),
        best_lap_kph    DECIMAL(6,2)
    );

    /*----------------------------------------------------------
      Analysis Endurance With Sections - Race 1
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_analysis_r1;
    CREATE TABLE bronze.barber_analysis_r1 (
        number                      INT,
        driver_number               INT,
        lap_number                  INT,
        lap_time                    VARCHAR(20),
        lap_improvement             INT,
        crossing_finish_line_in_pit VARCHAR(5),

        s1                          VARCHAR(20),
        s1_improvement              INT,
        s2                          VARCHAR(20),
        s2_improvement              INT,
        s3                          VARCHAR(20),
        s3_improvement              INT,

        kph                         DECIMAL(6,2),
        elapsed                     VARCHAR(20),
        hour                        VARCHAR(20),

        s1_large                    VARCHAR(20),
        s2_large                    VARCHAR(20),
        s3_large                    VARCHAR(20),

        top_speed                   DECIMAL(6,2),
        pit_time                    VARCHAR(20),

        class                       VARCHAR(10),
        [group]                     VARCHAR(25),
        manufacturer                VARCHAR(50),
        flag_at_fl                  VARCHAR(10),

        s1_seconds                  DECIMAL(8,3),
        s2_seconds                  DECIMAL(8,3),
        s3_seconds                  DECIMAL(8,3),

        im1a_time                   DECIMAL(8,3),
        im1a_elapsed                DECIMAL(8,3),
        im1_time                    DECIMAL(8,3),
        im1_elapsed                 VARCHAR(20),

        im2a_time                   DECIMAL(8,3),
        im2a_elapsed                VARCHAR(20),
        im2_time                    DECIMAL(8,3),
        im2_elapsed                 VARCHAR(20),

        im3a_time                   DECIMAL(8,3),
        im3a_elapsed                VARCHAR(20),

        fl_time                     VARCHAR(20),
        fl_elapsed                  VARCHAR(20)
    );

    /*----------------------------------------------------------
      Analysis Endurance With Sections - Race 2
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_analysis_r2;
    CREATE TABLE bronze.barber_analysis_r2 (
        number                      INT,
        driver_number               INT,
        lap_number                  INT,
        lap_time                    VARCHAR(20),
        lap_improvement             INT,
        crossing_finish_line_in_pit VARCHAR(5),

        s1                          VARCHAR(20),
        s1_improvement              INT,
        s2                          VARCHAR(20),
        s2_improvement              INT,
        s3                          VARCHAR(20),
        s3_improvement              INT,

        kph                         DECIMAL(6,2),
        elapsed                     VARCHAR(20),
        hour                        VARCHAR(20),

        s1_large                    VARCHAR(20),
        s2_large                    VARCHAR(20),
        s3_large                    VARCHAR(20),

        top_speed                   DECIMAL(6,2),
        pit_time                    VARCHAR(20),

        class                       VARCHAR(10),
        [group]                     VARCHAR(25),
        manufacturer                VARCHAR(50),
        flag_at_fl                  VARCHAR(10),

        s1_seconds                  DECIMAL(8,3),
        s2_seconds                  DECIMAL(8,3),
        s3_seconds                  DECIMAL(8,3),

        im1a_time                   DECIMAL(8,3),
        im1a_elapsed                DECIMAL(8,3),
        im1_time                    DECIMAL(8,3),
        im1_elapsed                 VARCHAR(20),

        im2a_time                   DECIMAL(8,3),
        im2a_elapsed                VARCHAR(20),
        im2_time                    DECIMAL(8,3),
        im2_elapsed                 VARCHAR(20),

        im3a_time                   DECIMAL(8,3),
        im3a_elapsed                VARCHAR(20),

        fl_time                     VARCHAR(20),
        fl_elapsed                  VARCHAR(20)
    );

    /*----------------------------------------------------------
      Weather Tables
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.baber_weather_r1;
    CREATE TABLE bronze.baber_weather_r1 (
        time_utc_seconds    BIGINT,
        time_utc_str        VARCHAR(25),
        air_temp            DECIMAL(5,2),
        track_temp          DECIMAL(5,2),
        humidity            DECIMAL(5,2),
        pressure            DECIMAL(6,1),
        wind_speed          DECIMAL(5,2),
        wind_direction      INT,
        rain                BIT
    );

    DROP TABLE IF EXISTS bronze.baber_weather_r2;
    CREATE TABLE bronze.baber_weather_r2 (
        time_utc_seconds    BIGINT,
        time_utc_str        VARCHAR(25),
        air_temp            DECIMAL(5,2),
        track_temp          DECIMAL(5,2),
        humidity            DECIMAL(5,2),
        pressure            DECIMAL(6,1),
        wind_speed          DECIMAL(5,2),
        wind_direction      INT,
        rain                BIT
    );

    /*----------------------------------------------------------
      Best 10 Laps By Driver - Race 1 + Race 2
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_best_10_lp_dr_r1;
    CREATE TABLE bronze.barber_best_10_lp_dr_r1 (
        number              INT,
        vehicle             VARCHAR(50),
        class               VARCHAR(10),
        total_driver_laps   INT,

        bestlap_1           VARCHAR(20), bestlap_1_lapnum INT,
        bestlap_2           VARCHAR(20), bestlap_2_lapnum INT,
        bestlap_3           VARCHAR(20), bestlap_3_lapnum INT,
        bestlap_4           VARCHAR(20), bestlap_4_lapnum INT,
        bestlap_5           VARCHAR(20), bestlap_5_lapnum INT,
        bestlap_6           VARCHAR(20), bestlap_6_lapnum INT,
        bestlap_7           VARCHAR(20), bestlap_7_lapnum INT,
        bestlap_8           VARCHAR(20), bestlap_8_lapnum INT,
        bestlap_9           VARCHAR(20), bestlap_9_lapnum INT,
        bestlap_10          VARCHAR(20), bestlap_10_lapnum INT,

        average             VARCHAR(20)
    );

    DROP TABLE IF EXISTS bronze.barber_best_10_lp_dr_r2;
    CREATE TABLE bronze.barber_best_10_lp_dr_r2 (
        number              INT,
        vehicle             VARCHAR(50),
        class               VARCHAR(10),
        total_driver_laps   INT,

        bestlap_1           VARCHAR(20), bestlap_1_lapnum INT,
        bestlap_2           VARCHAR(20), bestlap_2_lapnum INT,
        bestlap_3           VARCHAR(20), bestlap_3_lapnum INT,
        bestlap_4           VARCHAR(20), bestlap_4_lapnum INT,
        bestlap_5           VARCHAR(20), bestlap_5_lapnum INT,
        bestlap_6           VARCHAR(20), bestlap_6_lapnum INT,
        bestlap_7           VARCHAR(20), bestlap_7_lapnum INT,
        bestlap_8           VARCHAR(20), bestlap_8_lapnum INT,
        bestlap_9           VARCHAR(20), bestlap_9_lapnum INT,
        bestlap_10          VARCHAR(20), bestlap_10_lapnum INT,

        average             VARCHAR(20)
    );

    /*----------------------------------------------------------
      Lap + Telemetry Tables (Race 1 + Race 2)
    ----------------------------------------------------------*/
    DROP TABLE IF EXISTS bronze.barber_lp_start_r1;
    CREATE TABLE bronze.barber_lp_start_r1 (
        expire_at           DATETIME2 NULL,
        lap                 INT,
        meta_event          VARCHAR(50),
        meta_session        VARCHAR(10),
        meta_source         VARCHAR(50),
        meta_time           DATETIME2,
        original_vehicle_id VARCHAR(50),
        outing              INT,
        timestamp_utc       DATETIME2,
        vehicle_id          VARCHAR(50),
        vehicle_number      INT
    );

    DROP TABLE IF EXISTS bronze.barber_lp_end_r1;
    CREATE TABLE bronze.barber_lp_end_r1 (
        expire_at           DATETIME2 NULL,
        lap                 INT,
        meta_event          VARCHAR(50),
        meta_session        VARCHAR(10),
        meta_source         VARCHAR(50),
        meta_time           DATETIME2,
        original_vehicle_id VARCHAR(50),
        outing              INT,
        timestamp_utc       DATETIME2,
        vehicle_id          VARCHAR(50),
        vehicle_number      INT
    );

    DROP TABLE IF EXISTS bronze.barber_lp_time_r1;
    CREATE TABLE bronze.barber_lp_time_r1 (
        expire_at           DATETIME2 NULL,
        lap                 INT,
        meta_event          VARCHAR(50),
        meta_session        VARCHAR(10),
        meta_source         VARCHAR(50),
        meta_time           DATETIME2,
        original_vehicle_id VARCHAR(50),
        outing              INT,
        timestamp_utc       DATETIME2,
        vehicle_id          VARCHAR(50),
        vehicle_number      INT
    );

    DROP TABLE IF EXISTS bronze.barber_lp_start_r2;
    CREATE TABLE bronze.barber_lp_start_r2 (
        expire_at           DATETIME2 NULL,
        lap                 INT,
        meta_event          VARCHAR(50),
        meta_session        VARCHAR(10),
        meta_source         VARCHAR(50),
        meta_time           DATETIME2,
        original_vehicle_id VARCHAR(50),
        outing              INT,
        timestamp_utc       DATETIME2,
        vehicle_id          VARCHAR(50),
        vehicle_number      INT
    );

    DROP TABLE IF EXISTS bronze.barber_lp_end_r2;
    CREATE TABLE bronze.barber_lp_end_r2 (
        expire_at           DATETIME2 NULL,
        lap                 INT,
        meta_event          VARCHAR(50),
        meta_session        VARCHAR(10),
        meta_source         VARCHAR(50),
        meta_time           DATETIME2,
        original_vehicle_id VARCHAR(50),
        outing              INT,
        timestamp_utc       DATETIME2,
        vehicle_id          VARCHAR(50),
        vehicle_number      INT
    );

    DROP TABLE IF EXISTS bronze.barber_lp_time_r2;
    CREATE TABLE bronze.barber_lp_time_r2 (
        expire_at           DATETIME2 NULL,
        lap                 INT,
        meta_event          VARCHAR(50),
        meta_session        VARCHAR(10),
        meta_source         VARCHAR(50),
        meta_time           DATETIME2,
        original_vehicle_id VARCHAR(50),
        outing              INT,
        timestamp_utc       DATETIME2,
        vehicle_id          VARCHAR(50),
        vehicle_number      INT
    );

    DROP TABLE IF EXISTS bronze.barber_tel_r1;
    CREATE TABLE bronze.barber_tel_r1 (
        expire_at           DATETIME2 NULL,
        lap                 INT,
        meta_event          VARCHAR(50),
        meta_session        VARCHAR(10),
        meta_source         VARCHAR(50),
        meta_time           DATETIME2,
        original_vehicle_id VARCHAR(50),
        outing              INT,
        telemetry_name      VARCHAR(50),
        telemetry_value     FLOAT,
        timestamp_utc       DATETIME2,
        vehicle_id          VARCHAR(50),
        vehicle_number      INT
    );

    DROP TABLE IF EXISTS bronze.barber_tel_r2;
    CREATE TABLE bronze.barber_tel_r2 (
        expire_at           DATETIME2 NULL,
        lap                 INT,
        meta_event          VARCHAR(50),
        meta_session        VARCHAR(10),
        meta_source         VARCHAR(50),
        meta_time           DATETIME2,
        original_vehicle_id VARCHAR(50),
        outing              INT,
        telemetry_name      VARCHAR(50),
        telemetry_value     FLOAT,
        timestamp_utc       DATETIME2,
        vehicle_id          VARCHAR(50),
        vehicle_number      INT
    );

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;

    PRINT 'Bronze Layer Table Creation Failed.';
    PRINT ERROR_MESSAGE();
END CATCH;
