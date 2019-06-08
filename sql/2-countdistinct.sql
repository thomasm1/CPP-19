
-- Using Group By clause
SELECT COUNT(DISTINCT first_name), COUNT(DISTINCT last_name)
FROM Actor
WHERE actor_id BETWEEN 100 AND 200;


SELECT *
FROM Actor
WHERE first_name = 'Morgan'
AND actor_id BETWEEN 100 AND 200;

-- Task: list unique first name along with count of occurrence from actor table 

-- Subtask 1: Count first name of actor where actor_id is between 100 and 200
-- Using Group By clause
SELECT first_name, COUNT(first_name)
FROM Actor
WHERE actor_id BETWEEN 100 AND 200
GROUP BY first_name
ORDER BY first_name;

-- Subtask 2: List all the first name which occurs more than 1 time
-- Using Group By clause
SELECT first_name, COUNT(first_name)
FROM Actor
WHERE actor_id BETWEEN 100 AND 200
GROUP BY first_name
HAVING COUNT(first_name) = 2
ORDER BY first_name;







