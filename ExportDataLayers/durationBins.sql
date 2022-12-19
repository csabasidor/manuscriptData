CREATE TEMP TABLE ga_duration_bins AS 
select origin_country, "durationBin", sum("Users") "Users", sum("Sessions") "Sessions"  
FROM
(select ga_city_sample.*, ga_fb_geocoded_cities.distance_km, ga_fb_geocoded_cities.duration_min,
	CASE 
		WHEN ga_fb_geocoded_cities.duration_min <= 60 then 'a Within 60 min'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 61 and 120 then 'b Within 61 to 120 min'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 121 and 180 then 'c Within 121 to 180'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 181 and 240 then 'd Within 181 to 240'
		WHEN ga_fb_geocoded_cities.duration_min > 240 THEN 'e Over 240 min'
		ELSE null
	END "durationBin"
from ga_city_sample, ga_fb_geocoded_cities
WHERE ga_city_sample.origin_city || ', ' || ga_city_sample.origin_country = ga_fb_geocoded_cities.adr
AND ga_city_sample.origin_city <> '(not set)'
AND ga_city_sample.origin_city is not null
AND distance_km is not null
AND REGEXP_REPLACE(ga_city_sample.origin_city,'[[:digit:]]','','g') <> ''
AND ga_fb_geocoded_cities.city_name <> ga_fb_geocoded_cities.country_name
) ga
GROUP BY origin_country, "durationBin";

CREATE TEMP TABLE ga_duration_bins_share AS
WITH country_totals AS (SELECT origin_country, SUM("Users") "Users", SUM("Sessions") "Sessions" FROM ga_duration_bins GROUP BY origin_country)
SELECT ga_duration_bins.*, round(((ga_duration_bins."Users"/country_totals."Users")::numeric*100), 2) pct_share_users,
round(((ga_duration_bins."Sessions"/country_totals."Sessions")::numeric*100), 2) pct_share_sessions
FROM ga_duration_bins, country_totals
WHERE ga_duration_bins.origin_country = country_totals.origin_country;


CREATE TEMP TABLE fb_duration_bins AS 
select origin_country, "durationBin", sum("Impressions") "Impressions", sum("Content Activity") "Content Activity"  
FROM
(select fb_city_sample.*, ga_fb_geocoded_cities.distance_km, ga_fb_geocoded_cities.duration_min,
	CASE 
		WHEN ga_fb_geocoded_cities.duration_min <= 60 then 'a Within 60 min'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 61 and 120 then 'b Within 61 to 120 min'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 121 and 180 then 'c Within 121 to 180'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 181 and 240 then 'd Within 181 to 240'
		WHEN ga_fb_geocoded_cities.duration_min > 240 THEN 'e Over 240 min'
		ELSE null
	END "durationBin"
from fb_city_sample, ga_fb_geocoded_cities
WHERE fb_city_sample.origin_city || ', ' || fb_city_sample.origin_country = ga_fb_geocoded_cities.adr
AND fb_city_sample.origin_city <> '(not set)'
AND fb_city_sample.origin_city is not null
AND distance_km is not null
AND REGEXP_REPLACE(fb_city_sample.origin_city,'[[:digit:]]','','g') <> ''
AND ga_fb_geocoded_cities.city_name <> ga_fb_geocoded_cities.country_name
) ga
GROUP BY origin_country, "durationBin";


CREATE TEMP TABLE fb_duration_bins_share AS
WITH country_totals AS (SELECT origin_country, SUM("Impressions") "Impressions", SUM("Content Activity") "Content Activity" FROM fb_duration_bins GROUP BY origin_country)
SELECT fb_duration_bins.*, round(((fb_duration_bins."Impressions"/country_totals."Impressions")::numeric*100), 2) pct_share_impressions,
round(((fb_duration_bins."Content Activity"/country_totals."Content Activity")::numeric*100), 2) pct_share_content_activity
FROM fb_duration_bins, country_totals
WHERE fb_duration_bins.origin_country = country_totals.origin_country;


--MONTHLY GOOGLE ANALYTICS SAMPLE
CREATE TEMP TABLE ga_monthly_duration_bins AS 
select origin_country, month_unified, "durationBin", sum("Users") "Users", sum("Sessions") "Sessions"  
FROM
(select ga_city_sample.*, ga_fb_geocoded_cities.distance_km, ga_fb_geocoded_cities.duration_min,
	CASE 
		WHEN ga_fb_geocoded_cities.duration_min <= 60 then 'a Within 60 min'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 61 and 120 then 'b Within 61 to 120 min'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 121 and 180 then 'c Within 121 to 180'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 181 and 240 then 'd Within 181 to 240'
		WHEN ga_fb_geocoded_cities.duration_min > 240 THEN 'e Over 240 min'
		ELSE null
	END "durationBin"
from ga_city_sample, ga_fb_geocoded_cities
WHERE ga_city_sample.origin_city || ', ' || ga_city_sample.origin_country = ga_fb_geocoded_cities.adr
AND ga_city_sample.origin_city <> '(not set)'
AND ga_city_sample.origin_city is not null
AND distance_km is not null
AND REGEXP_REPLACE(ga_city_sample.origin_city,'[[:digit:]]','','g') <> ''
AND ga_fb_geocoded_cities.city_name <> ga_fb_geocoded_cities.country_name
) ga
GROUP BY origin_country, month_unified, "durationBin"
ORDER BY origin_country, month_unified, "durationBin";

CREATE TEMP TABLE ga_monthly_duration_bins_share AS
WITH country_totals AS (SELECT origin_country, month_unified, SUM("Users") "Users", SUM("Sessions") "Sessions" FROM ga_monthly_duration_bins GROUP BY origin_country, month_unified)
SELECT ga_monthly_duration_bins.*, round(((ga_monthly_duration_bins."Users"/country_totals."Users")::numeric*100), 2) pct_share_users,
round(((ga_monthly_duration_bins."Sessions"/country_totals."Sessions")::numeric*100), 2) pct_share_sessions
FROM ga_monthly_duration_bins, country_totals
WHERE ga_monthly_duration_bins.origin_country = country_totals.origin_country AND ga_monthly_duration_bins.month_unified = country_totals.month_unified;

CREATE TEMP TABLE fb_monthly_duration_bins AS 
select origin_country, month_unified, "durationBin", sum("Impressions") "Impressions", sum("Content Activity") "Content Activity"  
FROM
(select fb_city_sample.*, ga_fb_geocoded_cities.distance_km, ga_fb_geocoded_cities.duration_min,
	CASE 
		WHEN ga_fb_geocoded_cities.duration_min <= 60 then 'a Within 60 min'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 61 and 120 then 'b Within 61 to 120 min'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 121 and 180 then 'c Within 121 to 180'
		WHEN ga_fb_geocoded_cities.duration_min BETWEEN 181 and 240 then 'd Within 181 to 240'
		WHEN ga_fb_geocoded_cities.duration_min > 240 THEN 'e Over 240 min'
		ELSE null
	END "durationBin"
from fb_city_sample, ga_fb_geocoded_cities
WHERE fb_city_sample.origin_city || ', ' || fb_city_sample.origin_country = ga_fb_geocoded_cities.adr
AND fb_city_sample.origin_city <> '(not set)'
AND fb_city_sample.origin_city is not null
AND distance_km is not null
AND REGEXP_REPLACE(fb_city_sample.origin_city,'[[:digit:]]','','g') <> ''
AND ga_fb_geocoded_cities.city_name <> ga_fb_geocoded_cities.country_name
) ga
GROUP BY origin_country, month_unified, "durationBin"
ORDER BY origin_country, month_unified, "durationBin";



CREATE TEMP TABLE fb_monthly_duration_bins_share AS
WITH country_totals AS (SELECT origin_country, month_unified, SUM("Impressions") "Impressions", SUM("Content Activity") "Content Activity" FROM fb_monthly_duration_bins GROUP BY origin_country, month_unified)
SELECT fb_monthly_duration_bins.*, round(((fb_monthly_duration_bins."Impressions"/country_totals."Impressions")::numeric*100), 2) pct_share_impressions,
round(((fb_monthly_duration_bins."Content Activity"/country_totals."Content Activity")::numeric*100), 2) pct_share_content_activity
FROM fb_monthly_duration_bins, country_totals
WHERE fb_monthly_duration_bins.origin_country = country_totals.origin_country AND fb_monthly_duration_bins.month_unified = country_totals.month_unified
ORDER BY origin_country, month_unified, "durationBin";