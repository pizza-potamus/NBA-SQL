--------------------------------------------------------
--  DDL for Procedure NEW_PLAYS_FOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."NEW_PLAYS_FOR" (
--All the parameters needed to insert a new plays_for entry.
    p_team_id   INT,
    p_player_id INT,
    p_to_date VARCHAR2,
    p_from_date VARCHAR2)
IS
--A variable to hold the plays_for_id which will be calculated by the get_primary_key function below.
  p_plays_for_id INT;
  
BEGIN
   --Use the get_primary_key function to get a legit primary key for the new plays_for data out of the appropriate sequence.
   p_plays_for_id  :=  get_primary_key('PLAYS_FOR');
  
  --Team_id exceptions are handled by the DBMS as team_id is a foreign key of
  --the PLAYER table.
  
  --Exception handling for PLAYS_FOR to_date's and from_dates that are incorrect or occur before the NBA even began.
  --Players cannot join the NBA before 1948.
  IF TO_DATE(p_from_date, 'YYYY-MM-DD') < ADD_MONTHS (SYSDATE, -12 * 69)
  THEN RAISE_APPLICATION_ERROR (-20009, 'The contract dates are impossible.  Check the to and from dates and their order. Contracts longer than 15 years or that occur before 1948 will be rejected.');
  --Players cannot have contracts that end before they begin.
  ELSIF TO_DATE(p_to_date, 'YYYY-MM-DD') < TO_DATE(p_from_date, 'YYYY-MM-DD')
  THEN RAISE_APPLICATION_ERROR (-20010, 'The contract dates are impossible.  Check the to and from dates and their order. Contracts longer than 15 years or that occur before 1948 will be rejected.');
  --Players cannot have contracts that end before 1948.
  ELSIF TO_DATE(p_to_date, 'YYYY-MM-DD') < ADD_MONTHS (SYSDATE, -12 * 69)
  THEN RAISE_APPLICATION_ERROR (-20011, 'The contract dates are impossible.  Check the to and from dates and their order. Contracts longer than 15 years or that occur before 1948 will be rejected.');
  --Players cannot have contracts that begin before today. Both travelling on the court and through time are forbidden by NBA rules.
  ELSIF TO_DATE(p_from_date, 'YYYY-MM-DD') > SYSDATE
  THEN RAISE_APPLICATION_ERROR (-20012, 'The contract dates are impossible.  Check the to and from dates and their order. Contracts longer than 15 years or that occur before 1948 will be rejected.');
  --Players cannot have contracts that last longer than 15 years, as the longest professional league contract in any sport is 13 years according to wikipedia.
  ELSIF TO_DATE(p_to_date, 'YYYY-MM-DD') > ADD_MONTHS (TO_DATE(p_from_date, 'YYYY-MM-DD'), 12 * 15)
  THEN RAISE_APPLICATION_ERROR (-20013, 'The contract dates are impossible.  Check the to and from dates and their order. Contracts longer than 15 years or that occur before 1948 will be rejected.');
  END IF;
  
  -- Insert the above input parameters into the PLAYS_FOR table.
  INSERT
  INTO PLAYS_FOR 
  VALUES
    (
      p_plays_for_id,
      p_team_id,
      p_player_id,
      TO_DATE(p_to_date, 'YYYY-MM-DD'),
      TO_DATE(p_from_date, 'YYYY-MM-DD')
    );
  
END;

/
