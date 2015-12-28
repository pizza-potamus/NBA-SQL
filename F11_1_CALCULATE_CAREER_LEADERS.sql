--------------------------------------------------------
--  DDL for Procedure CALCULATE_CAREER_LEADERS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IS620PMACMIL1"."CALCULATE_CAREER_LEADERS" (
--Parameters to hold the number of players to be ranked and the type of stat.
p_number_of_players INT, 
p_stat_requested VARCHAR2
)
--This makes the EXECUTE IMMEDIATEs go!
AUTHID CURRENT_USER IS
--Variables to hold some create table statements.
leaders_selected VARCHAR2(510);
leaders_selected_with_names VARCHAR2(510);
--This variable holds the drop table statements for cleanup purposes.
drop_tables VARCHAR2(510);
BEGIN

--Exception handling to make sure the correct stat is requested.
IF p_stat_requested != 'points' 
THEN
IF p_stat_requested != 'three_made'
THEN
IF p_stat_requested != 'assists'
THEN
IF p_stat_requested != 'steals'
THEN
IF p_stat_requested != 'rebounds'
THEN
RAISE_APPLICATION_ERROR (-20032, 'Cannot calculate the NBA leader in this input.  Please stick with points, assists, three_made, steals, or rebounds.');
END IF;
END IF;
END IF;
END IF;
END IF;

--Exception handling to keep the number of players reasonable.
  IF p_number_of_players < 1
  THEN RAISE_APPLICATION_ERROR (-20003, 'Positive numbers of players only, please.');
  END IF;

--Run the procedure that creates a TOTAL table with the player's id and total amount of stat for his career.
create_player_rank_table(p_stat_requested);

--Table to be created below to hold the player career rankings by player_id.
leaders_selected :=
  'CREATE TABLE CAREER_LEADERS 
  AS SELECT player_id, '||p_stat_requested||'
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM TOTAL ORDER BY '||p_stat_requested||' DESC ) A
          WHERE ROWNUM <= '||p_number_of_players||' )
  WHERE RNUM >= 1';

----Table to be created below to hold the player career rankings by player_id and name.
leaders_selected_with_names :=
  'CREATE TABLE CAREER_LEADER_NAMES 
  AS SELECT CAREER_LEADERS.player_id, PLAYER.name, CAREER_LEADERS.'||p_stat_requested||'
  FROM CAREER_LEADERS, PLAYER
  WHERE CAREER_LEADERS.player_id = PLAYER.player_id
  ORDER BY CAREER_LEADERS.'||p_stat_requested||' DESC';

--Create the above tables.
EXECUTE IMMEDIATE leaders_selected;
EXECUTE IMMEDIATE leaders_selected_with_names;

--Drop the total table from the create_player_rank_table procedure, as we don't need it anymore.
drop_tables := 'DROP TABLE total';
EXECUTE IMMEDIATE drop_tables;
--Drop the player career rankings table without names, as we don't need it anymore.
drop_tables := 'DROP TABLE CAREER_LEADERS';
EXECUTE IMMEDIATE drop_tables;

END;

/
