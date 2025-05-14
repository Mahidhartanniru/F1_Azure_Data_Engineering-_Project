-- Databricks notebook source
select driver_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc)
from f1_presentation.calculated_race_results
group by driver_name
having total_races > 50
order by avg_points desc

-- COMMAND ----------

select race_year,
       driver_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as rank
from f1_presentation.calculated_race_results
group by race_year, driver_name
order by race_year, avg_points desc

-- COMMAND ----------

-- MAGIC %python 
-- MAGIC html = """<h1 style= "clolor:Black;text-align:center;front-family:Ariel">Report on Dominant Formula 1 Drivers</h1>"""
-- MAGIC displayHTML(html)

-- COMMAND ----------

create or replace temp view v_dominen_drivers
as
select driver_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as driver_rank
from f1_presentation.calculated_race_results
group by driver_name
having count(1) >= 50
order by avg_points desc

-- COMMAND ----------

select race_year,
       driver_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as rank
from f1_presentation.calculated_race_results
where driver_name in (select driver_name from v_dominen_drivers where driver_rank <=10)
group by race_year, driver_name
order by race_year, avg_points desc

-- COMMAND ----------

select race_year,
       driver_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as rank
from f1_presentation.calculated_race_results
where driver_name in (select driver_name from v_dominen_drivers where driver_rank <=10)
group by race_year, driver_name
order by race_year, avg_points desc

-- COMMAND ----------

select race_year,
       driver_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as rank
from f1_presentation.calculated_race_results
where driver_name in (select driver_name from v_dominen_drivers where driver_rank <=10)
group by race_year, driver_name
order by race_year, avg_points desc