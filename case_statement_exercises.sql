/* Create a file named case_exercises.sql and craft queries to return the results for the following criteria: */
USE employees;
/* 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. */
SELECT emp_no, CONCAT(first_name, ' ', last_name) as full_name, dept_no, employees.hire_date, to_date, 
        CASE WHEN to_date > curdate() THEN 1 
        ELSE 0
        END AS is_current_employee
        FROM dept_emp
	JOIN employees USING(emp_no) ;

/* 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.*/
SELECT last_name,
	CASE
	WHEN substr(last_name,1,1) IN ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'a-h'
	WHEN substr(last_name,1,1) IN ('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'i-q'
	WHEN substr(last_name,1,1) IN ('r','s','t','u','v','w','x','y','z') THEN 'r-z'
	END AS alpha_group
FROM employees
ORDER BY alpha_group;
/* 3. How many employees (current or previous) were born in each decade? */
SELECT COUNT(birth_date),
	CASE
		WHEN birth_date LIKE '195%' THEN '# of employees born in fifties'
		WHEN birth_date LIKE '196%' THEN '# of employees born in sixties'
		END AS birth_decade
	FROM employees
	GROUP BY birth_decade;

/* BONUS

What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? 

+-------------------+-----------------+
| dept_group        | avg_salary      |
+-------------------+-----------------+
| Customer Service  |                 |
| Finance & HR      |                 |
| Sales & Marketing |                 |
| Prod & QM         |                 |
| R&D               |                 |
+-------------------+-----------------+ */
