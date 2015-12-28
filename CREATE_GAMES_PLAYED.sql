--------------------------------------------------------
--  DDL for Procedure CREATE_GAMES_PLAYED
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."CREATE_GAMES_PLAYED" (player_id INT)
--Needed for the EXECUTE IMMEDIATE function.
AUTHID CURRENT_USER IS
--Holds the create table statement.
create_games_played VARCHAR2(510);
BEGIN
--Create a table that is a join of PLAYER and all the games they played.
create_games_played := 
   'CREATE TABLE GAMES_PLAYED AS SELECT PLAYER.player_id, COUNT(GAME.game_id) AS Games_Played
  FROM PLAYER, PLAYER_GAME, GAME
  WHERE PLAYER.player_id = PLAYER_GAME.player_id 
  AND PLAYER_GAME.game_id = GAME.game_id
  GROUP BY PLAYER.player_id
  ORDER BY Games_Played DESC';

--Create the table!
EXECUTE IMMEDIATE create_games_played;

END;

/
