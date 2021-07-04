-- departments_dup creation

DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup (
    dept_no CHAR(4),
    dept_name VARCHAR(40)
);

insert into departments_dup
select * from departments;

insert into departments_dup ( dept_name ) values ('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';

insert into departments_dup ( dept_no ) values ('d010');
insert into departments_dup ( dept_no ) values ('d011');


SELECT 
    *
FROM
    departments_dup;
 
 -- dept_manager_dup creation
 
DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

INSERT INTO dept_manager_dup

select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES
	(999904, '2017-01-01'),
    (999905, '2017-01-01'),
    (999906, '2017-01-01'),
    (999907, '2017-01-01');
DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';
    
INSERT INTO departments_dup (dept_name)
VALUES                ('Public Relations');
DELETE FROM departments_dup 
WHERE
    dept_no = 'd002'; 
    
/*
Extract a list containing information about all managers’ employee number,
first and last name, department number, and hire date. 
*/

SELECT 
    m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    dept_manager_dup m
        INNER JOIN
    employees e ON m.emp_no = e.emp_no
ORDER BY m.emp_no;

/*
Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch.
 See if the output contains a manager with that name.  

Hint: Create an output containing information corresponding to the following fields:
 ‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.
*/

SELECT 
    dm.emp_no, em.first_name, em.last_name
FROM
    employees em
        LEFT JOIN
    dept_manager dm ON em.emp_no = dm.emp_no
WHERE
    em.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC , em.emp_no;

/*
Extract a list containing information about all managers’ employee number, first and last name, department number, 
and hire date. Use the old type of join syntax to obtain the result.
*/

SELECT 
    em.emp_no, em.first_name, em.last_name, dm.dept_no, em.hire_date
FROM
    employees em,
	dept_manager dm 
WHERE
    em.emp_no = dm.emp_no
ORDER BY dm.dept_no DESC , em.emp_no;

-- they asked to do it 
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

/*
Select the first and last name, the hire date, 
and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.
*/

SELECT 
    em.emp_no,
    em.first_name,
    em.last_name,
    em.hire_date,
    t.title
FROM
    employees em
        JOIN
    titles t ON em.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY em.emp_no;

/*
Use a CROSS JOIN to return a list with all possible combinations between managers 
from the dept_manager table and department number 9.
*/

select dm.*, d.*
from
dept_manager dm cross join departments d
where d.dept_no = 'd009';

/*
Return a list with the first 10 employees with all the departments they can be assigned to.

Hint: Don’t use LIMIT; use a WHERE clause.
*/

SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no <= 10010;
    
/*
Select all managers’ first and last name, hire date, job title, start date, and department name.
*/

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
group by e.emp_no;

/*
How many male and how many female managers do we have in the ‘employees’ database?
*/

select 
e.gender , count(e.gender) as g_count
from 
employees e join dept_manager d on e.emp_no = d.emp_no
group by e.gender;

