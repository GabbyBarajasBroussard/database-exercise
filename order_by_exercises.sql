## 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
USE employees;

## 2.  Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT * FROM employees	
		WHERE first_name in ('Irena','Vidya', 'Maya')
		ORDER BY first_name; #The first name listed is Irena Reutenaur.



## 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT * FROM employees	
		WHERE first_name in ('Irena','Vidya', 'Maya')
		ORDER BY first_name, last_name; # The first name listed is Irena Acton.
		
## 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT * FROM employees	
		WHERE first_name in ('Irena','Vidya', 'Maya')
		ORDER BY last_name, first_name; #The first name listed is Irena Acton. The last name listed is Maya Zyda.

## 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
SELECT * FROM employees
		WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
		ORDER BY emp_no;  #There are 899 employees. The first employee is 10021 Ramzi Erde and the last employee is 499648 Tadahiro Erde.

## 6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.
SELECT * FROM employees
		WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
		ORDER BY hire_date; # The number of employees returned is 899. The first employee is hired Sergi Erde on 1985-02-02. The newest employee is Teiji Eldridge hired on 11/27/1999.

## 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.
SELECT * FROM employees
		WHERE birth_date LIKE '%%%%-12-25'
		AND
		hire_date LIKE '199%-%%-%%'
		ORDER BY hire_date DESC, birth_date DESC;  #THERE ARE 362 EMPLOYEES. KHUN BERNINI WAS BORN 12/25/1952 AND HIRED ON 08/31/1999. ALSELM CAPPELLO WAS BORN 12/25/1962 AND HIRED ON 01/01/1990.