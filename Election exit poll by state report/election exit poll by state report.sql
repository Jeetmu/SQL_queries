drop table if exists candidates_tab;
create table candidates_tab
(
	id int,
	first_name varchar(50),
	last_name varchar(50)
);
insert into candidates_tab values(1,'Davide', 'Kentish');
insert into candidates_tab values(2,'Thorstein', 'Bridge');

drop table if exists results_tab;
create table results_tab
(
	candidate_id int,
	state varchar(50)
);
insert into results_tab values(1, 'Alabama');
insert into results_tab values(1, 'Alabama');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'New York');
insert into results_tab values(2, 'New York');
insert into results_tab values(2, 'Texas');
insert into results_tab values(2, 'Texas');
insert into results_tab values(2, 'Texas');
insert into results_tab values(1, 'New York');
insert into results_tab values(1, 'Texas');
insert into results_tab values(1, 'Texas');
insert into results_tab values(1, 'Texas');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'Alabama');

select * from candidates_tab;
select * from results_tab;

with cte as
	(select concat(first_name, ' ', last_name) as candidate_name
	, state
	, count(1) as total
	, dense_rank() over(partition by concat(first_name, ' ', last_name) order by count(1) desc) as rnk
	from candidates_tab c
	join results_tab r on r.candidate_id = c.id
	group by candidate_name, state)
select candidate_name
, string_agg(case when rnk = 1 then state||'('||total||')' end, ','order by state) as "1st_place"
, string_agg(case when rnk = 2 then state||'('||total||')' end, ',') as "2nd_place"
, string_agg(case when rnk = 3 then state||'('||total||')' end, ',') as "3rd_place"
from cte
where rnk <= 3
group by candidate_name