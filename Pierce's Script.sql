--Feature 1 - Pierce MacMillan
--A team signs a player with a new contract.
--The player will be added to the team if he is not a member of the team before.
--The contract includes the period and salary per year.

EXEC feature_1_sign_player ('New Player', '1980-04-16', 7, 11, 300, 'C', 1, '2012-10-28', '2015-04-16', 500000);

SELECT PLAYER.name, PLAYS_FOR.team_id, CONTRACT.salary
FROM PLAYER, PLAYS_FOR, CONTRACT
WHERE PLAYS_FOR.player_id = PLAYER.player_id
AND Player.player_id = CONTRACT.player_id
AND CONTRACT.salary = 500000
AND PLAYER.name = 'New Player';

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--Feature 4 - Pierce MacMillan
--Enter a new game into the database.
--The input includes information about the game, statistics about each quarter
--and overtime (if any) (see Assumption 11).

-- Run feature 4 with the following parameters:
--p_game_date, p_is_playoff, p_playoff_round, p_number_quarters, p_home_team_name,
--p_away_team_name, p_home_team_score, p_away_team_score

EXEC feature_4_new_game('2014-05-29', 'Y', 3, 4, 'Thunder', 'Spurs', 89, 117);

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--FEATURE 8 - Pierce MacMillan
--At the end of a regular season, compute the teams qualified for the playoff
--as well as first round pairing of teams (seed 1 vs. seed 8, etc.).

--DROP TABLE SEASON_RESULTS;
--DROP TABLE EASTERN_CONF_WINNERS;
--DROP TABLE WESTERN_CONF_WINNERS;
--DROP TABLE EASTERN_CONF_LOSERS;
--DROP TABLE WESTERN_CONF_LOSERS;
--DROP TABLE EASTERN_CONF_OTHERS;
--DROP TABLE WESTERN_CONF_OTHERS;
set serveroutput on;
EXEC get_season_wins;

--UPDATE SEASON_RESULTS SET games_won = 10
--WHERE team_name = 'Pacers'
--OR team_name = 'Spurs';
--
--UPDATE SEASON_RESULTS SET games_won = 9
--WHERE team_name = 'Heat'
--OR team_name = 'Thunder';

DECLARE
  eastern_conf_1 varchar2(20);
  eastern_conf_2 varchar2(20);
  eastern_conf_3 varchar2(20);
  eastern_conf_4 varchar2(20);
  eastern_conf_5 varchar2(20);
  eastern_conf_6 varchar2(20);
  eastern_conf_7 varchar2(20);
  eastern_conf_8 varchar2(20);
 
  western_conf_1 varchar2(20);
  western_conf_2 varchar2(20);
  western_conf_3 varchar2(20);
  western_conf_4 varchar2(20);
  western_conf_5 varchar2(20);
  western_conf_6 varchar2(20);
  western_conf_7 varchar2(20);
  western_conf_8 varchar2(20);
 
BEGIN
    
  SELECT team_name INTO eastern_conf_1
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM EASTERN_CONF_WINNERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 1 )
  WHERE RNUM >= 1;
 
  SELECT team_name INTO eastern_conf_2
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM EASTERN_CONF_WINNERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 2 )
  WHERE RNUM >= 2;
 
  SELECT team_name INTO eastern_conf_3
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM EASTERN_CONF_WINNERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 3 )
  WHERE RNUM >= 3;
 
  SELECT team_name INTO eastern_conf_4
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM EASTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 1 )
  WHERE RNUM >= 1;
 
  SELECT team_name INTO eastern_conf_5
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM EASTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 2 )
  WHERE RNUM >= 2;
 
  SELECT team_name INTO eastern_conf_6
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM EASTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 3 )
  WHERE RNUM >= 3;
 
  SELECT team_name INTO eastern_conf_7
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM EASTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 4 )
  WHERE RNUM >= 4;
 
  SELECT team_name INTO eastern_conf_8
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM EASTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 5 )
  WHERE RNUM >= 5;
 
  SELECT team_name INTO western_conf_1
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM WESTERN_CONF_WINNERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 1 )
  WHERE RNUM >= 1;
 
  SELECT team_name INTO western_conf_2
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM WESTERN_CONF_WINNERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 2 )
  WHERE RNUM >= 2;
 
  SELECT team_name INTO western_conf_3
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM WESTERN_CONF_WINNERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 3 )
  WHERE RNUM >= 3;
 
  SELECT team_name INTO western_conf_4
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM WESTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 1 )
  WHERE RNUM >= 1;
 
  SELECT team_name INTO western_conf_5
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM WESTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 2 )
  WHERE RNUM >= 2;
 
  SELECT team_name INTO western_conf_6
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM WESTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 3 )
  WHERE RNUM >= 3;
 
  SELECT team_name INTO western_conf_7
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM WESTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 4 )
  WHERE RNUM >= 4;
 
  SELECT team_name INTO western_conf_8
  FROM ( SELECT a.*, ROWNUM rnum
  FROM ( SELECT * FROM WESTERN_CONF_OTHERS ORDER BY Games_Won DESC ) A
      	WHERE ROWNUM <= 5 )
  WHERE RNUM >= 5;

 
  DBMS_OUTPUT.PUT_LINE(' ');
  DBMS_OUTPUT.PUT_LINE(' ');
  DBMS_OUTPUT.PUT_LINE('#############EASTERN CONFERENCE#############');
  DBMS_OUTPUT.PUT_LINE('First  Seed '||eastern_conf_1||'	vs Last	Seed '||eastern_conf_8);
  DBMS_OUTPUT.PUT_LINE('Second Seed '||eastern_conf_2||'  vs Seventh Seed '||eastern_conf_7);
  DBMS_OUTPUT.PUT_LINE('Third  Seed '||eastern_conf_3||' vs Sixth   Seed '||eastern_conf_6);
  DBMS_OUTPUT.PUT_LINE('Fourth Seed '||eastern_conf_4||'   vs Fifth   Seed '||eastern_conf_5);
  DBMS_OUTPUT.PUT_LINE(' ');
  DBMS_OUTPUT.PUT_LINE(' ');
  DBMS_OUTPUT.PUT_LINE('################WESTERN CONFERENCE################');
  DBMS_OUTPUT.PUT_LINE('First  Seed '||western_conf_1||'  vs Last	Seed '||western_conf_8);
  DBMS_OUTPUT.PUT_LINE('Second Seed '||western_conf_2||' 	vs Seventh Seed '||western_conf_7);
  DBMS_OUTPUT.PUT_LINE('Third  Seed '||western_conf_3||'   vs Sixth   Seed '||western_conf_6);
  DBMS_OUTPUT.PUT_LINE('Fourth Seed '||western_conf_4||'  vs Fifth   Seed '||western_conf_5);
 
  END;
 
DROP TABLE SEASON_RESULTS;
DROP TABLE EASTERN_CONF_WINNERS;
DROP TABLE WESTERN_CONF_WINNERS;
DROP TABLE EASTERN_CONF_LOSERS;
DROP TABLE WESTERN_CONF_LOSERS;
DROP TABLE EASTERN_CONF_OTHERS;
DROP TABLE WESTERN_CONF_OTHERS;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--Feature 11 - Pierce MacMillan
--Return the top X (X is an input) players in whole career (including both regular and playoff)
--in each of the following category: points per game, 3-pointers made per game,
--assists per game, steals per game, rebounds per game.

EXEC calculate_career_leaders(5, 'steals');

SELECT * FROM CAREER_LEADER_NAMES;

DROP TABLE CAREER_LEADERS;
DROP TABLE CAREER_LEADER_NAMES;
DROP TABLE TOTAL;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--Feature 14: Show statistics of a quarter in a game, including quarter level statistics listed
--in Assumption 11 and statistics of a player in that quarter
--(same as listed in Assumption 10 but at quarter level), which can be computed
--using play-by-play data.

--Create lots of temp tables to join the necessary data together.
DECLARE
p_quarter_id INT;
BEGIN
p_quarter_id := 1; --@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
f14_2_quarter_points(p_quarter_id);
f14_3_quarter_missed_shots(p_quarter_id);
f14_4_quarter_rebounds(p_quarter_id);
f14_5_quarter_steals(p_quarter_id);
f14_6_quarter_free_missed(p_quarter_id);
f14_7_quarter_free_throws(p_quarter_id);
END;

--Show player score totals for the above quarter.
SELECT QUARTER_SCORE_TOTAL.player_ID, PLAYER.name, QUARTER_SCORE_TOTAL.points
FROM QUARTER_SCORE_TOTAL, PLAYER
WHERE QUARTER_SCORE_TOTAL.player_ID = PLAYER.player_id
ORDER BY QUARTER_SCORE_TOTAL.points DESC;

--Show player smissed shot totals for the above quarter.
SELECT SHOTS_MISSED.player_ID, PLAYER.name, SHOTS_MISSED.shots_missed
FROM SHOTS_MISSED, PLAYER
WHERE SHOTS_MISSED.player_ID = PLAYER.player_id
ORDER BY SHOTS_MISSED.shots_missed DESC;

--Show player missed shot totals for the above quarter.
SELECT SHOTS_MISSED.player_ID, PLAYER.name, SHOTS_MISSED.shots_missed
FROM SHOTS_MISSED, PLAYER
WHERE SHOTS_MISSED.player_ID = PLAYER.player_id
ORDER BY SHOTS_MISSED.shots_missed DESC;

--Show player rebound totals for the above quarter.
SELECT QUARTER_REBOUNDS_BY_PLAYER.player_ID, PLAYER.name, QUARTER_REBOUNDS_BY_PLAYER.rebounds
FROM QUARTER_REBOUNDS_BY_PLAYER, PLAYER
WHERE QUARTER_REBOUNDS_BY_PLAYER.player_ID = PLAYER.player_id
ORDER BY QUARTER_REBOUNDS_BY_PLAYER.rebounds DESC;

--Show player assist totals for the above quarter.
SELECT QUARTER_REBOUNDS_BY_PLAYER.player_ID, PLAYER.name, QUARTER_REBOUNDS_BY_PLAYER.rebounds
FROM QUARTER_REBOUNDS_BY_PLAYER, PLAYER
WHERE QUARTER_REBOUNDS_BY_PLAYER.player_ID = PLAYER.player_id
ORDER BY QUARTER_REBOUNDS_BY_PLAYER.rebounds DESC;

--Show player steal totals for the above quarter.
SELECT QUARTER_STEALS_BY_PLAYER.player_ID, PLAYER.name, QUARTER_STEALS_BY_PLAYER.steals
FROM QUARTER_STEALS_BY_PLAYER, PLAYER
WHERE QUARTER_STEALS_BY_PLAYER.player_ID = PLAYER.player_id
ORDER BY QUARTER_STEALS_BY_PLAYER.steals DESC;

--Show made free thrwo totals for the above quarter.
SELECT FREE_THROW_MADE.player_ID, PLAYER.name, FREE_THROW_MADE.free_throw_made
FROM FREE_THROW_MADE, PLAYER
WHERE FREE_THROW_MADE.player_ID = PLAYER.player_id
ORDER BY FREE_THROW_MADE.free_throw_made DESC;

--Show made free thrwo totals for the above quarter.
SELECT FREE_THROW_MADE.player_ID, PLAYER.name, FREE_THROW_MADE.free_throw_made
FROM FREE_THROW_MADE, PLAYER
WHERE FREE_THROW_MADE.player_ID = PLAYER.player_id
ORDER BY FREE_THROW_MADE.free_throw_made DESC;

--Show made free thrwo totals for the above quarter.
SELECT FREES_MISSED.player_ID, PLAYER.name, FREES_MISSED.frees_missed
FROM FREES_MISSED, PLAYER
WHERE FREES_MISSED.player_ID = PLAYER.player_id
ORDER BY FREES_MISSED.frees_missed DESC;

DECLARE
counter INT;
only_team_id INT;
p_quarter_id INT;
p_home_team_id INT;
p_away_team_id INT;
empty_table VARCHAR2(50);
BEGIN
p_quarter_id := 1; --@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

p_home_team_id := get_teams_for_play_events('home', p_quarter_id);
p_away_team_id := get_teams_for_play_events('away', p_quarter_id);

--Exception handling for the situation where some tables created above are empty for some teams.
--Insert 0 value rows for the null rows in the missed shots table.
   SELECT COUNT(*) INTO counter
   FROM QUARTER_SHOTS_MISSED;
   
   IF counter = 0 THEN
   empty_table := 'YES';
   INSERT INTO QUARTER_SHOTS_MISSED VALUES (p_home_team_id, 0);
   INSERT INTO QUARTER_SHOTS_MISSED VALUES (p_away_team_id, 0);
   END IF;
   
IF (counter < 2)
THEN
   SELECT team_id INTO only_team_id
   FROM QUARTER_SHOTS_MISSED
   WHERE rownum = 1;
   
   IF only_team_id = p_away_team_id
   THEN
   INSERT INTO QUARTER_SHOTS_MISSED VALUES (p_home_team_id, 0);
   ELSE
   INSERT INTO QUARTER_SHOTS_MISSED VALUES (p_away_team_id, 0);
   END IF;
END IF;

--Insert 0 value rows for the null rows in the rebounds table.
   SELECT COUNT(*) INTO counter
   FROM QUARTER_REBOUNDS;
   
   IF counter = 0 THEN
   empty_table := 'YES';
   INSERT INTO QUARTER_REBOUNDS VALUES (p_home_team_id, 0);
   INSERT INTO QUARTER_REBOUNDS VALUES (p_away_team_id, 0);
   END IF;
   
IF (counter < 2)
THEN
   SELECT team_id INTO only_team_id
   FROM QUARTER_REBOUNDS
   WHERE rownum = 1;
   
   IF only_team_id = p_away_team_id
   THEN
   INSERT INTO QUARTER_REBOUNDS VALUES (p_home_team_id, 0);
   ELSE
   INSERT INTO QUARTER_REBOUNDS VALUES (p_away_team_id, 0);
   END IF;
END IF;

--Insert 0 value rows for the null rows in the steals table.
   SELECT COUNT(*) INTO counter
   FROM QUARTER_STEALS;
   
   IF counter = 0 THEN
   empty_table := 'YES';
   INSERT INTO QUARTER_STEALS VALUES (p_home_team_id, 0);
   INSERT INTO QUARTER_STEALS VALUES (p_away_team_id, 0);
   END IF;
   
IF (counter < 2)
THEN
   SELECT team_id INTO only_team_id
   FROM QUARTER_STEALS
   WHERE rownum = 1;
   
   IF only_team_id = p_away_team_id
   THEN
   INSERT INTO QUARTER_STEALS VALUES (p_home_team_id, 0);
   ELSE
   INSERT INTO QUARTER_STEALS VALUES (p_away_team_id, 0);
   END IF;
END IF;

--Insert 0 value rows for the null rows in the frees_missed table.
   
   SELECT COUNT(*) INTO counter
   FROM QUARTER_FREES_MISSED;
   
   IF counter = 0 THEN
   empty_table := 'YES';
   INSERT INTO QUARTER_FREES_MISSED VALUES (p_home_team_id, 0);
   INSERT INTO QUARTER_FREES_MISSED VALUES (p_away_team_id, 0);
   END IF;
   
IF (counter < 2)
THEN
   SELECT team_id INTO only_team_id
   FROM QUARTER_FREES_MISSED
   WHERE rownum = 1;
   
   IF only_team_id = p_away_team_id
   THEN
   INSERT INTO QUARTER_FREES_MISSED VALUES (p_home_team_id, 0);
   ELSE
   INSERT INTO QUARTER_FREES_MISSED VALUES (p_away_team_id, 0);
   END IF;
END IF;

--Insert 0 value rows for the null rows in the free_throws table.
   SELECT COUNT(*) INTO counter
   FROM QUARTER_FREE_THROWS;
   
   IF counter = 0 THEN
   empty_table := 'YES';
   INSERT INTO QUARTER_FREE_THROWS VALUES (p_home_team_id, 0);
   INSERT INTO QUARTER_FREE_THROWS VALUES (p_away_team_id, 0);
   END IF;
   
IF (counter < 2)
THEN
   SELECT team_id INTO only_team_id
   FROM QUARTER_FREE_THROWS
   WHERE rownum = 1;
   
   IF only_team_id = p_away_team_id
   THEN
   INSERT INTO QUARTER_FREE_THROWS VALUES (p_home_team_id, 0);
   ELSE
   INSERT INTO QUARTER_FREE_THROWS VALUES (p_away_team_id, 0);
   END IF;
END IF;
END;

EXEC f14_1_team_quarter_stats (1); --@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

SELECT * FROM QUARTER_STATS;

DROP TABLE QUARTER_STATS;
DROP TABLE QUARTER_INFO;
DROP TABLE QUARTER_POINTS;
DROP TABLE QUARTER_SHOTS_MISSED;
DROP TABLE QUARTER_REBOUNDS;
DROP TABLE QUARTER_FREE_THROWS;
DROP TABLE QUARTER_FREES_MISSED;
DROP TABLE QUARTER_STEALS;
DROP TABLE FREE_THROW_MADE;
DROP TABLE FREES_MISSED;
DROP TABLE FREE_THROW_MADE_LEADERS;
DROP TABLE QUARTER_REBOUNDS_BY_PLAYER;
DROP TABLE QUARTER_STEALS_BY_PLAYER;
DROP TABLE QUARTER_SCORE_TOTAL;
DROP TABLE SCORE_TOTALS;
DROP TABLE SHOTS_MISSED;
DROP TABLE SHOT_MADE_LEADERS;
DROP TABLE THREE_MADE_LEADERS;


