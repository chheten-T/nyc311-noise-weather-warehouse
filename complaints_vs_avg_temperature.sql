-- KPI: Complaint Volume vs. Average Daily Temperature
-- Counts the noise complaints for each day and matches each day with its average
-- temperature (the average of that day's high and low). I used this for the scatter chart in Tableau.
-- To run it, change your_project to your own Google Cloud project ID.

SELECT
  wd.DATE AS complaint_date,
  (fw.TMAX + fw.TMIN) / 2 AS avg_temp,
  COUNT(*) AS total_complaints
FROM `your_project.noise_weather_dw.311` f
JOIN `your_project.noise_weather_dw.Dim_CreatedTime` ct
  ON f.CreatedTime_Surrogate_Key = ct.CreatedTime_Surrogate_Key
JOIN `your_project.noise_weather_dw.Dim_WeatherDate` wd
  ON ct.Created_Date_Format = wd.DATE
JOIN `your_project.noise_weather_dw.Fact_Weather` fw
  ON wd.Date_Surrogate_Key = fw.Date_Surrogate_Key
WHERE (fw.TMAX + fw.TMIN) / 2 < 120   -- remove bad temperature readings
GROUP BY wd.DATE, fw.TMAX, fw.TMIN
ORDER BY wd.DATE ASC;
