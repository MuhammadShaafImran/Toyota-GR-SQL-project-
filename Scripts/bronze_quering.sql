select top 5 * 
from bronze.barber_prov_res_r1;

select top 5 *
from bronze.barber_prov_res_class_r1;


select 
	t2.*
from bronze.barber_prov_res_r1 as t1
join bronze.barber_prov_res_class_r1 as t2 on t1.number = t2.number
where 
	t1.number <> t2.number or
	t1.position <> t2.pos or
	t1.vehicle <> t2.vehicle or
	t1.class <> t2.class_type or 
	t1.laps	<> t2.laps or 
	t1.total_time <> t2.elapsed	or
	t1.gap_first <> t2.gap_first or
	t1.gap_previous	<> t2.gap_previous or
	t1.fl_time <> t2.best_lap_time or
	t1.fl_kph <> t2.best_lap_kph


select *
from bronze.barber_prov_res_r1
where number in (58, 80, 51, 18);

select *
from bronze.barber_prov_res_class_r1
where number in (58, 80, 51, 18);

select top 5 *
from bronze.barber_prov_res_r2;

select top 5 *
from bronze.barber_prov_res_class_r1;

select class_type, pic, count(*) as total_count
from bronze.barber_prov_res_class_r1
group by class_type, pic;

select *
from bronze.barber_res_class_r1;

select top 5 *
from bronze.barber_prov_res_class_r2;

select top 5 *
from bronze.barber_analysis_r1;

select distinct driver_number
from bronze.barber_analysis_r2;

select 
	driver_number, 
	count(*) as races_count
from bronze.barber_analysis_r1
group by driver_number;

select 
	number, 
	count(*) as car_number_count
from bronze.barber_analysis_r1
group by number;

select top 5 *
from bronze.barber_best_10_lp_dr_r1;

select top 5 * 
from bronze.barber_lp_start_r1;

select top 5 *
from bronze.barber_lp_end_r1;

select top 5 *
from bronze.barber_lp_time_r1;

select top 5 * 
from bronze.barber_tel_r1;


select *
from bronze.barber_prov_res_r1;

select top 5 *
from bronze.baber_weather_r1;

select top 5 *
from bronze.baber_weather_r2;