--Feature 14: Show statistics of a quarter in a game, including quarter level statistics listed 
--in Assumption 11 and statistics of a player in that quarter 
--(same as listed in Assumption 10 but at quarter level), which can be computed 
--using play-by-play data.

--Create lots of temp tables to join the necessary data together.
DECLARE
p_quarter_id INT;
BEGIN
p_quarter_id := 31;
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
p_quarter_id := 31;

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

EXEC f14_1_team_quarter_stats (31);

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