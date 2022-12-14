# notesData2092724  

The repository contains all code and base data referenced within the submited manuscript notes to journal [Data: Special Issue "Data-Driven Approach on Urban Planning and Smart Cities"](https://www.mdpi.com/journal/data/special_issues/78AR6O8M60), under the title:  
##### Basic input data for audiences’ geotargeting by destinations’ partial accessibility: Notes from Slovakia 

The contains of the repo should to be used only to the extent described within [manuscript](link will be added if published). Altering the purpose or extent that is not described, does not guarantee fuctionality.

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
- **Possible export formats at default:** PostgreSQL, .xlsx, .csv 

2. ### [callGraphApi.py](https://github.com/csabasidor/manuscriptData/blob/main/callGraphApi.py)  
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/)
- **Purpose and Extent of usage:**   
- **Default settings (of variables):**   
    - **Administrative unit (list_of_nuts):
    - **Year (year_id):** 2021 
    - **Months (list_of_months):** all available  
    - **Indicators:**  all available
    - **Incoming markets:** all available  
- **Possible export formats at default:** PostgreSQL, .xlsx, .csv 


3. ### [importMultipleExcelDumpsGoogleAnalytics.py](https://github.com/csabasidor/notesData2092724/blob/main/importMultipleExcelDumpsGoogleAnalytics.py)  
- **Minimum prerequisites**: [Python 3.7](https://www.python.org/downloads/release/python-370/) or later version, [PostgreSQL](https://www.postgresql.org/download/)
- **Purpose and Extent of usage:**   
- **Default settings (of variables):**   
    - **Administrative unit (list_of_nuts):
    - **Year (year_id):** 2021 
    - **Months (list_of_months):** all available  
    - **Indicators:**  all available
    - **Incoming markets:** all available  
- **Possible export formats at default:** PostgreSQL, .xlsx, .csv 

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
