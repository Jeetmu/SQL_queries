drop table match_score;
create table match_score
(
	balls int,
	runs int
);
select * from match_score;

insert into match_score
select balls, round(random() * 6)
from generate_series(1,120) as balls;

select runs, count(1)
from match_score
group by runs order by runs;

update match_score
set runs = round(random() * 2)
where runs = 5;

with cte as 
	(select * 
	, ntile(20) over(order by balls) as overs
	from match_score)
select overs, sum(runs) as run_per_overs
from cte
group by overs
order by overs;