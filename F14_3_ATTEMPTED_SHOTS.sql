--------------------------------------------------------
--  DDL for Procedure F14_3_ATTEMPTED_SHOTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."F14_3_ATTEMPTED_SHOTS" 
(
p_quarter_id INT
)

AUTHID CURRENT_USER IS
create_shot_missed_table VARCHAR2(510);
create_team_shots_missed_table VARCHAR2(510);

drop_tables VARCHAR2(50);

BEGIN
--Holds all the 2 pointers made by a player.
create_shot_missed_table := 
   'CREATE TABLE SHOTS_MISSED
   AS SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id) AS shots_missed
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type LIKE ''%_missed''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   AND PLAY_EVENT.quarter_id = '||p_quarter_id||'
   GROUP BY PLAYER.player_id
   ORDER BY shots_missed DESC';
   
create_team_shots_missed_table :=
    'CREATE TABLE QUARTER_SHOTS_MISSED AS 
    SELECT TEAM.team_id, SUM(SHOTS_MISSED.shots_missed) AS SHOTS_MISSED
    FROM TEAM, PLAYS_FOR, SHOTS_MISSED
    WHERE SHOTS_MISSED.player_id = PLAYS_FOR.player_id
    AND PLAYS_FOR.team_id = TEAM.team_id
    AND PLAYS_FOR.from_date <= 
    (SELECT GAME.game_date FROM GAME, QUARTER 
    WHERE GAME.game_id = QUARTER.game_id
    AND QUARTER.quarter_id = '||p_quarter_id||')
    GROUP BY TEAM.team_id';

--Create all those tables!
   EXECUTE IMMEDIATE create_shot_missed_table;
   EXECUTE IMMEDIATE create_team_shots_missed_table;


END;

/
