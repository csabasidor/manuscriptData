--CREATE TEMPORARY TABLE CONTAINING HARMONIZED DATA FROM SUSR DATA; INPUT SET: inputCr3804mr
CREATE TEMP TABLE susr_country_month AS
SELECT nuts14_x id_nuts, nuts14_y name_nuts, cr3804mr_dim3_x id_dim_native, cr3804mr_dim3_y name_dim_native, cr3804mr_dim3_y name_dim_unified, cr3804mr_ukaz_x id_var_native, cr3804mr_ukaz_y name_var_native, cr3804mr_rok_y::integer year_native, cr3804mr_mes_y month_native, "Value_y" val, 'SUSR'::TEXT value_source,
'cr3804mr'::TEXT id_source_native, 'Occupancy of accommodation estabishment - districts (countries)'::TEXT name_source_native,
CASE 
	WHEN cr3804mr_mes_y LIKE '0%' THEN CAST(REPLACE(cr3804mr_mes_y, '0', '') AS INTEGER)
	WHEN cr3804mr_mes_y LIKE '%.' AND cr3804mr_mes_y NOT LIKE '%-%'  THEN CAST(REPLACE(cr3804mr_mes_y, '.', '') AS INTEGER)
	ELSE CAST(cr3804mr_mes_y AS INTEGER) 
END month_unified 
FROM inputCr3804mr
WHERE nuts14_x LIKE 'SK0422_0425%' AND cr3804mr_mes_x <> '1. - 12.' AND  cr3804mr_rok_y::INTEGER  = 2021
ORDER BY nuts14_y, cr3804mr_ukaz_x, cr3804mr_dim3_y, month_unified;

-- CREATE TEMPORARY TABLE FOR FACEBOOK COUNTRY NAMES
CREATE TEMP TABLE "fbCountryNames" (country_id text, country_name text, continent text);

INSERT INTO "fbCountryNames" (country_id, country_name, continent) VALUES
('GM', 'The Gambia', 'Africa'),
('CA', 'Canada', 'North America'),
('US', 'United States', 'North America'),
('GB', 'United Kingdom', 'Europe'),
('AR', 'Argentina', 'South America'),
('AU', 'Australia', 'Australia'),
('AT', 'Austria', 'Europe'),
('BE', 'Belgium', 'Europe'),
('BR', 'Brazil', 'South America'),
('CL', 'Chile', 'South America'),
('CN', 'China', 'Asia'),
('CO', 'Colombia', 'South America'),
('HR', 'Croatia', 'Europe'),
('DK', 'Denmark', 'Europe'),
('DO', 'Dominican Republic', 'North America'),
('EG', 'Egypt', 'Africa'),
('FI', 'Finland', 'Europe'),
('FR', 'France', 'Europe'),
('DE', 'Germany', 'Europe'),
('GR', 'Greece', 'Europe'),
('HK', 'Hong Kong', 'Asia'),
('IN', 'India', 'Asia'),
('ID', 'Indonesia', 'Asia'),
('IE', 'Ireland', 'Europe'),
('IL', 'Israel', 'Asia'),
('IT', 'Italy', 'Europe'),
('JP', 'Japan', 'Asia'),
('JO', 'Jordan', 'Asia'),
('KW', 'Kuwait', 'Asia'),
('LB', 'Lebanon', 'Asia'),
('MY', 'Malaysia', 'Asia'),
('MX', 'Mexico', 'North America'),
('NL', 'Netherlands', 'Europe'),
('NZ', 'New Zealand', 'Australia'),
('NG', 'Nigeria', 'Africa'),
('NO', 'Norway', 'Europe'),
('PK', 'Pakistan', 'Asia'),
('PA', 'Panama', 'North America'),
('PE', 'Peru', 'South America'),
('PH', 'Philippines', 'Asia'),
('PL', 'Poland', 'Europe'),
('RU', 'Russia', 'Europe'),
('SA', 'Saudi Arabia', 'Asia'),
('RS', 'Serbia', 'Europe'),
('SG', 'Singapore', 'Asia'),
('ZA', 'South Africa', 'Africa'),
('KR', 'South Korea', 'Asia'),
('ES', 'Spain', 'Europe'),
('SE', 'Sweden', 'Europe'),
('CH', 'Switzerland', 'Europe'),
('TW', 'Taiwan', 'Asia'),
('TH', 'Thailand', 'Asia'),
('TR', 'Turkey', 'Asia'),
('AE', 'United Arab Emirates', 'Asia'),
('VE', 'Venezuela', 'South America'),
('PT', 'Portugal', 'Europe'),
('LU', 'Luxembourg', 'Europe'),
('BG', 'Bulgaria', 'Europe'),
('CZ', 'Czech Republic', 'Europe'),
('SI', 'Slovenia', 'Europe'),
('IS', 'Iceland', 'Europe'),
('SK', 'Slovakia', 'Europe'),
('LT', 'Lithuania', 'Europe'),
('TT', 'Trinidad and Tobago', 'North America'),
('BD', 'Bangladesh', 'Asia'),
('LK', 'Sri Lanka', 'Asia'),
('KE', 'Kenya', 'Africa'),
('HU', 'Hungary', 'Europe'),
('MA', 'Morocco', 'Africa'),
('CY', 'Cyprus', 'Asia'),
('JM', 'Jamaica', 'North America'),
('EC', 'Ecuador', 'South America'),
('RO', 'Romania', 'Europe'),
('BO', 'Bolivia', 'South America'),
('GT', 'Guatemala', 'North America'),
('CR', 'Costa Rica', 'North America'),
('QA', 'Qatar', 'Asia'),
('SV', 'El Salvador', 'North America'),
('HN', 'Honduras', 'North America'),
('NI', 'Nicaragua', 'North America'),
('PY', 'Paraguay', 'South America'),
('UY', 'Uruguay', 'South America'),
('PR', 'Puerto Rico', 'North America'),
('BA', 'Bosnia and Herzegovina', 'Europe'),
('PS', 'Palestine', 'Asia'),
('TN', 'Tunisia', 'Africa'),
('BH', 'Bahrain', 'Asia'),
('VN', 'Vietnam', 'Asia'),
('GH', 'Ghana', 'Africa'),
('MU', 'Mauritius', 'Africa'),
('UA', 'Ukraine', 'Europe'),
('MT', 'Malta', 'Europe'),
('BS', 'The Bahamas', 'North America'),
('MV', 'Maldives', 'Asia'),
('OM', 'Oman', 'Asia'),
('MK', 'Macedonia', 'Europe'),
('LV', 'Latvia', 'Europe'),
('EE', 'Estonia', 'Europe'),
('IQ', 'Iraq', 'Asia'),
('DZ', 'Algeria', 'Africa'),
('AL', 'Albania', 'Europe'),
('NP', 'Nepal', 'Asia'),
('MO', 'Macau', 'Asia'),
('ME', 'Montenegro', 'Europe'),
('SN', 'Senegal', 'Africa'),
('GE', 'Georgia', 'Asia'),
('BN', 'Brunei', 'Asia'),
('UG', 'Uganda', 'Africa'),
('GP', 'Guadeloupe', 'North America'),
('BB', 'Barbados', 'North America'),
('AZ', 'Azerbaijan', 'Asia'),
('TZ', 'Tanzania', 'Africa'),
('LY', 'Libya', 'Africa'),
('MQ', 'Martinique', 'North America'),
('CM', 'Cameroon', 'Africa'),
('BW', 'Botswana', 'Africa'),
('ET', 'Ethiopia', 'Africa'),
('KZ', 'Kazakhstan', 'Asia'),
('NA', 'Namibia', 'Africa'),
('MG', 'Madagascar', 'Africa'),
('NC', 'New Caledonia', 'Oceania'),
('MD', 'Moldova', 'Europe'),
('FJ', 'Fiji', 'Oceania'),
('BY', 'Belarus', 'Europe'),
('JE', 'Jersey', 'Europe'),
('GU', 'Guam', 'Oceania'),
('YE', 'Yemen', 'Asia'),
('ZM', 'Zambia', 'Africa'),
('IM', 'Isle Of Man', 'Europe'),
('HT', 'Haiti', 'North America'),
('KH', 'Cambodia', 'Asia'),
('AW', 'Aruba', 'North America'),
('PF', 'French Polynesia', 'Oceania'),
('AF', 'Afghanistan', 'Asia'),
('BM', 'Bermuda', 'North America'),
('GY', 'Guyana', 'South America'),
('AM', 'Armenia', 'Asia'),
('MW', 'Malawi', 'Africa'),
('AG', 'Antigua', 'North America'),
('RW', 'Rwanda', 'Africa'),
('GG', 'Guernsey', 'Europe'),
('FO', 'Faroe Islands', 'Europe'),
('LC', 'St. Lucia', 'North America'),
('KY', 'Cayman Islands', 'North America'),
('BJ', 'Benin', 'Africa'),
('AD', 'Andorra', 'Africa'),
('GD', 'Grenada', 'North America'),
('VI', 'US Virgin Islands', 'North America'),
('BZ', 'Belize', 'North America'),
('VC', 'Saint Vincent and the Grenadines', 'North America'),
('MN', 'Mongolia', 'Asia'),
('MZ', 'Mozambique', 'Africa'),
('ML', 'Mali', 'Africa'),
('AO', 'Angola', 'Africa'),
('GF', 'French Guiana', 'South America'),
('UZ', 'Uzbekistan', 'Asia'),
('DJ', 'Djibouti', 'Africa'),
('BF', 'Burkina Faso', 'Africa'),
('MC', 'Monaco', 'Europe'),
('TG', 'Togo', 'Africa'),
('GL', 'Greenland', 'North America'),
('GA', 'Gabon', 'Africa'),
('GI', 'Gibraltar', 'Europe'),
('CD', 'Democratic Republic of the Congo', 'Africa'),
('KG', 'Kyrgyzstan', 'Asia'),
('PG', 'Papua New Guinea', 'Oceania'),
('BT', 'Bhutan', 'Asia'),
('KN', 'Saint Kitts and Nevis', 'North America'),
('SZ', 'Swaziland', 'Africa'),
('LS', 'Lesotho', 'Africa'),
('LA', 'Laos', 'Asia'),
('LI', 'Liechtenstein', 'Europe'),
('MP', 'Northern Mariana Islands', 'Oceania'),
('SR', 'Suriname', 'South America'),
('SC', 'Seychelles', 'Africa'),
('VG', 'British Virgin Islands', 'North America'),
('TC', 'Turks and Caicos Islands', 'North America'),
('DM', 'Dominica', 'North America'),
('MR', 'Mauritania', 'Africa'),
('AX', 'Aland Islands', 'Europe'),
('SM', 'San Marino', 'Europe'),
('SL', 'Sierra Leone', 'Africa'),
('NE', 'Niger', 'Africa'),
('CG', 'Republic of the Congo', 'Africa'),
('AI', 'Anguilla', 'North America'),
('YT', 'Mayotte', 'Africa'),
('CV', 'Cape Verde', 'Africa'),
('GN', 'Guinea', 'Africa'),
('TM', 'Turkmenistan', 'Asia'),
('BI', 'Burundi', 'Africa'),
('TJ', 'Tajikistan', 'Asia'),
('VU', 'Vanuatu', 'Oceania'),
('SB', 'Solomon Islands', 'Oceania'),
('ER', 'Eritrea', 'Africa'),
('WS', 'Samoa', 'Oceania'),
('AS', 'American Samoa', 'Oceania'),
('FK', 'Falkland Islands', 'South America'),
('GQ', 'Equatorial Guinea', 'Oceania'),
('TO', 'Tonga', 'Africa'),
('KM', 'Comoros', 'Africa'),
('PW', 'Palau', 'Oceania'),
('FM', 'Federated States of Micronesia', 'Oceania'),
('CF', 'Central African Republic', 'Africa'),
('SO', 'Somalia', 'Africa'),
('MH', 'Marshall Islands', 'Oceania'),
('VA', 'Vatican City', 'Europe'),
('TD', 'Chad', 'Africa'),
('KI', 'Kiribati', 'Oceania'),
('ST', 'Sao Tome and Principe', 'Africa'),
('TV', 'Tuvalu', 'Oceania'),
('NR', 'Nauru', 'Oceania'),
('RE', 'Réunion', 'Africa'),
('IR', 'Iran', 'Asia'),
('XK', 'Kosovo', 'Europe'),
('SY', 'Syria', 'Asia'),
('CI', 'Ivory Coast', 'Africa'),
('ZW', 'Zimbabwe', 'Africa'),
('MM', 'Myanmar', 'Asia'),
('CU', 'Curaçao', 'South America'),
('LR', 'Liberia', 'Africa'),
('SD', 'Sudan', 'Africa'),
('SJ', 'Norway', 'Europe'),
('SS', 'Guinea-Bissau', 'Africa'),
('SX', 'Sint Maarten', 'South America'),
('TL', 'Timor-Leste', 'Asia'),
('GW', 'Guinea-Bissau', 'Africa'),
('CW', 'Curaçao', 'South America');



--CREATE TEMPORARY TABLE CONTAINING HARMONIZED DATA FROM FACEBOOK DATA AT COUNTRY LEVEL; INPUT SET: fb_data_in
CREATE TEMP TABLE fb_country_month AS
select 'SK0422_0425'::TEXT id_nuts, 'Košice (districts I - IV)'::TEXT name_nuts,
"fbCountryNames".country_id id_dim_native,
"fbCountryNames".country_name name_dim_native,
	case 
WHEN "fbCountryNames".country_name = 'Slovakia' THEN 'Domestic visitors'
WHEN "fbCountryNames".country_name = 'Afghanistan' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Algeria' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Andorra' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Angola' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Armenia' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Aruba' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Azerbaijan' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Bahrain' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Bangladesh' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Barbados' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Belize' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Benin' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Bhutan' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Bermuda' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Bolivia' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Botswana' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'British Virgin Islands' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Brunei' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Burkina Faso' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Burundi' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Cambodia' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Cameroon' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Cayman Islands' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Central African Republic' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Chad' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Chile' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Colombia' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Comoros' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Czech Republic' THEN 'Czechia'
WHEN "fbCountryNames".country_name = 'Democratic Republic of the Congo' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Costa Rica' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Curaçao' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Djibouti' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Ecuador' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'El Salvador' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Ethiopia' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Faroe Islands' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Fiji' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'French Guiana' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'French Polynesia' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'Gabon' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Ghana' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Gibraltar' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Grenada' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Guadeloupe' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Guam' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'Guatemala' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Guernsey' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Guinea' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Guinea-Bissau' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Guyana' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Haiti' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Honduras' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Iran' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Iraq' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Isle Of Man' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Ivory Coast' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Jamaica' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Jersey' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Kiribati' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'Kosovo' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Kuwait' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Kyrgyzstan' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Laos' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Lebanon' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Lesotho' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Liberia' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Libya' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Macedonia' THEN 'North Macedonia'
WHEN "fbCountryNames".country_name = 'Madagascar' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Malawi' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Mali' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Marshall Islands' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'Martinique' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Mauritania' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Monaco' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Mongolia' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Mozambique' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Myanmar' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Namibia' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Nepal' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'New Caledonia' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'Nicaragua' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Niger' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Nigeria' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Pakistan' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Palestine' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Panama' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Papua New Guinea' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'Paraguay' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Peru' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Philippines' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Puerto Rico' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Republic of the Congo' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Réunion' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Rwanda' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'San Marino' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Senegal' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Sierra Leone' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Sint Maarten' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Solomon Islands' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'Somalia' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Sudan' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Suriname' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Swaziland' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Syria' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Tajikistan' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Tanzania' THEN 'Tanzania (Zanzibar)'
WHEN "fbCountryNames".country_name = 'The Bahamas' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'The Gambia' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Timor-Leste' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Togo' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Tonga' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'Trinidad and Tobago' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Turkmenistan' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Uganda' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Uruguay' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Uzbekistan' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Vanuatu' THEN 'Oceania'
WHEN "fbCountryNames".country_name = 'Vatican City' THEN 'Other European countries'
WHEN "fbCountryNames".country_name = 'Venezuela' THEN 'Other American countries'
WHEN "fbCountryNames".country_name = 'Yemen' THEN 'Other Asian States'
WHEN "fbCountryNames".country_name = 'Zimbabwe' THEN 'Other African States'
WHEN "fbCountryNames".country_name = 'Zambia' THEN 'Other African States'
else "fbCountryNames".country_name
 end name_dim_unified,
 var_id id_var_native,

CASE 
	  WHEN var_id = 'page_fans_country' THEN 'Page fans by country'
	  WHEN var_id = 'page_impressions_by_country_unique' THEN 'Page impressions by country'
	  WHEN var_id = 'page_content_activity_by_country_unique' THEN 'Page content activity by country'
	  ELSE null
END name_var_native,
EXTRACT(YEAR FROM date::DATE) year_native, EXTRACT(MONTH FROM date::DATE)::TEXT month_native, 
CASE 
	WHEN var_id = 'page_fans_country' THEN ROUND(AVG(value), 0) 
	ELSE ROUND(SUM(value), 0) 
END val,
'Facebook Graph API'::TEXT value_source, 140831155939489::TEXT id_source_native, 'Visit Kosice'::TEXT name_source_native, EXTRACT(MONTH FROM date::DATE) month_unified
FROM fb_data_in, "fbCountryNames"
WHERE var_id IN  ('page_fans_country', 'page_impressions_by_country_unique', 'page_content_activity_by_country_unique')
AND "fbCountryNames".country_id = fb_data_in.country_id
GROUP BY fb_data_in.country_id, "fbCountryNames".country_id, "fbCountryNames".country_name, var_id, name_var_native, year_native, month_native, month_unified;


--CREATE TEMPORARY TABLE CONTAINING HARMONIZED DATA FROM GOOGLE ANALYTICS DATA AT COUNTRY LEVEL; INPUT SET: ga_country_month
CREATE TEMP TABLE ga_country_month AS
WITH UNIONS AS (
(select 'SK0422_0425'::text id_nuts, 'Košice (districts I - IV)'::text name_nuts, null::text id_dim_native, "Country" name_dim_native, null::text id_var_native, 'Users' name_var_native, d_year::integer year_native, d_month month_native, "Users" val, 'Google Analytics' value_source from ga_country_month where d_year = '2021') 
union all
(select 'SK0422_0425'::text id_nuts, 'Košice (districts I - IV)'::text name_nuts, null::text id_dim_native, "Country" name_dim_native, null::text id_var_native, 'Sessions' name_var_native, d_year::integer year_native, d_month month_native, "Sessions" val, 'Google Analytics' value_source from ga_country_month where d_year = '2021') 
union all
(select 'SK0422_0425'::text id_nuts, 'Košice (districts I - IV)'::text name_nuts, null::text id_dim_native, "Country" name_dim_native, null::text id_var_native, 'Avg. Session Duration' name_var_native, d_year::integer year_native, d_month month_native, "avg session duration" val, 'Google Analytics' ga_country_month from viske_ga_month where d_year = '2021') 
)
SELECT id_nuts, name_nuts, id_dim_native, name_dim_native,
CASE
 WHEN name_dim_native = 'Bosnia & Herzegovina' THEN 'Bosnia and Herzegovina'
 WHEN name_dim_native = 'Slovakia' THEN 'Domestic visitors'
WHEN name_dim_native ='Afghanistan' THEN 'Other Asian States'
WHEN name_dim_native ='Algeria' THEN 'Other African States'
WHEN name_dim_native ='Andorra' THEN 'Other European countries'
WHEN name_dim_native ='Angola' THEN 'Other African States'
WHEN name_dim_native ='Anguilla' THEN 'Other American countries'
WHEN name_dim_native ='Antigua & Barbuda' THEN 'Other American countries'
WHEN name_dim_native ='Armenia' THEN 'Other Asian States'
WHEN name_dim_native ='Azerbaijan' THEN 'Other Asian States'
WHEN name_dim_native ='Bahamas' THEN 'Other American countries'
WHEN name_dim_native ='Bahrain' THEN 'Other Asian States'
WHEN name_dim_native ='Bangladesh' THEN 'Other Asian States'
WHEN name_dim_native ='Barbados' THEN 'Other American countries'
WHEN name_dim_native ='Benin' THEN 'Other African States'
WHEN name_dim_native ='Bermuda' THEN 'Other American countries'
WHEN name_dim_native ='Bolivia' THEN 'Other American countries'
WHEN name_dim_native ='Botswana' THEN 'Other African States'
WHEN name_dim_native ='Brunei' THEN 'Other Asian States'
WHEN name_dim_native ='Burkina Faso' THEN 'Other African States'
WHEN name_dim_native ='Burundi' THEN 'Other African States'
WHEN name_dim_native ='Cambodia' THEN 'Other Asian States'
WHEN name_dim_native ='Cameroon' THEN 'Other African States'
WHEN name_dim_native ='Cayman Islands' THEN 'Other American countries'
WHEN name_dim_native ='Central African Republic' THEN 'Other African States'
WHEN name_dim_native ='Chad' THEN 'Other African States'
WHEN name_dim_native ='Chile' THEN 'Other American countries'
WHEN name_dim_native ='Colombia' THEN 'Other American countries'
WHEN name_dim_native ='Comoros' THEN 'Other African States'
WHEN name_dim_native ='Congo - Brazzaville' THEN 'Other African States'
WHEN name_dim_native ='Congo - Kinshasa' THEN 'Other African States'
WHEN name_dim_native ='Costa Rica' THEN 'Other American countries'
WHEN name_dim_native ='Côte d’Ivoire' THEN 'Other African States'
WHEN name_dim_native ='Djibouti' THEN 'Other African States'
WHEN name_dim_native ='Dominica' THEN 'Other American countries'
WHEN name_dim_native ='Ecuador' THEN 'Other American countries'
WHEN name_dim_native ='Ethiopia' THEN 'Other African States'
WHEN name_dim_native ='Fiji' THEN 'Oceania'
WHEN name_dim_native ='French Polynesia' THEN 'Oceania'
WHEN name_dim_native ='Ghana' THEN 'Other African States'
WHEN name_dim_native ='Guadeloupe' THEN 'Other American countries'
WHEN name_dim_native ='Guam' THEN 'Oceania'
WHEN name_dim_native ='Guatemala' THEN 'Other American countries'
WHEN name_dim_native ='Guernsey' THEN 'Other European countries'
WHEN name_dim_native ='Guinea' THEN 'Other African States'
WHEN name_dim_native ='Guyana' THEN 'Other American countries'
WHEN name_dim_native ='Honduras' THEN 'Other American countries'
WHEN name_dim_native ='Iran' THEN 'Other Asian States'
WHEN name_dim_native ='Iraq' THEN 'Other Asian States'
WHEN name_dim_native ='Jamaica' THEN 'Other American countries'
WHEN name_dim_native ='Jersey' THEN 'Other European countries'
WHEN name_dim_native ='Kosovo' THEN 'Other European countries'
WHEN name_dim_native ='Kuwait' THEN 'Other Asian States'
WHEN name_dim_native ='Kyrgyzstan' THEN 'Other Asian States'
WHEN name_dim_native ='Lebanon' THEN 'Other Asian States'
WHEN name_dim_native ='Lesotho' THEN 'Other African States'
WHEN name_dim_native ='Liberia' THEN 'Other African States'
WHEN name_dim_native ='Libya' THEN 'Other African States'
WHEN name_dim_native ='Macao' THEN 'Other Asian States'
WHEN name_dim_native ='Madagascar' THEN 'Other African States'
WHEN name_dim_native ='Mali' THEN 'Other African States'
WHEN name_dim_native ='Mauritania' THEN 'Other African States'
WHEN name_dim_native ='Mongolia' THEN 'Other Asian States'
WHEN name_dim_native ='Mozambique' THEN 'Other African States'
WHEN name_dim_native ='Myanmar (Burma)' THEN 'Other Asian States'
WHEN name_dim_native ='Namibia' THEN 'Other African States'
WHEN name_dim_native ='Nepal' THEN 'Other Asian States'
WHEN name_dim_native ='New Caledonia' THEN 'Oceania'
WHEN name_dim_native ='Nicaragua' THEN 'Other American countries'
WHEN name_dim_native ='Niger' THEN 'Other African States'
WHEN name_dim_native ='Nigeria' THEN 'Other African States'
WHEN name_dim_native ='Pakistan' THEN 'Other Asian States'
WHEN name_dim_native ='Palestine' THEN 'Other Asian States'
WHEN name_dim_native ='Panama' THEN 'Other American countries'
WHEN name_dim_native ='Paraguay' THEN 'Other American countries'
WHEN name_dim_native ='Peru' THEN 'Other American countries'
WHEN name_dim_native ='Philippines' THEN 'Other Asian States'
WHEN name_dim_native ='Puerto Rico' THEN 'Other American countries'
WHEN name_dim_native ='Réunion' THEN 'Other African States'
WHEN name_dim_native ='Rwanda' THEN 'Other African States'
WHEN name_dim_native ='Samoa' THEN 'Oceania'
WHEN name_dim_native ='San Marino' THEN 'Other European countries'
WHEN name_dim_native ='Senegal' THEN 'Other African States'
WHEN name_dim_native ='Somalia' THEN 'Other African States'
WHEN name_dim_native ='St. Kitts & Nevis' THEN 'Other American countries'
WHEN name_dim_native ='Sudan' THEN 'Other African States'
WHEN name_dim_native ='Svalbard & Jan Mayen' THEN 'Other European countries'
WHEN name_dim_native ='Syria' THEN 'Other Asian States'
WHEN name_dim_native ='Tajikistan' THEN 'Other Asian States'
WHEN name_dim_native ='Tanzania' THEN 'Other African States'
WHEN name_dim_native ='Togo' THEN 'Other African States'
WHEN name_dim_native ='Trinidad & Tobago' THEN 'Other American countries'
WHEN name_dim_native ='Turkmenistan' THEN 'Other Asian States'
WHEN name_dim_native ='U.S. Virgin Islands' THEN 'Other American countries'
WHEN name_dim_native ='Uganda' THEN 'Other African States'
WHEN name_dim_native ='Uruguay' THEN 'Other American countries'
WHEN name_dim_native ='Uzbekistan' THEN 'Other Asian States'
WHEN name_dim_native ='Venezuela' THEN 'Other American countries'
WHEN name_dim_native ='Yemen' THEN 'Other Asian States'
WHEN name_dim_native ='Zimbabwe' THEN 'Other African States'
WHEN name_dim_native ='Zambia' THEN 'Other African States'
WHEN name_dim_native is null then 'Visitors total' 
WHEN name_dim_native = '(not set)' THEN 'Non-specified' 
WHEN name_dim_native = 'Monaco' THEN 'Other European countries' 
WHEN name_dim_native = 'Gibraltar' THEN 'Other European countries' 
WHEN name_dim_native = 'El Salvador' THEN 'Other American countries' 
else name_dim_native end name_dim_unified,
id_var_native, name_var_native,
year_native,
month_native, val, value_source,
154432670::TEXT "id_source_native", 'visitkosice.org'::text name_source_native,
CASE 
	WHEN month_native LIKE '0%' THEN CAST(REPLACE(month_native, '0', '') AS INTEGER)
	WHEN month_native LIKE '%.' AND month_native NOT LIKE '%-%'  THEN CAST(REPLACE(month_native, '.', '') AS INTEGER)
	ELSE CAST(month_native AS INTEGER) 
END month_unified 
FROM UNIONS;


--FIGURE 1A
CREATE TEMP TABLE figure_1a AS 
WITH dim_sum AS (
SELECT 
CASE WHEN name_dim_native in ('Austria', 'Czechia', 'Hungary', 'Poland', 'Domestic visitors') then name_dim_native ELSE 'Rest of foreign incoming countries' END origin_country,
SUM(val) country_annual 
FROM susr_country_month
WHERE year_native= 2021 AND name_dim_native NOT IN ('Visitors total', 'Foreign visitors') AND name_var_native = 'Number of visitors total' AND month_unified BETWEEN 1 AND 12
GROUP BY origin_country
ORDER BY origin_country
),
total AS (
SELECT 
SUM(val) annual_total 
FROM susr_country_month
WHERE year_native= 2021 AND name_dim_native NOT IN ('Visitors total', 'Foreign visitors') AND name_var_native = 'Number of visitors total' AND month_unified BETWEEN 1 AND 12
)
SELECT *, ROUND((dim_sum.country_annual/total.annual_total)::NUMERIC*100,1) pct_share FROM dim_sum, total;

	
--FIGURE 1B
CREATE TEMP TABLE figure_1b AS 
WITH dim_sum AS (
SELECT 
CASE WHEN name_dim_native in ('Austria', 'Czechia', 'Hungary', 'Poland', 'Domestic visitors') then name_dim_native ELSE 'Rest of foreign incoming countries' END origin_country,
SUM(val) country_annual 
FROM susr_country_month
WHERE year_native= 2021 AND name_dim_native NOT IN ('Visitors total', 'Foreign visitors') AND name_var_native = 'Number of nights spent by visitors' AND month_unified BETWEEN 1 AND 12
GROUP BY origin_country
ORDER BY origin_country
),
total AS (
SELECT 
SUM(val) annual_total 
FROM susr_country_month
WHERE year_native= 2021 AND name_dim_native NOT IN ('Visitors total', 'Foreign visitors') AND name_var_native = 'Number of nights spent by visitors' AND month_unified BETWEEN 1 AND 12
)
SELECT *, ROUND((dim_sum.country_annual/total.annual_total)::NUMERIC*100,1) pct_share FROM dim_sum, total;

--FIGURE 1C
CREATE TEMP TABLE figure_1c AS 
SELECT CASE WHEN name_dim_native in ('Austria', 'Czechia', 'Hungary', 'Poland', 'Visitors total', 'Foreign visitors') THEN name_dim_native 	WHEN name_dim_native = 'Domestic visitors' THEN 'Slovakia' ELSE null END origin_country,
	   ROUND(avg(val)::numeric, 2) country_annual
FROM susr_country_month 
WHERE year_native= 2021 AND name_dim_native in ('Visitors total', 'Austria', 'Czechia', 'Hungary', 'Poland', 'Foreign visitors', 'Domestic visitors') AND name_var_native = 'Average number of nights spent by visitors' AND month_unified between 1 and 12
GROUP BY origin_country
ORDER BY origin_country;

--Figure 2a
CREATE TEMP TABLE figure_2a AS 
WITH dim_sum AS (
SELECT 
CASE WHEN name_dim_native in ('Austria', 'Czechia', 'Hungary', 'Poland', 'Slovakia') THEN name_dim_native ELSE 'Rest of foreign incoming countries' END origin_country,
SUM(val) country_annual 
FROM ga_country_month 
WHERE year_native= 2021 AND name_var_native = 'Users' AND name_dim_unified <> 'Visitors total' AND month_unified BETWEEN 1 AND 12
GROUP BY origin_country
ORDER BY origin_country
),
total AS (
SELECT SUM(val) annual_total 
FROM ga_country_month
WHERE year_native= 2021 AND name_var_native = 'Users' AND name_dim_unified = 'Visitors total' AND month_unified BETWEEN 1 AND 12
GROUP BY name_nuts
ORDER BY name_nuts
)
SELECT *, ROUND((dim_sum.country_annual/total.annual_total)::NUMERIC*100,1) pct_share FROM dim_sum, total;

--Figure 2b
CREATE TEMP TABLE figure_2b AS 
WITH dim_sum AS (
SELECT 
CASE WHEN name_dim_native in ('Austria', 'Czechia', 'Hungary', 'Poland', 'Slovakia') THEN name_dim_native ELSE 'Rest of foreign incoming countries' END origin_country,
SUM(val) country_annual 
FROM ga_country_month 
WHERE year_native= 2021 AND name_var_native = 'Sessions' AND name_dim_unified <> 'Visitors total' AND month_unified BETWEEN 1 AND 12
GROUP BY origin_country
ORDER BY origin_country
),
total AS (
SELECT SUM(val) annual_total 
FROM ga_country_month
WHERE year_native= 2021 AND name_var_native = 'Sessions' AND name_dim_unified = 'Visitors total' AND month_unified BETWEEN 1 AND 12
GROUP BY name_nuts
ORDER BY name_nuts
)
SELECT *, ROUND((dim_sum.country_annual/total.annual_total)::NUMERIC*100,1) pct_share FROM dim_sum, total;

--Figure 2c
CREATE TEMP TABLE figure_2c AS 
SELECT name_dim_unified origin_country,
	   ROUND(avg(val/60)::numeric, 2) country_annual
FROM ga_country_month 
WHERE year_native= 2021 AND name_dim_unified in ('Visitors total', 'Austria', 'Czechia', 'Hungary', 'Poland', 'Foreign visitors', 'Domestic visitors') AND name_var_native = 'Avg. Session Duration' AND month_unified between 1 and 12
GROUP BY origin_country
ORDER BY origin_country;

--Figure 3a
CREATE TEMP TABLE figure_3a AS
WITH unions AS (
(SELECT name_dim_unified origin_country, ROUND(AVG(val)::NUMERIC, 0) country_annual
FROM fb_country_month 
WHERE year_native= 2021 AND name_dim_unified in ('Austria', 'Czechia', 'Hungary', 'Poland', 'Domestic visitors') AND id_var_native = 'page_fans_country' AND month_unified between 1 and 12
GROUP BY origin_country
ORDER BY origin_country) UNION ALL
(WITH "restOfForeignMarkerts" AS (
	SELECT year_native, month_native, CASE WHEN name_dim_unified NOT IN ('Domestic visitors') THEN 'Rest of foreign incoming visitors' ELSE NULL END origin_country,
	SUM(val) country_annual 
	FROM fb_country_month
	WHERE year_native= 2021 AND name_dim_unified NOT IN ('Austria', 'Czechia', 'Hungary', 'Poland', 'Domestic visitors') AND id_var_native = 'page_fans_country' AND month_unified between 1 and 12
	GROUP BY year_native, month_native, origin_country
	ORDER BY origin_country, year_native, month_native 
) SELECT origin_country, ROUND(AVG(country_annual)::numeric, 0) FROM "restOfForeignMarkerts" GROUP BY origin_country ORDER BY origin_country
)	
) SELECT *, ROUND(country_annual/(SELECT SUM(country_annual) FROM unions)*100,2) FROM unions;


--Figure 3b
CREATE TEMP TABLE figure_3b AS 
WITH dim_sum AS (
SELECT 
CASE WHEN name_dim_unified in ('Austria', 'Czechia', 'Hungary', 'Poland', 'Domestic visitors') THEN name_dim_unified ELSE 'Rest of foreign incoming countries' END origin_country,
SUM(val) country_annual 
FROM fb_country_month
WHERE year_native= 2021 AND id_var_native = 'page_impressions_by_country_unique' AND month_unified BETWEEN 1 AND 12
GROUP BY origin_country
ORDER BY origin_country
),
total AS (
SELECT 
SUM(val) annual_total 
FROM fb_country_month
WHERE year_native= 2021  AND id_var_native = 'page_impressions_by_country_unique' AND month_unified BETWEEN 1 AND 12
)
SELECT *, ROUND((dim_sum.country_annual/total.annual_total)::NUMERIC*100,1) pct_share FROM dim_sum, total;


--Figure 3c
CREATE TEMP TABLE figure_3c AS 
WITH dim_sum AS (
SELECT 
CASE WHEN name_dim_unified in ('Austria', 'Czechia', 'Hungary', 'Poland', 'Domestic visitors') THEN name_dim_unified ELSE 'Rest of foreign incoming countries' END origin_country,
SUM(val) country_annual 
FROM fb_country_month
WHERE year_native= 2021 AND id_var_native = 'page_content_activity_by_country_unique' AND month_unified BETWEEN 1 AND 12
GROUP BY origin_country
ORDER BY origin_country
),
total AS (
SELECT 
SUM(val) annual_total 
FROM fb_country_month
WHERE year_native= 2021  AND id_var_native = 'page_content_activity_by_country_unique' AND month_unified BETWEEN 1 AND 12
)
SELECT *, ROUND((dim_sum.country_annual/total.annual_total)::NUMERIC*100,1) pct_share FROM dim_sum, total;

--sampled_monthly_markets for FIGURE 4_10
CREATE TEMP TABLE sampled_monthly_markets AS
SELECT * FROM susr_country_month WHERE name_dim_unified in ('Austria', 'Czechia', 'Domestic visitors', 'Hungary', 'Poland') 
UNION ALL
SELECT * FROM ga_country_month WHERE name_dim_unified in ('Austria', 'Czechia', 'Domestic visitors', 'Hungary', 'Poland') 
UNION ALL
SELECT * FROM fb_country_month WHERE name_dim_unified in ('Austria', 'Czechia', 'Domestic visitors', 'Hungary', 'Poland'); 


--FIGURE 4_10
CREATE TEMP TABLE figure_4to10 AS
SELECT *,
CASE WHEN raw.val < stat_characterisitcs."Median" THEN 'Under'::TEXT
	WHEN raw.val > stat_characterisitcs."Median" THEN 'Over'::TEXT
	WHEN raw.val = stat_characterisitcs."Median" THEN 'Median'::TEXT
	ELSE null
	END "underOverMedian",
CASE WHEN raw.val >= stat_characterisitcs."0.75 percentile" then  'q4'::TEXT
	 WHEN raw.val > stat_characterisitcs."Median" AND val < stat_characterisitcs."0.75 percentile" then  'q3'::TEXT
	 WHEN raw.val < stat_characterisitcs."Median" AND val > stat_characterisitcs."0.25 percentile" then  'q2'::TEXT 
	 WHEN raw.val <= stat_characterisitcs."0.25 percentile" then 'q1'::TEXT 
	 WHEN raw.val = stat_characterisitcs."Median" THEN 'Median'::TEXT
	ELSE null
	END qunatile
FROM 
(SELECT name_dim_unified, name_var_native, year_native, month_unified, val  FROM sampled_monthly_markets
WHERE name_dim_unified in ('Austria', 'Czechia', 'Domestic visitors', 'Hungary', 'Poland') 
) raw
LEFT JOIN
(SELECT name_dim_unified, name_var_native, year_native, round(AVG(val)::NUMERIC, 2) "Average", stddev(val) "Standard deviation", PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY val) "Median", PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY val) "0.75 percentile", PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY val) "0.25 percentile"
FROM sampled_monthly_markets 
WHERE name_dim_unified IN ('Austria', 'Czechia', 'Domestic visitors', 'Hungary', 'Poland') 
GROUP BY name_dim_unified, name_var_native, year_native) stat_characterisitcs
USING (name_dim_unified, name_var_native, year_native);

--sample Google Analytics cities
CREATE TABLE ga_city_sample AS
SELECT 
'SK0422_0425'::text id_destination_nuts, 'Košice (districts I - IV)'::text name_destination_nuts, "City" origin_city,  "Country" origin_country, d_year::integer year_native, 
CASE 
	WHEN d_month LIKE '0%' THEN CAST(REPLACE(d_month, '0', '') AS INTEGER)
	WHEN d_month LIKE '%.' AND d_month NOT LIKE '%-%'  THEN CAST(REPLACE(d_month, '.', '') AS INTEGER)
	ELSE CAST(d_month AS INTEGER) 
END month_unified,
"Users", "Sessions", 'Google Analytics' value_source, 154432670::TEXT "id_source_native", 'visitkosice.org'::text name_source_native
FROM ga_city_month 
WHERE "Country" IN ('Austria', 'Czechia','Hungary','Poland','Slovakia') AND page_name = 'Visit Kosice' AND "City" <> '(not set)' AND regexp_replace("City", '[^a-zA-Z]', '', 'g') <> '' AND d_year = '2021'
ORDER BY "Country", "City", month_unified;



--sample FB GRAPH API cities
CREATE TABLE fb_city_sample AS 
WITH merged AS (
SELECT 'SK0422_0425'::text id_destination_nuts, 'Košice (districts I - IV)'::text name_destination_nuts, country_id, 
CASE 
	WHEN (CHAR_LENGTH(country_id) - CHAR_LENGTH(REPLACE(country_id, ',', '')))/ CHAR_LENGTH(',') = 0 THEN country_id
	WHEN (CHAR_LENGTH(country_id) - CHAR_LENGTH(REPLACE(country_id, ',', '')))/ CHAR_LENGTH(',') = 1 THEN split_part(country_id, ', ', 1)
	WHEN (CHAR_LENGTH(country_id) - CHAR_LENGTH(REPLACE(country_id, ',', '')))/ CHAR_LENGTH(',') = 2 THEN split_part(country_id, ', ', 1)
	ELSE null
END origin_city,
CASE 
	WHEN (CHAR_LENGTH(country_id) - CHAR_LENGTH(REPLACE(country_id, ',', '')))/ CHAR_LENGTH(',') = 0 THEN null
	WHEN (CHAR_LENGTH(country_id) - CHAR_LENGTH(REPLACE(country_id, ',', '')))/ CHAR_LENGTH(',') = 1 THEN null
	WHEN (CHAR_LENGTH(country_id) - CHAR_LENGTH(REPLACE(country_id, ',', '')))/ CHAR_LENGTH(',') = 2 THEN split_part(country_id, ', ', 2)
	ELSE null
END origin_region,
CASE 
	WHEN country_id = 'Álora' THEN ''
	WHEN country_id = 'Čierny Balog' THEN 'Slovakia'
	WHEN country_id = 'Deč' THEN 'Serbia'
	WHEN country_id = 'Divina' THEN 'Slovakia'
	WHEN country_id = 'Ehingen' THEN 'Germany'
	WHEN country_id = 'Kajal' THEN 'Slovakia'
	WHEN country_id = 'Kriváň' THEN 'Slovakia'
	WHEN country_id = 'Lietava' THEN 'Slovakia'
	WHEN country_id = 'Málinec' THEN 'Slovakia'
	WHEN country_id = 'Melilla' THEN 'Spain'
	WHEN country_id = 'Mostová' THEN 'Slovakia'
	WHEN country_id = 'Mútne' THEN 'Slovakia'
	WHEN country_id = 'Pernik' THEN 'Bulgaria'
	WHEN country_id = 'Svätý Anton' THEN 'Slovakia'
	WHEN country_id = 'Vysoké Tatry' THEN 'Slovakia'
	WHEN country_id = 'Zemplín' THEN 'Slovakia'
	WHEN (CHAR_LENGTH(country_id) - CHAR_LENGTH(REPLACE(country_id, ',', '')))/ CHAR_LENGTH(',') = 0 THEN null
	WHEN (CHAR_LENGTH(country_id) - CHAR_LENGTH(REPLACE(country_id, ',', '')))/ CHAR_LENGTH(',') = 1 THEN split_part(country_id, ', ', 2)
	WHEN (CHAR_LENGTH(country_id) - CHAR_LENGTH(REPLACE(country_id, ',', '')))/ CHAR_LENGTH(',') = 2 THEN split_part(country_id, ', ', 3)
	ELSE null
END origin_country, 
year_native, month_unified, "Impressions", "Content Activity", 
'Facebook Graph Api' value_source, page_id "id_source_native", page_name name_source_native
FROM
(SELECT country_id,  EXTRACT(YEAR FROM date::DATE)::INTEGER year_native, EXTRACT(MONTH FROM date::DATE)::INTEGER month_unified, 
sum(value) "Content Activity", page_id, page_name 
FROM fb_data_in
WHERE var_id IN ('page_content_activity_by_city_unique')
GROUP BY country_id, year_native, month_unified, page_id, page_name) contentactivity
full outer join 
(SELECT country_id,  EXTRACT(YEAR FROM date::DATE)::INTEGER year_native, EXTRACT(MONTH FROM date::DATE)::INTEGER month_unified, 
sum(value) "Impressions", page_id, page_name 
FROM fb_data_in
WHERE var_id IN ('page_impressions_by_city_unique')
GROUP BY country_id, year_native, month_unified, page_id, page_name) impressions
USING (country_id, year_native, month_unified, page_id, page_name)
)
SELECT * FROM merged where origin_country IN ('Austria', 'Czechia', 'Hungary', 'Poland', 'Slovakia')
ORDER BY origin_country, origin_city, year_native, month_unified;



--GA cities for geocoding
CREATE TABLE ga_fb_geocoded_cities AS 
SELECT DISTINCT(origin_city), origin_country,
null::text "type",
null::text coordinates,
null::text adr,
null::text geometry_confidence,
null::text ors_id,
null::text osm_id,
null::text osm_layer,
null::text city_name,
null::text region_name,
null::text country_name,
null::float distance_km, 
null::float duration_min
FROM (
(SELECT DISTINCT(origin_city), origin_country from ga_city_sample
ORDER BY origin_country, origin_city)
UNION ALL
--FB citires for geocoding
(SELECT DISTINCT(origin_city), origin_country  from fb_city_sample
ORDER BY origin_country, origin_city) 
)unions
ORDER BY origin_country, origin_city;
