
INSERT INTO pocketable VALUES (id_maker.nextval, 'Bulbasaur', 'The first pocketable');
INSERT INTO pocketable VALUES (id_maker.nextval, 'Mudkip', 'He cute pokemanz');
INSERT INTO pocketable VALUES (id_maker.nextval, 'Mew', 'The first legendary');
INSERT INTO pocketable VALUES (id_maker.nextval, 'Exeggcute', 'This Pok�mon consists of six eggs that form a closely knit cluster. The six eggs attract each other and spin around. When cracks increasingly appear on the eggs, Exeggcute is close to evolution.');
INSERT INTO pocketable VALUES (id_maker.nextval, 'Mewtwo', 'Genetic pocketable');
INSERT INTO pocketable VALUES (id_maker.nextval, 'Aipom', 'Three handed monkey');
INSERT INTO pocketable VALUES (id_maker.nextval, 'Charmander', 'It breathes fire.');
INSERT INTO pocketable VALUES (id_maker.nextval, 'Zubat', 'bat thing');
INSERT INTO pocketable VALUES (id_maker.nextval, 'Raichu', 'The Originals');
INSERT INTO pocketable VALUES (id_maker.nextval,'Hitmonchan','Steroids are strong with this one');
INSERT INTO pocketable VALUES (id_maker.nextval, 'Hitmonleee', 'The kicking fiend');
INSERT INTO pocketable VALUES (id_maker.nextval,'Charizard', 'https://bulbapedia.bulbagarden.net/wiki/File:006Charizard.png');
commit;

SELECT * FROM pocketable;

-- Sequence is an SQL Object which will generate a unique number.
-- We will use sequences in place of AUTO_INCREMENT
DROP SEQUENCE id_maker;
CREATE SEQUENCE id_maker
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1;



INSERT INTO p_types VALUES(id_maker.nextval, 'Grass');
INSERT INTO p_types VALUES(id_maker.nextval, 'Water');
INSERT INTO p_types VALUES(id_maker.nextval, 'Fire');
INSERT INTO p_types VALUES(id_maker.nextval, 'Electric');
INSERT INTO p_types VALUES(id_maker.nextval, 'Dragon');
INSERT INTO p_types VALUES(id_maker.nextval, 'Ice');
INSERT INTO p_types VALUES(id_maker.nextval, 'Dark');
INSERT INTO p_types VALUES(id_maker.nextval, 'Normal');
INSERT INTO p_types VALUES(id_maker.nextval, 'Psychic');
INSERT INTO p_types VALUES(id_maker.nextval, 'Fairy');
INSERT INTO p_types VALUES(id_maker.nextval, 'Bug');
INSERT INTO p_types VALUES(id_maker.nextval, 'Steel');
INSERT INTO p_types VALUES(id_maker.nextval, 'Rock');
INSERT INTO p_types VALUES(id_maker.nextval, 'Ground');
INSERT INTO p_types VALUES(id_maker.nextval, 'Fighting');
INSERT INTO p_types VALUES(id_maker.nextval, 'Flying');
INSERT INTO p_types VALUES(id_maker.nextval, 'Poison');
INSERT INTO p_types VALUES(id_maker.nextval, 'Ghost');
commit;

SELECT * FROM pocketable;
SELECT * FROM p_types;


-- Procedure is just a set of SQL commands
-- essentially a script
-- Have 0 to Many inputs
-- Have 0 to Many outputs
-- Can manipulate data in the database.
CREATE OR REPLACE PROCEDURE add_pokemon(name VARCHAR2, bio VARCHAR2, t_id1 NUMBER, t_id2 NUMBER)
IS
BEGIN
INSERT INTO pocketable VALUES (id_maker.nextval, name, bio);
INSERT INTO stats VALUES (id_maker.currval,1,5,5,5,0);
INSERT INTO p_matcher VALUES (id_maker.currval, t_id1);
IF t_id2 != -1
THEN
    INSERT INTO p_matcher VALUES (id_maker.currval, t_id2);
END IF;
END;


CREATE OR REPLACE PROCEDURE add_pokemon2(name VARCHAR2, bio VARCHAR2, type1 VARCHAR2, type2 VARCHAR2)
IS
BEGIN
INSERT INTO pocketable VALUES (id_maker.nextval, name, bio);
INSERT INTO stats VALUES (id_maker.currval,1,5,5,5,0);
INSERT INTO p_matcher VALUES (id_maker.currval, (SELECT t_id FROM p_types WHERE type = type1 AND ROWNUM = 1));
IF type2 IS NOT NULL
THEN
    INSERT INTO p_matcher VALUES (id_maker.currval, (SELECT t_id FROM p_types WHERE type = type2 AND ROWNUM = 1));
END IF;
commit;
END;

CALL add_pokemon('Eevee','The cutest pocketable',38, -1);
CALL add_pokemon('Pidgey','The bird pocketable',38,46);

CALL add_pokemon2('Ivysaur','The second pocketable','Grass','Poison');
CALL add_pokemon2('Goldeen','The goldfish pocketable','Water',null);


SELECT * FROM pocketable ORDER BY p_id desc;
SELECT * FROM stats ORDER BY p_id desc;
SELECT * FROM p_matcher ORDER BY p_id desc;


-- A Function does not change values in a table
-- it MUST have inputs and EXACTLY 1 output. - 1 to Many inputs

CREATE OR REPLACE FUNCTION combat_power(hp NUMBER, atk NUMBER, def NUMBER) RETURN NUMBER
IS
BEGIN

RETURN hp + atk + def;

END;

CREATE OR REPLACE PROCEDURE level_up(p_idn NUMBER, hpn NUMBER, atk NUMBER, def NUMBER)
IS
BEGIN
    UPDATE stats SET lvl = lvl + 1, hp = hp + hpn, attack = attack + atk, defense = defense + def
    --,cp = combat_power(hp + hpn, attack + atk, defense + def) 
    WHERE p_id = p_idn;
END;

SELECT * FROM pocketable;
SELECT * FROM stats;
SELECT * FROM pocketable ORDER BY p_id desc;

CALL level_up(62, 2, 1, 3);
CALL level_up(63, 1, 3, 2);
CALL level_up(64, 2, 2, 2);

SELECT * FROM stats WHERE combat_power(hp,attack,defense) = 39;


-----------------------------

--Triggers are an Object that listens
--for an event to occur and executes when it does.


CREATE TABLE archived_pokemon (
    p_id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    bio VARCHAR2(200));
    
CREATE OR REPLACE TRIGGER archive_pokemon
BEFORE DELETE ON pocketable
FOR EACH ROW
BEGIN
    INSERT INTO archived_pokemon VALUES(:old.p_id, :old.name, :old.bio);
--    DELETE stats WHERE p_id = :old.p_id;
END;

CALL add_pokemon2('MissingNo', '???????????????', 'Normal','Flying');


SELECT * FROM pocketable ORDER BY p_id desc;
SELECT * FROM stats ORDER BY p_id desc;
SELECT * FROM p_matcher ORDER BY p_id desc;
SELECT * FROM archived_pokemon;

DELETE pocketable WHERE name = 'MissingNo';

CREATE OR REPLACE PROCEDURE unarchive_pokemon(poke_name VARCHAR2, bio VARCHAR2, type1 VARCHAR2, type2 VARCHAR2)
IS
BEGIN
    add_pokemon2(poke_name,bio,type1,type2);
    DELETE archived_pokemon WHERE name = poke_name;
END;

CALL unarchive_pokemon('MissingNo','??????','Dragon','Fighting');

----------------------------------------

-- Joins 
-- Everything after the FROM statement is just a virtual table
-- The idea of a join is to mold together two or more virtual tables.

SELECT * FROM pocketable p LEFT JOIN stats s ON p.p_id = s.p_id;
SELECT * FROM pocketable p RIGHT JOIN stats s ON p.p_id = s.p_id;

SELECT p.p_id, name,lvl, hp FROM pocketable p RIGHT JOIN stats s ON p.p_id = s.p_id;

ALTER TABLE stats DROP CONSTRAINT fk_stats_pokemon;

SELECT * FROM pocketable;
SELECT * FROM stats;
SELECT * FROM archived_pokemon;

DELETE pocketable WHERE p_id < 61;
DELETE pocketable WHERE p_id = 62;
DELETE stats WHERE p_id = 63;
commit;

SELECT * FROM pocketable INNER JOIN stats ON pocketable.p_id = stats.p_id;

SELECT * FROM pocketable FULL OUTER JOIN stats ON pocketable.p_id = stats.p_id;

SELECT * FROM pocketable NATURAL JOIN stats;

SELECT * FROM pocketable CROSS JOIN pocketable;
-- You can join on the same table. This is called a Self Join

SELECT * FROM pocketable INNER JOIN stats 
ON pocketable.p_id = stats.p_id WHERE lvl < 3;

INSERT INTO archived_pokemon VALUES (id_maker.nextval, 'Zubat', 'A bat pocketable');

SELECT archived_pokemon.name, pocketable.name FROM archived_pokemon LEFT JOIN pocketable 
ON pocketable.name < archived_pokemon.name;

