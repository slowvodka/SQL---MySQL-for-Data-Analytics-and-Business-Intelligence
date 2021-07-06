/*
Create a procedure that will provide the average salary of all employees.
Then, call the procedure.
*/

use employees;

drop procedure if exists avr_salary;

delimiter $$

create procedure avr_salary()
begin
	select avg(salary) from salaries;
end$$

delimiter ;

call employees.avr_salary();


/*
Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual,
 and returns their employee number.
*/

drop procedure if exists emp_info;

delimiter $$

create procedure emp_info(in p_fn varchar(40), in p_ln varchar(40), out p_emp_no integer)
begin
	SELECT 
    p.emp_no
INTO p_emp_no FROM
    employees p
WHERE
    first_name = p_fn AND last_name = p_ln;
end$$

delimiter ;

/*
Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.
Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively.
Finally, select the obtained output.
*/

set @v_emp_no = 0;
call emp_info('Aruna','Journel',@v_emp_no);
select @v_emp_no;

/*
Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee,
and returns the salary from the newest contract of that employee.
Hint: In the BEGIN-END block of this program, you need to declare and use two variables – 
v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.

Finally, select this function.
*/

drop function if exists emp_info;

delimiter $$
create function emp_info(p_first_name varchar(40), p_last_name varchar(40) ) returns decimal (10,2)
DETERMINISTIC
begin
declare v_salar decimal (10,2);

select s.salary into v_salar
from employees e join salaries s  on e.emp_no = s.emp_no 
where e.first_name = p_first_name and e.last_name = p_last_name and s.to_date = '9999-01-01';

return v_salar;

end$$
delimiter ;

select emp_info('Aruna','Journel');


