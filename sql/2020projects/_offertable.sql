CREATE OR REPLACE PROCEDURE register_user(username VARCHAR2, password VARCHAR2, fullname VARCHAR2, iscust NUMBER, isowner NUMBER)
IS
BEGIN
INSERT INTO usertable VALUES (id_maker.nextval, username, password, fullname, iscust, isowner);
END;
---------paytable-------------------------------------------------
---------------------------------------------------------------
balance NUMBER (7,2) DEFAULT (0.00),
        balmos NUMBER (2),
    
---------USERTABLE-------------------------------------------------
---------------------------------------------------------------
 
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

--------CARTABLE-------------------------------------------------
---------------------------------------------------------------

DROP TABLE cartable; 

CREATE TABLE cartable (
    carid NUMBER(4), 
    carmake VARCHAR2 (20),
    carmodel VARCHAR2 (20),
    pricetotal NUMBER(7,2),  
    purchased NUMBER(1) DEFAULT 0,
    constraint pk_cid PRIMARY KEY (carid));
 
INSERT INTO cartable VALUES (id_maker.nextval,'Ford', 'Focus', 36000.00, 0);
INSERT INTO cartable VALUES (id_maker.nextval,'Tesla', 'Cyber-Truck', 38000.00, 0);
INSERT INTO cartable VALUES (id_maker.nextval,'Chevrolet', 'Corvette', 70000.00, 0);
INSERT INTO cartable VALUES (id_maker.nextval,'Jeep', 'Wrangler', 56000.00, 0);
SELECT * FROM cartable;
commit; 

------OFFERTABLE----------------------------------------------
---------------------------------------------------------------

DROP TABLE offer_type;
DROP TABLE otype;
DROP TABLE ostats;
DROP TABLE offertable; 

CREATE TABLE offertable (
    offerid NUMBER(4),
    username VARCHAR2(20), --FOREIGN user_id of offer
    carid NUMBER(4), --FOREIGN car_id of offer 
--    carprice NUMBER (7,2), --FOREIGN car_price
    offeramount NUMBER(7,2), 
    offermos NUMBER(2),
    offerstatus VARCHAR2 (20),
    constraint pk_oid PRIMARY KEY (offerid),
--    constraint fk_cprice FOREIGN KEY (c_price) REFERENCES cartable (carprice),
    constraint fk_uid FOREIGN KEY (username) REFERENCES usertable (username),
    constraint fk_cid FOREIGN KEY (carid) REFERENCES cartable (carid));
SELECT * FROM offertable;

DROP SEQUENCE id_maker;
CREATE SEQUENCE id_maker 
    MINVALUE 1 
    START WITH 1 
    INCREMENT BY 1;
INSERT INTO offertable VALUES (id_maker.nextval, 10, 8, 2000.00, 18, 'OFFER_CANCELED');
INSERT INTO offertable VALUES (id_maker.nextval, 11, 5, 3000.00, 0, 'OFFER_DECLINED');
INSERT INTO offertable VALUES (id_maker.nextval, 12, 6, 4000.00, 18, 'OFFER_ACCEPTED');
INSERT INTO offertable VALUES (id_maker.nextval, 13, 7, 1000.00, 36, 'OFFER_PENDING'); 
SELECT * FROM offertable;
commit;


----------------
CREATE TABLE otype (
    status_id NUMBER(10),
    o_status VARCHAR2(20),
    constraint pk_status_id PRIMARY KEY (status_id));
    
CREATE TABLE ostats (
    ostats_id NUMBER(10) PRIMARY KEY,
    lvl NUMBER(10) DEFAULT 1,
    hp NUMBER(10),
    attack NUMBER(10),
    defense NUMBER(10),
    cp NUMBER(10),
    shiny NUMBER(1) DEFAULT 0,
    constraint fk_ostats_id FOREIGN KEY (ostats_id) references offertable (o_id));
     
CREATE TABLE offer_type (
    oo_id NUMBER(10),
    ss_id NUMBER(10),
    constraint fk_oo_idtype FOREIGN KEY (oo_id) references ostats (ostats_id),
    constraint fk_ss_idtype FOREIGN KEY (ss_id) references otype (status_id));
 
--ALTER TABLE ostats DROP CONSTRAINT fk_ostats_offer;
--ALTER TABLE ostats ADD CONSTRAINT fk_ostats_offer FOREIGN KEY
--(o_id) REFERENCES offer(o_id) ON DELETE CASCADE;
--
--DROP SEQUENCE id_maker;
--CREATE SEQUENCE id_maker 
--    MINVALUE 1 
--    START WITH 1 
--    INCREMENT BY 1;
--INSERT INTO otype VALUES(id_maker.nextval, 'OFFER_PENDING');
--INSERT INTO otype VALUES(id_maker.nextval, 'OFFER_CANCELED');
--INSERT INTO otype VALUES(id_maker.nextval, 'OFFER_DECLINED'); 
--INSERT INTO otype VALUES(id_maker.nextval, 'OFFER_ACCEPTED');
-- 
-- 
--DROP SEQUENCE id_maker; 
--CREATE SEQUENCE id_maker 
--    MINVALUE 1 
--    START WITH 1 
--    INCREMENT BY 1;
--INSERT INTO ostats VALUES (id_maker.nextval, 5, 5, 5, 5, 15, 0); 
--INSERT INTO ostats VALUES (id_maker.nextval, 5, 5, 5, 5, 15, 0);
--INSERT INTO ostats VALUES (id_maker.nextval, 5, 5, 5, 5, 15, 0); 
--INSERT INTO ostats VALUES (id_maker.nextval, 5, 5, 5, 5, 15, 0);
--
--DROP SEQUENCE id_maker; 
--CREATE SEQUENCE id_maker 
--    MINVALUE 1 
--    START WITH 1 
--    INCREMENT BY 1;
----INTRO id_maker1 
--CREATE SEQUENCE id_maker1 
--    MINVALUE 1 
--    START WITH 1 
--    INCREMENT BY 1;    
--
--INSERT INTO offer_type VALUES(id_maker.nextval, id_maker1.nextval);
--INSERT INTO offer_type VALUES(id_maker.nextval, id_maker1.nextval);
--INSERT INTO offer_type VALUES(id_maker.nextval, id_maker1.nextval); 
--INSERT INTO offer_type VALUES(id_maker.nextval, id_maker1.nextval); 
--
--DROP SEQUENCE id_maker; --last id_maker
--DROP SEQUENCE id_maker1; --last id_maker1
-------------
--select * from offertable;
--select * from otype;
--select * from ostats;
--select * from offer_type; 
-------------
--commit; 