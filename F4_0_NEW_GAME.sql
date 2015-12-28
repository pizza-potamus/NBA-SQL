--------------------------------------------------------
--  DDL for Procedure FEATURE_4_NEW_GAME
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."FEATURE_4_NEW_GAME" (
    --All the necessary parameters needed to add a series of play_events that make a game to the DB.
    --Fun fact!  I'm taking these dates in as varchar2's and then converting them to dates in the PL/SQL with the TO_DATE function! Fun!
    p_game_date      IN VARCHAR2,
    p_is_playoff     IN VARCHAR2,
    p_playoff_round  IN INT,
    p_number_quarters IN INT,
    p_home_team_name IN VARCHAR2,
    p_away_team_name IN VARCHAR2,
    p_home_team_score IN INT,
    p_away_team_score IN INT
    )
IS
--The game_id will come from the get_primary_key function below.
  p_game_id INT;
--To store the quarter number calculated in the below loop.
  p_quarter_number INT;
--Most games do not go into overtime, hence the default.
  p_is_overtime VARCHAR2(1) DEFAULT 'N';
BEGIN

  --Use the get_primary_key function to get a legit primary key for the new game out of the appropriate sequence.
  p_game_id    :=  get_primary_key('GAME');
  --Start quarters at 1 and increment them in the loop below.
  p_quarter_number := 1;
  --Use the new_game procedure to make a new game entry.
  new_game (p_game_id, p_game_date, p_is_playoff, p_playoff_round);
  --Use the new_plays procedure to make a new plays entry.
  new_plays(p_game_id, p_home_team_name, p_away_team_name, p_home_team_score, p_away_team_score);

  --Loop through the number of quarters in the game, creating a new one with each pass.
  FOR i IN 1..p_number_quarters LOOP
  new_quarter (p_game_id, p_quarter_number, p_is_overtime);
  p_quarter_number := p_quarter_number+1;
  IF p_quarter_number > 4
  THEN p_is_overtime := 'Y';
  END IF;
  END LOOP;
  
END;

/
