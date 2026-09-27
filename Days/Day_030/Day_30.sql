-- DAY 30 — SQL FINAL 100 EXAMPLES
-- 1. Create Database
create database day30_sql;
use day30_sql;

-- 2. Create Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(30),
    joining_date DATE,
    manager_id INT,
    email VARCHAR(100)
);

-- 3. Insert 20 Employees
INSERT INTO employees
(emp_id, emp_name, department, salary, city, joining_date, manager_id, email)
VALUES
(1, 'Ravi', 'IT', 55000, 'Hyderabad', '2022-06-15', 4, 'ravi@gmail.com'),
(2, 'Suresh', 'IT', 70000, 'Bangalore', '2021-03-20', 4, 'suresh@gmail.com'),
(3, 'Rahul', 'IT', 70000, 'Hyderabad', '2022-09-18', 4, 'rahul@gmail.com'),
(4, 'Arjun', 'IT', 95000, 'Chennai', '2018-04-15', NULL, 'arjun@gmail.com'),
(5, 'Mahesh', 'HR', 60000, 'Bangalore', '2020-12-01', 6, 'mahesh@gmail.com'),
(6, 'Priya', 'HR', 75000, 'Hyderabad', '2022-01-10', NULL, 'priya@gmail.com'),
(7, 'Anjali', 'Finance', 90000, 'Chennai', '2019-07-25', NULL, 'anjali@gmail.com'),
(8, 'Kiran', 'Finance', 65000, 'Hyderabad', '2023-02-10', 7, 'kiran@gmail.com'),
(9, 'Vijay', 'Sales', 50000, 'Bangalore', '2021-11-05', 10, 'vijay@gmail.com'),
(10, 'Neha', 'Sales', 80000, 'Hyderabad', '2022-08-20', NULL, 'neha@gmail.com'),
(11, 'Amit', 'IT', 85000, 'Pune', '2020-05-12', 4, 'amit@gmail.com'),
(12, 'Sneha', 'HR', 68000, 'Chennai', '2021-09-14', 6, 'sneha@gmail.com'),
(13, 'Manoj', 'Finance', 72000, 'Bangalore', '2022-03-22', 7, 'manoj@gmail.com'),
(14, 'Pooja', 'Sales', 62000, 'Pune', '2023-01-18', 10, 'pooja@gmail.com'),
(15, 'Karthik', 'IT', 78000, 'Hyderabad', '2021-12-10', 4, 'karthik@gmail.com'),
(16, 'Divya', 'HR', 58000, 'Bangalore', '2023-04-05', 6, 'divya@gmail.com'),
(17, 'Ramesh', 'Finance', 88000, 'Hyderabad', '2020-08-19', 7, 'ramesh@gmail.com'),
(18, 'Swathi', 'Sales', 55000, 'Chennai', '2022-11-25', 10, 'swathi@gmail.com'),
(19, 'Naveen', 'IT', 65000, 'Bangalore', '2023-06-15', 4, 'naveen@gmail.com'),
(20, 'Lakshmi', 'Finance', 60000, 'Pune', '2021-02-28', 7, 'lakshmi@gmail.com');

select * from employees;

-- 4. Create Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(30),
    location VARCHAR(30)
);

-- 5. Insert Departments
INSERT INTO departments VALUES
(1, 'IT', 'Hyderabad'),
(2, 'HR', 'Bangalore'),
(3, 'Finance', 'Chennai'),
(4, 'Sales', 'Pune'),
(5, 'Marketing', 'Hyderabad');

select * from departments;
-- BASIC SQL — 1 to 20
-- Q1. Display all employees
select * from employees;

-- Q2. Display employee names
select emp_name
from employees;

-- Q3. Display name and salary
select emp_name,salary
from employees;

-- Q4. Employees with salary > 70000
select * from employees
where salary>70000;

-- Q5. Salary >= 60000
select * from employees
where salary>=60000;

-- Q6. IT employees
select * from employees
where department="IT";

-- Q7. Hyderabad employees
select * from employees
where city="hyderabad";

-- Q8. IT employees earning > 70000
select * from employees
where department="IT" and salary>70000;

-- Q9. IT or HR employees
select * from employees
where department="IT"or department="HR";

-- Q10. Employees NOT in IT
select * from employees
where department!="IT";

-- Q11. Distinct departments
select distinct department
from employees;

-- Q12. Distinct cities
select distinct city
from employees;

-- Q13. Highest salary first
select * from employees
order by salary desc;

-- Q14. Lowest salary first
select * from employees
order by salary asc;

-- Q15. Top 5 salaries
select * from employees
order by salary desc
limit 5;

-- Q16. Salary between 60000 and 80000
select * from employees
where salary between 60000 and 80000;

-- Q17. Employees from selected cities
select * from employees
where city in('Hyderabad', 'Bangalore');

-- Q18. Employees not from selected cities
select * from employees
where city not in('Hyderabad', 'Bangalore');

-- Q19. Names starting with A
select * from employees
where emp_name like "A%";

-- Q20. Names ending with a
select * from employees
where emp_name like "%a";

-- AGGREGATE FUNCTIONS — 21 to 30
--  Q21. Count employees
select count(*) as total_employees
from employees;

-- Q22. Highest salary
select max(salary) as max_salary
from employees;

-- Q23. Lowest salary
select min(salary) as min_salary
from employees;

-- Q24. Average salary
select avg(salary) as avg_salary
from employees;

-- Q25. Total salary
select sum(salary) as total_salary
from employees;

-- Q26. Department-wise employee count
select department,count(*) as employeeP_count
from employees
group by department;

-- Q27. Department-wise average salary
select department,avg(salary) as dept_avg_salary
from employees
group by department;

-- Q28. Department-wise highest salary
select department,max(salary) as highest_salary
from employees
group by department;

-- Q29. Department-wise total salary
select department,sum(salary) as total_salary
from employees
group by department;

-- Q30. Departments having more than 4 employees
select department,count(*) as employees_count
from employees
group by department;

-- CASE — 31 to 35
-- Q31. Salary category
select emp_name,salary,case
     when salary>=80000 then "High"
     when salary>=60000 then "medium"
     else "low"
end as salary_category
from employees;

-- Q32. City category
select emp_name,city,
case
when city="Hyderabad" then "south"
when city="Bangalore" then "south"
else "other"
end as region
from employees;

-- Q33. Department category
select emp_name,department,case
when department="IT" then "Technical"
else 'Non-Technical'
end as department_type
from employees;

-- Q34. High salary employees
select emp_name,salary,case
when salary>=80000 then "High Salary"
else "Normal salary"
end as salary
from employees;

-- Q35. Salary group count
select 
case 
when salary>=80000 then "high"
when salary>=60000 then "Medium"
else "Low"
end as salary_group,
count(*) as total
from employees
group by 
case
     when salary>=80000 then "high"
when salary>=60000 then "Medium"
else "Low"
end;


-- STRING FUNCTIONS — 36 to 40

-- Q36. Convert names to uppercase
select upper(emp_name)as employees_name
from employees;

-- Q37. Convert names to lowercase
select lower(emp_name)as employees_name
from employees;

-- Q38. Find name length
select emp_name,length(emp_name) as name_length
from employees;

-- Q39. First 3 characters
select emp_name,left(emp_name,3)as first_three
from employees;

-- Q40. Concatenate name and department
select CONCAT(emp_name,  " _ ",department)as employees_details
from employees;

-- DATE FUNCTIONS — 41 to 45

-- Q41. Employees joined after 2022
select * from employees
where joining_date>"2022-01-01";

-- Q42. Employees joined in 2022
select * from employees
where year(joining_date)=2022;

-- Q43. Extract joining year
select emp_name,year(joining_date)as joining_year
from employees;

-- Q44. Extract joining month
select emp_name,month(joining_date) as joining_month
from employees;

-- Q45. Sort employees by joining date
select * from employees
order by joining_date;

-- JOINS — 46 to 55
select e.emp_name,
       e.department,
       d.location
from employees e
inner join departments d
on e.department = d.department_name;

-- Q47. LEFT JOIN
select e.emp_name,
       e.department,
       d.location
from employees e
left join departments d
on e.department = d.department_name;

-- Q48. RIGHT JOIN
select e.emp_name,
       e.department,
       d.location
from employees e
right join departments d
on e.department = d.department_name;

-- Q49. Employees whose department exists in department table
select e.*
from employees e
inner join departments d
on e.department=d.department_name;

-- Q50. Departments without employees
select d.department_name 
from departments d
left join employees e
on d.department_name=e.department
where e.emp_id is null;

-- Q51. Employee + department location
select e.emp_name,
       e.salary,
       d.location
from employees e
join departments d
on e.department=d.department_name;

-- Q52. Employees and managers — SELF JOIN
select e.emp_name AS employee,
       m.emp_name AS manager
from employees e
left join employees m
on e.manager_id = m.emp_id;

-- Q53. Employees earning more than manager
select e.emp_name AS employee,
       e.salary AS employee_salary,
       m.emp_name AS manager,
       m.salary AS manager_salary
from employees e
join employees m
on e.manager_id = m.emp_id
where e.salary > m.salary;

-- Q54. Employee count by department using JOIN
select d.department_name,
       COUNT(e.emp_id) as employee_count
from departments d
left join employees e
on  d.department_name = e.department
group by d.department_name;

-- Q55. Total salary by department using JOIN
select d.department_name,
       COALESCE(SUM(e.salary), 0) AS total_salary
from departments d
left join employees e
on d.department_name = e.department
group by d.department_name;

-- SUBQUERIES — 56 to 65

-- Q56. Highest salary employee
select max(salary) as highest_salary
from employees
where salary=(
select max(salary) 
from employees);

-- Q57. Second-highest salary
select max(salary) as max_salary
from employees
where salary<(
select max(salary) 
from employees);

-- Q58. Employees earning above average
select avg(salary) as avg_salary
from employees
where salary>(
select avg(salary)
from employees);

-- Q59. Employees earning below average
select avg(salary) as avg_salary
from employees
where salary<(
select avg(salary)
from employees);

-- Q60. Employees earning maximum salary in IT
select * from employees
where department="IT"
and salary=(
select max(salary)
from employees
where department="IT");

-- Q61. Employees earning above IT average
select * from employees 
where salary>(
select avg(salary)
from employees
where department="IT");

-- Q62. Employees earning above their department average
select * from employees e
where salary>(
select avg(salary)
from employees
where department=e.department
);

-- Q63. Third-highest salary
select max(salary) 
from employees
where salary<(
select max(salary)
from employees
where salary<(
select max(salary)
from employees)
);

-- Q64. Employees from departments having average salary > 70000
select * from employees
where department in(
select department
from employees
group by department
having avg(salary)>60000);

-- Q65. Employees from department with highest average salary
select * from employees
where department=(
select department
from employees
group by department
order by avg(salary) desc
limit 1
);

-- CTE — 66 to 70

-- Q66. Basic CTE

with highest_salary as(
select * from employees
where salary>80000
)
select * from highest_salary;

-- Q67. Average salary using CTE
with avg_salary as(
select  avg(salary) as avg_sal
from employees
)
select e.*
from employees e
cross join avg_salary a
where e.salary=a.avg_sal;

-- Q68. Department salary using CTE
with dept_salary as(
select department,sum(salary) as total_salary
from employees
group by department
)
select * from dept_salary
where total_salary>300000;

-- Q69. Department average using CTE
with dept_salary as(
select department,avg(salary) as avg_salary
from employees
group by department
)
select * from dept_salary;

-- Q70. CTE + ranking
with ranked_employees as(
select emp_name,
       salary,
       department,dense_rank()over(partition by department order by salary desc) as rnk
       from employees
       )
       select * from ranked_employees
       where rnk<=2;
       
-- UNION — 71 to 73

-- Q71. UNION
select emp_name
from employees
where department="IT"

union
select emp_name
from employees
where department="HR";

-- Q72. UNION ALL
select emp_name
from employees
where department="IT"

union all
select emp_name
from employees
where department="HR";

-- Q73. Combine Hyderabad and Bangalore employees
select * from employees
where city="Hyderabad"
union
select * from employees
where city="Bangalore";

-- WINDOW FUNCTIONS — 74 to 88
-- Q74. ROW_NUMBER
select emp_name,
       salary,row_number()over(order by salary desc) as rnk
       from employees;
       
-- Q75. ROW_NUMBER by department
select 
     emp_name,
     salary,
     department,row_number()over(partition by department order by salary desc) as rnk
     from employees;
     
-- Q76. RANK
select emp_name,
        salary,
        department,rank()over(order by salary desc) as rnk
        from employees;

-- Q77. DENSE_RANK
select  emp_name,
        salary,
        department,dense_rank()over(order by salary desc) as rnk
        from employees;
        
-- Q78. Department-wise DENSE_RANK
select
       emp_name,
       salary,
       department,dense_rank()over(partition by department order by salary desc) as rnk
       from employees;
       
-- Q79. Top 2 employees per department
with emp_rank as (
select *,dense_rank()over(partition by department order by salary desc) as rnk
from employees
)
select * from emp_rank
where rnk<=2;

-- Q80. LAG salary
select 
       emp_name,
       salary,lag(salary)over(order by emp_id) as previous_salary
       from employees;
       
-- Q81. LEAD salary
select emp_name,
       salary,lead(salary)over(order by salary desc) as next_salary
       from employees;

-- Q82. Salary difference
select emp_name,
       salary-lag(salary)over(order by emp_id
       )assalary_difference
       from employees;

-- Q83. Running total
select 
      emp_name,
      salary,sum(salary)over(order by emp_id) as running_total
      from employees;
      
-- Q84. Department running total
select 
       emp_name,
       department,
       salary,sum(salary)over(partition by department order by emp_id) as running_total
       from employees;
       
-- Q85. Department average using window function
select   
       emp_name,
       salary,
       department,avg(salary)over(partition by department) as dept_avg_salary
       from employees;
       
--  Q86. Difference from department average
select 
       emp_name,
       department,
       salary-lag(salary)over(partition by department) as salary_difference
       from employees;
       
-- Q87. Department total salary
select 
      emp_name,
      department,
      salary,sum(salary)over(partition by department order by salary desc) as rnk
      from employees;
      
-- Q88. Salary percentage of department total
select
   emp_name,
   department,
   salary,
   round(salary*100.0/sum(salary)over(partition by department),2) as salary_percentage
   from employees;
   
-- UPDATE / DELETE / ALTER — 89 to 93

-- Q89. Update salary
update employees
set salary=60000
where emp_id=2;

-- Q90. Update department
update employees
set department="Marketing"
where emp_id=20;

-- Q91. Delete an employee
delete from employees
where emp_id=20;

-- Q92. Add new column
alter table employees
add phone varchar(200);

-- Q93. Rename column
alter table employees
rename column phone to mobile_number;

-- VIEW & INDEX — 94 to 97

-- Q94. Create View
create view highest_salary as 
select emp_id,
       emp_name,
       department,
       salary
from employees
where salary>=80000;

-- Q95. Use View
select * from highest_salary;

-- Q96. Create Index
create index idx_employee_department
on employees(department);

-- Q97. Create salary index
create  index idx_employee_salary
on employees(salary);

-- TRANSACTIONS — 98 to 99

-- Q98. COMMIT
start transaction;

update employees
set salary=salary+50000
where department="IT";

commit;

-- Q99. ROLLBACK
start transaction;

update employees
set salary=salary+10000
where department="HR";

rollback;

-- 100 Find the highest-paid employee in each department.
with ranked_employees as (
select 
       emp_id,
       emp_name,
       salary,
       department,dense_rank()over(partition by department order by salary desc) as rnk
       from employees
)
select 
       emp_id,
       emp_name,
       department,
       salary
from ranked_employees
where rnk=1;