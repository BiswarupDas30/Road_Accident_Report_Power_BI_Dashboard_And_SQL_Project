Select * from road_accident;
Select SUM(number_of_casualties) as CY_Casualties from road_accident where YEAR(accident_date)='2022';
Select COUNT(accident_index) as CY_Accidents from road_accident where YEAR(accident_date)='2022';
Select SUM(number_of_casualties) as CY_Fatal_Casualties from road_accident where YEAR(accident_date)='2022' AND accident_severity='Fatal';
Select SUM(number_of_casualties) as CY_Serious_Casualties from road_accident where YEAR(accident_date)='2022' AND accident_severity='Serious';
Select SUM(number_of_casualties) as CY_Slight_Casualties from road_accident where YEAR(accident_date)='2022' AND accident_severity='Slight';
Select distinct(vehicle_type) from road_accident;
Select
	case
		when vehicle_type in ('Agricultural vehicle') then 'Agricultural'
		when vehicle_type in ('Car','Taxi/Private hire car') then 'Car'
		when vehicle_type in ('Motorcycle 50cc and under','Motorcycle over 500cc','Motorcycle over 125cc and up to 500cc','Motorcycle 125cc and under','Pedal cycle') then 'Bike'
		when vehicle_type in ('Minibus (8 - 16 passenger seats)','Bus or coach (17 or more pass seats)') then 'Bus'
		when vehicle_type in ('Van / Goods 3.5 tonnes mgw or under','Goods over 3.5t. and under 7.5t','Goods 7.5 tonnes mgw and over') then 'Van'
		else 'Other'
	end as Vehicle_Group,
	SUM(number_of_casualties) as Total_Casualties_By_Vehicle_Type 
from road_accident 
group by
	case
		when vehicle_type in ('Agricultural vehicle') then 'Agricultural'
		when vehicle_type in ('Car','Taxi/Private hire car') then 'Car'
		when vehicle_type in ('Motorcycle 50cc and under','Motorcycle over 500cc','Motorcycle over 125cc and up to 500cc','Motorcycle 125cc and under','Pedal cycle') then 'Bike'
		when vehicle_type in ('Minibus (8 - 16 passenger seats)','Bus or coach (17 or more pass seats)') then 'Bus'
		when vehicle_type in ('Van / Goods 3.5 tonnes mgw or under','Goods over 3.5t. and under 7.5t','Goods 7.5 tonnes mgw and over') then 'Van'
		else 'Other'
	end
order by Vehicle_Group;
Select DATENAME(MONTH,accident_date) as Month_Name,SUM(number_of_casualties) as PY_Casualties from road_accident where YEAR(accident_date)='2021' group by DATENAME(MONTH,accident_date),MONTH(accident_date) order by MONTH(accident_date);
Select urban_or_rural_area as Area_Type,CAST(((CAST(SUM(number_of_casualties) as decimal(10,2))*100)/(Select CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) from road_accident)) as decimal(10,2)) as Total_Casualties_Percentage_By_Road_Type from road_accident group by urban_or_rural_area order by urban_or_rural_area;
Select
	case
		when light_conditions in ('Daylight') then 'Day'
		else 'Night'
	end as Light_Group,
	CAST((CAST(SUM(number_of_casualties) as decimal(10,2))*100)/(Select CAST(SUM(number_of_casualties)as decimal(10,2)) from road_accident)as decimal(10,2)) as Total_Casualties_Percentage_By_Light_Condition
from road_accident
group by 
	case
		when light_conditions in ('Daylight') then 'Day'
		else 'Night'
	end
order by Light_Group;

Select top 10 local_authority as Location,SUM(number_of_casualties) as Total_Casualties from road_accident group by local_authority order by Total_Casualties DESC;

