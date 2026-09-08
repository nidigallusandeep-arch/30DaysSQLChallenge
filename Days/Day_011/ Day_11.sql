--  Day 11 Stored Procedures

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

-- Get all employees
DELIMITER //
create procedure get_employees()
BEGIN
select * from employees10;
END //
DELIMITER ;
call get_employees();


-- -- Example 2 — Get IT Employees
DELIMITER //
create procedure IT_employees()
BEGIN
select * from employees10
where department="IT";
END //
DELIMITER //
call IT_employees();


-- Example 3 — Procedure with Parameter
DELIMITER //
create procedure get_department(in dept varchar(100))
BEGIN
select * from employees10
where department=dept;
end //
DELIMITER ;
call get_department("Finance");

-- Example 4 — Salary Greater Than
DELIMITER //
create procedure high__salary(in min_salary int)
BEGIN
select emp_name,salary
from employees10
where salary>min_salary;
end //
DELIMITER ;
call high__salary(60000);

-- Example 5 — Employees from a City
DELIMITER //
create procedure city__employees(in emp_city varchar(100))
begin
select * from employees10
where city=emp_city;
end //
DELIMITER ;
call city__employees("Hyderabad");


-- Example 6 — Average Salary
DELIMITER //
create procedure avg_salary()
begin 
select avg(salary) as avg_salary
from employees10;
end //
DELIMITER ;
call avg_salary();

-- Example 7 — Maximum Salary
DELIMITER //
create procedure max_salary()
begin
select max(salary) as max_salary
from employees10;
end //
DELIMITER ;
call max_salary();

-- Example 8 — Minimum Salary
DELIMITER //
create procedure min_salary()
begin
select min(salary) as min_salary
from employees10;
end //
DELIMITER ;
call min_salary();

-- Example 9 — Employee Count
DELIMITER //
create procedure employees_count()
begin
select count(*) as count_emp
from employees10;
end //
DELIMITER ;
call employees_count();

-- Example 10 — Department Count
DELIMITER //
create procedure department_count(in dept varchar(100))
begin
select count(*) as total_employees
from employees10
where department=dept;
end //
DELIMITER ;
call department_count("IT");

-- Example 11 — Salary Between
DELIMITER //

CREATE PROCEDURE salary_between(
    IN min_salary INT,
    IN max_salary INT
)
BEGIN
    SELECT *
    FROM employees10
    WHERE salary BETWEEN min_salary AND max_salary;
END //

DELIMITER ;
CALL salary_between(40000, 60000);

-- Example 12 — Employee by ID
DELIMITER //
CREATE PROCEDURE employee___idd(IN emp__id INT)
BEGIN
    SELECT *
    FROM employees10
    WHERE emp_id = emp__id;
END //
DELIMITER ;
call employee___id(3);

-- Example 13 — IT Employees with High Salary
DELIMITER //
CREATE PROCEDURE high_salary(IN min_salary INT)
BEGIN
    SELECT emp_name, salary, department
    FROM employees10
    WHERE department = 'IT'
      AND salary > min_salary;
END //

DELIMITER ;
CALL high_salary(50000);