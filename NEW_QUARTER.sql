--------------------------------------------------------
--  DDL for Procedure NEW_QUARTER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."NEW_QUARTER" (
    --All the necessary parameters needed to add a new quarter to the database.
    p_game_id            INT,
    p_quarter_number     INT,
    p_is_overtime        VARCHAR2)
IS
  p_quarter_id    INT;
BEGIN

  --Use the get_primary_key function to get a legit primary key for the new quarter out of the appropriate sequence.
  p_quarter_id    :=  get_primary_key('QUARTER');
  
  --Exception handling for the p_game_id is handled by the DBMS as it is a foreign key.
  
  --Exception handling for quarters outside the range of 1 to 10.
  IF p_quarter_number < 1
  THEN RAISE_APPLICATION_ERROR (-20022, 'This quarter number is too low or too high. Stay between 1 and 10.');
  ELSIF p_quarter_number > 10
  THEN RAISE_APPLICATION_ERROR (-20023, 'This quarter number is too low or too high. Stay between 1 and 10.');
  END IF;
  
  --Exception handling for is_playoff parameters that are neither Y or N.
  IF p_is_overtime != 'N'
  THEN
  IF p_is_overtime != 'Y'
  THEN RAISE_APPLICATION_ERROR (-20024, 'The game either is a playoff ''Y'' or it is not ''N''. No other characters are acceptable.');
  END IF;
  END IF;
  
  --Exception handling for the overtime quarters to check that they fall in the correct range.
  IF p_is_overtime = 'Y'
  THEN
  --Exception handling for overtime quarters less than 5 but greater than 10.
  IF p_quarter_number < 5
  THEN RAISE_APPLICATION_ERROR (-20025, 'According to the is_overtime parameter, this is an overtime quarter. The quarter must be between 5 and 10, inclusive.');
  ELSIF p_quarter_number > 10
  THEN RAISE_APPLICATION_ERROR (-20026, 'According to the is_overtime parameter, this is an overtime quarter. The quarter must be between 5 and 10, inclusive.');
  END IF;
  END IF;
  
  --Exception handling for the overtime quarters to check that they fall in the correct range.
  IF p_is_overtime = 'Y'
  THEN
  --Exception handling for playoff rounds outside the range of 1 to 8.
  IF p_quarter_number > 5
  THEN RAISE_APPLICATION_ERROR (-20027, 'According to the is_overtime parameter, this is a regular quarter. The quarter must be between 1 and 4, inclusive.');
  END IF;
  END IF;
  
  -- Insert the above input parameters into the GAME table.
  INSERT
  INTO QUARTER VALUES
    (
      p_quarter_id,
      p_game_id,
      p_quarter_number,
      p_is_overtime
    );
    
END;

/
