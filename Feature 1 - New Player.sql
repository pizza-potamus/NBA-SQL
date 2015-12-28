--Feature 1 - Pierce MacMillan
--A team signs a player with a new contract.
--The player will be added to the team if he is not a member of the team before.
--The contract includes the period and salary per year.

EXEC feature_1_sign_player ('New Player', '1980-04-16', 7, 11, 300, 'C', 1, '2012-10-28', '2015-04-16', 500000);
--SELECT PLAYER.name, PLAYS_FOR.team_id, CONTRACT.salary FROM PLAYER, PLAYS_FOR, CONTRACT WHERE PLAYER.name = 'New Player' AND PLAYS_FOR.team_id = 1 AND CONTRACT.salary = 500000;
