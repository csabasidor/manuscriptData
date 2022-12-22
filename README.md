# notesData2092724  

The repository contains all code and base data referenced within the submited manuscript notes to journal [Data: Special Issue "Data-Driven Approach on Urban Planning and Smart Cities"](https://www.mdpi.com/journal/data/special_issues/78AR6O8M60), under the title:  
##### Basic input data for audiences’ geotargeting by destinations’ partial accessibility: Notes from Slovakia 

The contains of the repo should be used only to the extent described within [manuscript](link will be added if published). Altering the purpose or extent that is not described, does not guarantee fuctionality.

1. ### [callCR3804MR.py](https://github.com/csabasidor/notesData2092724/blob/main/callCR3804MR.py)  
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/)
- **Purpose and Extent of usage:**   
Extract dataset cr3804mr: Occupancy of accommodation establishments – districts (countries) from [API Open data SO SR](https://slovak.statistics.sk/wps/portal/ext/Databases/Open_data/) for further processing in PostgreSQL.
- **Default settings (of variables):**   
    - **Administrative unit (list_of_nuts):** SK0422_0425: Košice districts I - IV  
    - **Year (year_id):** 2021 
    - **Months (list_of_months):** all available  
    - **Indicators:**  all available
    - **Incoming markets:** all available  
- **Output data set name:** inputCr3804mr  
- **Possible export formats at default:** PostgreSQL, .xlsx, .csv 

2. ### [callGraphApi.py](https://github.com/csabasidor/manuscriptData/blob/main/callGraphApi.py)  
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/)
- **API accessibility prerequisites**: [Facebook Developer Account with Page Access Token](https://developers.facebook.com/docs/facebook-login/guides/access-tokens/)  
- **Purpose and Extent of usage:** Extract selected daily metrics for given Facebook page (DMO) via [Graph Api - Page Insights](https://developers.facebook.com/docs/graph-api/reference/insights/#page-impressions)
- **Default settings (of variables):**   
    - **Page name (page_name):** none
    - **Page ID (page_id):** none 
    - **Page access token (page_access_token):** none
    - **Indicators:**
        - Page fans per city [page_fans_city]       
        - Page fans per country [page_fans_country]  
        - Page impressions by country [page_impressions_by_country_unique]  
        - Page content activity by country [page_content_activity_by_country_unique]  
        - Page impressions by city [page_impressions_by_city_unique]  
        - Page impressions by content activity [page_content_activity_by_city_unique]     
    - **Output data set name:** fb_data_in  
    - **Possible export formats at default:** PostgreSQL, (.csv and .xlsx formats are not encouraged) 

3. ### [importMultipleExcelDumpsGoogleAnalytics.py](https://github.com/csabasidor/notesData2092724/blob/main/importMultipleExcelDumpsGoogleAnalytics.py)  
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/), .xslx dumps for cities (folder name = GAcities) and countries (folder name = GAcountries) in two seperate folders.
- **Purpose and Extent of usage:** Import multiple .xlsx dumps of [Google Analytics](https://analytics.google.com/) basic metrics. It is recommended to use only when one does not have an access token to the Google Analytics API.
- **Default settings (of variables):**   
    - **Page name (page_name):** None  
    - **Indicators:**  
        - per city, per country
        - Users, Sessions, Average Session Duration  
- **Output data set name:**
    - ga_country_month
    - ga_city_month

4. ### [runCountryAggregates.py](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/runCountryAggregates.py)  
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/)  
  - Previous execution of with PostgreSql DB:  
     - [callCR3804MR.py](https://github.com/csabasidor/notesData2092724/blob/main/callCR3804MR.py)  
     - [callGraphApi.py](https://github.com/csabasidor/manuscriptData/blob/main/callGraphApi.py)  
     - [importMultipleExcelDumpsGoogleAnalytics.py](https://github.com/csabasidor/notesData2092724/blob/main/importMultipleExcelDumpsGoogleAnalytics.py)  
- **Purpose and Extent of usage:**: Executes [createTempTables.sql](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/createTempTables.sql) that exports [aggregated data for Figure 1 to Figure 10](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/graphData) and creates tables **ga_city_sample, fb_city_sample** (sampled cities for further processing) and **ga_fb_geocoded_cities** as inupt data for [geocodeBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/geocodeBatchSimple.py).  
- **Default settings (of variables):**   
    - **Incoming markets:** Austria, Czechia, Hungary, Poland, Slovakia.    
    - **Possible export formats at default:** PostgreSQL.

5. ### [geocodeBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/geocodeBatchSimple.py)  
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/), [openrouteservice API KEY](https://openrouteservice.org/dev/#/signup).  
  - Previous execution of (with PostgreSql DB):  
    - [callCR3804MR.py](https://github.com/csabasidor/notesData2092724/blob/main/callCR3804MR.py)  
    - [callGraphApi.py](https://github.com/csabasidor/manuscriptData/blob/main/callGraphApi.py)  
    - [importMultipleExcelDumpsGoogleAnalytics.py](https://github.com/csabasidor/notesData2092724/blob/main/importMultipleExcelDumpsGoogleAnalytics.py)
    - [runCountryAggregates.py](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/runCountryAggregates.py)  
- **Purpose and Extent of usage:** Geocodes **ga_fb_geocoded_cities** (unique cities within Facebook a Google Analytics sample).   
- **Default settings:** Due to API limits, geocoding 50 records at instance.       
- **Possible export formats at default:** PostgreSQL.

6. ### [distanceMatrixBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/distanceMatrixBatchSimple.py)  
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/), [openrouteservice API KEY](https://openrouteservice.org/dev/#/signup).  
  - Previous execution of (with PostgreSql DB):  
    - [callCR3804MR.py](https://github.com/csabasidor/notesData2092724/blob/main/callCR3804MR.py)  
    - [callGraphApi.py](https://github.com/csabasidor/manuscriptData/blob/main/callGraphApi.py)  
    - [importMultipleExcelDumpsGoogleAnalytics.py](https://github.com/csabasidor/notesData2092724/blob/main/importMultipleExcelDumpsGoogleAnalytics.py)
    - [runCountryAggregates.py](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/runCountryAggregates.py)  
    - [geocodeBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/geocodeBatchSimple.py)  
- **Purpose and Extent of usage:** Update variables distance_km and duration_min of **ga_fb_geocoded_cities** (unique cities within Facebook a Google Analytics sample).   
- **Default settings:** Due to API limits, geocoding 50 records at instance. 
  - **Default destination:** Kosice, Slovakia.  
- **Possible export formats at default:** PostgreSQL.

7. ### [runCityDuratioBins.py](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/runCityDuratioBins.py)
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/), [openrouteservice API KEY](https://openrouteservice.org/dev/#/signup).  
  - Previous execution of (with PostgreSql DB):  
    - [callGraphApi.py](https://github.com/csabasidor/manuscriptData/blob/main/callGraphApi.py)  
    - [importMultipleExcelDumpsGoogleAnalytics.py](https://github.com/csabasidor/notesData2092724/blob/main/importMultipleExcelDumpsGoogleAnalytics.py)
    - [geocodeBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/geocodeBatchSimple.py)  
    - [distanceMatrixBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/distanceMatrixBatchSimple.py)  
- **Purpose and Extent of usage:** Executes [durationBins.sql](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/durationBins.sql) that exports [aggregated data for Figure 11 to Figure 15](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/graphData)
- **Default settings:** Set for 1 hour intervals, (max over 240min)  
- **Possible export formats at default:** PostgreSQL, .xlsx.

8. ### [AirportsDistanceMatrixBatch.py](https://github.com/csabasidor/notesData2092724/blob/main/AirportsDistanceMatrixBatch.py)
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/), [openrouteservice API KEY](https://openrouteservice.org/dev/#/signup).  
  - Previous execution of (with PostgreSql DB):  
    - [callGraphApi.py](https://github.com/csabasidor/manuscriptData/blob/main/callGraphApi.py)  
    - [importMultipleExcelDumpsGoogleAnalytics.py](https://github.com/csabasidor/notesData2092724/blob/main/importMultipleExcelDumpsGoogleAnalytics.py)
    - [geocodeBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/geocodeBatchSimple.py)  
    - [distanceMatrixBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/distanceMatrixBatchSimple.py)  
- **Purpose and Extent of usage:** Retrieves the duration of selected routes to selected airports and updates the relevant table containing all geocoded places.
- **Default settings:** Places initialy being over 240 min to Kosice with corresponding airports.
- **Possible export formats at default:** PostgreSQL.

9. ### [runAirportAggregates.py](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/runAirportAggregates.py)
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/). 
  - Previous execution of (with PostgreSql DB):  
    - [callGraphApi.py](https://github.com/csabasidor/manuscriptData/blob/main/callGraphApi.py)  
    - [importMultipleExcelDumpsGoogleAnalytics.py](https://github.com/csabasidor/notesData2092724/blob/main/importMultipleExcelDumpsGoogleAnalytics.py)
    - [geocodeBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/geocodeBatchSimple.py)  
    - [distanceMatrixBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/distanceMatrixBatchSimple.py)  
    - [airportsDistanceMatrixBatch.py](https://github.com/csabasidor/notesData2092724/blob/main/AirportsDistanceMatrixBatch.py)
- **Purpose and Extent of usage:** Executes [airAggregates.sql](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/airportAggregates.sql) that exports [aggregated data for Figure 16](https://github.com/csabasidor/notesData2092724/blob/main/ExportDataLayers/graphData)
- **Default settings:** Set for 1 hour intervals, (max over 240min) 
- **Possible export formats at default:** PostgreSQL, .xlsx.


10. All graphics' source code may be found in the [webData folder](https://github.com/csabasidor/notesData2092724/tree/main/webData) or online as a [dashboard](http://cases.idoaba.eu/ccors22/).
