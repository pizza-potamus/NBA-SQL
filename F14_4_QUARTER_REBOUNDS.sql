--------------------------------------------------------
--  DDL for Procedure F14_4_QUARTER_REBOUNDS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."F14_4_QUARTER_REBOUNDS" 
(
p_quarter_id INT
)

AUTHID CURRENT_USER IS
create_quarter_rebounds_table VARCHAR2(510);
create_team_rebounds_table VARCHAR2(510);

drop_tables VARCHAR2(50);

BEGIN
--Holds all the 2 pointers made by a player.
create_quarter_rebounds_table := 
   'CREATE TABLE QUARTER_REBOUNDS_BY_PLAYER
   AS SELECT PLAYER.player_id AS Player_ID, 
   COUNT(PLAY_EVENT.main_player_id) AS rebounds
   FROM PLAYER, PLAY_EVENT
   WHERE PLAY_EVENT.event_type LIKE ''%ebound''
   AND PLAY_EVENT.main_player_id = PLAYER.player_id
   AND PLAY_EVENT.quarter_id = '||p_quarter_id||'
   GROUP BY PLAYER.player_id
   ORDER BY rebounds DESC';
   
create_team_rebounds_table :=
    'CREATE TABLE QUARTER_REBOUNDS AS 
    SELECT TEAM.team_id, SUM(QUARTER_REBOUNDS_BY_PLAYER.rebounds) AS QUARTER_REBOUNDS
    FROM TEAM, PLAYS_FOR, QUARTER_REBOUNDS_BY_PLAYER
    WHERE QUARTER_REBOUNDS_BY_PLAYER.player_id = PLAYS_FOR.player_id
    AND PLAYS_FOR.team_id = TEAM.team_id
    AND PLAYS_FOR.from_date <= 
    (SELECT GAME.game_date FROM GAME, QUARTER 
    WHERE GAME.game_id = QUARTER.game_id
    AND QUARTER.quarter_id = '||p_quarter_id||')
    GROUP BY TEAM.team_id';

--Create all those tables!
   EXECUTE IMMEDIATE create_quarter_rebounds_table;
   EXECUTE IMMEDIATE create_team_rebounds_table;


END;

/
