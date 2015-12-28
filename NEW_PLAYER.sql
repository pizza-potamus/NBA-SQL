--------------------------------------------------------
--  DDL for Procedure NEW_PLAYER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."NEW_PLAYER" (
--All the parameters needed to input a player into the database.
    p_player_id            INT,
    p_player_name          VARCHAR2,
    p_player_birthdate     VARCHAR2,
    p_player_height_feet   INT,
    p_player_height_inches INT,
    p_player_weight        INT,
    p_player_position      VARCHAR2)
IS
BEGIN

  --Exception handling for date's outside reasonable NBA player ranges.
  IF TO_DATE(p_player_birthdate, 'YYYY-MM-DD') > ADD_MONTHS (SYSDATE, -12 * 18)
  THEN RAISE_APPLICATION_ERROR (-20001, 'Player must be at least 18 years old and less than 107 years old.');
  ELSIF TO_DATE(p_player_birthdate, 'YYYY-MM-DD') < TO_DATE('1908-01-01', 'YYYY-MM-DD')
  THEN RAISE_APPLICATION_ERROR (-20002, 'Player must be at least 18 years old and less than 107 years old.');
  END IF;
  
  --Exception handling for heights outside of reasonable NBA player ranges.
  IF p_player_height_feet < 5
  THEN RAISE_APPLICATION_ERROR (-20003, 'Player is impossibly short for the NBA or impossibly tall for our species.');
  ELSIF p_player_height_feet > 8
  THEN RAISE_APPLICATION_ERROR (-20004, 'Player is impossibly short for the NBA or impossibly tall for our species.');
  END IF;
  
  --Exception handling for inches outside the range of 1 to 12.
  IF p_player_height_inches < 0
  THEN RAISE_APPLICATION_ERROR (-20005, 'What kind of inch measurement is that? Stick to 1 to 12.');
  ELSIF p_player_height_inches > 12
  THEN RAISE_APPLICATION_ERROR (-20006, 'What kind of inch measurement is that? Stick to 1 to 12.');
  END IF;
  
  --Exception handling for weights outside the range of reasonable professional athletes.
  IF p_player_weight < 120
  THEN RAISE_APPLICATION_ERROR (-20007, 'This player is below 120 lbs. or over 300 lbs. Come on, bro!');
  ELSIF p_player_weight > 300
  THEN RAISE_APPLICATION_ERROR (-20008, 'This player is below 120 lbs. or over 300 lbs. Come on, bro!');
  END IF;
  
  --As per wikipedia, no need for exception handling of player postions as, 
  --"The rules of basketball do not mandate them, and they are sometimes not 
  --used. Indeed it could be said that the designation of positions is done 
  --more to satisfy broadcasters and fans than for coaches or players, and 
  --many top coaches, including Olympic coach Mike Krzyzewski are choosing to 
  --ignore positions altogether."
  
  -- Insert the above input parameters into the PLAYER table.
INSERT
INTO PLAYER
  VALUES
  (
    p_player_id,
    p_player_name,
    TO_DATE(p_player_birthdate, 'YYYY-MM-DD'),
    p_player_height_feet,
    p_player_height_inches,
    p_player_weight,
    p_player_position
  );
  
END;

/
