--CREATE TEMPORARY TABLE CONTAINING HARMONIZED DATA FROM SUSR DATA; INPUT SET: inputCr3804mr
CREATE TEMP TABLE susr_country_month AS
SELECT nuts14_x id_nuts, nuts14_y name_nuts, cr3804mr_dim3_x id_dim_native, cr3804mr_dim3_y name_dim_native, cr3804mr_dim3_y name_dim_unified, cr3804mr_ukaz_x id_var_native, cr3804mr_ukaz_y name_var_native, cr3804mr_rok_y::integer year_native, cr3804mr_mes_y month_native, "Value_y" val, 'SUSR'::TEXT value_source,
'cr3804mr'::TEXT id_source_native, 'Occupancy of accommodation estabishment - districts (countries)'::TEXT name_source_native,
CASE 
	WHEN cr3804mr_mes_y LIKE '0%' THEN CAST(REPLACE(cr3804mr_mes_y, '0', '') AS INTEGER)
	WHEN cr3804mr_mes_y LIKE '%.' AND cr3804mr_mes_y NOT LIKE '%-%'  THEN CAST(REPLACE(cr3804mr_mes_y, '.', '') AS INTEGER)
	ELSE CAST(cr3804mr_mes_y AS INTEGER) 
END month_unified 
FROM "inputCr3804mr"
WHERE nuts14_x LIKE 'SK0422_0425%' AND cr3804mr_mes_x <> '1. - 12.' AND  cr3804mr_rok_y::INTEGER  = 2021
ORDER BY nuts14_y, cr3804mr_ukaz_x, cr3804mr_dim3_y, month_unified;

--CREATE TEMP TABLE MONTHLY FOR SELECT MARKET
CREATE TEMP TABLE visitors AS
SELECT month_unified, sum(val) "Number of visitors" 
FROM susr_country_month  
WHERE name_dim_native in ('Domestic visitors') AND name_var_native = 'Number of visitors total'
GROUP BY month_unified
ORDER BY month_unified;

CREATE TEMP TABLE fb_bins_sample AS 
SELECT month_unified, "durationBin", "Impressions", pct_share_impressions, "Content Activity", pct_share_content_activity
FROM fb_monthly_duration_bins_share 
WHERE origin_country = 'Slovakia';

--GA TEMP BINS
CREATE TEMP TABLE ga_bins_sample AS 
SELECT month_unified, "durationBin", "Users", pct_share_users, "Sessions", pct_share_sessions
FROM ga_monthly_duration_bins_share 
WHERE origin_country = 'Slovakia';


CREATE TEMP TABLE corr_coefs AS
SELECT ga_bins_sample."durationBin", 
round(corr(visitors."Number of visitors", ga_bins_sample."Users")::numeric, 4) "Corr n Users",
round(corr(visitors."Number of visitors", ga_bins_sample.pct_share_users)::numeric, 4) "Corr % Users",
round(corr(visitors."Number of visitors", ga_bins_sample."Sessions")::numeric, 4) "Corr n Sessions",
round(corr(visitors."Number of visitors", ga_bins_sample.pct_share_sessions)::numeric, 4) "Corr % Sessions",
round(corr(visitors."Number of visitors", fb_bins_sample."Impressions")::numeric, 4) "Corr n Impressions",
round(corr(visitors."Number of visitors", fb_bins_sample.pct_share_impressions)::numeric, 4) "Corr % Impressions",
round((corr(visitors."Number of visitors", ga_bins_sample."Users")^2)::numeric*100, 2) "Coef. Determination n Users",
round((corr(visitors."Number of visitors", ga_bins_sample.pct_share_users)^2)::numeric*100, 2) "Coef. Determination % Users",
round((corr(visitors."Number of visitors", ga_bins_sample."Sessions")^2)::numeric*100, 2) "Coef. Determination n Sessions",
round((corr(visitors."Number of visitors", ga_bins_sample.pct_share_sessions)^2)::numeric*100, 2) "Coef. Determination % Sessions",
round((corr(visitors."Number of visitors", fb_bins_sample."Impressions")^2)::numeric*100, 2) "Coef. Determination n Impressions",
round((corr(visitors."Number of visitors", fb_bins_sample.pct_share_impressions)^2)::numeric*100, 2) "Coef. Determination % Impressions"

FROM ga_bins_sample, fb_bins_sample, visitors 
where ga_bins_sample.month_unified = visitors.month_unified
AND ga_bins_sample."durationBin" = fb_bins_sample."durationBin"
AND fb_bins_sample.month_unified = visitors.month_unified
GROUP BY ga_bins_sample."durationBin"
ORDER BY ga_bins_sample."durationBin";
