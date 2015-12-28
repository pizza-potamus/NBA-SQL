--Return the top X (X is an input) players in whole career (including both regular and playoff) 
--in each of the following category: points per game, 3-pointers made per game, 
--assists per game, steals per game, rebounds per game.

EXEC calculate_career_leaders(5, 'steals');

SELECT * FROM CAREER_LEADER_NAMES;

DROP TABLE CAREER_LEADERS;
DROP TABLE CAREER_LEADER_NAMES;
DROP TABLE TOTAL;