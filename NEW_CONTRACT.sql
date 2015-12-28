--------------------------------------------------------
--  DDL for Procedure NEW_CONTRACT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."NEW_CONTRACT" (
--All the inputs necessary to enter a new contract.
      p_player_id INT,
      p_salary NUMBER,
      p_to_date VARCHAR2,
      p_from_date VARCHAR2)
IS
--Stores the unique ID which is generated by the get_primary_key function below.
  p_contract_id  INT;
  
BEGIN

  --Use the get_primary_key function to get a legit primary key for the new plays_for data out of the appropriate sequence.
   p_contract_id  :=  get_primary_key('CONTRACT');
  
  --Exception handling for CONTRACT to_date's and from_dates that are incorrect or occur before the NBA even began.
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
  
  --Exception handling for salaries below the NBA minimum (490180) and above all common sense.
  IF p_salary < 490180
  THEN RAISE_APPLICATION_ERROR (-20014, 'This salary is below the NBA minimum of $490180 or above the stratosphere at $50 million.');
  ELSIF p_salary > 50000000
  THEN RAISE_APPLICATION_ERROR (-20015, 'This salary is below the NBA minimum of $490180 or above the stratosphere at $50 million.');
  END IF;
  
  -- Insert the above input parameters into the CONTRACT table.  
  INSERT
  INTO CONTRACT
  VALUES
    (
      p_contract_id,
      p_player_id,
      p_salary,
      TO_DATE(p_to_date, 'YYYY-MM-DD'),
      TO_DATE(p_from_date, 'YYYY-MM-DD')
    );
  
END;

/
