--------------------------------------------------------
--  DDL for Procedure F14_1_TEAM_QUARTER_STATS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."F14_1_TEAM_QUARTER_STATS" 
(
p_quarter_id INT
)
AUTHID CURRENT_USER IS 

create_quarter_info_table VARCHAR2(510);
create_quarter_stats_table VARCHAR2(1530);

drop_tables VARCHAR2(50);

BEGIN
--PART 1
--TEAM NAME (home, away)
--GAME ID
--QUARTER ID
--QUARTER NUMBER
--IS_OVERTIME
-- TEAM points
-- TEAM attempted shots (not free throws)
-- TEAM rebounds
-- TEAM steals
-- TEAM free-throws attempted
-- TEAM free-throws made

  --Exception handling for quarters outside the range of 1 to 10.
  IF p_quarter_id < 1
  THEN RAISE_APPLICATION_ERROR (-20022, 'Positive quarter_ids only please.');
  END IF;

create_quarter_info_table :=
  'CREATE TABLE QUARTER_INFO AS 
  SELECT GAME.game_id, TEAM.location, TEAM.name, TEAM.team_id, QUARTER.is_overtime
  FROM GAME, TEAM, QUARTER, PLAYS
  WHERE TEAM.team_id = PLAYS.team_id
  AND PLAYS.game_id = GAME.game_id
  AND GAME.game_id = QUARTER.game_id
  AND QUARTER.quarter_id = '||p_quarter_id||'';
  
create_quarter_stats_table :=  
'CREATE TABLE QUARTER_STATS AS
SELECT QUARTER_INFO.game_id, 
       QUARTER_INFO.location, 
       QUARTER_INFO.name,
       QUARTER_INFO.team_id, 
       QUARTER_INFO.is_overtime,
       COALESCE(QUARTER_POINTS.total_team_score,0) AS POINTS,
       COALESCE(QUARTER_SHOTS_MISSED.shots_missed, 0) AS SHOTS_MISSED, 
       COALESCE(QUARTER_REBOUNDS.quarter_rebounds,0) AS REBOUNDS, 
       COALESCE(QUARTER_STEALS.quarter_steals,0) AS STEALS,
       COALESCE(QUARTER_FREE_THROWS.free_throw_made,0) AS FREE_THROWS_MADE, 
       COALESCE(QUARTER_FREES_MISSED.frees_missed,0) AS FREE_THROWS_MISSED
       
FROM   QUARTER_INFO, QUARTER_POINTS, QUARTER_SHOTS_MISSED, 
       QUARTER_REBOUNDS, QUARTER_STEALS, QUARTER_FREE_THROWS, QUARTER_FREES_MISSED
       
WHERE  QUARTER_INFO.team_id = QUARTER_POINTS.team_id
AND    QUARTER_POINTS.team_id = QUARTER_SHOTS_MISSED.team_id
AND    QUARTER_SHOTS_MISSED.team_id = QUARTER_REBOUNDS.team_id
AND    QUARTER_REBOUNDS.team_id = QUARTER_STEALS.team_id
AND    QUARTER_STEALS.team_id = QUARTER_FREE_THROWS.team_id
AND    QUARTER_FREE_THROWS.team_id = QUARTER_FREES_MISSED.team_id';

EXECUTE IMMEDIATE create_quarter_info_table;
EXECUTE IMMEDIATE create_quarter_stats_table;

--Drop all the tables used for the quarter stats calculations.
drop_tables := 'DROP TABLE SCORE_TOTALS';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_SCORE_TOTAL';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_INFO';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_SHOTS_MISSED';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_REBOUNDS';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_POINTS';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE FREES_MISSED';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE FREE_THROW_MADE';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_REBOUNDS_BY_PLAYER';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_STEALS_BY_PLAYER';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE FREE_THROW_MADE_LEADERS';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_FREE_THROWS';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_FREES_MISSED';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE SHOT_MADE_LEADERS';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE QUARTER_STEALS';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE SHOTS_MISSED';
EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE THREE_MADE_LEADERS';
EXECUTE IMMEDIATE drop_tables;

END;

/
