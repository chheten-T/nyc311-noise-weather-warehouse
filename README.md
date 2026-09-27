# NYC 311 Noise Complaints and Weather

This was a team project for my Data Warehousing for Analytics class (CIS 4400) at Baruch College.

**My part:** I designed the data marts and the final data model, built the ETL workflow in Alteryx,
created and loaded the tables in Google BigQuery, and made the temperature KPI.

## The question

Noise complaints are one of the most common things New Yorkers report to 311.
We wanted to know if the weather changes how many noise complaints the city gets.
If it does, city agencies could use that to plan their staff and response.

## The data

| Source | What we used |
|---|---|
| [NYC 311 Service Requests](https://data.cityofnewyork.us/Social-Services/311-Service-Requests-from-2020-to-Present/erm2-nwe9) (NYC Open Data) | Only noise complaints. 500,000 rows in the final table |
| [NOAA daily weather](https://www.ncei.noaa.gov/products/land-based-station/global-historical-climatology-network-daily) | Daily high and low temperature, rain, snow, and wind for NYC weather stations |

## How I built it

1. **Got the data** from NYC Open Data and NOAA
2. **Cleaned it in Alteryx:** removed duplicates, fixed missing values, changed the date formats so the two datasets could be joined, gave each record an ID, and calculated how many hours each complaint took to close
3. **Loaded it into BigQuery:** 9 tables in total
4. **Wrote SQL** in BigQuery to answer each KPI
5. **Made charts** in Tableau

### Data model

The warehouse uses a star schema:

- `Fact_311`: one row for each noise complaint, including how many hours it took to close
- `Fact_Weather`: one row for each weather station for each day (high temp, low temp, rain, snow, wind)
- Lookup tables: Date (shared by both fact tables), Complaint Type, Agency, Location, and Station

![Data model](screenshots/dimensional-model.png)

![Alteryx ETL workflow](screenshots/etl-workflow.png)

![Tables loaded in BigQuery](screenshots/bigquery-tables.png)

## What we found

**Complaints vs. temperature (my KPI):** I expected more complaints as it got warmer, but that's
not quite what happened. Complaints go up from cold days to mild days, are highest around
60 to 70°F, and then go down again on the hottest days. Very hot and very cold days both
seem to keep people inside.

![Complaints vs. average daily temperature](screenshots/temp-vs-complaints.png)

The SQL for this chart is in [`sql/complaints_vs_avg_temperature.sql`](sql/complaints_vs_avg_temperature.sql).

![My KPI query in BigQuery](screenshots/sql-kpi.png)

**Other findings from the team:**

- Weekends have almost twice as many complaints as weekdays: about 103K on Saturday and 107K on Sunday, compared with about 54K to 59K on Monday through Thursday
- In every borough, hot and dry days had the most complaints and snowy days had the fewest

## What this means

The city should plan for more noise complaints on mild weekends, not just on the hottest days.

## What's in this repo

- `sql/`: the BigQuery SQL for my KPI
- `screenshots/`: the data model, Alteryx workflow, BigQuery tables, my SQL query, and my chart

## Tools

Alteryx, Google BigQuery, SQL, Tableau, NYC Open Data, NOAA Climate Data Online
