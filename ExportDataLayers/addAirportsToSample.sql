CREATE TEMP TABLE sample_airports_over240 AS 

select ors_id, adr, replace(split_part(ga_fb_geocoded_cities.coordinates, ',', 1), '[', '') lon, replace(split_part(coordinates, ', ', 2), ']', '') lat,
CASE WHEN origin_country = 'Austria' THEN 'Vienna International Airport'
	 WHEN origin_country = 'Czechia' THEN 'Václav Havel Airport Prague'
	 WHEN origin_country = 'Poland' THEN 'Warsaw Chopin Airport'
	 ELSE null
END destination, 
CASE WHEN origin_country = 'Austria' THEN array['16.561310614758202','48.12446934554131']
	 WHEN origin_country = 'Czechia' THEN array['14.276129249713593', '50.10983208306202']
	 WHEN origin_country = 'Poland' THEN array['20.97374942012459','52.169961141906576']
	 ELSE null
END destination_coordinates 
FROM ga_fb_geocoded_cities 
WHERE duration_min > 240
AND ga_fb_geocoded_cities.city_name <> ga_fb_geocoded_cities.country_name
AND ga_fb_geocoded_cities.sample_airport is null
AND origin_country in ('Austria', 'Czechia', 'Poland');
