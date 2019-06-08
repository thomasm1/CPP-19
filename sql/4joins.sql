-- ----------------------------------------------
-- Setup Enviroment - Create Table
-- Students
CREATE TABLE Students
(StudentId INT, StudentName VARCHAR(10));
INSERT INTO Students (StudentId, StudentName)
SELECT 1,'John'
UNION ALL
SELECT 2,'Matt'
UNION ALL
SELECT 3,'James'
UNION ALL
SELECT 4,'Andy';

-- Classes
CREATE TABLE Classes
(ClassId INT, ClassName VARCHAR(10));
INSERT INTO Classes (ClassId, ClassName)
SELECT 1,'Maths'
UNION ALL
SELECT 2,'Arts'
UNION ALL
SELECT 3,'History'
UNION ALL
SELECT 4,'Music';

-- StudentClass
CREATE TABLE StudentClass
(StudentId INT, ClassId INT);
INSERT INTO StudentClass (StudentId, ClassId)
SELECT 1,1
UNION ALL
SELECT 1,2
UNION ALL
SELECT 3,1
UNION ALL
SELECT 3,2
UNION ALL
SELECT 3,3;

-- Select data
SELECT *
FROM Students;
SELECT *
FROM Classes;
SELECT *
FROM StudentClass;

/* Scenario 1: Troy wants to retrieve all the students 
who have signed up for classes in the summer. */
SELECT st.StudentName, cl.ClassName
FROM StudentClass sc
INNER JOIN Classes cl ON cl.ClassID = sc.ClassID
INNER JOIN Students st ON st.StudentID = sc.StudentID;

/* Scenario 2: Troy wants to retrieve all the students who 
have signed up for no classes in the summer. */
SELECT st.StudentName, cl.ClassName
FROM Students st
LEFT JOIN StudentClass sc ON st.StudentID = sc.StudentID
LEFT JOIN Classes cl ON cl.ClassID = sc.ClassID
WHERE cl.ClassName IS NULL;

-- Alternative 1
SELECT st.StudentName
FROM Students st
LEFT JOIN StudentClass sc ON st.StudentID = sc.StudentID
WHERE sc.ClassID IS NULL;

-- Alternative 2
SELECT st.StudentName
FROM StudentClass sc
RIGHT JOIN Students st ON st.StudentID = sc.StudentID
WHERE sc.ClassID IS NULL;

/* Scenario 3: Troy wants to retrieve all the classes not 
signed up by any student in the summer. */
SELECT st.StudentName, cl.ClassName
FROM Students st
RIGHT JOIN StudentClass sc ON st.StudentID = sc.StudentID
RIGHT JOIN Classes cl ON cl.ClassID = sc.ClassID
WHERE st.StudentName IS NULL;

-- Alternative
SELECT cl.ClassName
FROM StudentClass sc 
RIGHT JOIN Classes cl ON cl.ClassID = sc.ClassID
WHERE sc.StudentID IS NULL;

/* Scenario 4: Troy wants to see how big the class can grow if all 
the students sign up for all the classes in the summer. */
SELECT st.StudentName, cl.ClassName
FROM Classes cl
CROSS JOIN Students st;


/* Scenario 5: Troy wants to see a list of enrolled students along
 with students who did not sign up for any class as well as a class
  not signed up by any students. */
SELECT st.StudentName, cl.ClassName
FROM Students st
FULL JOIN StudentClass sc ON st.StudentID = sc.StudentID
FULL JOIN Classes cl ON cl.ClassID = sc.ClassID;


-- Clean up
DROP TABLE Students;
DROP TABLE Classes;
DROP TABLE StudentClass;




