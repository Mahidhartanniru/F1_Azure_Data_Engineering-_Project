-- Databricks notebook source
select * from f1_presentation.calculated_race_results

-- COMMAND ----------

select team_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points
from f1_presentation.calculated_race_results
group by team_name
having total_races >= 100
order by avg_points desc

-- COMMAND ----------

select team_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points
from f1_presentation.calculated_race_results
where race_year between 2011 and 2020
group by team_name
having total_races >= 100
order by avg_points desc

-- COMMAND ----------

select team_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points
from f1_presentation.calculated_race_results
where race_year between 2001 and 2010
group by team_name
having total_races >= 100
order by avg_points desc