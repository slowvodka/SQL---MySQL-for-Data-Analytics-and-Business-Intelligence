use employees;

commit;

drop trigger if exists new_nanager;

delimiter $$

create trigger new_nanager
after insert on dept_manager
for each row
begin
	declare v_cur_salary int; 

	select max(salary)
	into v_cur_salary from salaries
	where emp_no = new.emp_no;
    
	if v_cur_salary is not null
    then update salaries
    set to_date = sysdate()
    where emp_no = new.emp_no and to_date = new.to_date;
    
    insert into salaries
    values (new.emp_no, v_cur_salary + 20000, new.from_date, new.to_date);
    end if;
end$$

delimiter ;

-- check
insert into dept_manager 
values ('111534','d009', date_format(sysdate(), '%Y-%m-%d'), '9999-01-01');

select * from dept_manager where emp_no = '111534';

select * from salaries where emp_no = '111534';

rollback;


/*
Create a trigger that checks if the hire date of an employee is higher than the current date.
If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
*/

commit;
drop trigger if exists check_hire_date;
delimiter $$
create trigger check_hire_date
before insert on employees
for each row
begin

IF NEW.hire_date > date_format(sysdate(), '%Y-%m-%d') THEN   
    set new.hire_date = date_format(sysdate(), '%Y-%m-%d');
end if;

end $$

delimiter ;

insert into employees 
values ('999998','1953-08-02', 'Zeev','Slobo', 'M','9999-01-01');


select * from employees where emp_no = 999998;

rollback;

/*

*/

ALTER TABLE employees

DROP INDEX i_hire_date;

/*
Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.
*/

select * from salaries where salary > 89000;

create index i_salary on salaries(salary);

rollback;

/*
Similar to the exercises done in the lecture, obtain a result set 
containing the employee number, first name, and last name of all employees with a number higher than 109990.
Create a fourth column in the query, indicating whether this employee is also a manager, 
according to the data provided in the dept_manager table, or a regular employee. 
*/

select 
	e.emp_no,
    e.first_name,
    e.last_name,
    case 
		when dm.emp_no is not null then 'Manager'
        else 'Employee'
	end as is_Manager
 from 
 
 employees e left join dept_manager dm on e.emp_no = dm.emp_no 
 where e.emp_no >109990;
 
 /*
 Extract a dataset containing the following information about the managers:
 employee number, first name, and last name. Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee,
 and another one saying whether this salary raise was higher than $30,000 or NOT.

If possible, provide more than one solution.
 */
 
 select 
	e.emp_no,
    e.first_name,
    e.last_name,
    max(s.salary) - min(s.salary) as salary_raise,
    case when max(s.salary) - min(s.salary) > 30000 then 'YES' else 'NOT' end as more_than_30k
 from employees e join dept_manager dm on e.emp_no = dm.emp_no
 join salaries s on e.emp_no = s.emp_no
 group by s.emp_no;
 
 
 /*
 Extract the employee number, first name, and last name of the first 100 employees, 
 and add a fourth column, called “current_employee” saying “Is still employed” if the employee is still working in the company, 
 or “Not an employee anymore” if they aren’t.

Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. 
 */
 select 
	e.emp_no,
    e.first_name,
    e.last_name,
    case when de.to_date = '9999-01-01' then 'YES' else 'NOT' end as still_here
 from employees e join dept_emp de on e.emp_no = de.emp_no
 limit 100;
 
 
 SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'YES'
        ELSE 'NO'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;



