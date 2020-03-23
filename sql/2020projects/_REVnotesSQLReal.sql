
#########################################################

########## 2  REVATURE NOTES SQL         ################ 

### ORACLE
https://docs.oracle.com/cd/E11882_01/index.htm
https://docs.oracle.com/en/database/oracle/oracle-database/18/sqlrf/INSERT.html#GUID-903F8043-0254-4EE9-ACC1-CB8AC0AF3423
### https://mystery.knightlab.com/

#########
SQL Day 1
######### 

RDBMS - Relational Database Management System
	- software designed to manage a database
	- Examples: Oracle SQL, PostGreSQL, MySQL, mariaDB, Amazon Aurora,
	Windows SQL Server, etc....

Database - A collection of object designed to hold information

Relational Database - A database which holds information in tables related to each other.

table - composed of columns (fields) which hold attributes and rows (records) which model
an instance.

SQL - Structured Query Language
	- used for managing data held inside an RDBMS
	- Freedom to choose how much code is executed at a time.

Schema - group of DB related objects

Cursor - result set of a SQL query

View - Virtual table based on the result of a query.

SQL has 5 sublanguages

	- Data Definition Language (DDL)
		- Defines the rules and structures of a database
		- Create, Alter, Rename, Drop, Truncate
ON DELETE CASCADE means if the parent record is deleted, then any referencing child records are also deleted. ON UPDATE defaults to RESTRICT, which means the UPDATE on the parent record will fail. 2) ON DELETE action defaults to RESTRICT, which means the DELETE on the parent record will fail.

	- Data Manipulation Language (DML)
		- Adds, removes, or edits data in the database
		- Insert, Delete, Update

	- Data Query Language (DQL)
		- For reading information
		- Select

	- Data Control Language (DCL)
		- For granting permissions to users
		- Grant, Revoke

	- Transaction Control Language (TCL)
		- For generating transactions
		- Commit, rollback, savepoint

---------------------SQL-1------#################

--This is a comment. Uses the double dash '--'
-- SQL is NOT case sensitive. Note though, a lot of SQL keywords
-- are commonly written in UPPERCASE.
-- SELECT == select = SeLeCt
-- SQL is a scripting language. We do not have to compile it.
-- SQL is a query language. Which means I can run independent chunks
-- of code.

-- DDL statement
DROP TABLE pocketable;

-- DDL statements autocommit.
CREATE TABLE pocketable ( 
    p_id NUMBER(10),
    name VARCHAR2(20),
    type VARCHAR2(50),
    bio VARCHAR2(500),
    lvl NUMBER(10),
    shiny NUMBER(1));
    
SELECT * FROM pocketable;

-- DML which does not autocommit.
INSERT INTO pocketable VALUES (1, 'Bulbasaur', 'Grass/Poison', 'The first Pokemon', 5, 0);
INSERT INTO pocketable VALUES (111, 'Mudkip', 'Water', 'He cute pokemanz', 5, 1);
INSERT INTO pocketable VALUES (151, 'Mew', 'Psychic', 'The first legendary', 35, 0);
delete from pocketable where p_id = 69;
-- INSERT INTO pocketable VALUES (69, 'Exeggcute', 'Grass/Psychic', 'This PokEmon consists of six eggs that form a closely knit cluster.', 5, 0);
INSERT INTO pocketable VALUES (150, 'Mewtwo', 'Psychic', 'Genetic Pokemon', 9, 1);
INSERT INTO pocketable VALUES (7, 'Aipom', 'Normal', 'Three handed monkey', 100, 0);
INSERT INTO pocketable VALUES (2, 'Charmander', 'Fire', 'It breathes fire.', 6, 0);
INSERT INTO pocketable VALUES (11, 'Zubat', 'Flying/Poison', 'bat thing', 5, 1);
INSERT INTO pocketable VALUES (8, 'Raichu', 'Electric', 'The Originals', 1, 1);
INSERT INTO pocketable VALUES (25,'Hitmonchan','Fighting','Steroids are strong with this one',100,1);
INSERT INTO pocketable VALUES (106, 'Hitmonleee', 'Fighting', 'The kicking fiend', 23, 0);
INSERT INTO pocketable VALUES (99,'Charizard', 'Fire', 'https://bulbapedia.bulbagarden.net/wiki/File:006Charizard.png', 10,0);

commit;
--rollback;

-- To remove records from a table you have options
-- DELETE removes data from a table. Does not remove the table.

-- DML, manipulating the data in the table
--DELETE pocketable;
--commit;

-- DELETE pocketable WHERE lvl > 10;
-- DELETE pocketable WHERE p_id NOT BETWEEN 50 AND 125;

-- Truncate Table performs the same action as DELETE

-- This is DDL, why?
--TRUNCATE TABLE pocketable;

SELECT name,lvl FROM pocketable;

SELECT p_id,name,lvl FROM pocketable WHERE lvl >= 10;
SELECT p_id,name,lvl FROM pocketable WHERE name = 'Aipom';
--For fun
SELECT p_id,name,lvl FROM pocketable WHERE REGEXP_LIKE (name, '^[A-C]+');

--Aliases
SELECT p.name,p.lvl FROM pocketable p WHERE p.name = 'Aipom';

-- DML, not autocommited.
UPDATE pocketable SET lvl = 100 WHERE p_id > 50;
commit;

-- Aggregate function is going to calculate some value using multiple
-- records
-- AVG, MAX, MIN, SUM, COUNT

SELECT MAX(lvl), MIN(p_id) FROM pocketable;

SELECT COUNT(shiny) FROM pocketable WHERE shiny = 1;

-- GROUP BY is used with aggregate functions to break records into
-- groups/buckets

SELECT type,COUNT(type),ROUND(AVG(lvl), 0) FROM pocketable GROUP BY type;
SELECT lvl,COUNT(lvl) FROM pocketable GROUP BY lvl;
SELECT MOD(p_id,5),AVG(lvl),COUNT(p_id) FROM pocketable GROUP BY MOD(p_id,5);


-- HAVING is an extra clause we use with GROUP BY becuase Oracle wont
-- let you use WHERE. WHERE filters out records to return, but GROUP BY
-- doesn't return records.

SELECT type,COUNT(type),AVG(lvl) FROM pocketable GROUP BY type HAVING type LIKE 'F%';
SELECT type,COUNT(type),AVG(lvl) FROM pocketable GROUP BY type HAVING type LIKE '%c';


-- ORDER BY only changes the way in which the table is displayed.
-- Not what records you return;

SELECT p_id,name,lvl FROM pocketable ORDER BY name;
SELECT p_id,name,lvl FROM pocketable ORDER BY lvl desc;

SELECT type,COUNT(type),AVG(lvl) FROM pocketable GROUP BY type ORDER BY AVG(p_id);

--Subqueries
SELECT * FROM pocketable WHERE lvl = (SELECT MIN(lvl) FROM pocketable);
UPDATE pocketable SET lvl = 50 WHERE lvl = (SELECT MIN(lvl) FROM pocketable);


SELECT * FROM (SELECT p_id,name,lvl FROM pocketable ORDER BY lvl desc) WHERE ROWNUM <= 6;

-- Not the same
SELECT p_id,name,lvl FROM pocketable WHERE ROWNUM <=6 ORDER BY lvl desc;
###########--------------------------------
###########--------------------------------
###########--------------------------------


 
###########
--SQL Day 2
###########

--COPY TABLE--
CREATE TABLE archived_pocketable AS SELECT * FROM pocketable;
INSERT INTO new_table SELECT * FROM original_table;
--
CREATE TABLE - does exactly that
DROP TABLE - destroy a table
Truncate TABLE - essentially deletes all data from a table, by dropping the table
		and recreating it.
DELETE - deleting data from a table

INSERT INTO - adding data to a table			C
SELECT - retrieve data or records from a table		R
UPDATE SET - update records in a table			U
DELETE - removing data					D

WHERE - an extra clause to specify which records to return

GROUP BY - is used to group records into groups/buckets
HAVING - is used with GROUP BY in place of a WHERE clause,
	since you can't filter rows, but instead can filter whole groups

ORDER BY - sort your records based on a field.

desc - reverses the order used by ORDER BY

LIKE - return all strings of a certain pattern

NOT - opposite of whatever follows

BETWEEN (with AND) to specify a range of values

IN - specify a set of values

commit - finalize a transaction
rollback - undo everything in the current transaction

----------------------------------------------------

Alias - a way to simplify the name of a table.
Aggregate Functions - returns a single output from an array of inputs
	- AVG, SUM, COUNT, MAX, MIN
Scalar Functions - returns a single output from a single input
	- round, trim, substr, to_char

----------------------------------------------------

Constraints - rules used to specify what data can be added to a column.

	- Primary Key - Unique identifier. Used to identify each record.
			- combination of Unique and Not Null Keys. 
	- Foreign Key - Used to establish a relationship between another table with a Primary Key. 
	- Default Key - Specifies a default value for a column 
	- Not Null Key - ensures that values in the column can not be null 
	- Unique Key - Ensures that values in the column are unique  
	- Check Key - Checks the data being inserted across some value 
	- Composite Key - Primary key made up of 2 or more fields.

--------------------------------------------

Orphan Record - Record that references a key that no longer exists.

Referential Integrity - Principle that foreign keys a in table referring to
another table should ALWAYS refer to a valid row in that referred-to table.
 
---------------SQL-2-----------------#### 
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

--#### DQL: Data Query Language - SELECT
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
---------------####################################### ###### 


##########
SQL Day 3
######### 
Multiplicities (relations between tables)

	3 Types:
		- 1-to-1 relationship - pokemon - stats
		- 1-to-Many relationship - pokemon - trainer
					 - User - Car
		- Many-to-Many relationship - pokemon - type
			- Many to Many relationships should use a Junction Table


Entity Relationship Diagram
	- Data modeling technique that represents the relationship between tables
	and illustrates the entity framework.

-------------------------------------------------

Normalization - Process of reducing redundancy in a database
(not always desirable)

	1NF - 
	- All data is atomic
	- Each record is uniquely identifiable

	2NF -
	- There are no functional dependencies
		- This means that no data **needed for calculating** from other data in a table.
	- Also in 1NF

	3NF -
	- There are no transitive dependencies
		- You can find **no data** of a particular value somewhere else in the database.
	- Also in 2NF

----------------------------------------------------

JOINS  ==> HORIZONTALLY
 
-- Joins 
-- Everything after the FROM statement is just a virtual table
-- The idea of a join is to mold together two or more virtual tables.

Joins - Combine two tables HORIZONTALLY based on some type of predicate
	
	- ex: - "ON pokemon.p_id = stats.p_id"

	- Left Join
	- Right Join
	- Cross Join
	- Natural Join-- all columns in the two tables that have the same name and data types.
	- Full Outer Join  Outer Join
	- Inner Join
	- Theta Join-- allows for arbitrary comparison relationships (such as ≥). 

--------------------------------------------------

Transactions - A logical unit of SQL commands

	** Oracle's transaction SHOULD obey ACID **

A - Atomic - all statements in a transaction succeed or none of them do.
C - Consistent - The database moves from one consistent committed state to another.
I - Isolated - Concurrent transactions do not cause consistency issues.
D - Durable - Transactions fail gracefully and do not cause your database to crash
	or something to happen.
 
Procedure 

-- is just a set of SQL commands
-- essentially a script
-- Have 0 to Many inputs
-- Have 0 to Many outputs
-- Can manipulate data in the database. 

Function
-- A Function does not change values in a table
-- it MUST have inputs and EXACTLY 1 output. - 1 to Many inputs

Triggers
--Triggers are an Object that listens
--for an event to occur and executes when it does.

------SQL 3--------#############

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


 

##########
SQL Day 4
######### 

UNIONS ==> VERTICALLY

Set Operators in SQL
	- Union, Union All, Intersect, Minus (in other SQL languages this is Except)
	- They combine two table VERTICALLY
	- They join the records not the fields
	- These tables MUST have the same number and type of fields

------------------------------------------------------

DUAL/dual table
	- Special 1-row, 1-column table.
		- The column is called DUMMY
		- The values inside the 1 row is X.

------------------------------------------------------
http://tutorials.jenkov.com/jdbc
JDBC - Java Database Connectivity: The Java JDBC API is part of the core Java SE SDK.
public static void main(String[] args) throws ClassNotFoundException {
	Class.forName("org.h2.Driver"); 
	String url      = "jdbc:h2:~/test";   //database specific url.
	String user     = "sa";
	String password = ""; 
	
	try(Connection myConnection = DriverManager.getConnection(url, user, password)) { // Try-With-Res.
	myConnection.setAutoCommit(false);
		try(Statement myStatement = myConnection.createStatement()){
			String sql = "select * from people"; 
			try(ResultSet myResult = myStatement.executeQuery(sql)){
				while(myResult.next()) {
					String name = myResult.getString("name");
					long   age  = myResult.getLong  ("age");					
				}//=endwhile    
			}//endResult= 
		}//endStatement
		finally { if(myStatement !=null){ myStatement.clos(); }
	}=endConnection
		catch (SQLException e) {   e.printStackTrace(); connection.rollback();  }//endcatch
		finally { if(connection !=null) { connection.close(); } }
}=end
	- JDBC is a Java library with classes to connect to a db. The API makes it possible to query(& navigate results of those queries), update relational db, call stored procedures, and get meta data (i.e., information on the tables defined, columns in each table, data types, etc) about the db. 
	  - Transactions is anoter common use case. 
	  - A transaction groups multiple updates and possibly queries into a single action. Either all of the actions are executed, or none of them are.
	  
	- JDBC Drivers:  concrete JDBC driver implements (& is hidden behind) the JDBC interfaces. 
	  -
	  
	- Interfaces of JDBC:  
	  - Connections - used to connect to a database
	  - Statements - used for pure SQL strings
	  
	  - PreparedStatement - protects from SQL injection and sanitizes inputs.
			-DB's Statement cache stores Java app's PreparedStatements.
			-A Java JDBC PreparedStatement is a special kind of Java JDBC Statement object with additional features.  You *need* a Statement in order to execute either a query or an update.
http://tutorials.jenkov.com/jdbc/preparedstatement.html
			-easy to insert (and reuse) parameters into SQL statement.
			-Both JDBC driver and DB reuse the PS by reusing both the SQL parsing and query plan for subsequent queries. 
			-This speeds up query execution, by decreasing the parsing and query planning overhead of each execution. So may increase performance of executed statements;  
			-enables easier batch updates.
				Query:
>String sql = "select * from people where firstname=? and lastname=?";
>PreparedStatement myPeparedStatement = connection.prepareStatement(sql);
>myPeparedStatement.setString(1, "John");
>myPeparedStatement.setString(2, "Smith");
>ResultSet result = myPeparedStatement.executeQuery(); // Returns a ResultSet.
>while(result.next()) { 	String name = result.getString("name");
				Update: adding new records or modifying (updating) existing records.
>String sql = "update people set firstname=? , lastname=? where id=?";
>PreparedStatement myPreparedStatement = connection.prepareStatement(sql);
>myPreparedStatement.setString(1, "Gary"); // 1st number (1) is index of param; 2nd is value.
>myPreparedStatement.setString(2, "Larson");
>myPreparedStatement.setLong  (3, 123); 
>int myIntRowsAffected = myPreparedStatement.executeUpdate(); // Returns integer of rows updated.

  	  - CallableStatement - java.sql.CallableStatement -used for calling (stored) procedures in a database. 
			-A stored procedure is like a function or method in a class, except it lives inside the database. 
			-Some db-heavy operations benefit performance-wise from being executed inside the same memory space as the database server, as a stored procedure.
http://tutorials.jenkov.com/jdbc/callablestatement.html
				1.) Create instance of a CallableStatement by calling the prepareCall() method on a connection object.
>CallableStatement myCallableStatement = connection.prepareCall("{call calculateStatistics(?, ?)}");
		
		- ResultSet - stores the results from a query
			-If the stored procedure returns a ResultSet, and you need a non-default ResultSet (e.g. with different holdability, concurrency etc.)characteristics,  specify these characteristics when creating the CallableStatement.  
>CallableStatement myCallableStatement =  connection.prepareCall("{call calculateStatistics(?, ?)}",
>ResultSet.TYPE_FORWARD_ONLY,
>ResultSet.CONCUR_READ_ONLY,
>ResultSet.CLOSE_CURSORS_OVER_COMMIT    );

		- Parameter Values: CallableStatement is like a PreparedStatement: set parameters into SQL,i.e., ?  
>CallableStatement myCallableStatement = connection.prepareCall("{call calculateStatistics(?, ?)}"); 
>myCallableStatement.setString(1, "param1");
>myCallableStatement.setInt   (2, 123);
		
		- Execute the CallableStatement:  Once you have set the parameter values you need to set, execute the CallableStatement. 
>ResultSet result = callableStatement.executeQuery();
		
		- The executeQuery() method is used if the stored procedure returns a ResultSet.
		 If the stored procedure just updates the database, you can call the executeUpdate() method instead, like this:
>myCallableStatement.executeUpdate();

		- Batch Updates - You can group multiple calls to a stored procedure into a batch update. 
>CallableStatement myCallableStatement =  connection.prepareCall("{call calculateStatistics(?, ?)}");
>myCallableStatement.setString(1, "param1");
>myCallableStatement.setInt   (2, 123);
>myCallableStatement.addBatch();

>myCallableStatement.setString(1, "param2");
>myCallableStatement.setInt   (2, 456);
>myCallableStatement.addBatch();
	
>int[] updateCounts = myCallableStatement.executeBatch();
	
		- Out Parameters -  A stored procedure may return OUT parameters.  That is, values that are returned instead of, or in addition to, a ResultSet. 
		  After executing the CallableStatement you can then access these OUT parameters from the CallableStatement object.  
>CallableStatement myCallableStatement = connection.prepareCall("{call calculateStatistics(?, ?)}");
>myCallableStatement.setString(1, "param1");
>myCallableStatement.setInt   (2, 123);

>myCallableStatement.registerOutParameter(1, java.sql.Types.VARCHAR);
>myCallableStatement.registerOutParameter(2, java.sql.Types.INTEGER);

>ResultSet result = myCallableStatement.executeQuery();
>while(result.next()) { 
	... }
>String out1 = myCallableStatement.getString(1);
>int out2 = myCallableStatement.getInt   (2);

		- It is recommended that you first process the ResultSet before trying to access any OUT parameters. 
		  This is recommended for database compatibility reasons.
		
---------------------------############################----------
