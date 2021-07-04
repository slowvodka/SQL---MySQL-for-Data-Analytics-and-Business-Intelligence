/*
Change the “Business Analysis” department name to “Data Analysis”.
Hint: To solve this exercise, use the “departments” table.
*/

select * from departments
order by dept_no desc
limit 10;

insert into departments values ('d010', 'Business Analysis');

UPDATE departments 
SET 
    dept_name = 'Data Analysis'
WHERE
    dept_no = 'd010';
    
DELETE FROM departments 
WHERE
    dept_no = 'd010';