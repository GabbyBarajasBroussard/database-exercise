/*Open Sequel Pro and login to the database server
Save your work in a file named tables_exercises.sql */

# Use the employees database
USE employees;
# List all the tables in the database
SHOW TABLES;
#Explore the employees table. What different data types are present on this table?
DESCRIBE employees;
# Which table(s) do you think contain a numeric type column?
	## The column that shows numeric type columns is employee number.
# Which table(s) do you think contain a string type column?
	## The columns that contain a string type column are first_name and last_name.
# Which table(s) do you think contain a date type column?
	## The columns that show a date are hire_date and birth_date.
# What is the relationship between the employees and the departments tables?
DESCRIBE departments;
	## the relationship between departments and employees are the dept_no when joined with the dept_emp tables
# Show the SQL that created the dept_manager table.
SHOW CREATE TABLE dept_manager;