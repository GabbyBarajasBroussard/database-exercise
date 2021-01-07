/*. Create a file named temporary_tables.sql to do your work for this exercise.*/
USE easley_1273;
/* 1. Using the example from the lesson, re-create the employees_with_departments table. */
CREATE TEMPORARY TABLE employees_with_departments AS 
		SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_no, departments.dept_name
		FROM employees.employees
		JOIN employees.dept_emp USING(emp_no)
		JOIN employees.departments USING(dept_no);

		/* a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns */
		ALTER TABLE employees_with_departments 
			ADD full_name VARCHAR(41);
		
		/*b. Update the table so that full name column contains the correct data */
		UPDATE employees_with_departments 
		SET full_name = CONCAT(first_name, ' ', last_name);
		/*c. Remove the first_name and last_name columns from the table. */
		ALTER TABLE employees_with_departments
			DROP COLUMN first_name;
		ALTER TABLE employees_with_departments
			DROP COLUMN last_name;
			
			#Viz of the temporary table
			SELECT * FROM employees_with_departments;
			DROP TEMPORARY TABLE employees_with_departments; #removing temporary tables to free up disk space
		
		/* d. What is another way you could have ended up with this same table? */
		CREATE TEMPORARY TABLE employees_w_departments AS
			SELECT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) AS 'full_name', departments.dept_no, departments.dept_name
			FROM employees.employees
			JOIN employees.dept_emp USING(emp_no)
			JOIN employees.departments USING(dept_no);
			#viz of the alternate temp table 
				SELECT * FROM employees_w_departments;
				DROP TEMPORARY TABLE employees_w_departments; #removing temporary tables to free up disk space
/* 2. Create a temporary table based on the payment table from the sakila database. */
CREATE TEMPORARY TABLE payment AS
		SELECT payment.payment_id, payment.customer_id, payment.staff_id, payment.rental_id, payment.amount, payment.payment_date, payment.last_update
		FROM sakila.payment;
		SELECT * FROM payment;
/*		Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199. */
		ALTER TABLE payment MODIFY amount INT UNSIGNED;
		UPDATE payment
		SET amount= amount * 100;
		
		SELECT * FROM payment;	
		
		DROP TEMPORARY TABLE payment;  #removing temporary tables to free up disk space
		
/* 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst? */
CREATE TEMPORARY TABLE salaries_with_departments AS 
	SELECT e.*, s.salary, d.dept_name, d.dept_no FROM employees.employees AS e
	JOIN employees.salaries AS s USING (emp_no)
	JOIN employees.dept_emp AS de USING (emp_no)
	JOIN employees.departments AS d USING (dept_no)
	WHERE s.to_date > curdate()
	AND de.to_date > curdate();
## viz of the temp table
SELECT * FROM salaries_with_departments;
##changing the integers to floats
ALTER TABLE salaries_with_departments 
ADD mean_salary FLOAT;
ALTER TABLE salaries_with_departments
ADD sd_salary FLOAT;
ALTER TABLE salaries_with_departments
ADD z_salary FLOAT;
##  Creating a new temp table with the salary average as mean and salary standard developers using the data from the salaries_with_departments table to find the overall mean and STDdev.


		CREATE TEMPORARY TABLE salary_aggregates AS
		SELECT AVG(salary) AS mean, STDDEV(salary) AS sd FROM salaries_with_departments;
#viz of the temp table 
SELECT * FROM salary_aggregates;
##Updateing my salaries_with_departments table with the mean salary from the aggregate table
UPDATE salaries_with_departments 
SET mean_salary = (
	SELECT mean FROM salary_aggregates);
##Updating my salaries_with_departments table with the STDev salary from the aggregate table
UPDATE salaries_with_departments
SET sd_salary = (
	SELECT sd FROM salary_aggregates);
## Updating my salaries_with_departments table with the z score 	
UPDATE salaries_with_departments
SET z_salary = (
	salary - mean_salary) 
	/ sd_salary;
## creating the table with the z-salary information	
SELECT dept_name, AVG(z_salary) AS z_salary
FROM salaries_with_departments
GROUP BY dept_name
ORDER BY z_salary;
	## viz of the temp table
SELECT * FROM salaries_with_departments; #based off the z salary, working for sales would be the best to work for and human resources would be the worst.

