CREATE OR REPLACE PROCEDURE register_user(username VARCHAR2, password VARCHAR2, fullname VARCHAR2, iscust NUMBER, isowner NUMBER)
IS
BEGIN
INSERT INTO usertable VALUES (id_maker.nextval, username, password, fullname, iscust, isowner);
END;
---------FINANCIALS
balance NUMBER (7,2) DEFAULT (0.00),
        balmos NUMBER (2),
    
---------USERTABLE
 
DROP TABLE usertable;

CREATE TABLE usertable (
    userid NUMBER(10),
    username VARCHAR2(20) NOT NULL,
    password VARCHAR2 (20) NOT NULL,
    fullname VARCHAR2(200),
    iscust NUMBER (1) DEFAULT (1) NOT NULL,
        isowner NUMBER (1) DEFAULT (0),
        constraint pk_uid PRIMARY KEY (u_id));

INSERT INTO usertable VALUES (id_maker.nextval, 'myUserName0', 'myPassword0', 'myFullName0',0,0);
INSERT INTO usertable VALUES (id_maker.nextval, 'myUserName1', 'myPassword1', 'myFullName1',1,0);
INSERT INTO usertable VALUES (id_maker.nextval, 'myUserName2', 'myPassword2', 'myFullName2',1,0);
INSERT INTO usertable VALUES (id_maker.nextval, 'myUserName3', 'myPassword3', 'myFullName3',1,1);  
commit;
SELECT * FROM usertable;
SELECT * FROM cartable;



--CREATE TABLE utype (
--    t_id NUMBER(10),
--    type VARCHAR(20),
--    constraint pk_tid PRIMARY KEY (t_id));
    
--CREATE TABLE ustats (
--    u_id NUMBER(10) PRIMARY KEY,
--    lvl NUMBER(10) DEFAULT 1,
--    hp NUMBER(10),
--    attack NUMBER(10),
--    defense NUMBER(10),
--    cp NUMBER(10),
--    shiny NUMBER(1) DEFAULT 0,
--    constraint fk_uid FOREIGN KEY (u_id) references usertable (u_id));
     
--CREATE TABLE user_type (
--    u_id NUMBER(10),
--    t_id NUMBER(10),
--    constraint fk_uidtype FOREIGN KEY (u_id) references ustats (u_id),
--    constraint fk_tidtype FOREIGN KEY (t_id) references utype (t_id));

--ALTER TABLE ustats DROP CONSTRAINT fk_ustats_user;
--ALTER TABLE ustats ADD CONSTRAINT fk_ustats_user FOREIGN KEY
--(u_id) REFERENCES user(u_id) ON DELETE CASCADE;
 


--DROP SEQUENCE id_maker;
--CREATE SEQUENCE id_maker 
--    MINVALUE 1 
--    START WITH 1 
--    INCREMENT BY 1;
--INSERT INTO utype VALUES(id_maker.nextval, 'cust');
--INSERT INTO utype VALUES(id_maker.nextval, 'cust'); 
--INSERT INTO utype VALUES(id_maker.nextval, 'emp'); 
--INSERT INTO utype VALUES(id_maker.nextval, 'emp'); 
 