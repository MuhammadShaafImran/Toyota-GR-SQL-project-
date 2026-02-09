/*==============================================================
  BRONZE LAYER BULK LOAD PROCEDURE
==============================================================*/

CREATE OR ALTER PROCEDURE bronze.barber_load_data
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY   
        BEGIN TRANSACTION;

        /*----------------------------------------------------------
          Provisional Results - Race 1
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_prov_res_r1;
        BULK INSERT bronze.barber_prov_res_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\03_Provisional Results_Race 1_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Provisional Results - Race 2
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_prov_res_r2;
        BULK INSERT bronze.barber_prov_res_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\03_Provisional Results_Race 2_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Official Results - Race 2
          (Fixing your mistake: you were inserting into wrong table)
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_res_r2;
        BULK INSERT bronze.barber_res_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\03_Results GR Cup Race 2 Official_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Provisional Results By Class - Race 1
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_prov_res_class_r1;
        BULK INSERT bronze.barber_prov_res_class_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\05_Provisional Results by Class_Race 1_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Provisional Results By Class - Race 2
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_prov_res_class_r2;
        BULK INSERT bronze.barber_prov_res_class_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\05_Provisional Results by Class_Race 2_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Official Results By Class - Race 1
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_res_class_r1;
        BULK INSERT bronze.barber_res_class_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\05_Results by Class GR Cup Race 1 Official_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Analysis Endurance - Race 1
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_analysis_r1;
        BULK INSERT bronze.barber_analysis_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\23_AnalysisEnduranceWithSections_Race 1_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Analysis Endurance - Race 2
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_analysis_r2;
        BULK INSERT bronze.barber_analysis_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\23_AnalysisEnduranceWithSections_Race 2_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Weather - Race 1
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.baber_weather_r1;
        BULK INSERT bronze.baber_weather_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\26_Weather_Race 1_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Weather - Race 2
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.baber_weather_r2;
        BULK INSERT bronze.baber_weather_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\26_Weather_Race 2_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Best 10 Laps - Race 1
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_best_10_lp_dr_r1;
        BULK INSERT bronze.barber_best_10_lp_dr_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\99_Best 10 Laps By Driver_Race 1_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Best 10 Laps - Race 2
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_best_10_lp_dr_r2;
        BULK INSERT bronze.barber_best_10_lp_dr_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\99_Best 10 Laps By Driver_Race 2_Anonymized.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ';',
            ROWTERMINATOR = '0x0A',
            TABLOCK,
            CODEPAGE = '65001'
        );

        /*----------------------------------------------------------
          Lap Start/End/Time + Telemetry (Comma delimited)
        ----------------------------------------------------------*/
        TRUNCATE TABLE bronze.barber_lp_start_r1;
        BULK INSERT bronze.barber_lp_start_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\R1_barber_lap_start.CSV'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0A');

        TRUNCATE TABLE bronze.barber_lp_end_r1;
        BULK INSERT bronze.barber_lp_end_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\R1_barber_lap_end.CSV'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0A');

        TRUNCATE TABLE bronze.barber_lp_time_r1;
        BULK INSERT bronze.barber_lp_time_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\R1_barber_lap_time.CSV'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0A');

        TRUNCATE TABLE bronze.barber_lp_start_r2;
        BULK INSERT bronze.barber_lp_start_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\R2_barber_lap_start.CSV'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0A');

        TRUNCATE TABLE bronze.barber_lp_end_r2;
        BULK INSERT bronze.barber_lp_end_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\R2_barber_lap_end.CSV'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0A');

        TRUNCATE TABLE bronze.barber_lp_time_r2;
        BULK INSERT bronze.barber_lp_time_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\R2_barber_lap_time.CSV'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0A');

        TRUNCATE TABLE bronze.barber_tel_r1;
        BULK INSERT bronze.barber_tel_r1
        FROM 'D:\Toyota GR (SQL project)\data\barber\R1_barber_telemetry_data.CSV'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0A');

        TRUNCATE TABLE bronze.barber_tel_r2;
        BULK INSERT bronze.barber_tel_r2
        FROM 'D:\Toyota GR (SQL project)\data\barber\R2_barber_telemetry_data.CSV'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0A');

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT 'Bronze Bulk Load Failed.';
        PRINT ERROR_MESSAGE();
    END CATCH;
END;

