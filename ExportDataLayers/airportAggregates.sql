--Google Analytics
CREATE TEMP TABLE ga_airports_agg AS
SELECT ga_fb_geocoded_cities.sample_airport, 
CASE 
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric <= 60 then 'a Within 60 min'
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric BETWEEN 61 and 120 then 'b Within 61 to 120 min'
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric BETWEEN 121 and 180 then 'c Within 121 to 180'
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric BETWEEN 181 and 240 then 'd Within 181 to 240'
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric > 240 THEN 'e Over 240 min'
		ELSE null
	END "durationBin",
sum(ga_city_sample."Users") "Users", sum(ga_city_sample."Sessions") "Sessions"
FROM ga_fb_geocoded_cities, ga_city_sample
WHERE ga_fb_geocoded_cities.sample_airport IS NOT NULL
AND ga_fb_geocoded_cities.origin_country IN ('Austria', 'Czechia', 'Poland')
AND ga_city_sample.origin_city || ', ' || ga_city_sample.origin_country = ga_fb_geocoded_cities.adr
GROUP by ga_fb_geocoded_cities.sample_airport, "durationBin"
ORDER BY ga_fb_geocoded_cities.sample_airport, "durationBin";


CREATE TEMP TABLE ga_airports_agg_share AS
WITH country_totals AS (SELECT sample_airport, SUM("Users") "Users", SUM("Sessions") "Sessions" FROM ga_airports_agg GROUP BY sample_airport)
SELECT ga_airports_agg.*, round(((ga_airports_agg."Users"/country_totals."Users")::numeric*100), 2) pct_share_users,
round(((ga_airports_agg."Sessions"/country_totals."Sessions")::numeric*100), 2) pct_share_sessions
FROM ga_airports_agg, country_totals
WHERE ga_airports_agg.sample_airport = country_totals.sample_airport;

--FACEBOOK
CREATE TEMP TABLE fb_airports_agg AS
SELECT ga_fb_geocoded_cities.sample_airport, 
CASE 
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric <= 60 then 'a Within 60 min'
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric BETWEEN 61 and 120 then 'b Within 61 to 120 min'
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric BETWEEN 121 and 180 then 'c Within 121 to 180'
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric BETWEEN 181 and 240 then 'd Within 181 to 240'
		WHEN ga_fb_geocoded_cities.min_to_airport::numeric > 240 THEN 'e Over 240 min'
		ELSE null
	END "durationBin",
sum(fb_city_sample."Impressions") "Impressions", sum(fb_city_sample."Content Activity") "Content Activity"
FROM ga_fb_geocoded_cities, fb_city_sample
WHERE ga_fb_geocoded_cities.sample_airport IS NOT NULL
AND ga_fb_geocoded_cities.origin_country IN ('Austria', 'Czechia', 'Poland')
AND fb_city_sample.origin_city || ', ' || fb_city_sample.origin_country = ga_fb_geocoded_cities.adr
GROUP by ga_fb_geocoded_cities.sample_airport, "durationBin"
ORDER BY ga_fb_geocoded_cities.sample_airport, "durationBin";


CREATE TEMP TABLE fb_airports_agg_share AS
WITH country_totals AS (SELECT sample_airport, SUM("Impressions") "Impressions", SUM("Content Activity") "Content Activity" FROM fb_airports_agg GROUP BY sample_airport)
SELECT fb_airports_agg.*, round(((fb_airports_agg."Impressions"/country_totals."Impressions")::numeric*100), 2) pct_share_impressions,
round(((fb_airports_agg."Content Activity"/country_totals."Content Activity")::numeric*100), 2) pct_share_content_activtiy
FROM fb_airports_agg, country_totals
WHERE fb_airports_agg.sample_airport = country_totals.sample_airport;

