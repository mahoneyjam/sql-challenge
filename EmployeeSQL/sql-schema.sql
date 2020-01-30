Departments
-
dept_no PK string
dept_name string

"Department Manager"
-
id int PK 
dept_no string FK >- Departments.dept_no 
emp_no int FK >- Employees.emp_no
from_date string
to_date string

"Department Employees"
-
id int PK
emp_no int FK >- Employees.emp_no
dept_no string FK >- Departments.dept_no
from_date string
to_date string

Employees
-
emp_no int PK 
brith_date string
first_name string
last_name string
gender string
hire_date string

Salaries
-
emp_no int FK  >- Employees.emp_no
salary int
from_date string
to_date string

Titles
-
id PK
emp_no int FK >- Employees.emp_no
Title string
from_date string
to_date string