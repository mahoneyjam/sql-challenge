DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;


CREATE TABLE department (
  dept_id character varying(20) primary key NOT NULL,
  dept_name character varying(45) NOT NULL
);

CREATE TABLE employees (
	emp_no integer primary key NOT NULL,
	birth_date character varying(45) NOT NULL,
	first_name character varying(45) NOT NULL,
	last_name character varying(45) NOT NULL,
	gender character varying(1) NOT NULL,
	hire_date character varying(45) NOT NULL
);

CREATE TABLE dept_emp (
	id SERIAL PRIMARY KEY,
	emp_no integer NOT NULL,
	dept_no character varying(20) NOT NULL,
	from_date character varying(45) NOT NULL,
	to_date character varying(45) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES department(dept_id)
);

CREATE TABLE dept_manager (
	id SERIAL PRIMARY KEY,
	dept_no character varying(20) NOT NULL,
	emp_no integer NOT NULL,
	from_date character varying(45) NOT NULL,
	to_date character varying(45) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES department(dept_id)
);


CREATE TABLE salaries (
	id SERIAL PRIMARY KEY,
	emp_no integer NULL,
	salary integer NOT NULL,
	from_date character varying(45) NOT NULL,
	to_date character varying(45) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles (
	id SERIAL PRIMARY KEY,
	emp_no integer NOT NULL,
	title character varying(45) NOT NULL,
	from_date character varying(45) NOT NULL,
	to_date character varying(45) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--Check to ensure data imported
select * from department;
select * from employees;
select * from dept_emp;
select * from dept_manager;
select * from salaries;
select * from titles;



--List details of each employee: emp number, last name, first name, gender and salary
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees as e
inner join salaries as s on e.emp_no = s.emp_no
order by 1;

--List employees hired in 1986
select first_name, last_name, hire_date
from employees where hire_date LIKE '1986%'

--List manager of each dept with the following info: dept number, dept name,
--manager's emp number, last name, first name, start and end emp dates
select m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
from dept_manager as m
inner join employees as e on e.emp_no = m.emp_no
inner join department as d on d.dept_id = m.dept_no
order by 1;

--List the dept of each employee w/the following info: emp no, last name, first name, dept name
--This table includes ALL of the departments an employee worked in during the time period
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
inner join dept_emp as p on p.emp_no = e.emp_no
inner join department as d on d.dept_id = p.dept_no
order by 1;

--List all employees whose first name is "Hercules" and las name begins with "B"
select first_name, last_name
from employees where first_name = 'Hercules' and last_name like 'B%'
order by 2;

--List all emp in the Sales dept, including
--emp number, last name, first name, and dept name
--This data set shows anyone who currently works in the Sales dept

select m.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp as m
inner join employees as e on e.emp_no = m.emp_no
inner join department as d on d.dept_id = m.dept_no
where d.dept_name = 'Sales' and m.to_date LIKE '9999%'
order by 2;

--List all emp in the Sales or Development dept, including
--emp number, last name, first name, and dept name
--This data set shows anyone who currently works in the Sales or Development depts
select m.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp as m
inner join employees as e on e.emp_no = m.emp_no
inner join department as d on d.dept_id = m.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development' and m.to_date LIKE '9999%'
order by 2;

-- In desc order, list frequency count of employee last names
select distinct(last_name), count(last_name)
from employees
group by last_name
order by 2 desc;