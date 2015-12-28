--------------------------------------------------------
--  DDL for Procedure F14_7_QUARTER_FREE_THROWS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."F14_7_QUARTER_FREE_THROWS" 
(
p_quarter_id INT
)

AUTHID CURRENT_USER IS
create_free_throw_made_table VARCHAR2(510);
create_team_free_table VARCHAR2(510);

drop_tables VARCHAR2(50);

counter INT;
only_team_id INT;

BEGIN
--Holds all the 2 pointers made by a player.
create_free_throw_made_table := 
   'CREATE TABLE FREE_THROW_MADE
   AS SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id) AS free_throw_made
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type = ''free_throw_made''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   AND PLAY_EVENT.quarter_id = '||p_quarter_id||'
   GROUP BY PLAYER.player_id
   ORDER BY free_throw_made DESC';
   
create_team_free_table :=
    'CREATE TABLE QUARTER_FREE_THROWS AS 
    SELECT TEAM.team_id, SUM(FREE_THROW_MADE.free_throw_made) AS FREE_THROW_MADE
    FROM TEAM, PLAYS_FOR, FREE_THROW_MADE
    WHERE FREE_THROW_MADE.player_id = PLAYS_FOR.player_id
    AND PLAYS_FOR.team_id = TEAM.team_id
    AND PLAYS_FOR.from_date <= 
    (SELECT GAME.game_date FROM GAME, QUARTER 
    WHERE GAME.game_id = QUARTER.game_id
    AND QUARTER.quarter_id = '||p_quarter_id||')
    GROUP BY TEAM.team_id';

--Create all those tables!
   EXECUTE IMMEDIATE create_free_throw_made_table;
   EXECUTE IMMEDIATE create_team_free_table;

END;

/
