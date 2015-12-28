--------------------------------------------------------
--  DDL for Procedure FEATURE_1_SIGN_PLAYER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."FEATURE_1_SIGN_PLAYER" (
    --All the necessary parameters needed to add a new NBA player to a team.
    p_player_name          VARCHAR2,
    --Fun fact!  I'm taking these dates in as varchar2's and then converting them to dates in the PL/SQL with the TO_DATE function! Fun!
    p_player_birthdate     VARCHAR2,
    p_player_height_feet   INT,
    p_player_height_inches INT,
    p_player_weight        INT,
    p_player_position      VARCHAR2,
    p_team_id              INT,
    p_from_date            VARCHAR2,
    p_to_date              VARCHAR2,
    p_salary               NUMBER)    
IS
  p_player_id    INT;
  
BEGIN
  
  --Use the get_primary_key function to get a legit primary key for the new player out of the appropriate sequence.
  p_player_id  :=  get_primary_key('PLAYER');
  
  --Call the new_player procedure to a insert a new player's data into the PLAYER table.
  new_player(p_player_id, p_player_name, p_player_birthdate, p_player_height_feet, p_player_height_inches, p_player_weight, p_player_position);
  
  --Call the new_plays_for procedure to a insert a new player's data into the PLAYS_FOR table.
  new_plays_for(p_team_id, p_player_id, p_to_date, p_from_date);
  
  --Call the new_contract procedure to a insert a new player's data into the PLAYS_FOR table.
  new_contract(p_player_id, p_salary, p_to_date, p_from_date);

END;

/
