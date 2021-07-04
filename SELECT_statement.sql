use employees;
/*
Select the information from the “dept_no” column of the “departments” table.

Select all data from the “departments” table.

*/

SELECT 
    dept_no
FROM
    departments;

/*
Select all people from the “employees” table whose first name is “Elvis”.
*/
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    
/*
Retrieve a list with all female employees whose first name is Kellie. 
*/ 

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' and gender = 'F';
    
/* Retrieve a list with all employees whose first name is either Kellie or Aruna. */

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' or first_name = 'Aruna';
    
/*Retrieve a list with all female employees whose first name is either Kellie or Aruna.*/

SELECT 
    *
FROM
    employees
WHERE
    (first_name = 'Kellie' or first_name = 'Aruna') and gender = 'F';
    
/* Use the IN operator to select all individuals from the “employees” table,
 whose first name is either “Denis”, or “Elvis”.*/
 
 SELECT 
    *
FROM
    employees
WHERE
    first_name in ('Denis', 'Elvis');
    
/*Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.*/

 SELECT 
    *
FROM
    employees
WHERE
    first_name not in ('John', 'Mark', 'Jacob');
    
    
/*
Working with the “employees” table, use the LIKE operator to select the data about all individuals,
whose first name starts with “Mark”; specify that the name can be succeeded by any sequence of characters.

Retrieve a list with all employees who have been hired in the year 2000.

Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”.
*/
 SELECT 
    *
FROM
    employees
WHERE
    first_name like ('Mark%');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date like ('2000%');
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no like ('1000_');
    
/*
Extract all individuals from the ‘employees’ table whose first name contains “Jack”.

Once you have done that, extract another list containing the names of employees that do not contain “Jack”.
*/

SELECT 
    *
FROM
    employees
WHERE
    first_name like ('%jack%');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name not like ('%jack%');
    
/*
Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.

Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.

Select the names of all departments with numbers between ‘d003’ and ‘d006’.
*/

SELECT 
    *
FROM
    salaries
WHERE
    salary between 66000 and 70000;
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no not between 10004 and 10012;
    
SELECT 
    *
FROM
    departments
WHERE
    dept_no between 'd003' and 'd006';
    
/* Select the names of all departments whose department number value is not null. */

SELECT 
    *
FROM
    departments
WHERE
    dept_no is not null;
    
/*
Retrieve a list with data about all female employees who were hired in the year 2000 or after.

Hint: If you solve the task correctly, SQL should return 7 rows.

Extract a list with all employees’ salaries higher than $150,000 per annum.
*/

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F' and hire_date >= '2000-01-01';
    
SELECT 
    *
FROM
    salaries
WHERE
    salary > '150000';
    
/*
Obtain a list with all different “hire dates” from the “employees” table.

Expand this list and click on “Limit to 1000 rows”. This way you will set the limit of output rows displayed back to the default of 1000.

In the next lecture, we will show you how to manipulate the limit rows count. 
*/

SELECT DISTINCT
    hire_date
FROM
    employees;
    
/*
How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?

How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise.
*/
    
SELECT 
    COUNT(salary)
FROM
    salaries
WHERE
    salary >= 100000;
    
SELECT 
    COUNT(*)
FROM
    dept_manager;
    
/*Select all data from the “employees” table, ordering it by “hire date” in descending order.*/

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

/*
Write a query that obtains two columns.
The first column must contain annual salaries higher than 80,000 dollars.
The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
Lastly, sort the output by the first column.
*/

SELECT 
    salary, COUNT(salary) AS 'emps_with_same_salary'
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;

/*
Select all employees whose average salary is higher than $120,000 per annum.
*/

SELECT
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;
    
SELECT
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;

SELECT
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

/*Select the employee numbers of all individuals
who have signed more than 1 contract after the 1st of January 2000.
Hint: To solve this exercise, use the “dept_emp” table.*/

SELECT 
    emp_no, COUNT(emp_no) AS contracts_count
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1;

/*Select the first 100 rows from the ‘dept_emp’ table. */
SELECT 
    *
FROM
    dept_emp
LIMIT 100;