
-- Day 12 – SQL Views
use car;
CREATE TABLE employees11(
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    experience INT,
    city VARCHAR(50)
);

INSERT INTO employees11 VALUES
(1, 'Sandeep', 'IT', 60000, 3, 'Bangalore'),
(2, 'Rahul', 'IT', 45000, 2, 'Hyderabad'),
(3, 'Priya', 'HR', 55000, 5, 'Chennai'),
(4, 'Anil', 'Finance', 70000, 6, 'Bangalore'),
(5, 'Sneha', 'IT', 80000, 7, 'Hyderabad'),
(6, 'Kiran', 'HR', 40000, 1, 'Chennai'),
(7, 'Ravi', 'Finance', 65000, 4, 'Bangalore'),
(8, 'Arun', 'IT', 50000, 3, 'Chennai'),
(9, 'Divya', 'HR', 60000, 6, 'Hyderabad'),
(10, 'Vijay', 'Finance', 75000, 8, 'Bangalore');
select * from employees11;

-- 1. Create a view containing all employees.
create view all_employees as
select * from employees11;

select * from all_employees;

-- 2. Create a view containing only employee name and salary.
create view emp_salary_view as 
select * from employees11;

select * from emp_salary_view;


-- 3. Create a view for IT employees
create view it_employees as 
select * from employees11
where department="IT";

select * from it_employees;

-- 4. Create a view for employees from Hyderabad.
create view hyd_employees as
select * from employees11
where city="Hyderabad";

select * from hyd_employees;

-- 5. Create a view for employees earning more than 50,000.
create view emp_salary as
select * from employees11
where salary>50000;

select * from emp_salary;

-- 6. Create a view showing employee name, department and salary.
create view emp_names_dept_salary as 
select emp_name,salary,department
from employees11;

select * from emp_names_dept_salary;

-- 7. Create a view for IT employees earning more than 55,000.
create view it_employees_ as
select * from employees11
where department ="IT" and salary>55000;

select * from it_employees_;

-- 8. Create a view showing employees sorted by highest salary.
create view sorted_by as 
select * from employees11
order by salary desc;

select * from sorted_by ;


-- 9. Create a view containing employees whose salary is between 45,000 and 60,000.
create view salary_range as 
select * from employees11
where salary  between 45000 and 60000;

select * from salary_range;

-- 10. Create a view for IT and Finance employees.
create view it_finace_emp as 
select * from employees11
where department in("IT","Finance");

select * from it_finace_emp;

-- 11. Create a view showing average salary by department.
create view avg_salary_detp as
select department,avg(salary) as avg_salary
from employees11
group by department;

select* from avg_salary_detp;

-- 12. Create a view showing maximum salary in each department.
create view max_salary as
select department,max(salary) as max_salary
from employees11
group by department;

select * from max_salary;

-- 13. Create a view showing minimum salary in each department.
create view min_salary as
select department,min(salary) as min__salary
from employees11
group by department;

select * from min_salary;

-- 14. Create a view showing number of employees in each department.
create view department_employee_count as
select department,count(*) as employee
from employees11
group by department;

select * from  department_employee_count;

-- 15. Create a view showing departments where average salary is greater than 50,000.
create view dept_avg_salary as
select department,avg(salary) as avg_salary
from employees11
group by department
having avg_salary>50000;

select * from dept_avg_salary;

-- 16. Create a view showing employees with salary greater than the overall average salary.
create view above_avg_salary as
select * from employees11
where salary>(
select avg(salary)
from employees11);

select * from above_avg_salary;

-- 17. Create a view showing the highest-paid employee in each department.
create view highest_paid_employee as
select e.*
from employees11 e
where salary=(
select max(salary) as max_salary
from employees11 e2
where e2.department=e.department);

select * from highest_paid_employee;

-- 18. Create a view showing only Hyderabad IT employees.
create view it_emp_hyd as
select * from employees11
where city="Hyderabad"
and department="IT";

select * from it_emp_hyd;

-- 19. How do you modify an existing view?
create view employee_details as
select emp_name,department,salary 
from employees11;

select * from employee_details;


CREATE OR REPLACE VIEW employee_details AS
SELECT emp_name, department, salary, city
FROM employees11;

SELECT * FROM employee_details;

-- 20. How do you delete a view?

-- Suppose we have:- employee_details
-- Delete it using:
drop view employee_details;

-- To verify:
SELECT * FROM employee_details;



