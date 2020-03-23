
-- Union
SELECT * FROM electrolot;
SELECT * FROM archived_electrolot;

-- Clone-copy
CREATE TABLE archived_electrolot AS SELECT * FROM electrolot;

--DROP TABLE archived_electrolot;
INSERT INTO archived_electrolot VALUES (61, 'Eevee', 'The cutest electrolot');
commit;

SELECT * FROM electrolot UNION SELECT * FROM archived_electrolot;
SELECT * FROM electrolot UNION ALL SELECT * FROM archived_electrolot;

SELECT * FROM electrolot INTERSECT SELECT * FROM archived_electrolot; --(leaves out unmatching)

SELECT * FROM electrolot MINUS SELECT * FROM archived_electrolot; --(leaves out 2nd_table's extras)
SELECT * FROM archived_electrolot MINUS SELECT * FROM electrolot; --(reveals 1st_tables' extras)


--------------------------------------------

DROP TABLE p_matcher;
DROP TABLE p_statistics;
DROP TABLE p_types;
DROP TABLE electrolot;

CREATE TABLE electrolot (
    p_id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    bio VARCHAR2(200));
    
CREATE TABLE archived_electrolot (
    p_id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    bio VARCHAR2(200));
    
CREATE TABLE p_types (
    t_id NUMBER(10) PRIMARY KEY,
    type VARCHAR(20));
    
CREATE TABLE p_statistics (
    p_id NUMBER(10),
    lvl NUMBER(10) DEFAULT 1,
    hp NUMBER(10),
    attack NUMBER(10),
    defense NUMBER(10),
    shiny NUMBER(1) DEFAULT 0,
    CONSTRAINT fk_stats_electrolot FOREIGN KEY (p_id) 
    REFERENCES electrolot(p_id) ON DELETE CASCADE);
    
CREATE TABLE p_matcher (
    p_id NUMBER(10),
    t_id NUMBER(10),
    CONSTRAINT fk_pt_electrolot FOREIGN KEY (p_id)
    REFERENCES electrolot(p_id) ON DELETE CASCADE,
    CONSTRAINT fk_pt_type FOREIGN KEY (t_id)
    REFERENCES p_types(t_id) ON DELETE CASCADE);
    


------------------------
-- dual table

CREATE TABLE dual (
    dummy VARCHAR2(1));
    
INSERT INTO dual VALUES ('X');

SELECT * FROM dual;
    
SELECT 1 FROM dual;

SELECT 1+1 FROM dual;

SELECT SYSDATE FROM archived_electrolot WHERE ROWNUM = 1;

SELECT SYSDATE FROM dual;

SELECT USER FROM dual;

SELECT USER FROM archived_electrolot WHERE ROWNUM = 1;


------------------------------------

-- Procedures OUT parameters

CREATE OR REPLACE PROCEDURE convertTypesToIds(type1 IN VARCHAR2, type2 IN VARCHAR2, t_id1 OUT NUMBER, t_id2 OUT NUMBER)
IS
BEGIN
SELECT t_id INTO t_id1 FROM p_types WHERE type = type1 AND ROWNUM = 1;
IF type2 IS NOT NULL
THEN
SELECT t_id INTO t_id2 FROM p_types WHERE type = type2 AND ROWNUM = 1;
ELSE
SELECT -1 INTO t_id2 FROM dual;
END IF;
END;


CREATE OR REPLACE PROCEDURE add_electrolot2(name IN VARCHAR2, bio IN VARCHAR2, type1 IN VARCHAR2, type2 IN VARCHAR2)
IS
t_id1 NUMBER(10);
t_id2 NUMBER(10);
BEGIN
convertTypesToIds(type1, type2, t_id1, t_id2);
add_electrolot(name, bio, t_id1, t_id2);

commit;
END;

CALL add_electrolot2('Venasaur','The third electrolot','Grass','Poison');
CALL add_electrolot2('Seaking','The bigger goldfish electrolot','Water',null);

SET serveroutput on;
DECLARE
t_id1 NUMBER(10);
t_id2 NUMBER(10);
BEGIN
convertTypesToIds('Water', null, t_id1, t_id2);
dbms_output.put_line(t_id2);
END;


SELECT * FROM electrolot;
SELECT * FROM p_statistics;
SELECT * FROM p_matcher;
SELECT * FROM p_types;

CREATE OR REPLACE PROCEDURE add_new_electrolot(name VARCHAR2, bio VARCHAR2)
IS
BEGIN
    INSERT INTO electrolot VALUES (id_maker.nextval, name, bio);
END;

CALL add_new_electrolot('Ditto','The copy electrolot');
commit;

SELECT * FROM electrolot;



