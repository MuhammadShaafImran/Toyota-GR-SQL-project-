
---------------------------------------------------------------------
-- Table: Events
---------------------------------------------------------------------
IF OBJECT_ID('silver.events', 'U') IS NULL
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
IF OBJECT_ID('silver.races', 'U') IS NULL
BEGIN
    CREATE TABLE silver.races
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        event_id INT FOREIGN KEY REFERENCES silver.events(event_id) ON DELETE CASCADE,
        race_no INT,
        load_datetime DATETIME DEFAULT GETDATE()
    );
END

---------------------------------------------------------------------
-- Table: Teams
---------------------------------------------------------------------
IF OBJECT_ID('silver.teams', 'U') IS NULL
BEGIN
    CREATE TABLE silver.teams
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(200),
        load_datetime DATETIME DEFAULT GETDATE()
    );
END

---------------------------------------------------------------------
-- Table: Drivers
---------------------------------------------------------------------

IF OBJECT_ID('silver.drivers', 'U') IS NULL
BEGIN
    CREATE TABLE silver.drivers
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(200),
        surname NVARCHAR(200),
        country NVARCHAR(100),
        load_datetime DATETIME DEFAULT GETDATE()
    );
END

---------------------------------------------------------------------
-- Table: Vehicles
---------------------------------------------------------------------

IF OBJECT_ID('silver.vehicles', 'U') IS NULL
BEGIN
    CREATE TABLE silver.vehicles
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(200),
        car_number INT,
        manufacturer NVARCHAR(200),
        class NVARCHAR(200),
        load_datetime DATETIME DEFAULT GETDATE()
    );
END

---------------------------------------------------------------------
-- Table: Weather
---------------------------------------------------------------------
IF OBJECT_ID('silver.weather', 'U') IS NULL
BEGIN
    CREATE TABLE silver.weather
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        race_id INT FOREIGN KEY REFERENCES silver.races(id) ON DELETE CASCADE,
        utc_datetime DATETIME,
        air_temp FLOAT,
        track_temp FLOAT,
        humidity FLOAT,
        pressure FLOAT,
        wind_speed FLOAT,
        wind_direction NVARCHAR(10),
        rain NVARCHAR(10),
        load_datetime DATETIME DEFAULT GETDATE()
    );
END

---------------------------------------------------------------------
-- Table: Top Laps 
---------------------------------------------------------------------

IF OBJECT_ID('silver.top_10_laps', 'U') IS NULL
BEGIN
    CREATE TABLE silver.top_10_laps
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        race_id INT NOT NULL FOREIGN KEY REFERENCES silver.races(id),
        driver_id INT NOT NULL FOREIGN KEY REFERENCES silver.drivers(id),
        team_id INT NOT NULL FOREIGN KEY REFERENCES silver.teams(id),
        vehicle_id INT NOT NULL FOREIGN KEY REFERENCES silver.vehicles(id),
        lap_number INT NOT NULL,
        lap_time  float NOT NULL,          
        lap_rank INT NOT NULL,            
        load_datetime DATETIME DEFAULT GETDATE()
    );
END

---------------------------------------------------------------------
-- Table: races results
---------------------------------------------------------------------

IF OBJECT_ID('silver.races_results', 'U') IS NULL
BEGIN
    CREATE TABLE silver.races_results
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        race_id INT NOT NULL FOREIGN KEY REFERENCES silver.races(id),
        driver_id INT NOT NULL FOREIGN KEY REFERENCES silver.drivers(id),
        vehicle_id INT NOT NULL FOREIGN KEY REFERENCES silver.vehicles(id),
        team_id INT NOT NULL FOREIGN KEY REFERENCES silver.teams(id),
        position INT,
        laps INT,
        total_time FLOAT,
        gap_first_sec FLOAT,
        lap_first_gap FLOAT,
        gap_previous_sec FLOAT,
        lap_previous_gap FLOAT,
        best_lap_no INT,
        best_lap_time FLOAT,
        best_lap_speed FLOAT,
        source NVARCHAR(25),
        load_datetime DATETIME DEFAULT GETDATE()
    );
END

---------------------------------------------------------------------
-- Table: Lap analysis
---------------------------------------------------------------------
IF OBJECT_ID('silver.lap_analysis', 'U') IS NULL
BEGIN
    CREATE TABLE silver.lap_analysis
    (
        id INT IDENTITY(1,1) PRIMARY KEY,

        race_id INT NOT NULL,
        driver_id INT NOT NULL,
        team_id INT NOT NULL,
        vehicle_id INT NOT NULL,

        lap_number INT NOT NULL,

        lap_time_sec FLOAT,
        lap_improvement INT,

        speed_kph FLOAT,
        top_speed FLOAT,

        elapsed_sec FLOAT,
        race_hour TIME(3),

        pit_time TIME(3),
        crossed_finish_in_pit NVARCHAR(2),
        flag_at_finish NVARCHAR(10),
        finish_line_time DECIMAL(10,3),
        finish_line_elapsed DECIMAL(10,3),

        load_datetime DATETIME DEFAULT GETDATE()
    );
END

---------------------------------------------------------------------
-- Table: Lap sectors
---------------------------------------------------------------------

IF OBJECT_ID('silver.lap_sectors', 'U') IS NULL
BEGIN
    CREATE TABLE silver.lap_sectors
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        lap_analysis_id INT NOT NULL,

        s1_sec FLOAT,
        s2_sec FLOAT,
        s3_sec FLOAT,

        s1_improvement INT,
        s2_improvement INT,
        s3_improvement INT
    );
END

---------------------------------------------------------------------
-- Table: Lap intermediates
---------------------------------------------------------------------

IF OBJECT_ID('silver.lap_intermediates', 'U') IS NULL
BEGIN
    CREATE TABLE silver.lap_intermediates
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        lap_analysis_id INT NOT NULL,

        im1_time_sec FLOAT,
        im1_elapsed_sec FLOAT,

        im2_time_sec FLOAT,
        im2_elapsed_sec FLOAT,

        im3a_time_sec FLOAT,
        im3a_elapsed_sec FLOAT
    );
END

----------------------------------------------------------------------
-- Table: Driver Championship Standings
----------------------------------------------------------------------
IF OBJECT_ID('silver.driver_event_result', 'U') IS NULL
BEGIN
    CREATE TABLE silver.driver_event_result
    (
        id INT IDENTITY PRIMARY KEY,

        race_id INT NOT NULL,
        driver_id INT NOT NULL,
        team_id INT,
        vehicle_id INT,
        position INT,

        event_points INT,
        pole_points INT,
        fastest_lap_points INT,
        event_status VARCHAR(50),

        total_extra_points INT,
        extra_participation_points INT,
        extra_participation_invalid INT,
        extra_not_started_points INT,
        extra_not_started_invalid INT,
        extra_not_classified_points INT,
        extra_not_classified_invalid INT,


        created_at DATETIME DEFAULT GETDATE(),

        CONSTRAINT fk_der_driver FOREIGN KEY (driver_id) REFERENCES silver.drivers(id),
        CONSTRAINT fk_der_team FOREIGN KEY (team_id) REFERENCES silver.teams(id),
        CONSTRAINT fk_der_race FOREIGN KEY (race_id) REFERENCES silver.races(id)
    );
END
        

        drop table if exists  silver.driver_event_result;
----------------------------------------------------------------------
-- Table: Team Championship Standings
----------------------------------------------------------------------
IF OBJECT_ID('silver.team_event_result', 'U') IS NULL
BEGIN
    CREATE TABLE silver.team_event_result
    (
        id INT IDENTITY PRIMARY KEY,
        team_id INT,
        event_points INT,
        pole_points INT,
        fastest_lap_points INT,
        event_status VARCHAR(50),
        total_extra_points INT,
        extra_participation_points INT,
        extra_participation_invalid INT,
        extra_not_started_points INT,
        extra_not_started_invalid INT,
        extra_not_classified_points INT,
        extra_not_classified_invalid INT,

        created_at DATETIME DEFAULT GETDATE(),
        CONSTRAINT fk_team_ FOREIGN KEY (team_id) REFERENCES silver.teams(id)
    );
END
