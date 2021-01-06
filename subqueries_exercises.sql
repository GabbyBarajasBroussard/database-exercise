## Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

## Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT e.hire_date, e.first_name, e.last_name 
FROM employees AS e
WHERE e.hire_date = (SELECT hire_date FROM employees WHERE emp_no = '101010');

## Find all the titles ever held by all current employees with the first name Aamod.
SELECT t.title, COUNT(t.title)
FROM employees AS e
JOIN titles AS t ON t.emp_no = e.emp_no
WHERE e.emp_no IN (
    SELECT e.emp_no
    FROM employees
    WHERE e.first_name = 'Aamod')
GROUP BY t.title;

## How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT * 
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > curdate()) ; #There are 59900 former employees


## Find all the current department managers that are female. List their names in a comment in your code.
SELECT  first_name, last_name
FROM employees
WHERE emp_no IN (
SELECT emp_no
FROM dept_manager
WHERE emp_no IN (
		SELECT emp_no
		FROM employees
		WHERE gender = 'F')
	AND to_date > curdate()) ; #The current department managers that are female are Isamu Leleitner, Karsten Sigstam, Leon DasSarma, and Hilary Kambil.
	
## Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT first_name, last_name, salary
FROM employees
JOIN salaries on salaries.emp_no = employees.emp_no
WHERE salary > (
	SELECT AVG(salary)
	FROM salaries
)
AND to_date > curdate();

## How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT * 
FROM salaries
WHERE salary >(
SELECT MAX(salary)-STDDEV(salary)
FROM salaries)
AND to_date > curdate(); #There are 78 current salaries withing 1 STD of the current highest salary.


SELECT COUNT(*) AS 'num_salaries_1_stddev_below_max',
(count(*)/ (SELECT count(*) FROM salaries)) * 100
FROM salaries
WHERE salary >=
(
	(SELECT max(salary) FROM salaries) - (SELECT STDDEV(salary) FROM salaries)
)
and to_date > curdate();

#BONUS

# Find all the department names that currently have female managers.
SELECT  departments.dept_name, first_name, last_name
FROM employees
WHERE emp_no IN (
SELECT emp_no
FROM dept_manager
WHERE emp_no IN (
		SELECT emp_no
		FROM employees
		WHERE gender = 'F')
	AND to_date > curdate()) ;
# Find the first and last name of the employee with the highest salary.

# Find the department name that the employee with the highest salary works in.