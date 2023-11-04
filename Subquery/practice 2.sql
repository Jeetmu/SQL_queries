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

-- nested subquery
/* QUESTION: Find stores who's sales where better than the average sales accross all the stores */
-- 1) find the total sales for each stores
-- 2) find avg for all the stores
-- 3) compare 1 & 2
drop table if exists sales;
create table sales
(
	store_id int,
	store_name varchar(50),
	product_name varchar(50),
	quantity int,
	price int
);
insert into sales values(1, 'Apple Store 3', 'MacBook pro 14', 1, 2000);
insert into sales values(1, 'Apple Store 3', 'MacBook Air', 4, 4400);
insert into sales values(1, 'Apple Store 4', 'iphone 13', 2, 1800);
insert into sales values(1, 'Apple Store 4', 'Airpods Pro', 3, 750);
INSERT INTO sales VALUES (1, 'Apple Store', 'iPad Pro 12.9', 5, 1200);
INSERT INTO sales VALUES (1, 'Apple Store', 'Apple Watch Series 7', 6, 450);
INSERT INTO sales VALUES (1, 'Apple Store', 'iMac 27-inch', 2, 1700);
INSERT INTO sales VALUES (2, 'Apple Store 2', 'iPhone SE', 8, 500);
INSERT INTO sales VALUES (2, 'Apple Store 2', 'Apple Pencil', 10, 120);
INSERT INTO sales VALUES (3, 'Apple Store 5', 'Mac Mini', 3, 700);
INSERT INTO sales VALUES (3, 'Apple Store 5', 'Apple TV 4K', 4, 170);
INSERT INTO sales VALUES (3, 'Apple Store 5', 'HomePod Mini', 7, 100);
INSERT INTO sales VALUES (4, 'Apple Store 6', 'iPhone 12 Pro', 2, 1000);
INSERT INTO sales VALUES (4, 'Apple Store 6', 'MacBook Pro 16', 1, 2500);
INSERT INTO sales VALUES (5, 'Apple Store 7', 'iPad Air', 6, 700);
INSERT INTO sales VALUES (5, 'Apple Store 7', 'AirTag', 20, 30);
INSERT INTO sales VALUES (6, 'Apple Store 8', 'Apple Watch SE', 4, 300);
INSERT INTO sales VALUES (6, 'Apple Store 8', 'MacBook Air M1', 3, 1000);
INSERT INTO sales VALUES (7, 'Apple Store 9', 'iPhone 13 Pro', 2, 1200);
INSERT INTO sales VALUES (7, 'Apple Store 9', 'AirPods Max', 5, 550);
INSERT INTO sales VALUES (8, 'Apple Store 10', 'iPad Mini', 3, 400);
INSERT INTO sales VALUES (8, 'Apple Store 10', 'Mac Pro', 1, 6000);

--1
select store_name, sum(price) as total_sales
from sales
group by store_name
--2 & 3
select *
from (select store_name, sum(price) as total_sales
	 from sales
	 group by store_name) sales
join (select avg(total_sales) as sales
	  from (select store_name, sum(price) as total_sales
		   from sales
		   group by store_name) x) avg_sales
		   on sales.total_sales > avg_sales.sales;
-- using with clause not to repeat steps
with sales as 
	(select store_name, sum(price) as total_sales
	from sales
	group by store_name)
select *
from sales
join (select avg(total_sales) as sales
	 from sales x) avg_sales
	 on sales.total_sales > avg_sales.sales;

-- Different Clause where subquery is allowed.(select, from, where, having)
-- using subquery in SELECT clause
/* QUESTION: Fetch all the employee details and add remarks to those employees who earn more than the average pay. */
select *
, (case when salary > (select avg(salary) from employee)
  	then 'Higher than average'
   else null
  end ) as remarks
from employee;
-- modifying above select clause using cross join
select *
, (case when salary > avg_sal.sal
  then 'Higher than average'
  else null
  end ) as remarks
from employee
cross join (select avg(salary) sal from employee) avg_sal

-- HAVING CLAUSE
/* QUESTION: Find the stores who have sold more units than the average units sold by all store.*/
select store_name, sum(quantity)
from sales
group by store_name
having sum(quantity) > (select avg(quantity) from sales);

-- SQL commands that allow subquery(insert,update,delete)
create table employee_history
(
	emp_id int,
	emp_name varchar(50),
	dept_name varchar(50),
	salary integer,
	location varchar(100)
);
-- INSERT command subquery to update table from other tables
select * from employee_history;

insert into employee_history
select e.id, e.emp_name, d.dept_name, e.salary, d.locations
from employee e
join department d on d.dept_name = e.dept_name
where not exists (select 1
				 from employee_history eh
				 where eh.emp_id = e.id)
				 
-- UPDATE
/* QUESTION: Give 10% increment to all employees in bangalore location based on the maximum salary earned by an emp in each dept. Only consider employees in employee history table */
update employee e
set salary = (select max(salary) + (max(salary) * 0.1)
			 from employee_history eh
			 where eh.dept_name = e.dept_name)
where e.dept_name in (select dept_name
					 from department
					 where locations='Bangalore')
and e.id in (select emp_id from employee_history);

-- DELETE
/* QUESTION: Delete all departments who do not have any employees */
select dept_name
from department d
where not exists (select 1 from employee e where e.dept_name = d.dept_name)

delete from department
where dept_name in (select dept_name
					from department d
					where not exists (select 1 from employee e where e.dept_name = d.dept_name)
				   );
select *
from department

