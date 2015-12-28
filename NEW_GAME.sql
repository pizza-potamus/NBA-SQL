--------------------------------------------------------
--  DDL for Procedure NEW_GAME
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."NEW_GAME" (
    --All the necessary parameters needed to add a new game to the database.
    --Fun fact!  I'm taking these dates in as varchar2's and then converting them to dates in the PL/SQL with the TO_DATE function! Fun!
    p_game_id              INT,
    p_game_date            VARCHAR2,
    p_is_playoff           VARCHAR2,
    p_playoff_round        INT)
IS
BEGIN

  --Exception handling for game_date's that occur before the NBA began or after the current date.
  --Games cannot occur before the beginning of the NBA in 1948.
  IF TO_DATE(p_game_date, 'YYYY-MM-DD') < ADD_MONTHS (SYSDATE, -12 * 69)
  THEN RAISE_APPLICATION_ERROR (-20016, 'The game date is incorrect.  Games cannot have occured after today or before 1948.');
  --Games cannot have occured before today. Both travelling on the court and through time are forbidden by NBA rules.
  ELSIF TO_DATE(p_game_date, 'YYYY-MM-DD') > SYSDATE
  THEN RAISE_APPLICATION_ERROR (-20017, 'The game date is incorrect.  Games cannot have occured after today or before 1948.');
  END IF;
  
  --Exception handling for is_playoff parameters that are neither Y or N.
  IF p_is_playoff != 'N'
  THEN
  IF p_is_playoff != 'Y'
  THEN RAISE_APPLICATION_ERROR (-20018, 'The game either is a playoff ''Y'' or it is not ''N''. No other characters are acceptable.');
  END IF;
  END IF;
  
  --Exception handling for the playoff games to check that their rounds are also correct.
  IF p_is_playoff = 'Y'
  THEN
  --Exception handling for playoff rounds outside the range of 1 to 8.
  IF p_playoff_round < 1
  THEN RAISE_APPLICATION_ERROR (-20019, 'According to the is_playoff parameter, this is a playoff game. NBA playoff rounds occur between 1 to 4.');
  ELSIF p_playoff_round > 4
  THEN RAISE_APPLICATION_ERROR (-20020, 'According to the is_playoff parameter, this is a playoff game. NBA playoff rounds occur between 1 to 4.');
  END IF;
  END IF;
  
  --Exception handling for games that are not playoff games to ensure that null is the input parameter for the playoff_round.
  IF p_is_playoff = 'N'
  THEN
  IF p_playoff_round IS NOT NULL
  THEN RAISE_APPLICATION_ERROR (-20021, 'According to the is_playoff parameter, this is not playoff game, thus the playoff_round must be null.');
  END IF;
  END IF;
  
  -- Insert the above input parameters into the GAME table.
  INSERT
  INTO GAME VALUES
    (
      p_game_id,
      TO_DATE(p_game_date, 'YYYY-MM-DD'),
      p_is_playoff,
      p_playoff_round
    );
    
END;

/
