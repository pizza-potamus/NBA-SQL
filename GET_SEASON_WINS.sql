--------------------------------------------------------
--  DDL for Procedure GET_SEASON_WINS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."GET_SEASON_WINS" 
--This AUTHID thing let's the EXECUTE IMMEDIATE commands run properly
AUTHID CURRENT_USER IS
--Lots of variables to store CREATE table statements to hold the teams in order by wins.
  create_season_results varchar2(510);
  create_eastern_conf_winners varchar2(510);
  create_western_conf_winners varchar2(510);
  create_eastern_conf_losers varchar2(510);
  create_western_conf_losers varchar2(510);
  create_eastern_conf_others varchar2(510);
  create_western_conf_others varchar2(510);
  
BEGIN
--Create a table that uses the procedure parameter in its name to store the results of the query above.
  create_season_results := 
  'CREATE TABLE SEASON_RESULTS AS SELECT TEAM.div_id AS Division_Id, TEAM.name AS Team_Name, COUNT(PLAYS.team_id) AS Games_Won 
   FROM PLAYS, TEAM, GAME
   WHERE PLAYS.won_game = ''Y''
   AND PLAYS.team_id = TEAM.team_id
   AND PLAYS.game_id = GAME.game_id
   AND GAME.is_playoff = ''N''
   AND GAME.game_date BETWEEN TO_DATE(''2013-10-01'',''YYYY-MM-DD'') AND TO_DATE(''2014-07-01'',''YYYY-MM-DD'')
   GROUP BY team.name, team.div_id
   ORDER BY Division_Id ASC, Games_Won DESC';
  
  --Create a table from select eastern conference division winners in order of wins.
  create_eastern_conf_winners := 
  'CREATE TABLE EASTERN_CONF_WINNERS AS SELECT *
   FROM (SELECT DISTINCT division_id, team_name, games_won FROM SEASON_RESULTS 
   WHERE Division_id < 4 ORDER BY Games_Won DESC) SEASON_RESULTS2
   WHERE rownum <= 3
   ORDER BY rownum';

   --Create a table from select western conference division winners in order of wins.
   create_western_conf_winners :=
   'CREATE TABLE WESTERN_CONF_WINNERS AS SELECT *
    FROM (SELECT DISTINCT division_id, team_name, games_won FROM SEASON_RESULTS 
    WHERE Division_id > 3 ORDER BY Games_Won DESC) SEASON_RESULTS2
    WHERE rownum <= 3
    ORDER BY rownum';
    
    --Create a table from select eastern conference teams that didn't win their division in order of wins.
   create_eastern_conf_losers :=
   'CREATE TABLE EASTERN_CONF_LOSERS AS SELECT SEASON_RESULTS.Division_Id, SEASON_RESULTS.Team_Name, SEASON_RESULTS.Games_Won
    FROM SEASON_RESULTS
    LEFT JOIN EASTERN_CONF_WINNERS
    ON SEASON_RESULTS.Team_Name = EASTERN_CONF_WINNERS.Team_Name
    WHERE EASTERN_CONF_WINNERS.Team_Name IS NULL
    AND SEASON_RESULTS.Division_Id < 4
    ORDER BY Games_Won DESC';
    
    --Create a table from select western conference teams that didn't win their division in order of wins.
    create_western_conf_losers :=
   'CREATE TABLE WESTERN_CONF_LOSERS AS SELECT SEASON_RESULTS.Division_Id, SEASON_RESULTS.Team_Name, SEASON_RESULTS.Games_Won
    FROM SEASON_RESULTS
    LEFT JOIN EASTERN_CONF_WINNERS
    ON SEASON_RESULTS.Team_Name = EASTERN_CONF_WINNERS.Team_Name
    WHERE EASTERN_CONF_WINNERS.Team_Name IS NULL
    AND SEASON_RESULTS.Division_Id > 3
    ORDER BY Games_Won DESC';

   --Create a table from select eastern conference runners up from the conf_losers table in order of wins.
   create_eastern_conf_others :=
   'CREATE TABLE EASTERN_CONF_OTHERS AS SELECT *
    FROM (SELECT * FROM EASTERN_CONF_LOSERS ORDER BY Games_Won DESC) EASTERN_CONF_LOSERS2
    WHERE rownum <= 5
    ORDER BY rownum';

   --Create a table from select western conference runners up from the conf_losers table in order of wins.
   create_western_conf_others :=
   'CREATE TABLE WESTERN_CONF_OTHERS AS SELECT *
    FROM (SELECT * FROM WESTERN_CONF_LOSERS ORDER BY Games_Won DESC) WESTERN_CONF_LOSERS2
    WHERE rownum <= 5
    ORDER BY rownum';
  
--Create the tables!
EXECUTE IMMEDIATE create_season_results;
EXECUTE IMMEDIATE create_eastern_conf_winners;
EXECUTE IMMEDIATE create_western_conf_winners;

EXECUTE IMMEDIATE create_eastern_conf_losers;
EXECUTE IMMEDIATE create_western_conf_losers;

EXECUTE IMMEDIATE create_eastern_conf_others;
EXECUTE IMMEDIATE create_western_conf_others;

END;

/
