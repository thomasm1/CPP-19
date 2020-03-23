 


-- ########### Notes #################
--I. 	###########

--This is a comment. Uses the double dash '--'
-- SQL is NOT case sensitive. Note though, a lot of SQL keywords
-- are commonly written in UPPERCASE.
-- SELECT == select = SeLeCt
-- SQL is a scripting language. We do not have to compile it.
-- SQL is a query language. Which means I can run independent chunks
-- of code.

-- DDL statement
DROP TABLE pokemon;

-- DDL statements autocommit.
CREATE TABLE pokemon ( 
	p_id NUMBER(10),
	name VARCHAR2(20),
	type VARCHAR2(50),
	bio VARCHAR2(500),
	lvl NUMBER(10),
	shiny NUMBER(1));
	
SELECT * FROM pokemon;

-- DML which does not autocommit.
INSERT INTO pokemon VALUES (1, 'Bulbasaur', 'Grass/Poison', 'The first Pokemon', 5, 0);
INSERT INTO pokemon VALUES (111, 'Mudkip', 'Water', 'He cute pokemanz', 5, 1);
INSERT INTO pokemon VALUES (151, 'Mew', 'Psychic', 'The first legendary', 35, 0);
INSERT INTO pokemon VALUES (69, 'Exeggcute', 'Grass/Psychic', 'This Pok�mon consists of six eggs that form a closely knit cluster. The six eggs attract each other and spin around. When cracks increasingly appear on the eggs, Exeggcute is close to evolution.', 5, 0);
INSERT INTO pokemon VALUES (150, 'Mewtwo', 'Psychic', 'Genetic Pokemon', 9, 1);
INSERT INTO pokemon VALUES (7, 'Aipom', 'Normal', 'Three handed monkey', 100, 0);
INSERT INTO pokemon VALUES (2, 'Charmander', 'Fire', 'It breathes fire.', 6, 0);
INSERT INTO pokemon VALUES (11, 'Zubat', 'Flying/Poison', 'bat thing', 5, 1);
INSERT INTO pokemon VALUES (8, 'Raichu', 'Electric', 'The Originals', 1, 1);
INSERT INTO pokemon VALUES (25,'Hitmonchan','Fighting','Steroids are strong with this one',100,1);
INSERT INTO pokemon VALUES (106, 'Hitmonleee', 'Fighting', 'The kicking fiend', 23, 0);
INSERT INTO pokemon VALUES (99,'Charizard', 'Fire', 'https://bulbapedia.bulbagarden.net/wiki/File:006Charizard.png', 10,0);

commit;
rollback;

-- To remove records from a table you have options
-- DELETE removes data from a table. Does not remove the table.

-- DML, manipulating the data in the table
DELETE pokemon;
commit;

DELETE pokemon WHERE lvl > 10;
DELETE pokemon WHERE p_id NOT BETWEEN 50 AND 125;

-- Truncate Table performs the same action as DELETE

-- This is DDL, why?
TRUNCATE TABLE pokemon;

SELECT name,lvl FROM pokemon;

SELECT p_id,name,lvl FROM pokemon WHERE lvl >= 10;
SELECT p_id,name,lvl FROM pokemon WHERE name = 'Aipom';
--For fun
SELECT p_id,name,lvl FROM pokemon WHERE REGEXP_LIKE (name, '^[A-C]+');

--Aliases
SELECT p.name,p.lvl FROM pokemon p WHERE p.name = 'Aipom';

-- DML, not autocommited.
UPDATE pokemon SET lvl = 100 WHERE p_id > 50;
commit;


-- Aggregate function is going to calculate some value using multiple
-- records
-- AVG, MAX, MIN, SUM, COUNT

SELECT MAX(lvl), MIN(p_id) FROM pokemon;

SELECT COUNT(shiny) FROM pokemon WHERE shiny = 1;

-- GROUP BY is used with aggregate functions to break records into
-- groups/buckets

SELECT type,COUNT(type),ROUND(AVG(lvl), 0) FROM pokemon GROUP BY type;
SELECT lvl,COUNT(lvl) FROM pokemon GROUP BY lvl;
SELECT MOD(p_id,5),AVG(lvl),COUNT(p_id) FROM pokemon GROUP BY MOD(p_id,5);


-- HAVING is an extra clause we use with GROUP BY becuase Oracle wont
-- let you use WHERE. WHERE filters out records to return, but GROUP BY
-- doesn't return records.

SELECT type,COUNT(type),AVG(lvl) FROM pokemon GROUP BY type HAVING type LIKE 'F%';
SELECT type,COUNT(type),AVG(lvl) FROM pokemon GROUP BY type HAVING type LIKE '%c';


-- ORDER BY only changes the way in which the table is displayed.
-- Not what records you return;

SELECT p_id,name,lvl FROM pokemon ORDER BY name;
SELECT p_id,name,lvl FROM pokemon ORDER BY lvl desc;

SELECT type,COUNT(type),AVG(lvl) FROM pokemon GROUP BY type ORDER BY AVG(p_id);

--Subqueries
SELECT * FROM pokemon WHERE lvl = (SELECT MIN(lvl) FROM pokemon);
UPDATE pokemon SET lvl = 50 WHERE lvl = (SELECT MIN(lvl) FROM pokemon);


SELECT * FROM (SELECT p_id,name,lvl FROM pokemon ORDER BY lvl desc) WHERE ROWNUM <= 6;

-- Not the same
SELECT p_id,name,lvl FROM pokemon WHERE ROWNUM <=6 ORDER BY lvl desc;

	
--II 		###########

CREATE TABLE pokemon (
    p_id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    bio VARCHAR2(200));
    
CREATE TABLE ptype (
    t_id NUMBER(10) PRIMARY KEY,
    type VARCHAR(20));
    
CREATE TABLE stats (
    p_id NUMBER(10),
    lvl NUMBER(10) DEFAULT 1,
    hp NUMBER(10),
    attack NUMBER(10),
    defense NUMBER(10),
    cp NUMBER(10),
    shiny NUMBER(1) DEFAULT 0);
    
--Junction Table
--These are used for tables that have a Many-to-Many relationship

CREATE TABLE pokemon_type (
    p_id NUMBER(10),
    t_id NUMBER(10));
    
ALTER TABLE stats DROP CONSTRAINT fk_stats_pokemon;
ALTER TABLE stats ADD CONSTRAINT fk_stats_pokemon FOREIGN KEY
(p_id) REFERENCES pokemon(p_id) ON DELETE CASCADE;


INSERT INTO pokemon VALUES (1, 'Bulbasaur', 'The first Pokemon');
INSERT INTO stats VALUES (1, 5, 5, 5, 5, 15, 0);

INSERT INTO stats VALUES (2, 5, 5, 5, 5, 15, 0);

DELETE stats;
DELETE pokemon;
SELECT * FROM pokemon;
SELECT * FROM stats;


ALTER TABLE pokemon_type ADD CONSTRAINT fk_pt_pokemon FOREIGN KEY
(p_id) REFERENCES pokemon(p_id) ON DELETE CASCADE;

ALTER TABLE pokemon_type ADD CONSTRAINT fk_pt_type FOREIGN KEY
(t_id) REFERENCES ptype(t_id) ON DELETE CASCADE;

INSERT INTO ptype VALUES (1, 'Grass');
INSERT INTO ptype VALUES (2, 'Poison');

SELECT * FROM ptype;

SELECT * FROM pokemon_type;

INSERT INTO pokemon_type VALUES(1,1);
INSERT INTO pokemon_type VALUES(1,2);

--III 		###########   
		
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Bulbasaur', 'The first Pokemon');
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Mudkip', 'He cute pokemanz');
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Mew', 'The first legendary');
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Exeggcute', 'This Pok�mon consists of six eggs that form a closely knit cluster. The six eggs attract each other and spin around. When cracks increasingly appear on the eggs, Exeggcute is close to evolution.');
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Mewtwo', 'Genetic Pokemon');
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Aipom', 'Three handed monkey');
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Charmander', 'It breathes fire.');
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Zubat', 'bat thing');
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Raichu', 'The Originals');
	INSERT INTO pokemon VALUES (id_maker.nextval,'Hitmonchan','Steroids are strong with this one');
	INSERT INTO pokemon VALUES (id_maker.nextval, 'Hitmonleee', 'The kicking fiend');
	INSERT INTO pokemon VALUES (id_maker.nextval,'Charizard', 'https://bulbapedia.bulbagarden.net/wiki/File:006Charizard.png');
	commit;

	SELECT * FROM pokemon;

	-- Sequence is an SQL Object which will generate a unique number.
	-- We will use sequences in place of AUTO_INCREMENT
	DROP SEQUENCE id_maker;
	CREATE SEQUENCE id_maker
		MINVALUE 1
		START WITH 1
		INCREMENT BY 1;



	INSERT INTO ptype VALUES(id_maker.nextval, 'Grass');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Water');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Fire');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Electric');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Dragon');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Ice');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Dark');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Normal');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Psychic');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Fairy');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Bug');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Steel');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Rock');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Ground');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Fighting');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Flying');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Poison');
	INSERT INTO ptype VALUES(id_maker.nextval, 'Ghost');
	commit;

	SELECT * FROM pokemon;
	SELECT * FROM ptype;


	-- Procedure is just a set of SQL commands
	-- essentially a script
	-- Have 0 to Many inputs
	-- Have 0 to Many outputs
	-- Can manipulate data in the database.
	CREATE OR REPLACE PROCEDURE add_pokemon(name VARCHAR2, bio VARCHAR2, t_id1 NUMBER, t_id2 NUMBER)
	IS
	BEGIN
	INSERT INTO pokemon VALUES (id_maker.nextval, name, bio);
	INSERT INTO stats VALUES (id_maker.currval,1,5,5,5,0);
	INSERT INTO pokemon_type VALUES (id_maker.currval, t_id1);
	IF t_id2 != -1
	THEN
		INSERT INTO pokemon_type VALUES (id_maker.currval, t_id2);
	END IF;
	END;


	CREATE OR REPLACE PROCEDURE add_pokemon2(name VARCHAR2, bio VARCHAR2, type1 VARCHAR2, type2 VARCHAR2)
	IS
	BEGIN
	INSERT INTO pokemon VALUES (id_maker.nextval, name, bio);
	INSERT INTO stats VALUES (id_maker.currval,1,5,5,5,0);
	INSERT INTO pokemon_type VALUES (id_maker.currval, (SELECT t_id FROM ptype WHERE type = type1 AND ROWNUM = 1));
	IF type2 IS NOT NULL
	THEN
		INSERT INTO pokemon_type VALUES (id_maker.currval, (SELECT t_id FROM ptype WHERE type = type2 AND ROWNUM = 1));
	END IF;
	commit;
	END;

	CALL add_pokemon('Eevee','The cutest pokemon',38, -1);
	CALL add_pokemon('Pidgey','The bird pokemon',38,46);

	CALL add_pokemon2('Ivysaur','The second pokemon','Grass','Poison');
	CALL add_pokemon2('Goldeen','The goldfish pokemon','Water',null);


	SELECT * FROM pokemon ORDER BY p_id desc;
	SELECT * FROM stats ORDER BY p_id desc;
	SELECT * FROM pokemon_type ORDER BY p_id desc;


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

	SELECT * FROM pokemon;
	SELECT * FROM stats;
	SELECT * FROM pokemon ORDER BY p_id desc;

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
	BEFORE DELETE ON pokemon
	FOR EACH ROW
	BEGIN
		INSERT INTO archived_pokemon VALUES(:old.p_id, :old.name, :old.bio);
	--    DELETE stats WHERE p_id = :old.p_id;
	END;

	CALL add_pokemon2('MissingNo', '???????????????', 'Normal','Flying');


	SELECT * FROM pokemon ORDER BY p_id desc;
	SELECT * FROM stats ORDER BY p_id desc;
	SELECT * FROM pokemon_type ORDER BY p_id desc;
	SELECT * FROM archived_pokemon;

	DELETE pokemon WHERE name = 'MissingNo';

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

	SELECT * FROM pokemon p LEFT JOIN stats s ON p.p_id = s.p_id;
	SELECT * FROM pokemon p RIGHT JOIN stats s ON p.p_id = s.p_id;

	SELECT p.p_id, name,lvl, hp FROM pokemon p RIGHT JOIN stats s ON p.p_id = s.p_id;

	ALTER TABLE stats DROP CONSTRAINT fk_stats_pokemon;

	SELECT * FROM pokemon;
	SELECT * FROM stats;
	SELECT * FROM archived_pokemon;

	DELETE pokemon WHERE p_id < 61;
	DELETE pokemon WHERE p_id = 62;
	DELETE stats WHERE p_id = 63;
	commit;

	SELECT * FROM pokemon INNER JOIN stats ON pokemon.p_id = stats.p_id;

	SELECT * FROM pokemon FULL OUTER JOIN stats ON pokemon.p_id = stats.p_id;

	SELECT * FROM pokemon NATURAL JOIN stats;

	SELECT * FROM pokemon CROSS JOIN pokemon;
	-- You can join on the same table. This is called a Self Join

	SELECT * FROM pokemon INNER JOIN stats 
	ON pokemon.p_id = stats.p_id WHERE lvl < 3;

	INSERT INTO archived_pokemon VALUES (id_maker.nextval, 'Zubat', 'A bat pokemon');

	SELECT archived_pokemon.name, pokemon.name FROM archived_pokemon LEFT JOIN pokemon 
	ON pokemon.name < archived_pokemon.name;


--IV.  		###########   
-- Union
SELECT * FROM pokemon;
SELECT * FROM archived_pokemon;

INSERT INTO archived_pokemon VALUES (61, 'Eevee', 'The cutest pokemon');
commit;

SELECT * FROM pokemon UNION SELECT * FROM archived_pokemon;
SELECT * FROM pokemon UNION ALL SELECT * FROM archived_pokemon;

SELECT * FROM pokemon INTERSECT SELECT * FROM archived_pokemon;

SELECT * FROM pokemon MINUS SELECT * FROM archived_pokemon;
SELECT * FROM archived_pokemon MINUS SELECT * FROM pokemon;


--------------------------------------------

DROP TABLE pokemon_type;
DROP TABLE stats;
DROP TABLE ptype;
DROP TABLE pokemon;

CREATE TABLE pokemon (
    p_id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    bio VARCHAR2(200));
    
CREATE TABLE ptype (
    t_id NUMBER(10) PRIMARY KEY,
    type VARCHAR(20));
    
CREATE TABLE stats (
    p_id NUMBER(10),
    lvl NUMBER(10) DEFAULT 1,
    hp NUMBER(10),
    attack NUMBER(10),
    defense NUMBER(10),
    shiny NUMBER(1) DEFAULT 0,
    CONSTRAINT fk_stats_pokemon FOREIGN KEY (p_id) 
    REFERENCES pokemon(p_id) ON DELETE CASCADE);
    
CREATE TABLE pokemon_type (
    p_id NUMBER(10),
    t_id NUMBER(10),
    CONSTRAINT fk_pt_pokemon FOREIGN KEY (p_id)
    REFERENCES pokemon(p_id) ON DELETE CASCADE,
    CONSTRAINT fk_pt_type FOREIGN KEY (t_id)
    REFERENCES ptype(t_id) ON DELETE CASCADE);
    


------------------------
-- dual table

CREATE TABLE dual (
    dummy VARCHAR2(1));
    
INSERT INTO dual VALUES ('X');

SELECT * FROM dual;
    
SELECT 1 FROM dual;

SELECT 1+1 FROM dual;

SELECT SYSDATE FROM archived_pokemon WHERE ROWNUM = 1;

SELECT SYSDATE FROM dual;

SELECT USER FROM dual;

SELECT USER FROM archived_pokemon WHERE ROWNUM = 1;


------------------------------------

-- Procedures OUT parameters

CREATE OR REPLACE PROCEDURE convertTypesToIds(type1 IN VARCHAR2, type2 IN VARCHAR2, t_id1 OUT NUMBER, t_id2 OUT NUMBER)
IS
BEGIN
SELECT t_id INTO t_id1 FROM ptype WHERE type = type1 AND ROWNUM = 1;
IF type2 IS NOT NULL
THEN
SELECT t_id INTO t_id2 FROM ptype WHERE type = type2 AND ROWNUM = 1;
ELSE
SELECT -1 INTO t_id2 FROM dual;
END IF;
END;


CREATE OR REPLACE PROCEDURE add_pokemon2(name IN VARCHAR2, bio IN VARCHAR2, type1 IN VARCHAR2, type2 IN VARCHAR2)
IS
t_id1 NUMBER(10);
t_id2 NUMBER(10);
BEGIN
convertTypesToIds(type1, type2, t_id1, t_id2);
add_pokemon(name, bio, t_id1, t_id2);

commit;
END;

CALL add_pokemon2('Venasaur','The third pokemon','Grass','Poison');
CALL add_pokemon2('Seaking','The bigger goldfish pokemon','Water',null);

SET serveroutput on;
DECLARE
t_id1 NUMBER(10);
t_id2 NUMBER(10);
BEGIN
convertTypesToIds('Water', null, t_id1, t_id2);
dbms_output.put_line(t_id2);
END;


SELECT * FROM pokemon;
SELECT * FROM stats;
SELECT * FROM pokemon_type;
SELECT * FROM ptype;

CREATE OR REPLACE PROCEDURE add_new_pokemon(name VARCHAR2, bio VARCHAR2)
IS
BEGIN
    INSERT INTO pokemon VALUES (id_maker.nextval, name, bio);
END;

CALL add_new_pokemon('Ditto','The copy pokemon');
commit;

SELECT * FROM pokemon;


CREATE TABLE person (
    username VARCHAR2(100),
    password VARCHAR2(100));
    
INSERT INTO person VALUES ('Ryan', 'password');
INSERT INTO person VALUES ('Adam', 'password');
INSERT INTO person VALUES ('Shelby', 'password');
commit;



  
-- ########### PROJECT 0  [Oracle] CarDealership  #################

	12-30-19
	SELECT o.username,  o.carid,  o.offerstatus,  o.offermos, c.carid, c.carmake, c.carmodel, c.pricetotal FROM offertable o JOIN cartable c ON c.carid = o.carid WHERE o.offerstatus = 'APPROVED' AND o.username = 'sarah';
	SELECT * FROM usertable WHERE username = 'admin';
	select * from usertable where username = 'sarah';
	select * from cartable;
	select * from offertable;
	####

	DELETE electrolot where username = 'new';
	DELETE electrolot where balance = 0;
	delete electrolot where carid = '93';--'me' AND offerid=11;
	DELETE usertable where username = 'new';--'me' AND offerid=11;
	DELETE cartable where carid = '93';--'me' AND offerid=11; 
	DELETE offertable where offerid = '';--'me' AND offerid=11; 

	SELECT * from electrolot;
	SELECT * from offertable;
	SELECT * from usertable;
	SELECT * from usertable WHERE username = 'joshallen';
	SELECT * from cartable;
	SELECT * from cartable WHERE carmodel LIKE 'CyberTruck%';
	SELECT o.username,  o.carid,  o.offerstatus,  o.offermos, c.carid, c.carmake, c.carmodel, c.pricetotal FROM offertable o JOIN cartable c ON c.carid = o.carid WHERE o.offerstatus = 'APPROVED' AND o.username = 'me';
	SELECT o.username,  o.caridd  o.offerstatus,  o.offermos, c.carid, c.carmake, c.carmodel, c.pricetotal FROM offertable o JOIN cartable c ON c.carid = o.carid WHERE o.offerstatus = 'REJECTED' AND o.username = 'abc';
	COMMIT;
	--------------- 
	DROP SEQUENCE id_maker;
	CREATE SEQUENCE id_maker 
		MINVALUE 1 
		START WITH 1 
		INCREMENT BY 1; 
	----------------------------------------------------------
	-----------USERTABLE-------------------------------------- 
	 
	DROP TABLE usertable;
	CREATE TABLE usertable (
		userid NUMBER(10),
		username VARCHAR2(20) NOT NULL,
		password VARCHAR2 (20) NOT NULL,
		fullname VARCHAR2(200),
		iscust NUMBER (1) DEFAULT (1) NOT NULL,
		isowner NUMBER (1) DEFAULT (0),
		constraint pk_username PRIMARY KEY (username));

	DROP SEQUENCE id_maker_th;
	CREATE SEQUENCE id_maker_th 
		MINVALUE 1000
		START WITH 1000
		INCREMENT BY 1;
		
	INSERT INTO usertable VALUES (id_maker_th.nextval,  'myUserName0', 'myPassword0', 'myFullName0',0,0);
	INSERT INTO usertable VALUES (id_maker_th.nextval,  'myUserName1', 'myPassword1', 'myFullName1',1,0);
	INSERT INTO usertable VALUES (id_maker_th.nextval, 'myUserName2', 'myPassword2', 'myFullName2',1,0);
	INSERT INTO usertable VALUES (id_maker_th.nextval, 'myUserName3', 'myPassword3', 'myFullName3',1,1);  
	SELECT * FROM usertable;
	COMMIT;
	---------------PROC---------add_new_user
	create or replace PROCEDURE add_new_user(username VARCHAR2, password VARCHAR2, fullname VARCHAR2, iscust NUMBER, isowner NUMBER)
	IS
	BEGIN
	INSERT INTO usertable VALUES (id_maker.nextval, username, password, fullname, iscust, isowner); --id_maker.nextval, 
	END;
	---------------PROC---------add_new_user

	------------------------------------------------------------
	-------------CARTABLE----------------------------------------
		
	DROP TABLE cartable; 
	CREATE TABLE cartable (
		carid NUMBER(4), 
		carmake VARCHAR2 (20),
		carmodel VARCHAR2 (20),
		pricetotal NUMBER(7,2),  
		purchased NUMBER(1) DEFAULT 0,
		constraint pk_cid PRIMARY KEY (carid));
		
	DROP SEQUENCE id_maker;
	CREATE SEQUENCE id_maker 
		MINVALUE 1 
		START WITH 1 
		INCREMENT BY 1;
		
	INSERT INTO cartable VALUES (id_maker.nextval,'Ford', 'Focus', 36000.00, 0);
	INSERT INTO cartable VALUES (id_maker.nextval,'Tesla', 'Cyber-Truck', 38000.00, 0);
	INSERT INTO cartable VALUES (id_maker.nextval,'Chevrolet', 'Corvette', 70000.00, 0);
	INSERT INTO cartable VALUES (id_maker.nextval,'Jeep', 'Wrangler', 56000.00, 0);
	COMMIT; 
	SELECT * FROM cartable; 

	--customer view of lot
	SELECT * FROM cartable WHERE purchased=1;
	SELECT * FROM cartable WHERE purchased=0;
	--customer-owned cars 
	--SELECT * FROM pocketable INNER JOIN stats ON pocketable.p_id = stats.p_id;
	SELECT * FROM offertable left JOIN cartable ON offertable.carid = cartable.carid; --returns offer-car join
	SELECT * FROM offertable WHERE offertable.username = 'abc' AND offertable.offerstatus = 'PENDING'; --returns status+owner
	--/no work
	--SELECT * FROM (SELECT * FROM offertable WHERE offertable.username = 'abc' AND offertable.offerstatus = 'PENDING') JOIN cartable ON offertable.carid = cartable.carid;
	  SELECT  o.username,  o.carid,  o.offerstatus,  o.offermos, c.carid, c.carmake, c.carmodel, c.pricetotal FROM offertable o FULL JOIN cartable c ON c.carid = o.carid WHERE o.offerstatus = 'APPROVED' AND o.username = 'abc'; 
	SELECT
	  o.username,
	  o.carid,
	  o.offerstatus,
	  o.offermos,
	  
	  c.carid,
	  c.carmake,
	  c.carmodel,
	  c.pricetotal
	FROM
	  offertable o JOIN
	  cartable c 
	  ON c.carid = o.carid
	WHERE
	  o.offerstatus = 'APPROVED' AND
	  o.username = 'abc'; 
	--https://www.red-gate.com/simple-talk/sql/sql-training/subqueries-in-sql-server/ 
	  --https://www.red-gate.com/simple-talk/sql/sql-training/subqueries-in-sql-server/ 
	  SELECT o.username,  o.carid,  o.offerstatus,  o.offermos, c.carid, c.carmake, c.carmodel, c.pricetotal FROM offertable o JOIN cartable c ON c.carid = o.carid WHERE o.offerstatus = 'APPROVED' AND o.username = 'abc';
	SELECT o.username,  o.carid,  o.offerstatus,  o.offermos, c.carid, c.carmake, c.carmodel, c.pricetotal FROM offertable o JOIN cartable c ON c.carid = o.carid WHERE o.offerstatus = 'APPROVED' AND o.username = 'abc';
	---------------PROC-------------add_new_car
	create or replace PROCEDURE add_new_car(carmake VARCHAR2, carmodel VARCHAR2, pricetotal NUMBER, purchased NUMBER)
	IS
	BEGIN
	INSERT INTO cartable VALUES (id_maker.nextval, carmake, carmodel, pricetotal, purchased);   
	END;
	---------------PROC-------------add_new_car

	---------------------------------------------------------------
	----------------OFFERTABLE--------------------------------------
	--DROP TABLE offer_type;
	--DROP TABLE otype;
	--DROP TABLE ostats; 
	DROP TABLE offertable; 
	CREATE TABLE offertable (
		offerid NUMBER(4),
		username VARCHAR2( 20), --FOREIGN username of offer
		carid NUMBER(4), --FOREIGN car_id of offer 
	--    carprice NUMBER (7,2), --FOREIGN car_price
		offeramt NUMBER(7,2), 
		offermos NUMBER(2),
		offerstatus VARCHAR2 (20),
		constraint pk_oid PRIMARY KEY (offerid),
	--    constraint fk_cprice FOREIGN KEY (c_price) REFERENCES cartable (carprice),
		constraint fk_uid FOREIGN KEY (username) REFERENCES usertable (username),
		constraint fk_cid FOREIGN KEY (carid) REFERENCES cartable (carid));
	SELECT * FROM offertable;
	-- 
	--DROP SEQUENCE id_maker;
	--CREATE SEQUENCE id_maker 
	--    MINVALUE 1 
	--    START WITH 1 
	--    INCREMENT BY 1;

	DROP SEQUENCE id_maker_th2;
	CREATE SEQUENCE id_maker_th2 
		MINVALUE 2000
		START WITH 2000
		INCREMENT BY 1;

	DROP SEQUENCE id_maker_th3;
	CREATE SEQUENCE id_maker_th3 
		MINVALUE 3000
		START WITH 3000
		INCREMENT BY 1;
		
	DROP SEQUENCE id_maker_th; 
	CREATE SEQUENCE id_maker_th 
		MINVALUE 1000
		START WITH 1000
		INCREMENT BY 1;
		delete offertable where username='abc';
	INSERT INTO offertable VALUES (id_maker_th.nextval,'def', 1001, 2000.00, 18, 'CANCELED');
	INSERT INTO offertable VALUES (id_maker_th.nextval,'usernamem',1002, 3000.00, 0, 'DECLINED');
	INSERT INTO offertable VALUES (id_maker_th.nextval,'username3', id_maker_th3.nextval, 4000.00, 18, 'ACCEPTED');
	INSERT INTO offertable VALUES (id_maker_th.nextval, 'username4',id_maker_th3.nextval, 1000.00, 36, 'PENDING'); 
	COMMIT;
	SELECT * FROM offertable;
	SELECT * FROM offertable WHERE username='def';
	SELECT * FROM offertable WHERE username='abc';
	-----------------------PROC------------add_new_offer-----------
	create or replace PROCEDURE add_new_offer(username VARCHAR2, carid NUMBER, offeramt NUMBER, offermos NUMBER, offerstatus VARCHAR2)
	IS
	BEGIN
	INSERT INTO offertable VALUES (id_maker.nextval, username, carid, offeramt, offermos, offerstatus);   
	END;
	-----------------------PROC------------add_new_offer-----------

	---------------------------------------------------------------
	--------------------ELECTROLOT---------------------------------
	SELECT * from electrolot; 
	DROP TABLE electrolot; 
	CREATE TABLE electrolot (     
		id NUMBER(6),
		offerid NUMBER(6),
		carid NUMBER(6), 
		username VARCHAR2(20), 
		pricetotal NUMBER(10,2),  
		offeramt NUMBER(10,2),
		balance NUMBER (10,2),
		offermos NUMBER(4), 
		monthsremaining NUMBER (4),
		monthlypayments NUMBER (4),
		constraint pk_conid PRIMARY KEY (id));
	--    constraint fk_offerid FOREIGN KEY (offerid) REFERENCES offertable (offerid),
	--    constraint fk_username FOREIGN KEY (username) REFERENCES usertable (username),
	--    constraint fk_carid FOREIGN KEY (carid) REFERENCES cartable (carid),
	--    constraint fk_pricetotal FOREIGN KEY (pricetotal) REFERENCES cartable (pricetotal),
	--    constraint fk_offeramt FOREIGN KEY (offeramt) REFERENCES offertable (offeramt),
	--    constraint fk_offermos FOREIGN KEY (offermos) REFERENCES offertable (offermos),
		
	--DROP SEQUENCE id_maker_th;
	CREATE SEQUENCE id_maker_th 
		MINVALUE 1000 
		START WITH 1000 
		INCREMENT BY 1;
		
	--DROP SEQUENCE id_maker;
	CREATE SEQUENCE id_maker 
		MINVALUE 1 
		START WITH 1 
		INCREMENT BY 1;

	--DROP SEQUENCE id_maker2;
	CREATE SEQUENCE id_maker2 
		MINVALUE 1 
		START WITH 1 
		INCREMENT BY 1;

	--DROP SEQUENCE id_maker3;
	CREATE SEQUENCE id_maker3 
		MINVALUE 1 
		START WITH 1 
		INCREMENT BY 1;
		DROP SEQUENCE id_maker3;

	--DROP SEQUENCE id_maker4;
	CREATE SEQUENCE id_maker4 
		MINVALUE 1 
		START WITH 1 
		INCREMENT BY 1;
	INSERT INTO electrolot VALUES (id_maker.nextval_th, id_maker2.nextval, id_maker2.nextval,'usernameX',null,null,null,null, null,null); 

	INSERT INTO electrolot VALUES (100,1,1,1,null,null,null, null,null); 
	COMMIT;
	SELECT * FROM electrolot;
	select * fROM cartable;
	-----------------------PROC------------add_new_elecrolot-----------
	create or replace PROCEDURE add_new_electrolot( offerid NUMBER, carid NUMBER, username VARCHAR2, pricetotal NUMBER, offeramt NUMBER, balance NUMBER, offermos NUMBER, monthsremaining NUMBER, monthlypayments NUMBER)
	IS
	BEGIN
	INSERT INTO electrolot VALUES (id_maker.nextval, offerid, carid, username, pricetotal, offeramt, balance, offermos, monthsremaining, monthlypayments); --id_maker.nextval, 
	END;
	-----------------------PROC------------add_new_elecrolot-----------


-- ########### PROJECT 1  [Oracle]  TRMS- TuitionReimbursementManagementSystem   
 
	--OLD SCRIPTS
	ALTER TABLE requsertable ADD CONSTRAINT fk_deptid FOREIGN KEY (deptid) REFERENCES  reqdepttable (deptid) ON DELETE CASCADE; 
	DELETE reqcalculate where username = 'new';
	DELETE reqcalculate where balance = 0;
	delete reqcalculate where reqid = '93';--'me' AND taskid=11;
	DELETE requsertable where username = 'new';--'me' AND taskid=11;
	DELETE reqtable where reqid = '93';--'me' AND taskid=11; 
	DELETE tasktable where taskid = '';--'me' AND taskid=11; 

	SELECT * from reqcalculate;
	SELECT * from tasktable;
	SELECT * from requsertable;
	SELECT * from requsertable WHERE username = 'joshallen';
	SELECT * from reqtable;
	SELECT * from reqtable WHERE reqfor LIKE 'CyberTruck%';
	SELECT o.username,  o.reqid,  o.taskstatus,  o.taskmos, c.reqid, c.timestamp, c.reqfor, c.reqamt FROM tasktable o JOIN reqtable c ON c.reqid = o.reqid WHERE o.taskstatus = 'APPROVED' AND o.username = 'me';
	SELECT o.username,  o.reqid,  o.taskstatus,  o.taskmos, c.reqid, c.timestamp, c.reqfor, c.reqamt FROM tasktable o JOIN reqtable c ON c.reqid = o.reqid WHERE o.taskstatus = 'REJECTED' AND o.username = 'abc';
	COMMIT;

	-- PROJECT 1 SCRIPTS 

	DELETE REQUSERTABLE WHERE USERID = 4;
	--############################ 
	UPDATE requsertable
	SET password = 'pass'
	WHERE userid >= 0;
	commit;
	 
	ALTER TABLE reqtable ADD superText VARCHAR2(500); 
	ALTER TABLE reqtable ADD dheadText VARCHAR2(500);  
	ALTER TABLE reqtable ADD bencoText VARCHAR2(500); 
	ALTER TABLE reqtable ADD reqText VARCHAR2(500); 
	 
	ADD column_name data_type constraint;

	UPDATE reqtable
	SET stage = 4
	WHERE reqid = 113;
	commit;

	UPDATE reqtable
	SET stage = NULL
	WHERE stage = 2;
	--must remove values before modifying col
	ALTER TABLE reqtable MODIFY stage VARCHAR2(40);
	ALTER TABLE reqtable MODIFY stage NUMBER(2) DEFAULT 0;
	UPDATE reqtable SET stage=99 WHERE reqid >= 100;
	 
	commit;
	ALTER TABLE table_name 
	ADD column_name data_type constraint;

	SELECT * FROM reqtable WHERE reqid =102;
	--1. apprSuper
	--2. apprSupAuto
	// SET TIMEOUT FOR 2 MINS 120 * 1000      120.000
	// (USUALLY 1 WEEK) == 604800 * 1000 = 604.800.000
	--3. denySuper---->send reason to requestor
	--4. apprDhead
	--5. pendDocs ---->need docs from requestor
	--6. denyDhead
	--7. apprBenco
	--8. apprLargerBenc--->reason for exceeding available
	--8. pendAmtBenc---->need final approve from requestor
	--9. pendTimeBenc---->letter to supervisor
	--10.denyBenco
	--
	-- 
	SELECT * FROM reqdepttable WHERE deptheadid = 333;
	DROP TABLE reqdepttable;

	-- view of requests
	SELECT * FROM reqtable WHERE userid=1002;
	SELECT * FROM reqtable WHERE stage=1;

	--request table FULL JOIN  users table 
	SELECT * FROM reqtable JOIN requsertable ON requsertable.userid = reqtable.userid; 
	 --returns stage and amount
	SELECT * FROM reqtable WHERE reqtable.reqamt >= 100.30 AND reqtable.stage > 0;

	SELECT * FROM reqtasktable WHERE username='def';
	SELECT * FROM reqtasktable WHERE username='abc';
	 
	UPDATE requsertable
	SET username = 'Sarah_Conner' 
	WHERE username = 'Sarah Conner';

	--ALTER TABLE reqtable MODIFY reqname char(100);
	ALTER TABLE reqtasktable MODIFY currdocs VARCHAR2(1000);
	-- MODIFY COLS

	UPDATE reqtable
	SET stage = NULL
	WHERE stage = 2;
	--must remove values before modifying col
	ALTER TABLE reqtable MODIFY stage VARCHAR2(40);
	 
	--ADD COL
	ALTER TABLE table_name 
	ADD column_name data_type constraint;
	-------------DEPT TABLE----------------------------------------
	DROP TABLE reqdepttable;
	CREATE TABLE reqdepttable (
		deptid NUMBER(5) NOT NULL, 
		deptheadid NUMBER(5) NOT NULL,
		deptname VARCHAR2(20),
		constraint pk_deptid PRIMARY KEY (deptid));
	-------------
	DROP SEQUENCE id_maker_four;
	CREATE SEQUENCE id_maker_four 
		MINVALUE 401
		START WITH 401
		INCREMENT BY 1; 
	--------------- 
	DROP SEQUENCE id_maker;
	CREATE SEQUENCE id_maker 
		MINVALUE 1 
		START WITH 1 
		INCREMENT BY 1; 
	--------------- 
	INSERT INTO reqdepttable VALUES (id_maker_four.nextval,id_maker.nextval, 'literature');
	INSERT INTO reqdepttable VALUES (id_maker_four.nextval,id_maker.nextval, 'corporate');
	INSERT INTO reqdepttable VALUES (id_maker_four.nextval,id_maker.nextval, 'computer_science' );
	INSERT INTO reqdepttable VALUES (id_maker_four.nextval,id_maker.nextval, 'benefits');  
	SELECT * FROM reqdepttable;
	COMMIT; 


	---------------PROC---------add_new_dept
	--
	--create or replace PROCEDURE add_new_dept(deptHeadId NUMBER, deptname VARCHAR2)
	--IS
	--BEGIN
	--INSERT INTO reqdepttable VALUES (id_maker_four.nextval,deptHeadId, deptname); --id_maker.nextval, 
	--END;

	------------------------------------------------------------	
	-----------  USER TABLE-------------------------------------- 
	 
	DROP TABLE requsertable;
	CREATE TABLE requsertable (
		userid NUMBER(5),
		deptid NUMBER(5) DEFAULT (0),
		superid NUMBER(5),
		username VARCHAR2(20) NOT NULL,
		password VARCHAR2 (20) NOT NULL,
		email VARCHAR2(100) NOT NULL, 
		constraint pk_userid PRIMARY KEY (userid));
	--------------- 
	DROP SEQUENCE id_maker;
	CREATE SEQUENCE id_maker 
		MINVALUE 1 
		START WITH 1 
		INCREMENT BY 1; 
	--------------- 
	DROP SEQUENCE id_maker_four;
	CREATE SEQUENCE id_maker_four 
		MINVALUE 401
		START WITH 401
		INCREMENT BY 1; 
	INSERT INTO requsertable VALUES (id_maker.nextval,id_maker_four.nextval,51, 'Tom', 'Tom', 'tom@gmail.com');
	INSERT INTO requsertable VALUES (id_maker.nextval,id_maker_four.nextval,52,  'Sue', 'Sue', 'sue@msn.com');
	INSERT INTO requsertable VALUES (id_maker.nextval,id_maker_four.nextval,53, 'Pete', 'Pete', 'pete@gmail.com');
	INSERT INTO requsertable VALUES (id_maker.nextval,id_maker_four.nextval,54, 'Cyndi', 'Cyndi', 'cyndi@msn.com');  
	SELECT * FROM requsertable;
	COMMIT;

	SELECT * FROM requsertable;
	ALTER TABLE requsertable ADD CONSTRAINT fk_deptid FOREIGN KEY (deptid) REFERENCES  reqdepttable (deptid) ON DELETE CASCADE; 
	 
	-------------------------------add_new_requser
	--create or replace PROCEDURE add_new_requser(deptid NUMBER, superid NUMBER, username VARCHAR2, password VARCHAR2, email VARCHAR2)
	--IS
	--BEGIN
	--INSERT INTO requsertable VALUES (id_maker_proc.nextval,deptid, superid, username, password, email); --id_maker.nextval, 
	--END;


	------------------------------------------------------------
	-------------REQUEST TABLE----------------------------------------
	DROP TABLE reqtable; 
	CREATE TABLE reqtable (
		reqid NUMBER(5), 
		userid NUMBER(5), 
		
		reqname VARCHAR2 (20),
		reqtype VARCHAR2 (20), 
		reqdesc VARCHAR2 (200),
		reqjustify VARCHAR2 (200),
		
		reqdatetime VARCHAR2 (40),
		reqplace VARCHAR2 (40),
		reqgradetype VARCHAR2 (40),
		reqgradepass VARCHAR2 (40),
		reqamt NUMBER(7,2),  
		stage NUMBER(1) DEFAULT 0,
		constraint fk_userid FOREIGN KEY (userid) REFERENCES requsertable (userid), 
		constraint pk_reqid PRIMARY KEY (reqid));
		 
	-----------------
	DROP SEQUENCE id_maker_hund;
	CREATE SEQUENCE id_maker_hund 
		MINVALUE 100 
		START WITH 100 
		INCREMENT BY 1;
	-----------------
	DROP SEQUENCE id_maker;
	CREATE SEQUENCE id_maker 
		MINVALUE 1 
		START WITH 1 
		INCREMENT BY 1;
	-------------------      
	INSERT INTO reqtable VALUES (id_maker_hund.nextval, id_maker.nextval,'AWS','cert','Cloud tech','My dept requested it', '2020-01-16','Pittsburgh','testdefault','720', 360.00, 0);
	INSERT INTO reqtable VALUES (id_maker_hund.nextval, id_maker.nextval,'ORA','certprep','New Java 13 features','I am dept Head, but Im training up','2020-01-16','Pittsburgh','testcustom','80%',   300.00, 1);
	INSERT INTO reqtable VALUES (id_maker_hund.nextval, id_maker.nextval,'A++','course','University coursework for hardware/networking','Need Hardware retraining', '2020-01-16','Morgantown','testdefault','C+  university minimum',  700.00, 2);
	INSERT INTO reqtable VALUES (id_maker_hund.nextval, id_maker.nextval,'MSFT','techtrain','Microsoft Azure','New Years resolution',  '2020-01-16','Morgantown','presentation','presentation',  560.00, 1);
	SELECT * FROM reqtable; 
	COMMIT; 
	 
	--already admininistered
	--ALTER TABLE reqtable ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES  requsertable (userid) ON DELETE CASCADE; 

	----------------------------------------------------------add_new_reqtable
	--create or replace PROCEDURE add_new_reqtable(reqid NUMBER, userid NUMBER, reqName VARCHAR2, reqType VARCHAR2, reqDesc VARCHAR2,reqJustify VARCHAR2, reqDatetime VARCHAR2, reqPlace VARCHAR2,gradeType VARCHAR2, gradePass VARCHAR2, reqAmt NUMBER, stage NUMBER)
	--IS
	--BEGIN
	--INSERT INTO reqtable VALUES (id_maker_hund.nextval,reqid, userid, reqName, reqType, reqDesc, reqJustify, reqDatetime, reqPlace,gradeType, gradePass, reqAmt, stage); --id_maker.nextval, 
	--END;
	 
	---------------------------------------------------------------
	----------------TASKTABLE--------------------------------------
	 
	DROP TABLE reqtasktable; 
	CREATE TABLE reqtasktable (
		taskid NUMBER(5),                            --userid-->*relevant deptid-->*relevant deptheadid
		reqid NUMBER(5), --FOREIGN *reqtable.reqid :->*relevant userid-->*relevant supersid->
		curruserid NUMBER( 5),--current responsibility
		timestamp VARCHAR2 (40),
		currdocs VARCHAR2 (40),
		
		updatereason VARCHAR2 (200), --why change pprice
		updateReqType VARCHAR2 (40),--   override    -> *reqtable.reqtype
		updateGradeType VARCHAR2 (40),--  override   -> *reqtable.gradetype
		updateGradePass VARCHAR2 (40),--   override  -> *reqtable.gradepass
		updateAmt NUMBER (7,2), --benco change pprice  
		updateStage NUMBER (1) DEFAULT (0),
		constraint pk_taskid PRIMARY KEY (taskid),  
		constraint fk_reqid FOREIGN KEY (reqid) REFERENCES reqtable (reqid));
	SELECT * FROM reqtasktable;
	COMMIT;  

	DROP SEQUENCE id_maker;
	CREATE SEQUENCE id_maker 
		MINVALUE 1
		START WITH 1
		INCREMENT BY 1;

	DROP SEQUENCE id_maker_hund;
	CREATE SEQUENCE id_maker_hund 
		MINVALUE 100
		START WITH 100
		INCREMENT BY 1;
		
	DROP SEQUENCE id_maker_th; 
	CREATE SEQUENCE id_maker_th 
		MINVALUE 1000
		START WITH 1000
		INCREMENT BY 1;
	  
	INSERT INTO reqtasktable VALUES (id_maker_th.nextval,id_maker_hund.nextval,id_maker.nextval,'2020-01-06','dt', 'updatereason','updateReqType','testdefault','720', 260.00, 0);
	INSERT INTO reqtasktable VALUES (id_maker_th.nextval,id_maker_hund.nextval,id_maker.nextval,'2020-02-16','dt', 'updatereason','updateReqType','testcustom','80%',   250.00, 0);
	INSERT INTO reqtasktable VALUES (id_maker_th.nextval,id_maker_hund.nextval,id_maker.nextval,'2020-03-16','dt', 'updatereason','updateReqType','testdefault','C+  university minimum',  350.00, 0);
	INSERT INTO reqtasktable VALUES (id_maker_th.nextval,id_maker_hund.nextval,id_maker.nextval,'2020-04-16','dt', 'updatereason','updateReqType','presentation','presentation',  160.00, 0); 
	COMMIT;
	SELECT * FROM reqtasktable;

	-----------------------PROC------------add_new_tasktable 
	--create or replace PROCEDURE add_new_tasktable(reqId NUMBER, currUserId NUMBER,  timeStamp VARCHAR2, currDocs VARCHAR2, updateReason VARCHAR2,updateReqType VARCHAR2, updateGradeType VARCHAR2, updateGradePass VARCHAR2, updateAmt NUMBER, updateStage NUMBER)
	--IS
	--BEGIN
	--INSERT INTO reqtasktable VALUES (ID_MAKER_TH.nextval, reqId, currUserId, timeStamp, currDocs, updateReason, updateReqType, updateGradeType, updateGradePass, updateAmt, updateStage); --id_maker.nextval, 
	--END;



	----------------------------------------
	-----------------------------------------------
	--------------------reqcalculate---------------------------------
	--SELECT * from reqcalculate; 
	--DROP TABLE reqcalculate; 
	--CREATE TABLE reqcalculate (     
	--    id NUMBER(6),
	--    taskid NUMBER(6),
	--    reqid NUMBER(6), 
	--    username VARCHAR2(20), 
	--    reqamt NUMBER(10,2),  
	--    taskamt NUMBER(10,2),
	--    balance NUMBER (10,2),
	--    taskmos NUMBER(4), 
	--    monthsremaining NUMBER (4),
	--    monthlypayments NUMBER (4),
	--    constraint pk_conid PRIMARY KEY (id));
	----    constraint fk_taskid FOREIGN KEY (taskid) REFERENCES tasktable (taskid),
	----    constraint fk_username FOREIGN KEY (username) REFERENCES usertable (username),
	----    constraint fk_reqid FOREIGN KEY (reqid) REFERENCES reqtable (reqid),
	----    constraint fk_reqamt FOREIGN KEY (reqamt) REFERENCES reqtable (reqamt),
	----    constraint fk_taskamt FOREIGN KEY (taskamt) REFERENCES tasktable (taskamt),
	----    constraint fk_taskmos FOREIGN KEY (taskmos) REFERENCES tasktable (taskmos),
	--    
	----DROP SEQUENCE id_maker_th;
	--CREATE SEQUENCE id_maker_th 
	--    MINVALUE 1000 
	--    START WITH 1000 
	--    INCREMENT BY 1;
	--    
	----DROP SEQUENCE id_maker;
	--CREATE SEQUENCE id_maker 
	--    MINVALUE 1 
	--    START WITH 1 
	--    INCREMENT BY 1;
	--
	----DROP SEQUENCE id_maker2;
	--CREATE SEQUENCE id_maker2 
	--    MINVALUE 1 
	--    START WITH 1 
	--    INCREMENT BY 1;
	--
	----DROP SEQUENCE id_maker3;
	--CREATE SEQUENCE id_maker3 
	--    MINVALUE 1 
	--    START WITH 1 
	--    INCREMENT BY 1;
	--    DROP SEQUENCE id_maker3;
	--
	----DROP SEQUENCE id_maker4;
	--CREATE SEQUENCE id_maker4 
	--    MINVALUE 1 
	--    START WITH 1 
	--    INCREMENT BY 1;
	--INSERT INTO reqcalculate VALUES (id_maker.nextval_th, id_maker2.nextval, id_maker2.nextval,'usernameX',null,null,null,null, null,null); 
	--
	--INSERT INTO reqcalculate VALUES (100,1,1,1,null,null,null, null,null); 
	--COMMIT;
	--SELECT * FROM reqcalculate;
	--select * fROM reqtable;
	-------------------------PROC------------add_new_reqcalculate-----------
	--create or replace PROCEDURE add_new_reqcalculate( taskid NUMBER, reqid NUMBER, username VARCHAR2, reqamt NUMBER, taskamt NUMBER, balance NUMBER, taskmos NUMBER, monthsremaining NUMBER, monthlypayments NUMBER)
	--IS
	--BEGIN
	--INSERT INTO reqcalculate VALUES (id_maker.nextval, taskid, reqid, username, reqamt, taskamt, balance, taskmos, monthsremaining, monthlypayments); --id_maker.nextval, 
	--END;
	-------------------------PROC------------add_new_reqcalculate-----------


-- ########### PROJECT 2 [Oracle] BackEnd_Master (Oracle-thomas) 

--------------------------------------------------------
--  DDL for Table APPOINTMENT
--------------------------------------------------------

CREATE TABLE  "APPOINTMENT" 
   (	"A_ID" NUMBER(10,0), 
	"C_ID" NUMBER(10,0), 
	"P_ID" NUMBER(10,0), 
	"E_ID" NUMBER(10,0), 
	"WEIGHT" NUMBER(10,0), 
	"A_DESCRIPTION" VARCHAR2(100 BYTE), 
	"TIME_SLOT" NUMBER(10,0), 
	"A_DATE" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into APPOINTMENT
SET DEFINE OFF;

--------------------------------------------------------
--  DDL for Table ASSOCIATE
--------------------------------------------------------

  CREATE TABLE "ADMIN"."ASSOCIATE" 
   (	"A_ID" NUMBER(10,0), 
	"NAME" VARCHAR2(20 BYTE), 
	"POINTS" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into ADMIN.ASSOCIATE
SET DEFINE OFF;
Insert into ADMIN.ASSOCIATE (A_ID,NAME,POINTS) values (54,'ryan',100);
Insert into ADMIN.ASSOCIATE (A_ID,NAME,POINTS) values (55,'ryan',100);
--------------------------------------------------------
--  DDL for Index SYS_C004245
--------------------------------------------------------

--------------------------------------------------------
--  DDL for Table CUSTOMER
--------------------------------------------------------
DROP TABLE "CUSTOMER";
  CREATE TABLE "CUSTOMER" 
   (	"C_ID" NUMBER(10,0), 
	"FNAME" VARCHAR2(50 BYTE), 
	"LNAME" VARCHAR2(50 BYTE), 
	"PHONE" VARCHAR2(20 BYTE), 
	"EMAIL" VARCHAR2(50 BYTE), 
	"PASS" VARCHAR2(20 BYTE), 
	"CUS_URL" VARCHAR2(500 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into CUSTOMER
SET DEFINE OFF;

--------------------------------------------------------
--  DDL for Table EMPLOYEE
--------------------------------------------------------

  CREATE TABLE "EMPLOYEE" 
   (	"E_ID" NUMBER(10,0), 
	"E_TYPE" NUMBER(10,0), 
	"FNAME" VARCHAR2(50 BYTE), 
	"LNAME" VARCHAR2(50 BYTE), 
	"PHONE" VARCHAR2(20 BYTE), 
	"EMAIL" VARCHAR2(50 BYTE), 
	"PASS" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into EMPLOYEE
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Table NOTE
--------------------------------------------------------

  CREATE TABLE "NOTE" 
   (	"N_ID" NUMBER(10,0), 
	"A_ID" NUMBER(10,0), 
	"P_ID" NUMBER(10,0), 
	"N_MESSAGE" VARCHAR2(4000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into NOTE
SET DEFINE OFF;


--------------------------------------------------------
--  DDL for Table PET
--------------------------------------------------------

  CREATE TABLE "PET" 
   (	"P_ID" NUMBER(10,0), 
	"C_ID" NUMBER(10,0), 
	"P_NAME" VARCHAR2(50 BYTE), 
	"P_WEIGHT" NUMBER(10,0), 
	"P_COLOR" VARCHAR2(50 BYTE), 
	"P_TYPE" NUMBER(10,0), 
	"P_BREED" VARCHAR2(30 BYTE), 
	"NEUTER" NUMBER(1,0) DEFAULT 0, 
	"P_DESCRIPTION" VARCHAR2(100 BYTE), 
	"PET_URL" VARCHAR2(500 BYTE), 
	"DOB" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into PET
SET DEFINE OFF;


--------------------------------------------------------
--  DDL for Table VACC_RECORD
--------------------------------------------------------

  CREATE TABLE "VACC_RECORD" 
   (	"R_ID" NUMBER(10,0), 
	"P_ID" NUMBER(10,0), 
	"VNAME" VARCHAR2(100 BYTE), 
	"VTIME" NUMBER(10,0), 
	"VDATE" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into VACC_RECORD
SET DEFINE OFF;
  
  ALTER TABLE "VACC_RECORD" ADD PRIMARY KEY ("R_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  DDL for Table VACCINATION
--------------------------------------------------------

  CREATE TABLE "VACCINATION" 
   (	"V_ID" NUMBER(10,0), 
	"V_NAME" VARCHAR2(255 CHAR), 
	"P_TYPE" NUMBER(10,0), 
	"V_TIME" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into VACCINATION
SET DEFINE OFF;
######################### END PROJECT 2 ###################


-- ###########  PROJECT 3 [PostgreSQL] 
### USERS ###
create table public.users (
	user_id INT,
	email VARCHAR(50),
	first_name VARCHAR(50),
	is_accepting_rides VARCHAR(50),
	is_active VARCHAR(50),
	is_driver VARCHAR(50),
	last_name VARCHAR(50),
	phone_number VARCHAR(50),
	user_name TEXT,
	batch_number INT,
	h_address VARCHAR(50),
	w_address VARCHAR(50)
);
insert into public.users (user_id, email, first_name, is_accepting_rides, is_active, is_driver, last_name, phone_number, user_name, batch_number, h_address, w_address) values (1, 'ccarlin0@businessweek.com', 'Carma', true, true, true, 'Carlin', '195-561-9291', 'error: Please use field(''UNIQUE'') to access UNIQUE because it starts with an upper case letter.', 7, '7 Springview Lane', '59 Vera Drive');
insert into public.users (user_id, email, first_name, is_accepting_rides, is_active, is_driver, last_name, phone_number, user_name, batch_number, h_address, w_address) values (2, 'cbrazenor1@yahoo.co.jp', 'Caldwell', true, false, false, 'Brazenor', '301-272-3200', 'error: Please use field(''UNIQUE'') to access UNIQUE because it starts with an upper case letter.', 19, '6 Troy Plaza', '97 Delladonna Crossing');
insert into public.users (user_id, email, first_name, is_accepting_rides, is_active, is_driver, last_name, phone_number, user_name, batch_number, h_address, w_address) values (3, 'cglavis2@abc.net.au', 'Cosette', false, true, false, 'Glavis', '109-578-0202', 'error: Please use field(''UNIQUE'') to access UNIQUE because it starts with an upper case letter.', 7, '50771 Homewood Plaza', '6 Johnson Point');
insert into public.users (user_id, email, first_name, is_accepting_rides, is_active, is_driver, last_name, phone_number, user_name, batch_number, h_address, w_address) values (4, 'bdenisevich3@forbes.com', 'Berrie', false, false, true, 'Denisevich', '833-182-5364', 'error: Please use field(''UNIQUE'') to access UNIQUE because it starts with an upper case letter.', 17, '83 Stuart Court', '57499 1st Lane');
insert into public.users (user_id, email, first_name, is_accepting_rides, is_active, is_driver, last_name, phone_number, user_name, batch_number, h_address, w_address) values (5, 'aconigsby4@squidoo.com', 'Ariela', false, true, false, 'Conigsby', '883-888-4268', 'error: Please use field(''UNIQUE'') to access UNIQUE because it starts with an upper case letter.', 12, '51980 Mallard Way', '687 Little Fleur Court');

--#########   added: h_address, w_address
ALTER TABLE users
ADD COLUMN h_address VARCHAR;
ALTER TABLE users
ADD COLUMN w_address VARCHAR;
######################### END PROJECT 2 ###################


#################################################################
-- ########### SQL UDEMY COURSE #################
create table dept(
  deptno number(2,0),
  dname  varchar2(14),
  loc    varchar2(13),
  constraint pk_dept primary key (deptno)
);
 
create table emp(
  empno    number(4,0),
  ename    varchar2(10),
  job      varchar2(9),
  mgr      number(4,0),
  hiredate date,
  sal      number(7,2),
  comm     number(7,2),
  deptno   number(2,0),
  constraint pk_emp primary key (empno),
  constraint fk_deptno foreign key (deptno) references dept (deptno)
);


DECLARE

BEGIN

insert into dept
values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept
values(20, 'RESEARCH', 'DALLAS');
insert into dept
values(30, 'SALES', 'CHICAGO');
insert into dept
values(40, 'OPERATIONS', 'BOSTON');
 
insert into emp
values(
 7839, 'KING', 'PRESIDENT', null,
 to_date('17-11-1981','dd-mm-yyyy'),
 5000, null, 10
);
insert into emp
values(
 7698, 'BLAKE', 'MANAGER', 7839,
 to_date('1-5-1981','dd-mm-yyyy'),
 2850, null, 30
);
insert into emp
values(
 7782, 'CLARK', 'MANAGER', 7839,
 to_date('9-6-1981','dd-mm-yyyy'),
 2450, null, 10
);
insert into emp
values(
 7566, 'JONES', 'MANAGER', 7839,
 to_date('2-4-1981','dd-mm-yyyy'),
 2975, null, 20
);
insert into emp
values(
 7788, 'SCOTT', 'ANALYST', 7566,
 to_date('9-12-1981','dd-mm-yyyy'),
 3000, null, 20
);
insert into emp
values(
 7902, 'FORD', 'ANALYST', 7566,
 to_date('3-12-1981','dd-mm-yyyy'),
 3000, null, 20
);
insert into emp
values(
 7369, 'SMITH', 'CLERK', 7902,
 to_date('17-12-1980','dd-mm-yyyy'),
 800, null, 20
);
insert into emp
values(
 7499, 'ALLEN', 'SALESMAN', 7698,
 to_date('20-2-1981','dd-mm-yyyy'),
 1600, 300, 30
);
insert into emp
values(
 7521, 'WARD', 'SALESMAN', 7698,
 to_date('22-2-1981','dd-mm-yyyy'),
 1250, 500, 30
);
insert into emp
values(
 7654, 'MARTIN', 'SALESMAN', 7698,
 to_date('28-9-1981','dd-mm-yyyy'),
 1250, 1400, 30
);
insert into emp
values(
 7844, 'TURNER', 'SALESMAN', 7698,
 to_date('8-9-1981','dd-mm-yyyy'),
 1500, 0, 30
);
insert into emp
values(
 7876, 'ADAMS', 'CLERK', 7788,
 to_date('12-1-1983', 'dd-mm-yyyy'),
 1100, null, 20
);
insert into emp
values(
 7900, 'JAMES', 'CLERK', 7698,
 to_date('3-12-1981','dd-mm-yyyy'),
 950, null, 30
);
insert into emp
values(
 7934, 'MILLER', 'CLERK', 7782,
 to_date('23-1-1982','dd-mm-yyyy'),
 1300, null, 10
);
 
/*
insert into salgrade
values (1, 700, 1200);
insert into salgrade
values (2, 1201, 1400);
insert into salgrade
values (3, 1401, 2000);
insert into salgrade
values (4, 2001, 3000);
insert into salgrade
values (5, 3001, 9999);
*/
 
COMMIT;

END;

