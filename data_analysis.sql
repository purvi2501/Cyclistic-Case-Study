#### Identifying riding trends

### Aggregate numbers by month, day of the week and type of bike.

## Viewing the complete data
SELECT *
FROM 
   `mydataproject64995.cyclistic.final_cd`
ORDER BY 
   ride_length DESC;

## Data Summary

  SELECT
     COUNT(member_casual) AS total_rides,
     COUNTIF(member_casual = "member") AS member_riders,
     COUNTIF(member_casual = "casual") AS casual_riders,
     ROUND((COUNTIF(member_casual = "member")/COUNT(member_casual)*100),2) AS member_percentage,
     ROUND((COUNTIF(member_casual = "casual")/COUNT(member_casual)*100),2) AS casual_percentage,
     AVG(ride_length) AS avg_ride_length,
     MAX(ride_length) AS max_ride_length
  FROM 
    `mydataproject64995.cyclistic.final_cd`;

  #Results: 
   -- Over the year, a total of 4,437,242 rides were taken by users, from which around 60% (2,662,140) were taken by annual members, while around 40% (1,775,102) accounted for rides taken by casual riders. Moreover, the average ride length over the year was 16 mins 53 seconds. 


## Analyzing number of riders, monthly

  SELECT 
     month,
     COUNT(member_casual) AS total_rides,
     COUNTIF(member_casual = "member") AS member_riders,
     COUNTIF(member_casual = "casual") AS casual_riders,
     ROUND((COUNTIF(member_casual = "member")/COUNT(member_casual)*100),2) AS member_percentage,
     ROUND((COUNTIF(member_casual = "casual")/COUNT(member_casual)*100),2) AS casual_percentage,
     ROUND((COUNTIF(member_casual = "member")/COUNT(member_casual)*100) - (COUNTIF(member_casual = "casual")/COUNT(member_casual)*100),2) AS percent_difference,
     AVG(ride_length) AS avg_ride_length,
     MAX(ride_length) AS max_ride_length
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  GROUP BY 
     month
  ORDER BY 
     total_rides DESC;
  
  #Results: 
    -- 1. It has been observed that the months of July (642,675), June (620,349) and August (605,323), in that order, recorded the most riders. Least rides were recorded in the months of January(148,061), December (135,403) and February (89,168), in that order. 

      --> In all months, member riders were (significantly, in some cases) greater than casual riders. To gauge the extent of this difference, member and casual riders as a percent of total rides was found out, and then the percent difference between these was calculated. 

    -- 2. It is intersting to note that the percent difference between casual riders and member riders is lowest in the months of July(3.01%), June (5.84%), and August (10.76%), the most ride months. This implies that the number of casual riders and members were more or less the same. The difference is higher in least ride months of February (66.06%), January (60.07%), and December (53.46%), implying that in the Winter months, members were more likely to book rides as compared to casual riders. 

   -- 3. In the months of August, June and July, member riders as percent of total rides account for 55.38%, 52.92% and 51.50%, respectively. Meanwhile, in the same months, casual riders accounted for 44.62%, 47.08% and 48.5% repsectively. 

   -- 4. Similarly, the months of February, January and December recorded the most number of member riders, having 83.03%, 80.03% and 76.73% member riders respectively Meanwhile, in the same months, casual riders accounted for 16.97%, 19.97% and 23.27% repsectively. 
 
   -- 5. Following the high recording Summer months are alternating Spring and Fall months, before culminating with the winter months.

   -- 6. The range of average ride length is between 10 mins and 20 mins. The highest average ride length was recorded in the month of May (19m 32s), followed by July (19m 01s), June (18m 59s) and August (17m 39s). Similarly, the lowest average ride lenghts were recorded in the months of February (12m 27s), followed by December (11m 16s), January (10m 55s). The trend observed before was seen here too. Summer months record higher ride duration, as compared to the Winter months. 
  
      ==> Actionable Insight: Casual riders are less likely to book rides in the Winter months, as opposed to Summer months. This implies, marketing strategies targeting casual riders for conversion to annual members should happen in the months before summer. 

  
## Analyzing number of riders, by weekday. 

  SELECT 
     start_day_of_week,
     COUNT(member_casual) AS total_rides,
     COUNTIF(member_casual = "member") AS member_riders,
     COUNTIF(member_casual = "casual") AS casual_riders,
     ROUND((COUNTIF(member_casual = "member")/COUNT(member_casual)*100),2) AS member_percentage,
     ROUND((COUNTIF(member_casual = "casual")/COUNT(member_casual)*100),2) AS casual_percentage,
     ROUND((COUNTIF(member_casual = "member")/COUNT(member_casual)*100) - (COUNTIF(member_casual = "casual")/COUNT(member_casual)*100),2) AS percent_difference,
     AVG(ride_length) AS avg_ride_length
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  GROUP BY 
     start_day_of_week
  ORDER BY 
     total_rides DESC;

# Note: 1 = Sunday, 2 = Monday, 3 = Tuesday, 4 = Wednesday, 5 = Thursday, 6 = Friday, 7 = Saturday.

  #Results: 
    -- 1. Saturdays have been recorded as the day with most trips (709,608), followed by Thursday (654,383) and Wednesday (628,648).

    -- 2. Least number of trips were recorded on Monday (595,756), follwed by Sunday (607,443), and Friday (617,429). 

    -- 3. Except Saturdays and Sundays, member riders book more rides as compared to casual riders. On Saturdays,there were 3.83% more casual riders, while on Sundays, there were 0.24% more casual riders. These were also the days when most rides were booked by casual riders. 

    -- 4. The weekdays are where higher proportion of members book rides. On Tuesdays, members booked the most rides, accounting for 67.96% of the total rides, followed by Wednesday (67.16%), Thursday (64.56%), and Monday (64.2%). On average, the total rides on these days were close to or over 600,000. 

    -- 5. On Fridays, member rides accounted for 59.4% of the total rides, while 40.6% rides were booked by casual riders. 

    -- 6. On average, Saturdays and Sundays registered a higher ride duration of 20 mins 25 seconds, followed by Mondays (16 mins 20 seconds) and Fridays (16 mins 11 seconds). 
  
      ==> Actionable Insight: Casual riders booked more rides on Saturdays and Sundays, while members booked more rides on weekdays. Additionally, the average ride duration was also higher on the weekends as compared to other days.


 ## Analyzing number of riders, by bike type
 
  SELECT 
     rideable_type,
     COUNT(member_casual) AS total_rides,
     COUNTIF(member_casual = "member") AS member_riders,
     COUNTIF(member_casual = "casual") AS casual_riders,
     ROUND((COUNTIF(member_casual = "member")/COUNT(member_casual)*100),2) AS member_percentage,
     ROUND((COUNTIF(member_casual = "casual")/COUNT(member_casual)*100),2) AS casual_percentage,
     ROUND((COUNTIF(member_casual = "member")/COUNT(member_casual)*100) - (COUNTIF(member_casual = "casual")/COUNT(member_casual)*100),2) AS percent_difference,
     AVG(ride_length) AS avg_ride_length
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  GROUP BY 
     rideable_type
  ORDER BY 
     total_rides DESC;

  # Results:
    -- 1. Classic bikes have been booked the most,having 2,632,814 rides in the past year, followed by electric bikes, having 1,628,880 rides, and docked bikes having 175,548 rides. 

    -- 2. Of the 2,632,814 classic bike rides, 65.98% (1,737,086) were booked by members, while the rest, 34.02% (895,728) were booked by casual riders. A similar trend was seen for electric bikes. Of the 1,628,880 rides, 56.79% (925,054) were booked by members, while 43.21% (703,826) were booked by casual riders.

    -- 3. It is intersting to note that when it came to docked bikes, all 175,548 rides were booked by casual riders. 

    -- 4. When it comes to average ride lengths, it is obvious docked bikes would register a higher duration, since only casual riders use these bikes. Docked bikes recorded an average ride duration of 48 mins 05 seconds. While, Classic bikes recorded an average ride duration of 16 mins 58 seconds, and electric bikes recorded an average ride duration of 13 mins 23 seconds.

      ==> Actionable Insight: While both types of riders first prefer clasic bikes, followed by electric bikes,further investigation is needed to understand why only casual riders use docked bikes. 


## Analyzing ride duration, by rider type.

  SELECT
     member_casual,
     AVG(ride_length) AS avg_ride_length
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  GROUP BY 
     member_casual;

  # Results:
    -- Members, on average, rode for 12 mins 23 secs, while Casual riders rode for 23 mins 38 secs on average. 


## Analyzing monthly ride duration, by rider type. 

 -- Members
  SELECT 
     start_day_of_week,
     AVG(ride_length) AS member_avg_ride_length,
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  WHERE 
     member_casual = "member"
  GROUP BY 
     start_day_of_week
  ORDER BY 
     member_avg_ride_length DESC;

  # Result: 
    -- 1. Unsurprisingly, Saturdays(13m 58s) and Sundays(13m 50s) register the higest avg ride duration for members. 

    -- 2. Tuesdays(11m 43s) and Wednesdays(11m 48s) register the lowest avg ride duration for members.  

 -- Casual riders
  SELECT 
     start_day_of_week,
     AVG(ride_length) AS casual_avg_ride_length,
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  WHERE 
     member_casual = "casual"
  GROUP BY 
     start_day_of_week
  ORDER BY 
     casual_avg_ride_length DESC;

  # Results:
    -- 1. In case of casual riders, Sundays (26m 59s) and Saturdays (26m 24s) have recorded the highest avg ride duration.

    -- 2. Unlike members, for casual riders, lowest avg ride durations were recorded on Wednesdays (20m 59s) and Thursdays (20m 21s).

      ==> Actionable Insight: In either case, weekends are more popular among riders. However, according to the group differences between the highest avg ride durations. casual riders were seen to use bikes for a 64.44% longer duration as compared to members. 


## Analyzing weekday ride duration, by rider type. 

 -- Members 
  SELECT 
     month,
     AVG(ride_length) AS member_avg_ride_length,
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  WHERE 
     member_casual = "member"
  GROUP BY 
     month
  ORDER BY 
     member_avg_ride_length DESC;

  # Result: 
    -- 1. Unsurprisingly, the months of June (13m 41s), July (13m 30s) and May (13m17s) register the higest avg ride duration for members. 

    -- 2. February (10m 37s), December (10m 12s) and January (09m 57s) register the lowest avg ride duration for members.  

 -- Casual riders
  SELECT 
     month,
     AVG(ride_length) AS casual_avg_ride_length,
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  WHERE 
     member_casual = "casual"
  GROUP BY 
     month
  ORDER BY 
     casual_avg_ride_length DESC;

  # Results:
    -- 1. In case of casual riders, the months of Spring, namely May (27m 34s), March (26m 27s), and April (25m 41s) have recorded the highest avg ride duration.

    -- 2. Lowest avg ride durations were recorded in the months Autumn month of November (17m 31s) and in the Winter months of December (14m 47s) and January (14m 48s).

      ==> Actionable Insight: There are stark differences in the average ride duration between both groups, and there is also a difference in the overall trend. So far, it was observed that for both categories, the months of Summer were the ones where both types of riders booked more rides as compared to other months. However, in terms of average ride duration, members follow the above trend. However, casual riders rode their bikes for a longer duration in the months of spring. This is where, I believe, cyclistic can most likely convert casual riders into annual members by offering attractive benefits for the member plans. 

## Analyzing ride duration for bike types, by rider type

  SELECT 
     rideable_type,
     AVG(ride_length) AS avg_ride_length
  FROM 
    `mydataproject64995.cyclistic.final_cd`
  WHERE 
    member_casual = "casual"  -- change to "member" for getting average ride duration by members. 
  GROUP BY 
    rideable_type;
  
  # Results:
     -- 1. The average ride duration for classic bikes for members was 13 minutes 10 seconds, while, for casual riders, it was 24 minutes 20 seconds.        
     -- 2. Similarly, for electric bikes, the average ride duration for member was 10 minutes 55 seconds, whereas, for casual riders, it was 16 minutes 37 seconds. 
     
     -- 3. The average ride duration for docked bikes was very high from the overall average. It was recorded to be 48 minutes 05 seconds. The average ride duration for docked bikes may be considered as outliers, as it was observed that only casual riders use these bikes. However, more further information and data are required on the reasons for usage of such bikes to draw reliable conclusions.  

## Top 10 Start Startions

-- First, distinct start stations will be viewed.
  
  SELECT 
     DISTINCT start_station_name
     FROM 
        `mydataproject64995.cyclistic.final_cd`;

  #Result: There are 1561 distinct start stations.

## Top 10 start stations by total riders, members and casual riders.

 -- Ordered by total_riders
  SELECT
     DISTINCT start_station_name,
     COUNT(DISTINCT ride_id) AS total_riders,
     COUNTIF(member_casual = "member") AS member_riders,
     COUNTIF(member_casual = "casual") AS casual_riders,
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  GROUP BY 
      start_station_name
  ORDER BY 
      total_riders DESC
  LIMIT 10;

 -- Ordered by member_riders
  SELECT
    DISTINCT start_station_name,
    COUNT(DISTINCT ride_id) AS total_riders,
    COUNTIF(member_casual = "member") AS member_riders,
    COUNTIF(member_casual = "casual") AS casual_riders,
  FROM
     `mydataproject64995.cyclistic.final_cd`
  GROUP BY 
     start_station_name
  ORDER BY 
     member_riders DESC
  LIMIT 10;

 -- Ordered by casual_riders
  SELECT
     DISTINCT start_station_name,
     COUNT(DISTINCT ride_id) AS total_riders,
     COUNTIF(member_casual = "member") AS member_riders,
     COUNTIF(member_casual = "casual") AS casual_riders,
  FROM 
     `mydataproject64995.cyclistic.final_cd`
  GROUP BY 
     start_station_name
  ORDER BY 
     casual_riders DESC
  LIMIT 10;
