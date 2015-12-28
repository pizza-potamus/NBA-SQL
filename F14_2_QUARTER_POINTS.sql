--------------------------------------------------------
--  DDL for Procedure F14_2_QUARTER_POINTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."F14_2_QUARTER_POINTS" 
(
p_quarter_id INT
)

AUTHID CURRENT_USER IS
create_three_made_table VARCHAR2(510);
create_shot_made_table VARCHAR2(510);
create_free_throw_made_table VARCHAR2(510);
create_score_totals_table VARCHAR2(510);
create_quarter_total_table VARCHAR2(510);
create_team_score_table  VARCHAR2(510);

drop_tables VARCHAR2(50);

BEGIN
--Holds all the 2 pointers made by a player.
create_shot_made_table := 
   'CREATE TABLE SHOT_MADE_LEADERS 
   AS SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id)*2 AS shot_made
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type LIKE ''shot_mad%''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   AND PLAY_EVENT.quarter_id = '||p_quarter_id||'
   GROUP BY PLAYER.player_id
   ORDER BY shot_made DESC';

--Holds all the 3 pointers made by a player.
create_three_made_table := 
   'CREATE TABLE THREE_MADE_LEADERS 
   AS SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id)*3 AS three_made
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type LIKE ''three_mad%''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   AND PLAY_EVENT.quarter_id = '||p_quarter_id||'
   GROUP BY PLAYER.player_id
   ORDER BY three_made DESC';
   
--Holds all the free throws made by a player.
create_free_throw_made_table := 
   'CREATE TABLE FREE_THROW_MADE_LEADERS AS 
   SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id) AS free_throw_made
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type = ''free_throw_made''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   AND PLAY_EVENT.quarter_id = '||p_quarter_id||'
   GROUP BY PLAYER.player_id
   ORDER BY free_throw_made DESC';

--Joins the two rebound tables by player_id.
create_score_totals_table := 
   'CREATE TABLE SCORE_TOTALS AS 
   SELECT * FROM shot_made_leaders
   UNION ALL
   SELECT * FROM three_made_leaders
   UNION ALL
   SELECT * FROM free_throw_made_leaders';
   
--Uses the SUM function to add the rows of the rebound_totals for each player_id.
create_quarter_total_table :=
   'CREATE TABLE QUARTER_SCORE_TOTAL AS 
   SELECT score_totals.player_id, SUM(shot_made) AS points
   FROM score_totals
   GROUP BY score_totals.player_id
   ORDER BY points DESC';
   
create_team_score_table :=
    'CREATE TABLE QUARTER_POINTS AS 
    SELECT TEAM.team_id, SUM(QUARTER_SCORE_TOTAL.points) AS TOTAL_TEAM_SCORE
    FROM TEAM, PLAYS_FOR, QUARTER_SCORE_TOTAL
    WHERE QUARTER_SCORE_TOTAL.player_id = PLAYS_FOR.player_id
    AND PLAYS_FOR.team_id = TEAM.team_id
    AND PLAYS_FOR.from_date <= 
    (SELECT GAME.game_date FROM GAME, QUARTER 
    WHERE GAME.game_id = QUARTER.game_id
    AND QUARTER.quarter_id = '||p_quarter_id||')
    GROUP BY TEAM.team_id';

--Create all those tables!
   EXECUTE IMMEDIATE create_shot_made_table;
   EXECUTE IMMEDIATE create_three_made_table;
   EXECUTE IMMEDIATE create_free_throw_made_table;
   EXECUTE IMMEDIATE create_score_totals_table;
   EXECUTE IMMEDIATE create_quarter_total_table;
   EXECUTE IMMEDIATE create_team_score_table;
   
END;

/
