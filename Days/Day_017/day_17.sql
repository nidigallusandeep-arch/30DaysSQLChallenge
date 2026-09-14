use car;

-- Day_17 — SQL INDEX | 15 Examples

CREATE TABLE employees_2(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(30),
    age INT
);

INSERT INTO employees_2
(emp_id, emp_name, department, salary, city, age)
VALUES
(1, 'Ravi', 'IT', 45000, 'Hyderabad', 25),
(2, 'Sandeep', 'IT', 60000, 'Bengaluru', 27),
(3, 'Priya', 'HR', 40000, 'Hyderabad', 24),
(4, 'Rahul', 'Finance', 55000, 'Chennai', 29),
(5, 'Anjali', 'IT', 70000, 'Hyderabad', 28),
(6, 'Kiran', 'HR', 35000, 'Pune', 23),
(7, 'Sneha', 'Finance', 65000, 'Bengaluru', 26),
(8, 'Arjun', 'IT', 50000, 'Chennai', 30),
(9, 'Divya', 'HR', 42000, 'Hyderabad', 25),
(10, 'Vijay', 'Finance', 75000, 'Pune', 31);

select * from employees_2;

-- Example 1 — Create Index on Name
create index idx_emp_name
on employees_2(emp_name);

-- Example 2 — Search Employee by Name
select * from employees_2
where emp_name="Sandeep";

-- Example 3 — Create Index on Salary
create index idx_salary
on employees_2(salary);

-- Example 4 — Search Salary
select * from employees_2
where salary=70000;

-- Example 5 — Create Index on City
create index emp_city
on employees_2(city);

-- Example 6 — Find Hyderabad Employees
select * from employees_2
where city="Hyderabad";

-- Example 7 — Create Index on Department
create index department
on employees_2(department);

-- Example 8 — Find IT Employees
select * from employees_2
where department="IT";

-- Example 9 — Create Composite Index
create index dept_salary
on employees_2(department,salary);

-- Example 10 — Search Department + Salary
select * from employees_2
where Department="IT" and salary>50000;

-- Example 11 — Unique Index
create unique index idx_unique_emp_name
on employees_2(emp_name);

-- Example 12 — Drop an Index
CREATE INDEX idx_city
ON employees_2(city);

DROP INDEX idx_city ON employees_2;

-- Example 14 — Show Indexes
SHOW INDEX FROM employees_2;

-- Check Query Performance
EXPLAIN
SELECT *
FROM employees_2
WHERE emp_name = 'Sandeep';