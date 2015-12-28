--------------------------------------------------------
--  DDL for Procedure TEAM_NAMES_ARRAY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."TEAM_NAMES_ARRAY" 
IS
c_team_name VARCHAR2(20);
c_team_city VARCHAR2(20);
team_name VARCHAR2(20);
type namesarray IS VARRAY(30) OF VARCHAR2(20);
all_teams namesarray;
BEGIN
FOR i IN 1..30
LOOP
SELECT name, location INTO
c_team_name, c_team_city
FROM TEAM;
team_name := c_team_name||' '||c_team_city;
all_teams(i) := team_name;
END LOOP;
END;

/
