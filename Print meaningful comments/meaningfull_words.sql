drop table if exists comments_and_translations;
create table comments_and_translations
(
	id				int,
	comment			varchar(100),
	translation		varchar(100)
);

insert into comments_and_translations values
(1, 'very good', null),
(2, 'good', null),
(3, 'bad', null),
(4, 'ordinary', null),
(5, 'cdcdcdcd', 'very bad'),
(6, 'excellent', null),
(7, 'ababab', 'not satisfied'),
(8, 'satisfied', null),
(9, 'aabbaabb', 'extraordinary'),
(10, 'ccddccbb', 'medium');
commit;

-- QUERY 1: Print meaningful comments
/* Write an SQL query to display the correct message (meaningful message) from input comments_and_translation table.*/

select case 
	when translation is null 
		then comment 
	else translation 
 end as output

from comments_and_translations;

-- other way to solve
select coalesce(translation, comment) as output
from comments_and_translations;