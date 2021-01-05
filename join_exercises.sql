## Create a file named join_exercises.sql to do your work in.
use join_example_db;

## Join Example Database
		## Use the join_example_db. Select all the records from both the users and roles tables.
				SELECT * FROM users AS u 
					JOIN roles AS r ON r.id =u.role_id;

		##  Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.


					## Join, I expect 4 rows of names, emails, and role of the company.
						SELECT * FROM users AS u
							JOIN roles AS r ON r.id = u.role_id ;
					## Left Join-- I expect 6 rows this time because the last query did not include those without roles. 
						SELECT * FROM users AS u
							LEFT JOIN roles AS r ON r.id = u.role_id;
					## Right Join-- I expect 5 rows because this one lists all the roles even if no one is in the role.
						SELECT * FROM users AS u
							RIGHT JOIN roles AS r ON r.id = u.role_id;
		##		Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along 	with the number of users that has the role. Hint: You will also need to use group by in the query.
		SELECT r.name, COUNT(roles.name) AS 'Number of People in Each Role' FROM users AS u
			RIGHT JOIN roles AS r ON r.id = u.role_id
			GROUP BY r.name;


## Employees Database
## Use the employees database.
USE employees;
/* Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang
  
*/
SELECT dept_name AS 'DEPARTMENT NAME', 
CONCAT(first_name, ' ', last_name ) AS 'DEPARTMENT MANAGER'
FROM departments
JOIN dept_manager 
	ON departments.dept_no = dept_manager.dept_no
JOIN employees 
	ON employees.emp_no = dept_manager.emp_no 
		AND dept_manager.to_date > curdate()
ORDER BY dept_name; 

/* Find the name of all departments currently managed by women. 

Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil */
USE employees;
SELECT dept_name, CONCAT(first_name, ' ', last_name ) AS dept_manager
FROM departments
JOIN dept_manager 
	ON departments.dept_no = dept_manager.dept_no
JOIN employees 
	ON employees.emp_no = dept_manager.emp_no 
		AND dept_manager.to_date > curdate() 
		AND employees.gender = 'F'
ORDER BY dept_name; 



/* Find the current titles of employees currently working in the Customer Service department.
Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/

SELECT title AS 'Title', 
COUNT(*)  AS 'Count'
FROM titles
JOIN employees 
	ON titles.emp_no = employees.emp_no 
JOIN dept_emp
	ON employees.emp_no = dept_emp.emp_no	
JOIN departments 
	ON dept_emp.dept_no = departments.dept_no
		WHERE departments.dept_no LIKE '%009'
		AND titles.to_date > curdate()
		AND dept_emp.to_date > curdate()
GROUP BY title
;

/* Find the current salary of all current managers.

Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987 */

SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name ) AS Name , salaries.salary AS Salary
FROM departments
JOIN dept_manager 
	ON departments.dept_no = dept_manager.dept_no
JOIN employees 
	ON employees.emp_no = dept_manager.emp_no 
		AND dept_manager.to_date > curdate()
JOIN salaries 
	ON employees.emp_no = salaries.emp_no 
		AND salaries.to_date > curdate()
ORDER BY dept_name; 

/* Find the number of current employees in each department.
+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+ */
SELECT departments.dept_no, departments.dept_name, COUNT(*) AS num_employees
FROM departments
JOIN dept_emp 
	ON dept_emp.dept_no = departments.dept_no
JOIN employees 
	ON dept_emp.emp_no = employees.emp_no 
		AND dept_emp.to_date > CURDATE()
GROUP by departments.dept_no;

/* Which department has the highest average salary? Hint: Use current not historic information.


+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+ */
SELECT dept_name, AVG (salary) AS 'average_salary'
FROM departments
JOIN dept_emp 
	ON departments.dept_no= dept_emp.dept_no 
		AND dept_emp.to_date > curdate()
JOIN salaries 
	ON dept_emp.emp_no = salaries.emp_no
	AND salaries.to_date > curdate() 
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

/* Who is the highest paid employee in the Marketing department?
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+ */
SELECT first_name, last_name
FROM employees
JOIN dept_emp 
	ON dept_emp.emp_no = employees.emp_no
		AND dept_emp.to_date > curdate()
JOIN departments 
	ON departments.dept_no= dept_emp.dept_no
		AND departments.dept_no LIKE '%01'
JOIN salaries 
	ON employees.emp_no = salaries.emp_no
		AND salaries.to_date > curdate()
ORDER BY salary DESC
LIMIT 1;

/* Which current department manager has the highest salary?
+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+ */
SELECT first_name, last_name, salary, dept_name
FROM employees
JOIN dept_manager 
	ON dept_manager.emp_no = employees.emp_no
JOIN salaries
	ON salaries.emp_no = dept_manager.emp_no
		AND salaries.to_date > curdate()
JOIN departments
	ON departments.dept_no = dept_manager.dept_no 
		AND dept_manager.to_date > curdate()
ORDER BY salary DESC
LIMIT 1;


/* Bonus Find the names of all current employees, their department name, and their current manager's name.


240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman */
SELECT 
CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
d.dept_name AS 'Department Name',
CONCAT (ee.first_name,' ', ee.last_name) AS 'Manager Name'
FROM dept_emp AS de
JOIN employees AS e
	ON de.emp_no = e.emp_no
JOIN departments AS d
	ON de.dept_no = d.dept_no
JOIN dept_manager AS dm
	ON de.dept_no = dm.dept_no 
		AND dm.to_date > curdate()
JOIN employees AS ee
	ON dm.emp_no = ee.emp_no
WHERE de.to_date > curdate();


/* Bonus Who is the highest paid employee within each department. */