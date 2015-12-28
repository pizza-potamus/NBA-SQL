create or replace PROCEDURE get_season_wins
--This AUTHID thing let's the EXECUTE IMMEDIATE commands run properly
AUTHID CURRENT_USER IS
--Create an explicit cursor to hold the results of the below join, which queries wins by team by division.  
  create_season_table varchar2(510);
  create_playoffs_table varchar2(510);
BEGIN
--Create a table that uses the procedure parameter in its name to store the results of the query above.
create_season_table := 
  'CREATE TABLE SEASON_RESULTS AS SELECT TEAM.div_id AS Division_Id, TEAM.name AS Team_Name, COUNT(PLAYS.team_id) AS Games_Won 
  FROM PLAYS, TEAM, GAME
  WHERE PLAYS.won_game = ''Y''
  AND PLAYS.team_id = TEAM.team_id
  AND PLAYS.game_id = GAME.game_id
  AND GAME.is_playoff = ''N''
  AND GAME.game_date BETWEEN TO_DATE(''2013-10-01'',''YYYY-MM-DD'') AND TO_DATE(''2014-07-01'',''YYYY-MM-DD'')
  GROUP BY team.name, team.div_id
  ORDER BY Division_Id ASC, Games_Won DESC';
  
  create_playoffs_table := 
  'CREATE TABLE PLAYOFFS AS(SELECT * FROM SEASON_RESULTS WHERE 1=2)';
  
--Create the tables!
EXECUTE IMMEDIATE create_season_table;
EXECUTE IMMEDIATE create_playoffs_table;

END;