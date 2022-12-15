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
    -  **Output data set name:** inputCr3804mr  
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
- **Possible export formats at default:** PostgreSQL, 

4. ### [geocodeBatchSimple.py](https://github.com/csabasidor/notesData2092724/blob/main/geocodeBatchSimple.py)  
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/)
- **Purpose and Extent of usage:**   
- **Default settings (of variables):**   
    - **Administrative unit (list_of_nuts):
    - **Year (year_id):** 2021 
    - **Months (list_of_months):** all available  
    - **Indicators:**  all available
    - **Incoming markets:** all available  
- **Possible export formats at default:** PostgreSQL, .xlsx, .csv 
