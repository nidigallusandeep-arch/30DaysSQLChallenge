
-- Day 15 – SQL RIGHT JOIN
-- RIGHT JOIN:-
-- All records from the RIGHT table + matching records from the LEFT table.

use inner_;

select * from employees;
select * from departments;

-- 1. Display all departments and employees
select e.emp_name,d.department_name
from employees e
right join departments d
on e.department_id=d.department_id;

-- 2. Display department ID and employee name
select d.department_id,d.department_name,e.emp_name
from employees e
right join departments d
on e.department_id=d.department_id;

-- 3. Find departments without employees
select d.department_name
from employees e
right join departments d
on e.department_id=d.department_id
where e.emp_id is null;

-- 4. Display all departments with employee salaries
select d.department_name,e.emp_name,e.salary
from employees e
right join departments d
on e.department_id=d.department_id;

-- 5. Find employees earning more than 50,000
select e.emp_name,e.salary,d.department_name
from employees e
right join departments d
on e.department_id=d.department_id
where e.salary>50000;

-- 6. Count employees in every department
select d.department_name,count(e.emp_id) as total_employee
from employees e
right join departments d
on e.department_id=d.department_id
group by d.department_name;

-- 7. Find average salary by department
select d.department_name,avg(e.salary) as avg_salary
from employees e
right join departments d
on e.department_id=d.department_id
group by d.department_name;

-- 8. Find maximum salary in every department
select department_name,max(e.salary) as avg_salary
from employees e
right join departments d
on e.department_id=d.department_id
group by d.department_name;

-- 9. Find minimum salary in every department
select department_name,min(e.salary) as min_salary
from employees e
right join departments d
on e.department_id=d.department_id
group by d.department_name;

-- 10. Replace NULL with 0
select d.department_name,coalesce(count(e.emp_id),0)as employees_count
from employees e
right join departments d
on e.department_id=d.department_id
group by d.department_name;

-- 11. Display departments having more than 1 employee
select d.department_name,count(e.emp_id)as employees_count
from employees e
right join departments d
on e.department_id=d.department_id
group by d.department_name
having employees_count>1;

-- 12. Display HR employees
select e.emp_name,d.department_name,e.salary
from employees e
left join departments d
on e.department_id=d.department_id
where d.department_name="HR";

-- 13. Display all departments sorted alphabetically
select d.department_name,e.emp_name
from employees e
left join departments d
on e.department_id=d.department_id
order by d.department_name;

-- 14. Find departments where average salary > 50,000
select department_name,avg(e.salary)as avg_salary
from employees e
right join departments d
on e.department_id=d.department_id
group by d.department_name
having avg_salary>50000;


-- 15. Show department status
select d.department_name,
case
when e.emp_id is null then "NO employees"
else "Employees available"
end as department_status
from employees e
right join departments d
on e.department_id=d.department_id;





