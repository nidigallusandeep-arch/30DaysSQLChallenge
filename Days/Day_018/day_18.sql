use car;

-- Day 18 — SQL CASE Statement

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


-- Example 1 — Salary Category

-- Question: Classify employees based on salary.
-- Salary >= 60000 → High
-- Salary >= 40000 → Medium
-- Otherwise → Low

select emp_name,salary,
case
when salary>=60000 then "High"
when salary >= 40000 then "Medium"
else "low"
end as emp_salary
from employees_2;

-- Example 2 — Age Category
-- Question: Classify employees as Young or Senior.

select emp_name,age,
case 
when age < 25 then "Yong"
when age >= 25 then "Senior"
end as age_category
from employees_2;

-- Example 3 — IT Department Label
-- Question: Show whether an employee belongs to IT or Non-IT.

select emp_name,department,
case
when department="IT" then "IT Employee"
else "Non-IT Employee"
end as employee_type
from employees_2;

-- Example 4 — Salary Bonus
-- Question: Give a bonus category based on salary.
select emp_name,salary,
case
when salary>=70000 then "20 Bonus"
when salary>=50000 then "10 Bonus"
else "5% Bonus"
end as bonus
from employees_2;

-- Example 5 — Salary Increase
-- Question: Calculate a new salary.
select emp_name,salary,
case
when salary>=60000 then salary+5000
else salary +3000
end as new_salary
from employees_2;

-- Example 6 — City Category
-- Question: Separate Hyderabad employees from other cities.
SELECT emp_name, city,
CASE
    WHEN city = 'Hyderabad' THEN 'Local'
    ELSE 'Other City'
END AS city_category
FROM employees_2;

-- Example 7 — Department Classification
SELECT emp_name, department,
CASE
    WHEN department = 'IT' THEN 'Technology'
    WHEN department = 'HR' THEN 'Human Resources'
    WHEN department = 'Finance' THEN 'Financial Department'
    ELSE 'Other'
END AS department_type
FROM employees_2;


-- Example 8 — Experience Level Using Age
SELECT emp_name, age,
CASE
    WHEN age <= 24 THEN 'Fresher'
    WHEN age <= 28 THEN 'Mid Level'
    ELSE 'Experienced'
END AS experience_level
FROM employees_2;

-- Example 9 — Salary Range
SELECT emp_name, salary,
CASE
    WHEN salary < 40000 THEN 'Below 40K'
    WHEN salary BETWEEN 40000 AND 59999 THEN '40K-59K'
    ELSE '60K+'
END AS salary_range
FROM employees_2;

-- Example 10 — High Salary Employee
SELECT emp_name, salary,
CASE
    WHEN salary >= 60000 THEN 'High Salary'
    ELSE 'Normal Salary'
END AS salary_status
FROM employees_2;

-- 11 Question: Show employee name, department, salary and give a complete performance category.
SELECT 
    emp_name,
    department,
    salary,
    CASE
        WHEN salary >= 70000 THEN 'Excellent'
        WHEN salary >= 60000 THEN 'Very Good'
        WHEN salary >= 50000 THEN 'Good'
        WHEN salary >= 40000 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance
FROM employees_2;

-- Example 12 — Age Group
SELECT emp_name, age,
CASE
    WHEN age < 25 THEN 'Under 25'
    WHEN age BETWEEN 25 AND 29 THEN '25-29'
    ELSE '30+'
END AS age_group
FROM employees_2;

-- Example 13 — Senior Employee
SELECT emp_name, age,
CASE
    WHEN age >= 30 THEN 'Senior Employee'
    ELSE 'Junior Employee'
END AS employee_level
FROM employees_2;

-- Example 15 — Department Bonus
SELECT emp_name, department, salary,
CASE
    WHEN department = 'IT' THEN salary + 5000
    WHEN department = 'Finance' THEN salary + 4000
    ELSE salary + 2000
END AS salary_after_bonus
FROM employees_2;


-- Example 15 — Salary Grade
SELECT emp_name, salary,
CASE
    WHEN salary >= 70000 THEN 'A'
    WHEN salary >= 50000 THEN 'B'
    WHEN salary >= 40000 THEN 'C'
    ELSE 'D'
END AS salary_grade
FROM employees_2;