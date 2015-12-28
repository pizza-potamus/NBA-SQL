ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'mi:ss';
SET SERVEROUTPUT ON;

CREATE TABLE DIVISION
  (div_id INT PRIMARY KEY, conf_id INT
  );

CREATE TABLE TEAM
  (
    team_id     INT PRIMARY KEY,
    div_id      INT,
    name        VARCHAR(20),
    location    VARCHAR (20),
    num_players INT,
    FOREIGN KEY (div_id) REFERENCES DIVISION (div_id)
  );

CREATE TABLE TEAM_HONOR
  (
    honor_id   INT PRIMARY KEY,
    team_id    INT,
    honor_type VARCHAR(50),
    honor_year DATE,
    FOREIGN KEY (team_id) REFERENCES TEAM (team_id)
  );

CREATE TABLE COACH
  (
    coach_id   INT PRIMARY KEY,
    name       VARCHAR(50),
    birth_date DATE
  );

CREATE TABLE COACHES
  (
    coaches_id     INT PRIMARY KEY,
    team_id        INT,
    coach_id       INT ,
    from_date      DATE,
    to_date        DATE,
    discharge_type VARCHAR(10),
    FOREIGN KEY (team_id) REFERENCES TEAM (team_id),
    FOREIGN KEY (coach_id) REFERENCES COACH (coach_id)
  );

CREATE TABLE PLAYER
  (
    player_id     INT PRIMARY KEY,
    name          VARCHAR(50),
    birth_date    DATE,
    height_feet   INT,
    height_inches INT,
    weight        INT,
    position      VARCHAR(2)
  );

CREATE TABLE GAME
  (
    game_id       INT PRIMARY KEY,
    game_date     DATE,
    is_playoff    VARCHAR(1),
    playoff_round INT
  );
  
CREATE TABLE QUARTER
  (
    quarter_ID     INT PRIMARY KEY,
    game_id        INT,
    quarter_number INT,
    is_overtime    VARCHAR(1),
    FOREIGN KEY (game_id) REFERENCES GAME (game_id)
  );
  
CREATE TABLE COACH_HONOR
  (
    honor_id   INT PRIMARY KEY,
    coach_id   INT,
    honor_type VARCHAR(50),
    honor_year DATE,
    FOREIGN KEY (coach_id) REFERENCES COACH (coach_id)
  );

CREATE TABLE PLAYS_FOR
  (
    plays_for_id INT PRIMARY KEY,
    team_id      INT,
    player_id    INT,
    from_date    DATE,
    to_date      DATE,
    FOREIGN KEY (team_id) REFERENCES TEAM (team_id),
    FOREIGN KEY (player_id) REFERENCES PLAYER (player_id)
  );

CREATE TABLE PLAYER_GAME
  (
    game_id   INT,
    player_id INT,
    PRIMARY KEY (game_id, player_id),
    FOREIGN KEY (game_id) REFERENCES GAME (game_id),
    FOREIGN KEY (player_id) REFERENCES PLAYER (player_id)
  );

CREATE TABLE PLAYS
  (
    game_id  INT,
    team_id  INT,
    score    INT,
    won_game VARCHAR(1),
    PRIMARY KEY (game_id, team_id),
    FOREIGN KEY (team_id) REFERENCES TEAM (team_id),
    FOREIGN KEY (game_id) REFERENCES GAME (game_ID)
  );

CREATE TABLE PLAYER_HONOR
  (
    honor_id   INT PRIMARY KEY,
    player_id  INT,
    honor_type VARCHAR(20),
    honor_year DATE,
    FOREIGN KEY (player_id) REFERENCES PLAYER (player_id)
  );

CREATE TABLE PLAY_EVENT
  (
    play_event_ID    INT,
    main_player_ID   INT,
    second_player_ID INT,
    quarter_ID       INT,
    event_type       VARCHAR(50),
    time_left        TIMESTAMP,
    PRIMARY KEY (play_event_ID),
    FOREIGN KEY (main_player_ID) REFERENCES PLAYER (player_id),
    FOREIGN KEY (second_player_ID) REFERENCES PLAYER (player_id),
    FOREIGN KEY (quarter_ID) REFERENCES QUARTER (quarter_ID)
  );

CREATE TABLE TRADE
  (
    trade_id     INT,
    player_id    INT,
    from_team_id INT,
    to_team_id   INT,
    to_date      DATE,
    PRIMARY KEY (trade_id),
    FOREIGN KEY (player_id) REFERENCES PLAYER (player_id),
    FOREIGN KEY (from_team_id) REFERENCES TEAM (team_id),
    FOREIGN KEY (to_team_id) REFERENCES TEAM (team_id)
  );

CREATE TABLE CONTRACT
  (
    contract_id INT PRIMARY KEY,
    player_id   INT,
    salary      NUMBER(20),
    from_date   DATE,
    to_date     DATE,
    FOREIGN KEY (player_id) REFERENCES PLAYER (player_id)
  );
  
CREATE SEQUENCE DIV_ID_SEQ MINVALUE 6 START WITH 6 INCREMENT BY 1;
CREATE SEQUENCE TEAM_ID_SEQ MINVALUE 30 START WITH 30 INCREMENT BY 1;
CREATE SEQUENCE TEAM_HONOR_ID_SEQ MINVALUE 9 START WITH 9 INCREMENT BY 1;
CREATE SEQUENCE COACH_ID_SEQ MINVALUE 35 START WITH 35 INCREMENT BY 1;
CREATE SEQUENCE COACHES_ID_SEQ MINVALUE 35 START WITH 35 INCREMENT BY 1;
CREATE SEQUENCE PLAYER_ID_SEQ MINVALUE 548 START WITH 548 INCREMENT BY 1;
CREATE SEQUENCE GAME_ID_SEQ MINVALUE 167 START WITH 167 INCREMENT BY 1;
CREATE SEQUENCE QUARTER_ID_SEQ MINVALUE 680 START WITH 680 INCREMENT BY 1;
CREATE SEQUENCE COACH_HONOR_ID_SEQ MINVALUE 680 START WITH 680 INCREMENT BY 1;
CREATE SEQUENCE PLAYS_FOR_ID_SEQ MINVALUE 548 START WITH 548 INCREMENT BY 1;
CREATE SEQUENCE PLAYER_HONOR_ID_SEQ MINVALUE 17 START WITH 17 INCREMENT BY 1;
CREATE SEQUENCE PLAY_EVENT_ID_SEQ MINVALUE 75379 START WITH 75379 INCREMENT BY 1;
CREATE SEQUENCE TRADE_ID_SEQ MINVALUE 45 START WITH 45 INCREMENT BY 1;
CREATE SEQUENCE CONTRACT_ID_SEQ MINVALUE 523 START WITH 523 INCREMENT BY 1;

COMMIT;