-- Subtask 1: Retrieve all the actor with actor_id lesser than 11 

-- Retrieve All Data
SELECT * 
FROM Actor;

-- Using WHERE clause
SELECT * 
FROM Actor
WHERE actor_id < 11;

-- -----------------------------------------------------
-- Subtask 2: Order data by first_name

-- Using Order By clause
SELECT *
FROM Actor
WHERE actor_id < 11
ORDER BY first_name;

-- -----------------------------------------------------
-- Subtask 3: Order data by last_name in decending order
-- Using Order By clause
SELECT *
FROM Actor
WHERE actor_id < 11
ORDER BY last_name DESC;

