-- Creating tables for PHemployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

COPY departments FROM '/Applications/untitled folder/Data/departments.csv' WITH (FORMAT CSV, HEADER);

SELECT * FROM departments;

COPY employees FROM '/Users/collinsculley/DataAustin2020/AustinDataCamp/Week7/Pewlett-Hackard-Analysis/Data/employees.csv' WITH (FORMAT CSV, HEADER);

SELECT * FROM employees;

COPY dept_manager FROM '/Users/collinsculley/DataAustin2020/AustinDataCamp/Week7/Pewlett-Hackard-Analysis/Data/dept_manager.csv' WITH (FORMAT CSV, HEADER);

SELECT * FROM dept_manager;

COPY salaries FROM '/Users/collinsculley/DataAustin2020/AustinDataCamp/Week7/Pewlett-Hackard-Analysis/Data/salaries.csv' WITH (FORMAT CSV, HEADER);

SELECT * FROM salaries;

COPY dept_emp FROM '/Users/collinsculley/DataAustin2020/AustinDataCamp/Week7/Pewlett-Hackard-Analysis/Data/dept_emp.csv' WITH (FORMAT CSV, HEADER);

SELECT * FROM dept_emp;

COPY titles FROM '/Users/collinsculley/DataAustin2020/AustinDataCamp/Week7/Pewlett-Hackard-Analysis/Data/titles.csv' WITH (FORMAT CSV, HEADER);

SELECT * FROM titles;

-- retirement eligible = 90398
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- DOB '1952' = 21209
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility + hire date condition = 41380
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Implement COUNT function on previous code
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table to easily export retirement eligible emp's
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

COPY (select * from retirement_info) TO '/Users/collinsculley/DataAustin2020/AustinDataCamp/Week7/Pewlett-Hackard-Analysis/Data/retirement_info.csv' DELIMITER ',' CSV HEADER;