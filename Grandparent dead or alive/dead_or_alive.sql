drop table if exists persons;
create table persons
(
	person			varchar(10),
	parent			varchar(10),
	person_status	varchar(10)	
);
insert into persons values ('A','X','Alive');
insert into persons values ('B','Y','Dead');
insert into persons values ('X','X1','Alive');
insert into persons values ('Y','Y1','Alive');
insert into persons values ('X1','X2','Alive');
insert into persons values ('Y1','Y2','Dead');

select c.person as child
, c.parent as parent
, p.parent as grand_parent
, g.person_status as grand_parent_status
from persons c
left join persons p on c.parent = p.person
left join persons g on p.parent = g.person
where g.person_status = 'Alive'