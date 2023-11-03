drop table if exists employee;
create table employee
(
	id int,
	emp_name varchar(50),
	dept_name varchar(50),
	salary int
);
insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar','IT', 4000);
insert into employee values(104, 'Dorvin','Finance', 6500);
insert into employee values(105, 'Rohit','HR', 3000);
insert into employee values(106, 'Rajesh','Finance', 5000);
INSERT INTO employee VALUES (110,'Lily','HR', 3200);
INSERT INTO employee VALUES (111,'Daniel','Finance', 5400);
INSERT INTO employee VALUES (112,'Ella','Admin', 4300);
INSERT INTO employee VALUES (113,'Matthew','IT', 4200);
INSERT INTO employee VALUES (114,'Avery','Finance', 5600);
INSERT INTO employee VALUES (115,'David','HR', 3200);
INSERT INTO employee VALUES (116,'Grace','Admin', 4300);
INSERT INTO employee VALUES (117,'William','IT', 4200);
INSERT INTO employee VALUES (118,'Chloe','Finance', 5600);
INSERT INTO employee VALUES (119,'Ethan','HR', 3200);
INSERT INTO employee VALUES (107,'John','Admin', 4200);
INSERT INTO employee VALUES (108,'Sara','IT', 4100);
INSERT INTO employee VALUES (109,'Chris','Finance', 5500);

drop table if exists department;
create table department
(
	dept_id int,
	dept_name varchar(50),
	locations varchar(100)
);
insert into department values (1,'HR','Bangalore');
insert into department values (2,'IT','Bangalore');
insert into department values (3,'Finance','Mumbai');
insert into department values (4,'Marketing','Bangalore');
insert into department values (5,'Sales','Mumbai');
insert into department values (6,'Admin','Delhi');

/* QUESTION: Find the employees who's salary is more than the average salary earned by all employee */
select avg(salary) from employee; -- 4342.1052631578947368 (scalar sub query)

select * --outer query / main query
from employee
where salary > (select avg(salary) from employee); --subquery / inner query

--scalar subquery
-- it always return 1 row or 1 column 
select *
from employee e
join (select avg(salary) sal from employee) avg_sal
	on e.salary > avg_sal.sal;
	
-- multiple row sub query
-- subquery which returns multiple column and multiple row
-- subquery which returns only 1 column and multiple row

/* QUESTION: Find the employees who earn the highest salary in each department. */
select dept_name, max(salary)
from employee
group by dept_name

select *
from employee
where (dept_name, salary) in (select dept_name, max(salary)
								from employee
								group by dept_name);
								
-- single column, multiple row subquery
/* QUESTION: Find department who do not have any employees */
select distinct(dept_name) from employee;

select *
from department
where dept_name not in (select distinct(dept_name) from employee);

-- correlated subquery (1)
-- A subquery which is related to the outer query
/* QUESTION: Find the employees in each department who earn more than the avg salary in that department */
select avg(salary) from employee
where dept_name = 

select * 
from employee e1
where salary > (select avg(salary) from employee e2
			   where e2.dept_name = e1.dept_name
			   );

-- correlated subquery (2)
/* Find department who do not have any employees */
select * 
from department d
where not exists (select * from employee e where e.dept_name = d.dept_name);