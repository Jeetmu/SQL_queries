/* There are 10 IPL team. write an sql query such that each team play with every other team just once. */

drop table if exists teams;
create table teams
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');
commit;

select * from teams;

-- playing twice against each teams
select team.team_name as team, opponent.team_name as opponent
from teams team
join teams opponent on team.team_name <> opponent.team_name

-- playing once against each teams
with matches as
	(select row_number() over(order by team_name) as ID, team_code, team_name
	from teams t)
select team.team_name as team, opponent.team_name as opponent
from matches team
join matches opponent on team.id < opponent.id;