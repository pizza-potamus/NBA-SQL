--Feature 4 - Pierce MacMillan
--Enter a new game into the database. 
--The input includes information about the game, statistics about each quarter
--and overtime (if any) (see Assumption 11).

-- Run feature 4 with the following parameters: 
--p_game_date, p_is_playoff, p_playoff_round, p_number_quarters, p_home_team_name, 
--p_away_team_name, p_home_team_score, p_away_team_score
EXEC feature_4_new_game('2014-05-29', 'Y', 3, 4, 'Thunder', 'Spurs', 89, 117);