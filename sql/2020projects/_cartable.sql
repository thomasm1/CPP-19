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

--------------------------------------------------------------------
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
------------------------------------------------------------------