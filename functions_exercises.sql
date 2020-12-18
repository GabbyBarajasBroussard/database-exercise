/* 1. Copy the order by exercise and save it as functions_exercises.sql. */

USE employees;


/* 2. Write a query to to find all current employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name. */
SELECT CONCAT(first_name,' ', last_name) AS full_name FROM employees
	WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e';

/*3. Convert the names produced in your last query to all uppercase. */
SELECT UPPER(CONCAT(first_name,' ', last_name) ) AS FULL_NAME FROM employees
	WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e';;

/* 4. Find all previous employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()), */
SELECT CONCAT(first_name, ' ' , last_name) AS full_name, DATEDIFF (CURDATE(),hire_date) AS total_days_working_for_company FROM employees 
	WHERE birth_date LIKE '%-12-25'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	ORDER BY birth_date ASC, hire_date DESC;

/* 5. Find the smallest and largest current salary from the salaries table. */
SELECT MIN(salary) AS 'smallest_salary' FROM salaries;
SELECT MAX(salary) AS 'largest_salary' FROM salaries;

/* 6. Use your knowledge of built in SQL functions to generate a username for all of the current and previous employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. */
SELECT CONCAT(LOWER(SUBSTR(first_name,1,1)), LOWER(SUBSTR(last_name,1,4)),'_', LOWER(SUBSTR(birth_date, 6,2)), LOWER(SUBSTR(birth_date, 2,2))) AS 'username', first_name, last_name, birth_date FROM employees;