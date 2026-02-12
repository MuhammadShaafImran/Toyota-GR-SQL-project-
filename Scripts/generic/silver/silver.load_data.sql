/*
    Load data from bronze to silver
*/


---------------------------------------------------------------------
-- Table: Events
---------------------------------------------------------------------

insert into silver.events (event_name)
select distinct substring(source_file, 1, charindex('\', source_file) - 1) as source_folder
from bronze.weather;

---------------------------------------------------------------------
-- Table: Races
---------------------------------------------------------------------

insert into silver.races(event_id, race_no)
select e.event_id, b.race_no 
from bronze.weather as b
join silver.events as e 
    on substring(b.source_file, 1, charindex('\', b.source_file) - 1) = e.event_name
group by e.event_id, b.race_no

---------------------------------------------------------------------
-- Table: Teams
---------------------------------------------------------------------

insert into silver.teams(name)
select distinct participant
from bronze.teams_championship;

---------------------------------------------------------------------
-- Table: Drivers
---------------------------------------------------------------------

with SplitNames as
(
    select
        substring(participant, 1, charindex(' ', participant) - 1) as name,
        substring(participant, charindex(' ', participant) + 1, len(participant)) as surname,
        country
    from bronze.drivers_championship
)

insert into silver.drivers(name, surname, country)
select 
    name, surname, max(country) as country
from SplitNames
group by name, surname;

---------------------------------------------------------------------
-- Table: Vehicles
---------------------------------------------------------------------

insert into silver.vehicles(name, car_number, manufacturer, class)
select distinct 'Toyota GR86' as name, number as car_number, 'Toyota Gazoo Racing' as manufacturer, 'Am' as class
from bronze.top_10_laps;

---------------------------------------------------------------------
-- Table: Weather
---------------------------------------------------------------------

insert into silver.weather (race_id, utc_datetime, air_temp, track_temp, humidity, pressure, wind_speed, wind_direction, rain)
select
    r.id as race_id,
    b.time_utc_str as utc_datetime,
    NULLIF(b.air_temp, 0) as air_temp,
    NULLIF(b.track_temp, 0) as track_temp,
    NULLIF(b.humidity, 0) as humidity,
    NULLIF(b.pressure, 0) as pressure,
    NULLIF(b.wind_speed, 0) as wind_speed,
    case
        when b.wind_direction IS NULL then NULL
        when b.wind_direction >= 337.5 or b.wind_direction < 22.5 then 'N'
        when b.wind_direction < 67.5 then 'NE'
        when b.wind_direction < 112.5 then 'E'
        when b.wind_direction < 157.5 then 'SE'
        when b.wind_direction < 202.5 then 'S'
        when b.wind_direction < 247.5 then 'SW'
        when b.wind_direction < 292.5 then 'W'
        when b.wind_direction < 337.5 then 'NW'
        else 'UNKNOWN'
    end as wind_direction,
    case 
        when b.rain = 0 then 'No' else 'Yes'
    end as rain
from bronze.weather as b
left join silver.races as r 
    on b.race_no = r.race_no and 
    substring(b.source_file, 1, charindex('\', b.source_file) - 1) = (select event_name from silver.events where event_id = r.event_id);

---------------------------------------------------------------------
-- top 10 laps
---------------------------------------------------------------------

insert into silver.top_10_laps (race_id, driver_id, team_id, vehicle_id, lap_number, lap_time, lap_rank)
select
    r.id as race_id,
    d.id as driver_id,
    t.id as team_id,
    v.id as vehicle_id,
    laps.lap_number,
    silver.fn_time_to_seconds(laps.lap_time) as lap_time,
    laps.lap_rank
from bronze.top_10_laps b
join silver.races r
    on r.race_no = b.race_no
    and substring(b.source_file, 1, charindex('\', b.source_file) - 1) = (select event_name from silver.events where event_id = r.event_id)
join silver.teams t
    on t.name = b.team
join silver.drivers d
    on d.name = b.firstname
    and d.surname = b.secondname
join silver.vehicles v
    on v.name = b.vehicle
    and v.car_number = b.number
    and v.class = b.class
cross apply
(
    values
        (b.bestlap_1_lapnum,  b.bestlap_1,  1),
        (b.bestlap_2_lapnum,  b.bestlap_2,  2),
        (b.bestlap_3_lapnum,  b.bestlap_3,  3),
        (b.bestlap_4_lapnum,  b.bestlap_4,  4),
        (b.bestlap_5_lapnum,  b.bestlap_5,  5),
        (b.bestlap_6_lapnum,  b.bestlap_6,  6),
        (b.bestlap_7_lapnum,  b.bestlap_7,  7),
        (b.bestlap_8_lapnum,  b.bestlap_8,  8),
        (b.bestlap_9_lapnum,  b.bestlap_9,  9),
        (b.bestlap_10_lapnum, b.bestlap_10, 10)
) laps (lap_number, lap_time, lap_rank)
where laps.lap_time is NOT NULL
    and laps.lap_number is NOT NULL;

---------------------------------------------------------------------
-- race results
---------------------------------------------------------------------

insert into silver.races_results
(
    race_id, driver_id, vehicle_id, team_id,  position, laps, total_time, gap_first_sec, lap_first_gap, gap_previous_sec, lap_previous_gap, best_lap_no, best_lap_time, best_lap_speed, source
)
select
    r.id as race_id,
    d.id as driver_id,
    v.id as vehicle_id,
    t.id as team_id,

    b.pos as position,
    b.laps,

    -- total time
    silver.fn_time_to_seconds(b.elapsed) as total_time,
    -- gap first sec
    silver.fn_time_to_seconds(b.gap_first) as gap_first_sec,

    -- lap gap first
    case
        when b.gap_first like '%laps%' then
            cast(left(b.gap_first, charindex(' ', b.gap_first) - 1) as int)
        else null
    end as lap_first_gap,

    -- gap previous
    silver.fn_time_to_seconds(b.gap_previous) as gap_previous_sec,
    -- lap gap previous
    case
        when b.gap_previous like '%laps%' then
            cast(left(b.gap_previous, charindex(' ', b.gap_previous) - 1) as int)
        else null
    end as lap_previous_gap,

    b.best_lap_num as best_lap_no,

    -- best lap time
    silver.fn_time_to_seconds(b.best_lap_time) as best_lap_time,
    b.best_lap_kph as best_lap_speed,

    case 
        when b.source_file like '%provisional%' then 'provisional' else 'official'
    end as source

from bronze.prov_off_results_class b

join silver.races r
    on r.race_no = b.race_no
    and substring(b.source_file, 1, charindex('\', b.source_file) - 1) =
        (select event_name from silver.events where event_id = r.event_id)

join silver.drivers d
    on d.name + ' ' + d.surname = b.driver

join silver.teams t
    on t.name = b.team

join silver.vehicles v
    on v.name = b.vehicle
    and v.car_number = b.number;


---------------------------------------------------------------------
-- lap analysis
---------------------------------------------------------------------

insert into silver.lap_analysis
(
    race_id, driver_id, team_id, vehicle_id, lap_number, lap_time_sec, lap_improvement, speed_kph, top_speed, elapsed_sec, race_hour, pit_time, crossed_finish_in_pit, flag_at_finish, finish_line_time, finish_line_elapsed
)
select
    r.id as race_id,
    d.id as driver_id,
    t.id as team_id,
    v.id as vehicle_id,
    b.lap_number,
    silver.fn_time_to_seconds(b.lap_time) as lap_time_sec,
    b.lap_improvement,
    b.kph as speed_kph,
    b.top_speed,
    silver.fn_time_to_seconds(b.elapsed) as elapsed_sec,
    cast(b.hour as time(3)) as race_hour,
    cast(b.pit_time as time(3)) as pit_time,
    b.crossing_finish_line_in_pit as crossed_finish_in_pit,
    b.flag_at_fl as flag_at_finish,
    silver.fn_time_to_seconds(b.fl_time) as finish_line_time,
    silver.fn_time_to_seconds(b.fl_elapsed) as finish_line_elapsed

from bronze.analysis_endurance b
join silver.races r
    on r.race_no = b.race_no
    and substring(b.source_file, 1, charindex('\', b.source_file) - 1) =
        (select event_name from silver.events where event_id = r.event_id)
join silver.drivers d      on d.name + ' ' + d.surname = b.driver_name
join silver.teams t        on t.name = b.team
join silver.vehicles v     on v.car_number = b.number;


---------------------------------------------------------------------
-- lap sectors
---------------------------------------------------------------------

insert into silver.lap_sectors (lap_analysis_id, s1_sec, s2_sec, s3_sec, s1_improvement, s2_improvement, s3_improvement )
select 
    la.id as lap_analysis_id,
    silver.fn_time_to_seconds(b.s1) as s1_sec,
    silver.fn_time_to_seconds(b.s2) as s2_sec,
    silver.fn_time_to_seconds(b.s3) as s3_sec,
    b.s1_improvement,
    b.s2_improvement,
    b.s3_improvement

from bronze.analysis_endurance b
join silver.races r
    on r.race_no = b.race_no
    and substring(b.source_file, 1, charindex('\', b.source_file) - 1) =
        (select event_name from silver.events where event_id = r.event_id)
join silver.drivers d
    on d.name + ' ' + d.surname = b.driver_name

join silver.lap_analysis la
    on la.race_id = r.id
    and la.driver_id = d.id
    and la.lap_number = b.lap_number;


---------------------------------------------------------------------
-- lap intermediate
---------------------------------------------------------------------

insert into silver.lap_intermediates (lap_analysis_id, im1_time_sec, im1_elapsed_sec, im2_time_sec, im2_elapsed_sec, im3a_time_sec, im3a_elapsed_sec)
select
    la.id,
    silver.fn_time_to_seconds(b.im1_time) as im1_time_sec,
    silver.fn_time_to_seconds(b.im1_elapsed) as im1_elapsed_sec,
    silver.fn_time_to_seconds(b.im2_time) as im2_time_sec,
    silver.fn_time_to_seconds(b.im2_elapsed) as im2_elapsed_sec,
    silver.fn_time_to_seconds(b.im3a_time) as im3a_time_sec,
    silver.fn_time_to_seconds(b.im3a_elapsed) as im3a_elapsed_sec

from bronze.analysis_endurance b

join silver.races r
    on r.race_no = b.race_no
    and substring(b.source_file, 1, charindex('\', b.source_file) - 1) =
        (select event_name from silver.events where event_id = r.event_id)

join silver.drivers d
    on d.name + ' ' + d.surname = b.driver_name

join silver.lap_analysis la
    on la.race_id = r.id
    and la.driver_id = d.id
    and la.lap_number = b.lap_number;

---------------------------------------------------------------------
-- Drivers Championship Standings
---------------------------------------------------------------------

EXEC silver.Build_Event_View
    @SourceSchema = 'bronze',
    @SourceTable  = 'drivers_championship',
    @ViewSchema   = 'silver',
    @ViewName     = 'driver_eventData';


insert into silver.driver_event_result(race_id, driver_id, team_id, vehicle_id, position, event_points, pole_points, fastest_lap_points, event_status, total_extra_points, extra_participation_points, extra_participation_invalid, extra_not_started_points, extra_not_started_invalid, extra_not_classified_points, extra_not_classified_invalid)
select 
    r.id as race_id,
    d.id as driver_id,
    t.id as team_id, 
    v.id as vehicle_id,
    b.pos as position, 
    fd.event_points, 
    fd.pole_points, 
    fd.fastest_lap_points, 
    fd.event_status, 
    fd.total_extra_points, 
    fd.extra_participation_points, 
    fd.extra_participation_invalid, 
    fd.extra_not_started_points, 
    fd.extra_not_started_invalid, 
    fd.extra_not_classified_points, 
    fd.extra_not_classified_invalid 

from silver.driver_eventData as fd 

join bronze.drivers_championship as b 
    on fd.Id = b.Id 

left join silver.races as r 
    on fd.race_no = r.race_no 

left join silver.events e 
    on e.event_id = r.event_id 
    and ( 
            case lower(fd.EventName) 
                when 'barber' then 'Barber Motorsports Park'
                when 'indy' then 'Indianapolis Motor Speedway RC' 
                when 'sonoma' then 'Sonoma Raceway' 
                when 'roadamerica' then 'Road America' 
                when 'sebring' then 'Sebring International Raceway' 
                when 'vir' then 'VIRginia International Raceway' 
                when 'cota' then 'Circuit of the Americas' 
            end 
        ) = e.event_name 

left join silver.drivers as d 
    on d.name + ' ' + d.surname = b.participant

left join silver.teams as t 
    on t.name = b.team 

left join silver.vehicles as v
    on v.car_number = b.number and v.manufacturer = b.manufacturer and v.class = b.class

---------------------------------------------------------------------
-- Teams Championship Standings
---------------------------------------------------------------------

EXEC silver.Build_Event_View
    @SourceSchema = 'bronze',
    @SourceTable  = 'drivers_championship',
    @ViewSchema   = 'silver',
    @ViewName     = 'team_eventData';

insert into silver.team_event_result(team_id, event_points, pole_points, fastest_lap_points, event_status, total_extra_points, extra_participation_points, extra_participation_invalid, extra_not_started_points, extra_not_started_invalid, extra_not_classified_points, extra_not_classified_invalid)
select
    t.id as team_id,
    fd.event_points, 
    fd.pole_points, 
    fd.fastest_lap_points, 
    fd.event_status, 
    fd.total_extra_points, 
    fd.extra_participation_points, 
    fd.extra_participation_invalid, 
    fd.extra_not_started_points, 
    fd.extra_not_started_invalid, 
    fd.extra_not_classified_points, 
    fd.extra_not_classified_invalid 

from bronze.team_eventData as fd 

join bronze.teams_championship as b 
    on fd.Id = b.id 

left join silver.teams as t 
    on t.name = b.participant 
