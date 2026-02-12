CREATE OR ALTER PROCEDURE bronze.create_tables
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        ---------------------------------------------------------------------
        -- Table: Drivers Campionship
        ---------------------------------------------------------------------
        IF OBJECT_ID('bronze.drivers_championship', 'U') IS NULL
        BEGIN
            CREATE TABLE bronze.drivers_championship
            (
                id INT IDENTITY(1,1) PRIMARY KEY,
                pos INT,
                participant NVARCHAR(100),
                points INT,
                number INT,
                name NVARCHAR(100),
                surname NVARCHAR(100),
                country NVARCHAR(100),
                team NVARCHAR(200),
                manufacturer NVARCHAR(100),
                class NVARCHAR(50),

                -- Sonoma Race 1
                sonoma_r1_points NVARCHAR(10),
                sonoma_r1_pole_points NVARCHAR(10),
                sonoma_r1_fastest_lap_points NVARCHAR(10),
                sonoma_r1_extra1 NVARCHAR(10),
                sonoma_r1_extra2 NVARCHAR(10),
                sonoma_r1_total_extra_points NVARCHAR(10),
                sonoma_r1_status VARCHAR(20),
                sonoma_r1_extra_participation_points NVARCHAR(10),
                sonoma_r1_extra_participation_invalid TINYINT,
                sonoma_r1_extra_not_started_points NVARCHAR(10),
                sonoma_r1_extra_not_started_invalid TINYINT,
                sonoma_r1_extra_not_classified_points NVARCHAR(10),
                sonoma_r1_extra_not_classified_invalid TINYINT,

                -- Sonoma Race 2
                sonoma_r2_points NVARCHAR(10),
                sonoma_r2_pole_points NVARCHAR(10),
                sonoma_r2_fastest_lap_points NVARCHAR(10),
                sonoma_r2_extra1 NVARCHAR(10),
                sonoma_r2_extra2 NVARCHAR(10),
                sonoma_r2_total_extra_points NVARCHAR(10),
                sonoma_r2_status VARCHAR(20),
                sonoma_r2_extra_participation_points NVARCHAR(10),
                sonoma_r2_extra_participation_invalid TINYINT,
                sonoma_r2_extra_not_started_points NVARCHAR(10),
                sonoma_r2_extra_not_started_invalid TINYINT,
                sonoma_r2_extra_not_classified_points NVARCHAR(10),
                sonoma_r2_extra_not_classified_invalid TINYINT,

                -- COTA Race 1
                cota_r1_points NVARCHAR(10),
                cota_r1_pole_points NVARCHAR(10),
                cota_r1_fastest_lap_points NVARCHAR(10),
                cota_r1_extra1 NVARCHAR(10),
                cota_r1_extra2 NVARCHAR(10),
                cota_r1_total_extra_points NVARCHAR(10),
                cota_r1_status VARCHAR(20),
                cota_r1_extra_participation_points NVARCHAR(10),
                cota_r1_extra_participation_invalid TINYINT,
                cota_r1_extra_not_started_points NVARCHAR(10),
                cota_r1_extra_not_started_invalid TINYINT,
                cota_r1_extra_not_classified_points NVARCHAR(10),
                cota_r1_extra_not_classified_invalid TINYINT,

                -- COTA Race 2
                cota_r2_points NVARCHAR(10),
                cota_r2_pole_points NVARCHAR(10),
                cota_r2_fastest_lap_points NVARCHAR(10),
                cota_r2_extra1 NVARCHAR(10),
                cota_r2_extra2 NVARCHAR(10),
                cota_r2_total_extra_points NVARCHAR(10),
                cota_r2_status VARCHAR(20),
                cota_r2_extra_participation_points NVARCHAR(10),
                cota_r2_extra_participation_invalid TINYINT,
                cota_r2_extra_not_started_points NVARCHAR(10),
                cota_r2_extra_not_started_invalid TINYINT,
                cota_r2_extra_not_classified_points NVARCHAR(10),
                cota_r2_extra_not_classified_invalid TINYINT,

                -- Sebring Race 1
                sebring_r1_points NVARCHAR(10),
                sebring_r1_pole_points NVARCHAR(10),
                sebring_r1_fastest_lap_points NVARCHAR(10),
                sebring_r1_extra1 NVARCHAR(10),
                sebring_r1_extra2 NVARCHAR(10),
                sebring_r1_total_extra_points NVARCHAR(10),
                sebring_r1_status VARCHAR(20),
                sebring_r1_extra_participation_points NVARCHAR(10),
                sebring_r1_extra_participation_invalid TINYINT,
                sebring_r1_extra_not_started_points NVARCHAR(10),
                sebring_r1_extra_not_started_invalid TINYINT,
                sebring_r1_extra_not_classified_points NVARCHAR(10),
                sebring_r1_extra_not_classified_invalid TINYINT,

                -- Sebring Race 2
                sebring_r2_points NVARCHAR(10),
                sebring_r2_pole_points NVARCHAR(10),
                sebring_r2_fastest_lap_points NVARCHAR(10),
                sebring_r2_extra1 NVARCHAR(10),
                sebring_r2_extra2 NVARCHAR(10),
                sebring_r2_total_extra_points NVARCHAR(10),
                sebring_r2_status VARCHAR(20),
                sebring_r2_extra_participation_points NVARCHAR(10),
                sebring_r2_extra_participation_invalid TINYINT,
                sebring_r2_extra_not_started_points NVARCHAR(10),
                sebring_r2_extra_not_started_invalid TINYINT,
                sebring_r2_extra_not_classified_points NVARCHAR(10),
                sebring_r2_extra_not_classified_invalid TINYINT,

                -- VIR Race 1
                vir_r1_points NVARCHAR(10),
                vir_r1_pole_points NVARCHAR(10),
                vir_r1_fastest_lap_points NVARCHAR(10),
                vir_r1_extra1 NVARCHAR(10),
                vir_r1_extra2 NVARCHAR(10),
                vir_r1_total_extra_points NVARCHAR(10),
                vir_r1_status VARCHAR(20),
                vir_r1_extra_participation_points NVARCHAR(10),
                vir_r1_extra_participation_invalid TINYINT,
                vir_r1_extra_not_started_points NVARCHAR(10),
                vir_r1_extra_not_started_invalid TINYINT,
                vir_r1_extra_not_classified_points NVARCHAR(10),
                vir_r1_extra_not_classified_invalid TINYINT,

                -- VIR Race 2
                vir_r2_points NVARCHAR(10),
                vir_r2_pole_points NVARCHAR(10),
                vir_r2_fastest_lap_points NVARCHAR(10),
                vir_r2_extra1 NVARCHAR(10),
                vir_r2_extra2 NVARCHAR(10),
                vir_r2_total_extra_points NVARCHAR(10),
                vir_r2_status VARCHAR(20),
                vir_r2_extra_participation_points NVARCHAR(10),
                vir_r2_extra_participation_invalid TINYINT,
                vir_r2_extra_not_started_points NVARCHAR(10),
                vir_r2_extra_not_started_invalid TINYINT,
                vir_r2_extra_not_classified_points NVARCHAR(10),
                vir_r2_extra_not_classified_invalid TINYINT,

                -- Road America Race 1
                roadamerica_r1_points NVARCHAR(10),
                roadamerica_r1_pole_points NVARCHAR(10),
                roadamerica_r1_fastest_lap_points NVARCHAR(10),
                roadamerica_r1_extra1 NVARCHAR(10),
                roadamerica_r1_extra2 NVARCHAR(10),
                roadamerica_r1_total_extra_points NVARCHAR(10),
                roadamerica_r1_status VARCHAR(20),
                roadamerica_r1_extra_participation_points NVARCHAR(10),
                roadamerica_r1_extra_participation_invalid TINYINT,
                roadamerica_r1_extra_not_started_points NVARCHAR(10),
                roadamerica_r1_extra_not_started_invalid TINYINT,
                roadamerica_r1_extra_not_classified_points NVARCHAR(10),
                roadamerica_r1_extra_not_classified_invalid TINYINT,

                -- Road America Race 2
                roadamerica_r2_points NVARCHAR(10),
                roadamerica_r2_pole_points NVARCHAR(10),
                roadamerica_r2_fastest_lap_points NVARCHAR(10),
                roadamerica_r2_extra1 NVARCHAR(10),
                roadamerica_r2_extra2 NVARCHAR(10),
                roadamerica_r2_total_extra_points NVARCHAR(10),
                roadamerica_r2_status VARCHAR(20),
                roadamerica_r2_extra_participation_points NVARCHAR(10),
                roadamerica_r2_extra_participation_invalid TINYINT,
                roadamerica_r2_extra_not_started_points NVARCHAR(10),
                roadamerica_r2_extra_not_started_invalid TINYINT,
                roadamerica_r2_extra_not_classified_points NVARCHAR(10),
                roadamerica_r2_extra_not_classified_invalid TINYINT,

                -- Barber Race 1
                barber_r1_points NVARCHAR(10),
                barber_r1_pole_points NVARCHAR(10),
                barber_r1_fastest_lap_points NVARCHAR(10),
                barber_r1_extra1 NVARCHAR(10),
                barber_r1_extra2 NVARCHAR(10),
                barber_r1_total_extra_points NVARCHAR(10),
                barber_r1_status VARCHAR(20),
                barber_r1_extra_participation_points NVARCHAR(10),
                barber_r1_extra_participation_invalid TINYINT,
                barber_r1_extra_not_started_points NVARCHAR(10),
                barber_r1_extra_not_started_invalid TINYINT,
                barber_r1_extra_not_classified_points NVARCHAR(10),
                barber_r1_extra_not_classified_invalid TINYINT,

                -- Barber Race 2
                barber_r2_points NVARCHAR(10),
                barber_r2_pole_points NVARCHAR(10),
                barber_r2_fastest_lap_points NVARCHAR(10),
                barber_r2_extra1 NVARCHAR(10),
                barber_r2_extra2 NVARCHAR(10),
                barber_r2_total_extra_points NVARCHAR(10),
                barber_r2_status VARCHAR(20),
                barber_r2_extra_participation_points NVARCHAR(10),
                barber_r2_extra_participation_invalid TINYINT,
                barber_r2_extra_not_started_points NVARCHAR(10),
                barber_r2_extra_not_started_invalid TINYINT,
                barber_r2_extra_not_classified_points NVARCHAR(10),
                barber_r2_extra_not_classified_invalid TINYINT,

                -- Indy Race 1
                indy_r1_points NVARCHAR(10),
                indy_r1_pole_points NVARCHAR(10),
                indy_r1_fastest_lap_points NVARCHAR(10),
                indy_r1_extra1 NVARCHAR(10),
                indy_r1_extra2 NVARCHAR(10),
                indy_r1_total_extra_points NVARCHAR(10),
                indy_r1_status VARCHAR(20),
                indy_r1_extra_participation_points NVARCHAR(10),
                indy_r1_extra_participation_invalid TINYINT,
                indy_r1_extra_not_started_points NVARCHAR(10),
                indy_r1_extra_not_started_invalid TINYINT,
                indy_r1_extra_not_classified_points NVARCHAR(10),
                indy_r1_extra_not_classified_invalid TINYINT,

                -- Indy Race 2
                indy_r2_points NVARCHAR(10),
                indy_r2_pole_points NVARCHAR(10),
                indy_r2_fastest_lap_points NVARCHAR(10),
                indy_r2_extra1 NVARCHAR(10),
                indy_r2_extra2 NVARCHAR(10),
                indy_r2_total_extra_points NVARCHAR(10),
                indy_r2_status VARCHAR(20),
                indy_r2_extra_participation_points NVARCHAR(10),
                indy_r2_extra_participation_invalid TINYINT,
                indy_r2_extra_not_started_points NVARCHAR(10),
                indy_r2_extra_not_started_invalid TINYINT,
                indy_r2_extra_not_classified_points NVARCHAR(10),
                indy_r2_extra_not_classified_invalid TINYINT,

                source_file NVARCHAR(500),
                load_datetime DATETIME DEFAULT GETDATE()
            );
        END

        ---------------------------------------------------------------------
        -- Table: Weather
        ---------------------------------------------------------------------
        IF OBJECT_ID('bronze.weather', 'U') IS NULL
        BEGIN
            CREATE TABLE bronze.weather
            (
                id INT IDENTITY(1,1) PRIMARY KEY,
                race_no INT,
                time_utc_seconds BIGINT,
                time_utc_str DATETIME,
                air_temp FLOAT,
                track_temp FLOAT,
                humidity FLOAT,
                pressure FLOAT,
                wind_speed FLOAT,
                wind_direction INT,
                rain INT,
                source_file NVARCHAR(500),
                load_datetime DATETIME DEFAULT GETDATE()
            );
        END

        ---------------------------------------------------------------------
        -- Table: Analysis Endurance
        ---------------------------------------------------------------------
        IF OBJECT_ID('bronze.analysis_endurance', 'U') IS NULL
        BEGIN
            CREATE TABLE bronze.analysis_endurance
            (
                id INT IDENTITY(1,1) PRIMARY KEY,
                race_no INT,
                number INT,
                driver_number INT,
                lap_number INT,

                lap_time NVARCHAR(50),
                lap_improvement INT,
                crossing_finish_line_in_pit NVARCHAR(10),

                s1 NVARCHAR(50),
                s1_improvement INT,
                s2 NVARCHAR(50),
                s2_improvement INT,
                s3 NVARCHAR(50),
                s3_improvement INT,

                kph FLOAT,
                elapsed NVARCHAR(50),
                hour NVARCHAR(50),

                s1_large NVARCHAR(50),
                s2_large NVARCHAR(50),
                s3_large NVARCHAR(50),

                top_speed FLOAT,
                driver_name NVARCHAR(200),
                pit_time NVARCHAR(50),
                class NVARCHAR(50),
                group_name NVARCHAR(50),
                team NVARCHAR(200),
                manufacturer NVARCHAR(200),
                flag_at_fl NVARCHAR(10),

                s1_seconds FLOAT,
                s2_seconds FLOAT,
                s3_seconds FLOAT,

                im1a_time NVARCHAR(50),
                im1a_elapsed NVARCHAR(50),
                im1_time NVARCHAR(50),
                im1_elapsed NVARCHAR(50),

                im2a_time NVARCHAR(50),
                im2a_elapsed NVARCHAR(50),
                im2_time NVARCHAR(50),
                im2_elapsed NVARCHAR(50),

                im3a_time NVARCHAR(50),
                im3a_elapsed NVARCHAR(50),

                fl_time NVARCHAR(50),
                fl_elapsed NVARCHAR(50),

                source_file NVARCHAR(500),
                load_datetime DATETIME DEFAULT GETDATE()
            );
        END


        ---------------------------------------------------------------------
        -- Table: Provisional / Official Results
        ---------------------------------------------------------------------
        IF OBJECT_ID('bronze.prov_off_results', 'U') IS NULL
        BEGIN
            CREATE TABLE bronze.prov_off_results
            (
                id INT IDENTITY(1,1) PRIMARY KEY,
                race_no INT,
                position INT,
                number INT,
                status NVARCHAR(50),
                laps INT,
                total_time NVARCHAR(50),
                gap_first NVARCHAR(50),
                gap_previous NVARCHAR(50),
                fl_lapnum INT,
                fl_time NVARCHAR(50),
                fl_kph FLOAT,
                team NVARCHAR(200),
                class NVARCHAR(50),
                group_name NVARCHAR(50),
                division NVARCHAR(50),
                vehicle NVARCHAR(200),
                tires NVARCHAR(100),
                ecm_participant_id INT,
                ecm_team_id INT,
                ecm_category_id INT,
                ecm_car_id INT,
                ecm_brand_id INT,
                ecm_country_id INT,
                extra_7 NVARCHAR(200),
                extra_8 NVARCHAR(200),
                extra_9 NVARCHAR(200),
                sort_key INT,
                driver_firstname NVARCHAR(100),
                driver_secondname NVARCHAR(100),
                driver_license NVARCHAR(100),
                driver_hometown NVARCHAR(200),
                driver_country NVARCHAR(100),
                driver_shortname NVARCHAR(50),
                driver_ecm_driver_id INT,
                driver_ecm_country_id INT,
                driver_extra_3 NVARCHAR(200),
                driver_extra_4 NVARCHAR(200),
                driver_extra_5 NVARCHAR(200),
                source_file NVARCHAR(500),
                load_datetime DATETIME DEFAULT GETDATE()
            );
        END

        ---------------------------------------------------------------------
        -- Table: Provisional / Official Results By Class
        ---------------------------------------------------------------------
        IF OBJECT_ID('bronze.prov_off_results_class', 'U') IS NULL
        BEGIN
        CREATE TABLE bronze.prov_off_results_class
            (
                id INT IDENTITY(1,1) PRIMARY KEY,
                race_no INT,
                class_type NVARCHAR(50),
                pos INT,
                pic INT,
                number INT,
                team NVARCHAR(200),
                vehicle NVARCHAR(200),
                driver NVARCHAR(200),
                laps INT,
                elapsed NVARCHAR(50),
                gap_first NVARCHAR(50),
                gap_previous NVARCHAR(50),
                best_lap_num INT,
                best_lap_time NVARCHAR(50),
                best_lap_kph FLOAT,
                source_file NVARCHAR(500),
                load_datetime DATETIME DEFAULT GETDATE()
            );
        END

        ---------------------------------------------------------------------
        -- Table: Top 10 Laps
        ---------------------------------------------------------------------
        IF OBJECT_ID('bronze.top_10_laps', 'U') IS NULL
        BEGIN
            CREATE TABLE bronze.top_10_laps
            (
                id INT IDENTITY(1,1) PRIMARY KEY,
                race_no INT,
                number INT,
                team NVARCHAR(200),
                vehicle NVARCHAR(200),
                class NVARCHAR(50),
                firstname NVARCHAR(100),
                secondname NVARCHAR(100),
                total_driver_laps INT,
                bestlap_1 NVARCHAR(50),
                bestlap_1_lapnum INT,
                bestlap_2 NVARCHAR(50),
                bestlap_2_lapnum INT,
                bestlap_3 NVARCHAR(50),
                bestlap_3_lapnum INT,
                bestlap_4 NVARCHAR(50),
                bestlap_4_lapnum INT,
                bestlap_5 NVARCHAR(50),
                bestlap_5_lapnum INT,
                bestlap_6 NVARCHAR(50),
                bestlap_6_lapnum INT,
                bestlap_7 NVARCHAR(50),
                bestlap_7_lapnum INT,
                bestlap_8 NVARCHAR(50),
                bestlap_8_lapnum INT,
                bestlap_9 NVARCHAR(50),
                bestlap_9_lapnum INT,
                bestlap_10 NVARCHAR(50),
                bestlap_10_lapnum INT,
                average NVARCHAR(50),
                source_file NVARCHAR(500),
                load_datetime DATETIME DEFAULT GETDATE()
            );
        END

        ---------------------------------------------------------------------
        -- Helper Table: Bulk Map
        ---------------------------------------------------------------------
        IF OBJECT_ID('bronze.bulk_map', 'U') IS NULL
        BEGIN
            CREATE TABLE bronze.bulk_map
            (
                target_table SYSNAME,
                column_list NVARCHAR(MAX)
            );
        END

        ---------------------------------------------------------------------
        -- Table: Teams Championship
        ---------------------------------------------------------------------
        IF OBJECT_ID('bronze.teams_championship', 'U') IS NULL
        BEGIN
            CREATE TABLE bronze.teams_championship 
            (
                id INT IDENTITY(1,1) PRIMARY KEY,
                pos NVARCHAR(10) NOT NULL,
                participant VARCHAR(120) NOT NULL,
                points NVARCHAR(10) NOT NULL,

                -- Sonoma Race 1
                sonoma_r1_points NVARCHAR(10),
                sonoma_r1_pole_points NVARCHAR(10),
                sonoma_r1_fastest_lap_points NVARCHAR(10),
                sonoma_r1_extra1 NVARCHAR(10),
                sonoma_r1_extra2 NVARCHAR(10),
                sonoma_r1_total_extra_points NVARCHAR(10),
                sonoma_r1_status VARCHAR(20),
                sonoma_r1_extra_participation_points NVARCHAR(10),
                sonoma_r1_extra_participation_invalid TINYINT,
                sonoma_r1_extra_not_started_points NVARCHAR(10),
                sonoma_r1_extra_not_started_invalid TINYINT,
                sonoma_r1_extra_not_classified_points NVARCHAR(10),
                sonoma_r1_extra_not_classified_invalid TINYINT,

                -- Sonoma Race 2
                sonoma_r2_points NVARCHAR(10),
                sonoma_r2_pole_points NVARCHAR(10),
                sonoma_r2_fastest_lap_points NVARCHAR(10),
                sonoma_r2_extra1 NVARCHAR(10),
                sonoma_r2_extra2 NVARCHAR(10),
                sonoma_r2_total_extra_points NVARCHAR(10),
                sonoma_r2_status VARCHAR(20),
                sonoma_r2_extra_participation_points NVARCHAR(10),
                sonoma_r2_extra_participation_invalid TINYINT,
                sonoma_r2_extra_not_started_points NVARCHAR(10),
                sonoma_r2_extra_not_started_invalid TINYINT,
                sonoma_r2_extra_not_classified_points NVARCHAR(10),
                sonoma_r2_extra_not_classified_invalid TINYINT,

                -- COTA Race 1
                cota_r1_points NVARCHAR(10),
                cota_r1_pole_points NVARCHAR(10),
                cota_r1_fastest_lap_points NVARCHAR(10),
                cota_r1_extra1 NVARCHAR(10),
                cota_r1_extra2 NVARCHAR(10),
                cota_r1_total_extra_points NVARCHAR(10),
                cota_r1_status VARCHAR(20),
                cota_r1_extra_participation_points NVARCHAR(10),
                cota_r1_extra_participation_invalid TINYINT,
                cota_r1_extra_not_started_points NVARCHAR(10),
                cota_r1_extra_not_started_invalid TINYINT,
                cota_r1_extra_not_classified_points NVARCHAR(10),
                cota_r1_extra_not_classified_invalid TINYINT,

                -- COTA Race 2
                cota_r2_points NVARCHAR(10),
                cota_r2_pole_points NVARCHAR(10),
                cota_r2_fastest_lap_points NVARCHAR(10),
                cota_r2_extra1 NVARCHAR(10),
                cota_r2_extra2 NVARCHAR(10),
                cota_r2_total_extra_points NVARCHAR(10),
                cota_r2_status VARCHAR(20),
                cota_r2_extra_participation_points NVARCHAR(10),
                cota_r2_extra_participation_invalid TINYINT,
                cota_r2_extra_not_started_points NVARCHAR(10),
                cota_r2_extra_not_started_invalid TINYINT,
                cota_r2_extra_not_classified_points NVARCHAR(10),
                cota_r2_extra_not_classified_invalid TINYINT,

                -- Sebring Race 1
                sebring_r1_points NVARCHAR(10),
                sebring_r1_pole_points NVARCHAR(10),
                sebring_r1_fastest_lap_points NVARCHAR(10),
                sebring_r1_extra1 NVARCHAR(10),
                sebring_r1_extra2 NVARCHAR(10),
                sebring_r1_total_extra_points NVARCHAR(10),
                sebring_r1_status VARCHAR(20),
                sebring_r1_extra_participation_points NVARCHAR(10),
                sebring_r1_extra_participation_invalid TINYINT,
                sebring_r1_extra_not_started_points NVARCHAR(10),
                sebring_r1_extra_not_started_invalid TINYINT,
                sebring_r1_extra_not_classified_points NVARCHAR(10),
                sebring_r1_extra_not_classified_invalid TINYINT,

                -- Sebring Race 2
                sebring_r2_points NVARCHAR(10),
                sebring_r2_pole_points NVARCHAR(10),
                sebring_r2_fastest_lap_points NVARCHAR(10),
                sebring_r2_extra1 NVARCHAR(10),
                sebring_r2_extra2 NVARCHAR(10),
                sebring_r2_total_extra_points NVARCHAR(10),
                sebring_r2_status VARCHAR(20),
                sebring_r2_extra_participation_points NVARCHAR(10),
                sebring_r2_extra_participation_invalid TINYINT,
                sebring_r2_extra_not_started_points NVARCHAR(10),
                sebring_r2_extra_not_started_invalid TINYINT,
                sebring_r2_extra_not_classified_points NVARCHAR(10),
                sebring_r2_extra_not_classified_invalid TINYINT,

                -- VIR Race 1
                vir_r1_points NVARCHAR(10),
                vir_r1_pole_points NVARCHAR(10),
                vir_r1_fastest_lap_points NVARCHAR(10),
                vir_r1_extra1 NVARCHAR(10),
                vir_r1_extra2 NVARCHAR(10),
                vir_r1_total_extra_points NVARCHAR(10),
                vir_r1_status VARCHAR(20),
                vir_r1_extra_participation_points NVARCHAR(10),
                vir_r1_extra_participation_invalid TINYINT,
                vir_r1_extra_not_started_points NVARCHAR(10),
                vir_r1_extra_not_started_invalid TINYINT,
                vir_r1_extra_not_classified_points NVARCHAR(10),
                vir_r1_extra_not_classified_invalid TINYINT,

                -- VIR Race 2
                vir_r2_points NVARCHAR(10),
                vir_r2_pole_points NVARCHAR(10),
                vir_r2_fastest_lap_points NVARCHAR(10),
                vir_r2_extra1 NVARCHAR(10),
                vir_r2_extra2 NVARCHAR(10),
                vir_r2_total_extra_points NVARCHAR(10),
                vir_r2_status VARCHAR(20),
                vir_r2_extra_participation_points NVARCHAR(10),
                vir_r2_extra_participation_invalid TINYINT,
                vir_r2_extra_not_started_points NVARCHAR(10),
                vir_r2_extra_not_started_invalid TINYINT,
                vir_r2_extra_not_classified_points NVARCHAR(10),
                vir_r2_extra_not_classified_invalid TINYINT,

                -- Road America Race 1
                roadamerica_r1_points NVARCHAR(10),
                roadamerica_r1_pole_points NVARCHAR(10),
                roadamerica_r1_fastest_lap_points NVARCHAR(10),
                roadamerica_r1_extra1 NVARCHAR(10),
                roadamerica_r1_extra2 NVARCHAR(10),
                roadamerica_r1_total_extra_points NVARCHAR(10),
                roadamerica_r1_status VARCHAR(20),
                roadamerica_r1_extra_participation_points NVARCHAR(10),
                roadamerica_r1_extra_participation_invalid TINYINT,
                roadamerica_r1_extra_not_started_points NVARCHAR(10),
                roadamerica_r1_extra_not_started_invalid TINYINT,
                roadamerica_r1_extra_not_classified_points NVARCHAR(10),
                roadamerica_r1_extra_not_classified_invalid TINYINT,

                -- Road America Race 2
                roadamerica_r2_points NVARCHAR(10),
                roadamerica_r2_pole_points NVARCHAR(10),
                roadamerica_r2_fastest_lap_points NVARCHAR(10),
                roadamerica_r2_extra1 NVARCHAR(10),
                roadamerica_r2_extra2 NVARCHAR(10),
                roadamerica_r2_total_extra_points NVARCHAR(10),
                roadamerica_r2_status VARCHAR(20),
                roadamerica_r2_extra_participation_points NVARCHAR(10),
                roadamerica_r2_extra_participation_invalid TINYINT,
                roadamerica_r2_extra_not_started_points NVARCHAR(10),
                roadamerica_r2_extra_not_started_invalid TINYINT,
                roadamerica_r2_extra_not_classified_points NVARCHAR(10),
                roadamerica_r2_extra_not_classified_invalid TINYINT,

                -- Barber Race 1
                barber_r1_points NVARCHAR(10),
                barber_r1_pole_points NVARCHAR(10),
                barber_r1_fastest_lap_points NVARCHAR(10),
                barber_r1_extra1 NVARCHAR(10),
                barber_r1_extra2 NVARCHAR(10),
                barber_r1_total_extra_points NVARCHAR(10),
                barber_r1_status VARCHAR(20),
                barber_r1_extra_participation_points NVARCHAR(10),
                barber_r1_extra_participation_invalid TINYINT,
                barber_r1_extra_not_started_points NVARCHAR(10),
                barber_r1_extra_not_started_invalid TINYINT,
                barber_r1_extra_not_classified_points NVARCHAR(10),
                barber_r1_extra_not_classified_invalid TINYINT,

                -- Barber Race 2
                barber_r2_points NVARCHAR(10),
                barber_r2_pole_points NVARCHAR(10),
                barber_r2_fastest_lap_points NVARCHAR(10),
                barber_r2_extra1 NVARCHAR(10),
                barber_r2_extra2 NVARCHAR(10),
                barber_r2_total_extra_points NVARCHAR(10),
                barber_r2_status VARCHAR(20),
                barber_r2_extra_participation_points NVARCHAR(10),
                barber_r2_extra_participation_invalid TINYINT,
                barber_r2_extra_not_started_points NVARCHAR(10),
                barber_r2_extra_not_started_invalid TINYINT,
                barber_r2_extra_not_classified_points NVARCHAR(10),
                barber_r2_extra_not_classified_invalid TINYINT,

                -- Indy Race 1
                indy_r1_points NVARCHAR(10),
                indy_r1_pole_points NVARCHAR(10),
                indy_r1_fastest_lap_points NVARCHAR(10),
                indy_r1_extra1 NVARCHAR(10),
                indy_r1_extra2 NVARCHAR(10),
                indy_r1_total_extra_points NVARCHAR(10),
                indy_r1_status VARCHAR(20),
                indy_r1_extra_participation_points NVARCHAR(10),
                indy_r1_extra_participation_invalid TINYINT,
                indy_r1_extra_not_started_points NVARCHAR(10),
                indy_r1_extra_not_started_invalid TINYINT,
                indy_r1_extra_not_classified_points NVARCHAR(10),
                indy_r1_extra_not_classified_invalid TINYINT,

                -- Indy Race 2
                indy_r2_points NVARCHAR(10),
                indy_r2_pole_points NVARCHAR(10),
                indy_r2_fastest_lap_points NVARCHAR(10),
                indy_r2_extra1 NVARCHAR(10),
                indy_r2_extra2 NVARCHAR(10),
                indy_r2_total_extra_points NVARCHAR(10),
                indy_r2_status VARCHAR(20),
                indy_r2_extra_participation_points NVARCHAR(10),
                indy_r2_extra_participation_invalid TINYINT,
                indy_r2_extra_not_started_points NVARCHAR(10),
                indy_r2_extra_not_started_invalid TINYINT,
                indy_r2_extra_not_classified_points NVARCHAR(10),
                indy_r2_extra_not_classified_invalid TINYINT,

                source_file NVARCHAR(500),
                load_datetime DATETIME DEFAULT GETDATE()
            );
        END

        -- Commit transaction if all tables created successfully
        COMMIT TRANSACTION;
        PRINT 'All bronze tables created successfully.';

    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        THROW; -- preserves original error info
    END CATCH
END
