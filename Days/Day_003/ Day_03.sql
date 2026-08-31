-- Day 3 – SQL JOINs Problem Solving
-- Today focus: INNER JOIN, LEFT JOIN, RIGHT JOIN.
CREATE TABLE employees2(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    salary INT
);

INSERT INTO employees2 VALUES
(1, 'Sandeep', 101, 60000),
(2, 'Rahul', 102, 45000),
(3, 'Priya', 101, 75000),
(4, 'Anjali', 103, 55000),
(5, 'Kiran', 104, 50000),
(6, 'Ravi', 102, 40000),
(7, 'Sneha', 105, 80000),
(8, 'Arjun', 101, 65000),
(9, 'Divya', NULL, 48000),
(10, 'Vijay', 106, 52000);

select * from employees2;

-- departments
CREATE TABLE departments2(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments2 VALUES
(101, 'IT', 'Hyderabad'),
(102, 'HR', 'Bangalore'),
(103, 'Finance', 'Chennai'),
(104, 'Marketing', 'Mumbai'),
(105, 'Sales', 'Pune'),
(107, 'Operations', 'Delhi');

select * from departments2;

-- Day 3 – 15 Problems
-- INNER JOIN

-- Q1. Display employee names and their department names
select e.emp_name,d.department_name
from employees2 e
inner join departments2 d
on e.department_id=d.department_id;

-- Q2. Employee name, salary, and department
select e.emp_name,e.salary,d.department_name
from employees2 e
inner join departments2 d
on e.department_id=d.department_id;

-- Q3. Employees working in IT
select e.emp_name,e.salary,d.department_name
from employees2 e
inner join departments2 d
on e.department_id=d.department_id
where d.department_name="IT";

-- Q4. Employees working in Hyderabad
select e.emp_name,e.salary,d.location
from employees2 e
inner join departments2 d
on e.department_id=d.department_id
where d.location="Hyderabad";

-- Q5. Employee, department and location
select e.emp_name,d.department_name,d.location
from employees2 e
inner join departments2 d
on e.department_id=d.department_id;

-- LEFT JOIN
-- Q6. Display all employees
select e.emp_name,e.salary,d.department_name
from employees2 e
left join departments2 d
on e.department_id=d.department_id;

-- Q7. Employees without matching departments
select e.emp_name,d.department_name
from employees2 e
left join departments2 d
on e.department_id=d.department_id
where d.department_id is null;

-- Q8. All employees with department name
select e.emp_name,d.department_name
from employees2 e
left join departments2 d
on d.department_id=d.department_id;

-- Q9. Number of employees in each department
select d.department_name,count(e.emp_id) as total_employees
from employees2 e
left join departments2 d
on e.department_id=d.department_id
group by d.department_name;

-- Q10. Total salary for each department
SELECT d.department_name,
       COALESCE(SUM(e.salary), 0) AS total_salary
FROM departments2 d
LEFT JOIN employees2 e
ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Q11. Average salary for each department
select d.department_name,
       AVG(e.salary) AS average_salary
FROM departments2 d
LEFT JOIN employees2 e
ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Q12. Department with highest total salary
select d.department_name,
       SUM(e.salary) AS total_salary
from departments2 d
inner join employees2 e
ON d.department_id = e.department_id
group by d.department_name
order by total_salary DESC
limit 1;

-- Q13. Departments with no employees
SELECT d.department_name
FROM departments2 d
LEFT JOIN employees2 e
ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- Q14. Highest-paid employee in each department
select d.department_name,
       e.emp_name,
       e.salary
from employees2 e
inner join departments2 d
on e.department_id = d.department_id
where e.salary = (
    select MAX(e2.salary)
    from employees2 e2
    where e2.department_id = e.department_id
);

-- Q15. Employees earning more than department average
select e.emp_name,
       d.department_name,
       e.salary
from employees2 e
inner join departments2 d
ON e.department_id = d.department_id
where e.salary > (
    select avg(e2.salary)
   from employees2 e2
   where e2.department_id = e.department_id
);





