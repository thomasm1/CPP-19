-- Subtask 1: Change name of the actor from Cuba to Jacob

-- Using SELECT clause
SELECT * 
FROM Actor
WHERE first_name = 'Cuba';

-- Using UPDATE clause
UPDATE Actor
SET first_name = 'Jacob'
WHERE first_name = 'Cuba';

-- Verify Data Modification
-- Using SELECT clause
SELECT * 
FROM Actor
WHERE first_name = 'Cuba';
-- Using SELECT clause
SELECT * 
FROM Actor
WHERE first_name = 'Jacob';

-- ----------------------------------------------
-- Subtask 2: Insert a new row into table with actor name Robert Johnson

-- Insert Clause 
INSERT INTO actor(first_name, last_name)
VALUES ('Robert', 'Johnson');

-- Select Data
SELECT *
FROM Actor
WHERE first_name = 'Robert';
