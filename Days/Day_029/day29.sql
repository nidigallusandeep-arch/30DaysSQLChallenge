CREATE DATABASE day29_db;
USE day29_db;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(30),
    joining_date DATE
);

INSERT INTO employees VALUES
(1, 'Ravi', 'IT', 55000, 'Hyderabad', '2022-06-15'),
(2, 'Suresh', 'IT', 70000, 'Bangalore', '2021-03-20'),
(3, 'Rahul', 'IT', 70000, 'Hyderabad', '2022-09-18'),
(4, 'Arjun', 'IT', 85000, 'Chennai', '2018-04-15'),
(5, 'Mahesh', 'HR', 60000, 'Bangalore', '2020-12-01'),
(6, 'Priya', 'HR', 75000, 'Hyderabad', '2022-01-10'),
(7, 'Anjali', 'Finance', 90000, 'Chennai', '2019-07-25'),
(8, 'Kiran', 'Finance', 65000, 'Hyderabad', '2023-02-10'),
(9, 'Vijay', 'Sales', 50000, 'Bangalore', '2021-11-05'),
(10, 'Neha', 'Sales', 80000, 'Hyderabad', '2022-08-20');

select * from employees;

-- Q1. Find the highest salary
select max(salary) as max_salary
from employees;

-- Q2. Find the second-highest salary
select emp_name,salary
from employees
where salary=(
select max(salary)
from employees
where salary<(
select max(salary)
from employees)
);

-- Q3. Find employees earning more than 70000
select * from employees
where salary>70000;

-- Q4. Find average salary of employees
select avg(salary) as avg_salary
from employees;

-- Q5. Find department-wise average salary
select department,avg(salary) as dept_avg_salarty
from employees
group by department;

-- Q6. Find highest salary in each department
select department,max(salary) as highest_salary
from employees
group by department;

-- Q7. Find top 2 distinct salaries in each department
select * from (
select 
      emp_name,
      salary,
      department,dense_rank()over(partition by department order by salary desc) as rnk
      from employees
      )y
      where rnk<=2;
      
      
-- Q8. Find employees earning above their department average
select * from employees e
where salary>(
select avg(salary) avg_salary
from employees
where department=e.department);

-- Q9. Count employees in each city
select city,count(*) as count_employees
from employees
group by city;

-- Q10. Find employees who joined after January 1, 2022
select * from employees
where joining_date>"2022-01-01";

-- Q11. Calculate total salary expenditure for each department
select department,sum(salary) as total_salary
from employees
group by department;

-- Q12. Categorize employees into High, Medium and Low salary
select emp_name,salary,case
  when salary>=80000 then "High"
  when salary>=60000 then "medium"
  else "low"
  end as salary_category
  from employees;
  
-- Q13. Rank employees within each department using DENSE_RANK()
select emp_name
        salary,
        department,dense_rank()over(partition by department order by salary desc) as rnk
from employees;

-- Q14. Calculate running total of salaries within each department
select 
     emp_name,
     salary,
	department,sum(salary)over(partition by department order by emp_id) as runnign_total_salary
from employees;

-- Q15. Find salary difference from previous employee
select emp_name,
       salary,
       lag(salary)over(order by emp_id)as previous_salary,
       salary-lag(salary)over(order by emp_id) as salary_difference
       from employees;
       
-- Q16. Find highest-paid employee in each department
select * from (
select emp_name,
	   salary,
       department,dense_rank()over(partition by department order by salary desc) as rnk
       from employees
       )y
       where rnk=1;
       
-- Q17. Find duplicate salaries
select salary,count(*) as employee_count
from employees
group by salary
having count(*) >1;

-- Q18. Find departments having more than 2 employees
select department,count(*) as employees_count
from employees
group by department
having employees_count>2;

-- Q19. Find the employee with the third-highest salary
select * from (
select emp_name,
       salary,
       department,dense_rank()over(partition by department order by salary desc)as rnk
       from employees
       )y
       where rnk=3;
       
-- Q20. Find each employee's next higher salary using LEAD()
select emp_name,
       salary,lead(salary)over(order by emp_id) as next_salary
       from employees;
       
-- Q21. Find the lowest salary in each department
select department,min(salary) as lowest_salary
from employees
group by department;

-- Q22. Find employees whose salary is between 60,000 and 80,000
select * from employees
where salary between 60000 and 80000;

-- Q23. Find the city with the highest number of employees
select city,count(salary) as employees_count
from employees
group by city
order by employees_count desc
limit 1;

-- Q24. Find the top 3 highest-paid employees
select emp_name,
       salary,
       department
from employees
order by salary desc
limit 3;

-- Q25. Find the percentage contribution of each employee's salary to total salary
select emp_name,
       salary,
       department,
       round(salary*100.0/sum(salary)over(),2) as salary_percentage
       from employees;