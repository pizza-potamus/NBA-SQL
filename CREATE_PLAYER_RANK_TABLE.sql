--------------------------------------------------------
--  DDL for Procedure CREATE_PLAYER_RANK_TABLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."CREATE_PLAYER_RANK_TABLE" 
(
--This holds the stat to calculate.
p_stat_requested VARCHAR2
)
--Needed to make the EXECUTE IMMEDIATEs below work.
AUTHID CURRENT_USER IS

--Holds the commands to create the tables that calculate points scored over a player's career.
create_shot_made_table VARCHAR2(510);
create_shot_made_assist_table VARCHAR2(510);
create_three_made_table VARCHAR2(510);
create_free_throw_made_table VARCHAR2(510);
create_score_totals_table VARCHAR2(510);

--Holds the commands to create the tables that calculate threes made.
create_threes_made_table VARCHAR2(510);
create_threes_assist_table VARCHAR2(510);
create_threes_totals_table VARCHAR2(510);

--Holds the commands to create the tables that calculate rebounds made over a player's career.
create_rebound_table VARCHAR2(510);
create_defensive_rebound_table VARCHAR2(510);
create_rebound_totals_table VARCHAR2(510);

--Holds the command to create the total table which adds up the other tables if necessary.
create_total_table VARCHAR2(510);

--Holds the commands to drop tables no longer needed.
drop_tables VARCHAR2(50);
BEGIN

--Create a bunch of tables that add up the points scored by a player and drop them as they are used.
IF p_stat_requested = 'points'
THEN

--Holds all the 2 pointers made by a player.
create_shot_made_table := 
   'CREATE TABLE shot_made_leaders AS SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id)*2 AS shot_made
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type LIKE ''shot_mad%''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   GROUP BY PLAYER.player_id
   ORDER BY shot_made DESC';

--Holds all the 3 pointers made by a player.
create_three_made_table := 
   'CREATE TABLE three_made_leaders AS SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id)*3 AS three_made
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type LIKE ''three_mad%''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   GROUP BY PLAYER.player_id
   ORDER BY three_made DESC';
   
--Holds all the free throws made by a player.
create_free_throw_made_table := 
   'CREATE TABLE free_throw_made_leaders AS 
   SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id) AS free_throw_made
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type = ''free_throw_made''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   GROUP BY PLAYER.player_id
   ORDER BY free_throw_made DESC';

--Joins the two rebound tables by player_id.
create_score_totals_table := 
   'CREATE TABLE score_totals AS 
   SELECT * FROM shot_made_leaders
   UNION ALL
   SELECT * FROM three_made_leaders
   UNION ALL
   SELECT * FROM free_throw_made_leaders';
   
--Uses the SUM function to add the rows of the rebound_totals for each player_id.
create_total_table :=
   'CREATE TABLE total AS 
   SELECT score_totals.player_id, SUM(shot_made) AS points
   FROM score_totals
   GROUP BY score_totals.player_id
   ORDER BY points DESC';

--Create all those tables!
   EXECUTE IMMEDIATE create_shot_made_table;
   EXECUTE IMMEDIATE create_three_made_table;
   EXECUTE IMMEDIATE create_free_throw_made_table;
   EXECUTE IMMEDIATE create_score_totals_table;
   EXECUTE IMMEDIATE create_total_table;

--Drop the ones we don't need letter.
drop_tables := 'DROP TABLE shot_made_leaders';
   EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE three_made_leaders';
   EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE free_throw_made_leaders';
   EXECUTE IMMEDIATE drop_tables;
drop_tables := 'DROP TABLE score_totals';
   EXECUTE IMMEDIATE drop_tables;
END IF;

--Create a table of all threes made by a player.
IF p_stat_requested = 'three_made'
THEN
--Holds all the 3 pointers made by a player.
create_threes_made_table :=
   'CREATE TABLE total AS 
   SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id) AS three_made
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type LIKE ''three_mad%''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   GROUP BY PLAYER.player_id
   ORDER BY three_made DESC';
   
--Create the above table.
   EXECUTE IMMEDIATE create_total_table;
   
END IF;

--Create a table of all threes made by a player.
IF p_stat_requested = 'assists'
THEN
--Holds all the assists made by a player as the second_player in a play_event.
create_total_table :=
   'CREATE TABLE total AS SELECT PLAYER.player_id AS Player_ID, 
    COUNT(PLAY_EVENT.second_player_id) AS assists
    FROM PLAYER, PLAY_EVENT
    WHERE PLAY_EVENT.event_type LIKE ''%_with_assist''
    AND PLAY_EVENT.second_player_id = PLAYER.player_id
    GROUP BY PLAYER.player_id
    ORDER BY assists DESC';
--Create the above table.
    EXECUTE IMMEDIATE create_total_table;
END IF;

--Create a table of all streals made by a player.
IF p_stat_requested = 'steals'
THEN
--Holds all the steals made by a player as the second_player in a play_event.
create_total_table :=
   'CREATE TABLE total AS SELECT PLAYER.player_id AS Player_ID, 
    COUNT(PLAY_EVENT.second_player_id) AS steals
    FROM PLAYER, PLAY_EVENT
    WHERE PLAY_EVENT.event_type = ''turnover_steal''
    AND PLAY_EVENT.second_player_id = PLAYER.player_id
    GROUP BY PLAYER.player_id
    ORDER BY steals DESC';
--Create the above table.  
    EXECUTE IMMEDIATE create_total_table;
END IF;

--Create a table of all streals made by a player.
IF p_stat_requested = 'rebounds'
THEN

--Holds all the rebounds made by a player.
create_total_table := 
   'CREATE TABLE total AS SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id) AS rebounds
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type LIKE ''%ebound''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   GROUP BY PLAYER.player_id
   ORDER BY rebounds DESC';
   
    EXECUTE IMMEDIATE create_total_table;
   
END IF;

END;

/
