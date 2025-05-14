-- Databricks notebook source
select team_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as rank
from f1_presentation.calculated_race_results
group by team_name
having total_races > 100
order by avg_points desc

-- COMMAND ----------

select race_year,
       team_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as rank
from f1_presentation.calculated_race_results
group by race_year, team_name
order by race_year, avg_points desc

-- COMMAND ----------

-- MAGIC %python 
-- MAGIC html = """<h1 style= "clolor:Black;text-align:center;front-family:Ariel">Report on Dominant Formula 1 Teams</h1>"""
-- MAGIC displayHTML(html)

-- COMMAND ----------

create or replace temp view v_dominen_teams
as
select team_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as team_rank
from f1_presentation.calculated_race_results
group by team_name
having count(1) >= 10
order by avg_points desc

-- COMMAND ----------

select race_year,
       team_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as rank
from f1_presentation.calculated_race_results
where team_name in (select team_name from v_dominen_teams where team_rank <=10)
group by race_year, team_name
order by race_year, avg_points desc

-- COMMAND ----------

select race_year,
       team_name,
       count(1) as total_races,
       sum(points_rank) as total_points,
       avg(points_rank) as avg_points,
       rank() over(order by avg(points_rank) desc) as rank
from f1_presentation.calculated_race_results
where team_name in (select team_name from v_dominen_teams where team_rank <=10)
group by race_year, team_name
order by race_year, avg_points desc