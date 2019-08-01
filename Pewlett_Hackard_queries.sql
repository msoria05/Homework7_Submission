-- DATA MODELING AND ENGINEERING

-- Create employees table and import data from csv file
CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	gender VARCHAR (255) NOT NULL,
	hire_date DATE NOT NULL
); 

-- Create departments table and import data from csv file
CREATE TABLE departments (
	dept_no VARCHAR (255) PRIMARY KEY NOT NULL,
	dept_name VARCHAR (255) NOT NULL
); 

-- Create dept_emp table and import data from csv file
-- Define foreign keys for emp_no and dept_no from corresponding tables using "REFERENCES"
CREATE TABLE dept_emp (
	emp_no INT REFERENCES employees (emp_no),
	dept_no VARCHAR (255) REFERENCES departments (dept_no),
	from_date DATE NOT NULL,
	to_date DATE
); 

-- Create dept_manager table and import data from csv file
-- Define foreign keys for emp_no and dept_no from corresponding tables using "REFERENCES"
CREATE TABLE dept_manager (
	dept_no VARCHAR (255) REFERENCES departments (dept_no),
	emp_no INT REFERENCES employees (emp_no),
	from_date DATE NOT NULL,
	to_date DATE
); 

-- Create salaries table and import data from csv file
-- Define foreign key for emp_no from employee table using "REFERENCES"
CREATE TABLE salaries (
	emp_no INT REFERENCES employees (emp_no),
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE
); 

-- Create salaries titles and import data from csv file
-- Define foreign key for emp_no from employee table using "REFERENCES"
CREATE TABLE titles (
	emp_no INT REFERENCES employees (emp_no), 
	title VARCHAR (255) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE
); 


-- DATA ANALYSIS
-- Employee number, last name, first name, gender, and salary for each employee:
SELECT 
	employees.emp_no, employees.last_name, employees.first_name, employees.gender,
	salaries.salary 
	FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

-- Employees who were hired in 1986 (from 1/1/1986 to 12/31/1986)
SELECT emp_no, last_name, first_name, hire_date 
	FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;

-- Manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates
SELECT 
	dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, 
	employees.last_name, employees.first_name,
	dept_manager.from_date, dept_manager.to_date
	FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- Department of each employee with the following information: 
-- employee number, last name, first name, and department name
SELECT 
	employees.emp_no, employees.last_name, employees.first_name,
	departments.dept_name
	FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;

-- All employees whose first name is "Hercules" and last names begin with "B"
SELECT first_name, last_name
	FROM employees
WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';
	
-- All employees in the Sales department, including their 
-- employee number, last name, first name, and department name
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
	FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- All employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
	FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
	OR departments.dept_name = 'Development';

-- List the frequency count of employee last names, (i.e., how many employees share each last name)
-- In descending order
SELECT last_name,
	COUNT(last_name) AS "Frequency"
	FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC;
