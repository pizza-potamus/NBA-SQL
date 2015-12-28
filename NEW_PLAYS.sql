--------------------------------------------------------
--  DDL for Procedure NEW_PLAYS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."NEW_PLAYS" (
    --All the necessary parameters needed to add a new game to the database.
    --Fun fact!  I'm taking these dates in as varchar2's and then converting them to dates in the PL/SQL with the TO_DATE function! Fun!
    p_game_id          INT,
    p_home_team_name   VARCHAR2,
    p_away_team_name   VARCHAR2,
    p_home_team_score  INT,
    p_away_team_score  INT)
IS
TYPE team_names_array IS VARRAY(30) OF VARCHAR2(20);
all_team_names team_names_array;
--Variables to hold the ids and results of the teams playing in the game.
p_home_team_id  INT;
p_away_team_id  INT;
p_home_result VARCHAR2(1);
p_away_result VARCHAR2(1);
BEGIN

  --Exception handling for scores outside of realistic ranges.
  IF p_home_team_score < 50
  THEN RAISE_APPLICATION_ERROR (-20028, 'The home team score is too low.  Keep it above 50; we are professionals after all.');
  ELSIF p_home_team_score > 200
  THEN RAISE_APPLICATION_ERROR (-20029, 'Woah, easy there Wilt, no way the home team score is above 200.');
  END IF;
  
  --Exception handling for scores outside of realistic ranges.
  IF p_away_team_score < 50
  THEN RAISE_APPLICATION_ERROR (-20030, 'The home team score is too low.  Keep it above 50; we are professionals after all.');
  ELSIF p_away_team_score > 200
  THEN RAISE_APPLICATION_ERROR (-20031, 'Woah, easy there Wilt, no way the home team score is above 200.');
  END IF;
  
  SELECT TEAM.team_id
  INTO p_home_team_id
  FROM TEAM
  WHERE p_home_team_name = TEAM.name;
  
  SELECT TEAM.team_id
  INTO p_away_team_id
  FROM TEAM
  WHERE p_away_team_name = TEAM.name;
  
  EXCEPTION
  WHEN NO_DATA_FOUND
  THEN RAISE_APPLICATION_ERROR (-20032,'A team name is incorrect.  Use just the name of the team (i.e. Bulls) with no city.');
  
  IF p_home_team_score > p_away_team_score
  THEN 
  p_home_result := 'Y';
  p_away_result := 'N';
  ELSE
  p_home_result := 'N';
  p_away_result := 'Y';
  END IF;
  
  -- Insert the above input parameters into the GAME table.
  INSERT
  INTO PLAYS VALUES
    (
      p_game_id,
      p_home_team_id,
      p_home_team_score,
      p_home_result
    );
    
  -- Insert the above input parameters into the GAME table.
  INSERT
  INTO PLAYS VALUES
    (
      p_game_id,
      p_away_team_id,
      p_away_team_score,
      p_away_result
    );
    
END;

/
