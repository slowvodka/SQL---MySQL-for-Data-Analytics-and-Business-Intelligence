/*
Extract the information about all department managers who were
hired between the 1st of January 1990 and the 1st of January 1995.
*/

SELECT 
    *
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            emp_no
        FROM
            dept_manager)
        AND e.hire_date > '1990-01-01'
        AND e.hire_date < '1995-01-01';
        
/*
Select the entire information for all employees whose job title is “Assistant Engineer”. 
Hint: To solve this exercise, use the 'employees' table.
*/

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.title = 'Assistant Engineer'
                AND e.emp_no = t.emp_no);
                

/*
Starting your code with “DROP TABLE”, create a table called “emp_manager” 
(emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null). 
*/
drop table emp_manager;
create table emp_manager
(
	emp_no int(11) not null,
    dept_no char(4) null,
    manager_no int(11) not null
);

/*
Fill emp_manager with data about employees, the number of the department they are working in, and their managers.
Your query skeleton must be:

Insert INTO emp_manager SELECT
U.*
FROM
	(A) UNION (B) UNION (C) UNION (D) AS U;

A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM). 
In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A), 
and employee number 110039 as a manager to all employees from 10021 to 10040 (this must be subset B).

Use the structure of subset A to create subset C, where you must assign employee number 110039 as a manager to employee 110022.
Following the same logic, create subset D. 
Here you must do the opposite - assign employee 110022 as a manager to employee 110039.

Your output must contain 42 rows.

Good luck!
*/

insert INTO emp_manager SELECT
U.*
FROM
(
select A.* from (
	select
		e.emp_no as employee_ID,
		min(de.dept_no) as dept_code,
			(select emp_no 
			from dept_manager 
			where emp_no = '110022') as manager_ID
	from employees e join dept_emp de on e.emp_no = de.emp_no
	where e.emp_no < 10020
	group by e.emp_no
	) as A
union
select B.* from (
	select
		e.emp_no as employee_ID,
		min(de.dept_no) as dept_code,
			(select emp_no 
			from dept_manager 
			where emp_no = '110039') as manager_ID
	from employees e join dept_emp de on e.emp_no = de.emp_no
	where e.emp_no > 10020 and e.emp_no <= 10041
	group by e.emp_no
	) as B
union
   select C.* from (
	select
		e.emp_no as employee_ID,
		min(de.dept_no) as dept_code,
			(select emp_no 
			from dept_manager 
			where emp_no = '110022') as manager_ID
	from employees e join dept_emp de on e.emp_no = de.emp_no
	where e.emp_no = 110039
	) as C
union 
select D.* from (
	select
		e.emp_no as employee_ID,
		min(de.dept_no) as dept_code,
			(select emp_no 
			from dept_manager 
			where emp_no = '110039') as manager_ID
	from employees e join dept_emp de on e.emp_no = de.emp_no
	where e.emp_no = '110022'
	) as D
) as U;
