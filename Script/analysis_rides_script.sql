SELECT * FROM Project2_analytics.rides limit 1000;

SELECT * FROM Project2_analytics.stations limit 1000;

SELECT * FROM Project2_analytics.users limit 1000;

-- get count of rows per table
SELECT
	(SELECT COUNT(*) FROM Project2_analytics.rides) AS total_rides,
	(SELECT COUNT(*) FROM Project2_analytics.stations) AS total_stations,
	(SELECT COUNT(*) FROM Project2_analytics.users) AS total_users;
    

-- missing for missing values
SELECT

	SUM(ride_id IS NULL) AS null_ride_ids, 
    SUM(user_id IS NULL) AS null_user_id,
	SUM(start_time IS NULL) AS null_start_time,
	SUM(end_time IS NULL) AS null_end_time

FROM Project2_analytics.rides;


-- Summary statistics for the rides table
SELECT
	
    MIN(distance_km) AS min_dist,
	MAX(distance_km) AS max_dist,
	AVG(distance_km) AS avg_dist,
	MIN(TIMESTAMPDIFF(MINUTE,start_time,end_time)) AS min_duration_mins, 
    MAX(TIMESTAMPDIFF(MINUTE,start_time,end_time)) AS max_duration_mins, 
    AVG(TIMESTAMPDIFF(MINUTE,start_time,end_time)) AS avg_duration_mins
    
FROM Project2_analytics.rides;


-- checking for false starts for the rides

SELECT
	
    SUM(CASE WHEN (TIMESTAMPDIFF(MINUTE,start_time,end_time)<2) THEN 1 ELSE 0 END) AS short_duration_trips,
	SUM(CASE WHEN (distance_km = 0) THEN 1 ELSE 0 END) AS zero_distance_trips

FROM Project2_analytics.rides;


-- different memebrship
SELECT
	u.membership_level, 
    COUNT(r.ride_id) AS total_rides,
	AVG(r.distance_km) AS avg_distance_km,
	AVG(TIMESTAMPDIFF(MINUTE,r.start_time,r.end_time)) AS avg_duration_mins

FROM Project2_analytics.rides AS r
JOIN Project2_analytics.users AS u
ON r.user_id = u.user_id

GROUP BY u.membership_level
ORDER BY total_rides DESC;

-- peek hours

SELECT

	EXTRACT(HOUR FROM start_time) AS hour_of_day,
	COUNT(*) AS ride_count

FROM Project2_analytics.rides
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- check for popular stations

SELECT
	s.station_name,
	COUNT(r.ride_id) AS total_starts

FROM Project2_analytics.rides AS r
JOIN Project2_analytics.stations AS s
ON r.start_station_id = s.station_id

GROUP BY s.station_name
ORDER BY total_starts DESC
LIMIT 10;

-- Categorizing rides into Short, Medium,and Long

SELECT
	
    CASE
		WHEN TIMESTAMPDIFF(MINUTE,start_time,end_time) <= 10 THEN 'Short (<10m)'
		WHEN TIMESTAMPDIFF(MINUTE,start_time,end_time) BETWEEN 11 AND 30 THEN 'Medium (11-30m)'
		ELSE 'Long (>38m)'
	END AS ride_category,

	COUNT(*) AS count_of_rides

FROM Project2_analytics.rides
GROUP BY ride_category
ORDER BY count_of_rides DESC;

-- net flow for each station

WITH departures AS (
	
    SELECT start_station_id, COUNT(*) AS total_departures
	FROM Project2_analytics.rides
	GROUP BY 1
    
),

arrivals AS (

	SELECT end_station_id, COUNT(*) AS total_arrivals
	FROM Project2_analytics.rides
	GROUP BY 1

)

SELECT
	s. station_name,
	d. total_departures,
	a. total_arrivals,
	(a. total_arrivals - d. total_departures) AS net_flow

FROM Project2_analytics.stations AS s
JOIN departures d ON s.station_id = d.start_station_id
JOIN arrivals a ON s.station_id = a.end_station_id

ORDER BY net_flow ASC;

-- user retention

WITH monthly_signups AS (
	
    SELECT
		DATE_FORMAT(created_at, '%Y-%m-01') AS signup_month,
		COUNT(user_id) AS new_user_count

	FROM Project2_analytics.users
    GROUP BY signup_month
    
)

SELECT
	
    signup_month, 
    new_user_count,
	LAG(new_user_count) OVER (ORDER BY signup_month) AS previous_month_count,
    (new_user_count - LAG(new_user_count) OVER (ORDER BY signup_month) ) /
	NULLIF(LAG(new_user_count) OVER (ORDER BY signup_month), 0) *100 AS mom_growth

FROM monthly_signups 
order by signup_month;





