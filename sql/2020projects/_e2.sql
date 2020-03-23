DROP TABLE pocketable;

CREATE TABLE pocketable (
    p_id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    bio VARCHAR2(200));
    
INSERT INTO pocketable VALUES (1, 'Bulbasaur', 'Grass/Poison' ); --, 'The first Pokemon', 5, 0);
INSERT INTO pocketable VALUES (111, 'Mudkip', 'Water' ); --, 'He cute pokemanz', 5, 1);
INSERT INTO pocketable VALUES (151, 'Mew', 'Psychic' ); --, 'The first legendary', 35, 0);
--delete from pocketable where p_id = 69;
INSERT INTO pocketable VALUES (69, 'Exeggcute', 'Grass/Psychic' ); --, 'This PokEmon consists of six eggs that form a closely knit cluster.', 5, 0);
INSERT INTO pocketable VALUES (150, 'Mewtwo', 'Psychic' ); --, 'Genetic Pokemon', 9, 1);
INSERT INTO pocketable VALUES (7, 'Aipom', 'Normal' ); --, 'Three handed monkey', 100, 0);
INSERT INTO pocketable VALUES (2, 'Charmander', 'Fire' ); --, 'It breathes fire.', 6, 0);
INSERT INTO pocketable VALUES (11, 'Zubat', 'Flying/Poison' ); --, 'bat thing', 5, 1);
INSERT INTO pocketable VALUES (8, 'Raichu', 'Electric' ); --, 'The Originals', 1, 1);
INSERT INTO pocketable VALUES (25,'Hitmonchan','Fighting' ); --,'Steroids are strong with this one',100,1);
INSERT INTO pocketable VALUES (106, 'Hitmonleee', 'Fighting' ); --, 'The kicking fiend', 23, 0);
INSERT INTO pocketable VALUES (99,'Charizard', 'Fire' ); --, 'https://bulbapedia.bulbagarden.net/wiki/File:006Charizard.png', 10,0);
commit;   -- DML which does not autocommit.

DROP TABLE P_TYPES;
CREATE TABLE p_types (
    t_id NUMBER(10) PRIMARY KEY,
    type VARCHAR(20));
    
DROP TABLE p_statistics;
CREATE TABLE p_statistics (
    p_id NUMBER(10),
    lvl NUMBER(10) DEFAULT 1,
    hp NUMBER(10),
    attack NUMBER(10),
    defense NUMBER(10),
    cp NUMBER(10),
    shiny NUMBER(1) DEFAULT 0);
    
--Junction Table
--These are used for tables that have a Many-to-Many relationship
DROP TABLE p_matcher;
CREATE TABLE p_matcher (
    p_id NUMBER(10),
    t_id NUMBER(10));
    
--ALTER TABLE p_statistics DROP CONSTRAINT fk_stats_pocketable;
ALTER TABLE p_statistics ADD CONSTRAINT fk_stats_pocketable FOREIGN KEY (p_id) REFERENCES pocketable(p_id) ON DELETE CASCADE;


INSERT INTO pocketable VALUES (999, 'Bulbasaur', 'The first Pokemon');

INSERT INTO p_statistics VALUES (1, 5, 5, 5, 5, 15, 0);
INSERT INTO p_statistics VALUES (2, 5, 5, 5, 5, 15, 0);

--DELETE p_statistics;
--DELETE pocketable;
SELECT * FROM pocketable;
SELECT * FROM p_statistics;


ALTER TABLE p_matcher ADD CONSTRAINT fk_pt_pocketable FOREIGN KEY
(p_id) REFERENCES pocketable(p_id) ON DELETE CASCADE;

ALTER TABLE p_matcher ADD CONSTRAINT fk_pt_type FOREIGN KEY
(t_id) REFERENCES p_types(t_id) ON DELETE CASCADE;

INSERT INTO p_types VALUES (44, 'Grass');
INSERT INTO p_types VALUES (45, 'Poison');
--DROP TABLE p_types;
SELECT * FROM p_types;

SELECT * FROM p_matcher;

INSERT INTO p_matcher VALUES(1,2);
INSERT INTO p_matcher VALUES(2,2);
    
    
    