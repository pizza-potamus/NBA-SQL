--Feature 14: Show statistics of a quarter in a game, including quarter level statistics listed 
--in Assumption 11 and statistics of a player in that quarter 
--(same as listed in Assumption 10 but at quarter level), which can be computed 
--using play-by-play data.

--PART 1
--TEAM NAME (home, away)
--GAME ID
--QUARTER ID
--QUARTER NUMBER
--IS_OVERTIME
-- PLAYER points
-- PLAYER attempted shots (not free throws)
-- PLAYER rebounds
-- PLAYER steals
-- PLAYER free-throws attempted
-- PLAYER free-throws made

DECLARE
p_quarter_id INT;
BEGIN
p_quarter_id := 1;
f14_2_quarter_points(p_quarter_id);
f14_3_quarter_missed_shots(p_quarter_id);
f14_4_quarter_rebounds(p_quarter_id);
f14_5_quarter_steals(p_quarter_id);
f14_6_quarter_free_missed(p_quarter_id);
f14_7_quarter_free_throws(p_quarter_id);

END;


DECLARE
counter INT;
only_team_id INT;
p_quarter_id INT;
p_home_team_id INT;
p_away_team_id INT;
empty_table VARCHAR2(50);
BEGIN
p_quarter_id := 1;

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

EXEC f14_1_team_quarter_stats (1);

SELECT * FROM QUARTER_STATS;

DROP TABLE QUARTER_STATS;


