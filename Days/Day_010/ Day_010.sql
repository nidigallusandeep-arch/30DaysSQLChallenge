--  SQL Day 10 — CASE WHEN
use car;
CREATE TABLE employees10 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    experience INT
);

INSERT INTO employees10 VALUES
(1, 'Sandeep', 'IT', 60000, 3),
(2, 'Rahul', 'IT', 45000, 2),
(3, 'Priya', 'IT', 80000, 6),
(4, 'Anil', 'HR', 40000, 1),
(5, 'Ravi', 'HR', 65000, 5),
(6, 'Sneha', 'Finance', 70000, 4),
(7, 'Kiran', 'Finance', 50000, 2);

select * from employees10;


-- 1.Find whether salary is high or low.
select emp_name,
       salary,
case 
    when salary>=60000 then "High"
    else "Low"
    end as salary_salary_category
    from employees10;
    
-- Multiple Conditions
select emp_name,
	    salary,
case 
     when salary>=70000 then "Excellent"
     when salary>=60000 then "good"
     when salary>=50000 then "Average"
     else "Low"
     end as salary_level
     from employees10;
     
-- CASE with Experience
select emp_name,
       salary,
case
     when experience>=5 then "Senior"
     when experience >=3 then "Mid-Level"
     else "juior"
     end as employee_level
     from employees10;
     
-- Mid-Level'
SELECT
    emp_name,
    salary,
    experience,
    CASE
        WHEN salary >= 60000 AND experience >= 5
        THEN 'Senior High Paid'
        ELSE 'Other'
    END AS category
FROM employees10;

-- 7. CASE with GROUP BY
SELECT
    CASE
        WHEN salary >= 60000 THEN 'High Salary'
        ELSE 'Low Salary'
    END AS salary_category,
    COUNT(*) AS employee_count
FROM employees10
GROUP BY
    CASE
        WHEN salary >= 60000 THEN 'High Salary'
        ELSE 'Low Salary'
    END;
    
-- 8. Conditional Aggregation
select 
    count(case 
          when department="IT"then 1 end) as TI_employees
          from employees10;
          
-- 9. Count Employees by Department
select 
count(case when department ="IT" then 1 end) as IT,
count(case when department= "HR" then 1 end ) as HR,
count(case when department ="Finance" then 1 end) as Finance
from employees10;

--  Calculate total IT salary
SELECT
    SUM(
        CASE
            WHEN department = 'IT' THEN salary
            ELSE 0
        END
    ) AS IT_total_salary
FROM employees10;

-- 11. Find High-Salary Employees
select emp_name,
       salary,
       case 
          when salary >= 60000 then "Eligible"
          else "Not Eligible"
		end as status
	from employees10;
    
