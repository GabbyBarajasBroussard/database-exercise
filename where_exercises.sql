/* 1. Create a file named where_exercises.sql. Make sure to use the employees database. */
	USE employees;

## 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
	SELECT * FROM employees	
		WHERE first_name in ('Irena','Vidya', 'Maya'); #There are 709 employees with those names.
		
## 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
	SELECT * FROM employees
		WHERE first_name = 'Irena'
		OR first_name = 'Vidya'
		OR first_name = 'Maya'; #There are 709 employees with this method as well.

## 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
	SELECT * FROM employees
		WHERE gender = 'M' 
		AND (first_name = 'Irena'
		OR first_name = 'Vidya'
		OR first_name = 'Maya') ; #There are 441 male employees with those names
		
## 5. Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
	SELECT * FROM employees
		WHERE last_name LIKE 'E%'; #There are 7330 employees with a last name starting with E
		
## 6. Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
	SELECT * FROM employees
		WHERE last_name LIKE 'E%' OR last_name LIKE '%E'; #There are 30723 employees with names starting with or ending with E.
	SELECT * FROM employees
		WHERE last_name LIKE '%E' AND last_name NOT LIKE 'E%'; #There are 23393 remplyees with last names that end with E but do not start with E.
		
## 7. Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
	SELECT * FROM employees
		WHERE last_name LIKE '%E'; # There are 24292 names that end with e.

## 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
	SELECT * FROM employees
		WHERE hire_date LIKE '199%-%%-%%'; #There are 135214 employees hired in the nineties

## 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
	SELECT * FROM employees
		WHERE birth_date LIKE '%%%%-12-25'; #there are 842 employees born on Christmas day
	SELECT * FROM employees
		WHERE birth_date LIKE '%%%%-12-24'; #there are 791 employees born on Christmas eve
		
## 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
	SELECT * FROM employees
		WHERE birth_date LIKE '%%%%-12-25'
		AND
		hire_date LIKE '199%-%%-%%'; # There are 362 employees born on Christmas and hired in the nineties
		
## 11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
	SELECT * FROM employees
		WHERE last_name LIKE "%q%"; # There are 1873 employees with a q in their last name.
		
## 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found? 
	SELECT * FROM employees
	WHERE last_name LIKE "%q%"
	AND last_name NOT LIKE "%qu%";