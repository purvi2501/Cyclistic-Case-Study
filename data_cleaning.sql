-- After the initial data cleaning in Excel, I used BigQuery for further data cleaning. The following SQL queries highlight the same. 

-- First, all the .CSV files were uploaded on Google Drive and using file URIs, the tables were uploaded in BigQuery under a dataset called ‘bike_share’.

## Checking for Outliers
  
  -- Latitude and longitude coordinates can show potential outliers. Chicago’s official coordinates are 41.8781° N, 87.6298° W. Therefore, all rides must take place within these coordinates. 
  
  -- A query was run to find out the maximum and minimum coordinate values for ‘start_lat,’ ‘start_lng’, ‘end_lat’, and ‘end_lng’.  
  
  SELECT 
    MIN(start_lat) AS min_start_lat, 
    MAX(start_lat) AS max_start_lat, 
    MIN(start_lng) AS min_start_lng, 
    MAX(start_lng) AS max_start_lng, 
    MIN(end_lat) AS min_end_lat, 
    MAX(end_lat) AS max_end_lat, 
    MIN(end_lng) AS min_end_lng, 
    MAX(end_lng) AS max_end_lat
  FROM 
    `mydataproject64995.bike_share.nov_2022`;
   
    # Results indicate that min(end_lat) and max(end_lng) have values of 0.0 which are not possible since Chicago's coordinates are 41.8781° N, 87.6298° W. This implies that all trips must happen within these coordinates. Therefore, rows where 'end_lat = 0.0' and 'end_lng = 0.0' shall be removed. Since BigQuery Sandbox does not support the DELETE statement, a table without these rows will be viewed and materialized. 
 
 --> This was repeated for all tables.  

## Changing datatypes for data uniformity

-- For analysis in BigQuery, the 'start_time', 'end_time', and 'ride_length' columns needed to be converted from TIME to STRING and then INTERVAL datatypes. The following queries were used to do this:

  # CAST_1: From TIME TO STRING
  SELECT 
    ride_id,
    rideable_type,
    start_date,
    end_date,
    CAST(start_time AS STRING) AS start_time,
    CAST(end_time AS STRING) AS end_time,
    CAST(ride_length AS STRING) AS ride_length,
    num_of_days,
    start_day_of_week,
    month,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
FROM 
    `mydataproject64995.bike_share.jun_2022`; 
    
    # The results from this query were saved as a BigQuery table in the 'bike_share' dataset with a new naming convention. For instance, jun_2022 was saved as 202206_divvy_tripdata
    
 --> This was repeated for all tables. 
  
-- During the initial data prep in Excel, null values were observed in the ‘start_station_name’  and ‘end_station_name’ columns. To address the issue of null values, it was decided to check the start station and end stations’ latitude and longitude coordinates, wherein it was found records with null values had coordinate values up to two decimal places, as compared to those with minimum four decimal places. Hence, it was decided to remove these rows in the second CAST () query. 
 
 # CAST_2: From STRING to INTERVAL
 SELECT 
    ride_id,
    rideable_type,
    start_date,
    end_date,
    CAST(start_time AS INTERVAL) AS start_time,
    CAST(end_time AS INTERVAL) AS end_time,
    CAST(ride_length AS INTERVAL) AS ride_length,
    num_of_days,
    start_day_of_week,
    month,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual 
 FROM 
    `mydataproject64995.bike_share.202206_divvy_tripdata`
 WHERE   
    start_station_name IS NOT NULL AND end_station_name IS NOT NULL;
 
    # Another dataset was created, ‘cyclistic.’ Results of the second CAST () function were saved in this dataset with another naming convention. For instance, 2022_06_trips. The results of these two queries were saved as tables because BigQuery Sandbox does not allow Data Manipulation Language queries to run. 
    
  --> This was repeated for all tables. 

## Data Consolidation
-- After changing the table schemas for all tables, it was time to consolidate all the tables into one large table. This was done using the UNION DISTINCT operator. 

    SELECT * FROM `mydataproject64995.cyclistic.2022_02_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_03_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_04_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_05_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_06_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_07_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_08_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_09_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_10_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_11_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2022_12_trips`
    UNION DISTINCT
    SELECT * FROM `mydataproject64995.cyclistic.2023_01_trips`
    ORDER BY 
        start_date;
 
-- The resulting table was saved in the ‘cyclistic’ dataset as ‘cs1_consolidated_data’
        
## Addressing Outiers
-- As noted earlier, there were outliers in the data on the basis of the coordinates. There is another category of outliers, that is on the basis of the num_of_days column, which is the number of days passed since the start of the ride. Idealy, this number should either be 0 or 1. This too will be checked and addressed in this section.

  # 1. Based on Coordinates
  -- Viewing rows with 0.0 coordinates
  
  SELECT *
  FROM 
     `mydataproject64995.cyclistic.cs1_consolidated_data`
  WHERE 
     end_lat = 0.0 AND end_lng = 0.0;

    # There are 8 such records.
  
  -- Removing such records.

  SELECT *
  FROM 
     `mydataproject64995.cyclistic.cs1_consolidated_data`
  WHERE 
     end_lat != 0.0 AND end_lng != 0.0;
   
  --> The results of this query were saved in a BigQuery table by the name 'updated_cd'

  -- Checking 'end_lat' and 'end_lng' columns to check if 0.0 coordinate values have been removed.

  SELECT *
  FROM 
     `mydataproject64995.cyclistic.updated_cd`
  WHERE 
    end_lat = 0.0;

  SELECT * 
  FROM 
     `mydataproject64995.cyclistic.updated_cd`
  WHERE 
     end_lng = 0.0;
  
  --> There are no outliers on the basis of coordinates.
 
 # 2. Based on num_of_days
 -- During the initial data cleaning in Excel, it was found that there are records were num_of_days was greater than one. Upon careful consideration, it was decided such records be removed. 

-- Calculating the number of outliers

  SELECT 
     COUNTIF(num_of_days > 1) AS days_outliers
  FROM 
     `mydataproject64995.cyclistic.updated_cd`;
 
 # There were 43 such outliers. 

-- Viewing these records

  SELECT *
  FROM 
     `mydataproject64995.cyclistic.updated_cd`
  WHERE
     num_of_days > 1;
  
 -- Removing these records
 
 SELECT * 
 FROM 
    `mydataproject64995.cyclistic.updated_cd`
WHERE 
    num_of_days <= 1
ORDER BY 
    start_date, start_time;

  # Results of the above query were 'Saved as View', and named, 'final_cd'.
