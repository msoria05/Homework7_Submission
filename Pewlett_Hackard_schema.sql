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


