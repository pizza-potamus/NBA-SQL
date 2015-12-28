--FEATURE 8: At the end of a regular season, compute the teams qualified for the playoff
--as well as first round pairing of teams (seed 1 vs. seed 8, etc.).

--DROP TABLE SEASON_RESULTS;
--DROP TABLE EASTERN_CONF_WINNERS;
--DROP TABLE WESTERN_CONF_WINNERS;
--DROP TABLE EASTERN_CONF_LOSERS;
--DROP TABLE WESTERN_CONF_LOSERS;
--DROP TABLE EASTERN_CONF_OTHERS;
--DROP TABLE WESTERN_CONF_OTHERS;

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
  DBMS_OUTPUT.PUT_LINE('First  Seed '||eastern_conf_1||'  vs Last    Seed '||eastern_conf_8);
  DBMS_OUTPUT.PUT_LINE('Second Seed '||eastern_conf_2||'    vs Seventh Seed '||eastern_conf_7);
  DBMS_OUTPUT.PUT_LINE('Third  Seed '||eastern_conf_3||' vs Sixth   Seed '||eastern_conf_6);
  DBMS_OUTPUT.PUT_LINE('Fourth Seed '||eastern_conf_4||'   vs Fifth   Seed '||eastern_conf_5);
  DBMS_OUTPUT.PUT_LINE(' ');
  DBMS_OUTPUT.PUT_LINE(' ');
  DBMS_OUTPUT.PUT_LINE('################WESTERN CONFERENCE################');
  DBMS_OUTPUT.PUT_LINE('First  Seed '||western_conf_1||'    vs Last    Seed '||western_conf_8);
  DBMS_OUTPUT.PUT_LINE('Second Seed '||western_conf_2||'  vs Seventh Seed '||western_conf_7);
  DBMS_OUTPUT.PUT_LINE('Third  Seed '||western_conf_3||' vs Sixth   Seed '||western_conf_6);
  DBMS_OUTPUT.PUT_LINE('Fourth Seed '||western_conf_4||'    vs Fifth   Seed '||western_conf_5);
  
DROP TABLE SEASON_RESULTS;
DROP TABLE EASTERN_CONF_WINNERS;
DROP TABLE WESTERN_CONF_WINNERS;
DROP TABLE EASTERN_CONF_LOSERS;
DROP TABLE WESTERN_CONF_LOSERS;
DROP TABLE EASTERN_CONF_OTHERS;
DROP TABLE WESTERN_CONF_OTHERS;

END;