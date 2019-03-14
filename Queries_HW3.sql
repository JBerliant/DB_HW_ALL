--2. Write a query that returns guests with a birthday before 2000.

select humanoid_name, humanoid_title, humanoid_birthday, visitor_id from tavern_humanoids
join visitor_id on visitor_id.humanoid_id = tavern_humanoids.humanoid_id WHERE humanoid_birthday < '2000-01-01';

--3. Write a query to return rooms that cost more than 100 gold a night

select * from tavern_rooms where room_rate > 100;

--4. Write a query that returns UNIQUE guest names.

select distinct humanoid_name, humanoid_title, visitor_id from tavern_humanoids
join visitor_id on visitor_id.humanoid_id = tavern_humanoids.humanoid_id;

--5. Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col]

select humanoid_name, humanoid_title, humanoid_birthday, visitor_id from tavern_humanoids
join visitor_id on visitor_id.humanoid_id = tavern_humanoids.humanoid_id ORDER BY humanoid_name ASC;


--6. Write a query that returns the top 10 highest price sales
--select sale_amount, total_sale from room_stays union tavern_sales;

select top 10 sale_id, customer_id, total_sale, sale_datetime from
(select sale_id,customer_id,total_sale, sale_datetime from tavern_sales
UNION 
Select stay_id,guest_id, sale_amt,time_of_sale from room_stays) sub
order by total_sale desc;

-- 7. Write a query to return all Lookup Table Names - this is, not the names of the tables but the Names of things like Status/Role/Class,etc. (w/ Union)

select concat(table_name,'.',column_name) AS 'LOOKUPTABLE' from INFORMATION_SCHEMA.columns);

--as we reviewed in class: (w/ union)
select service_id as N_ame from service_desc
union all 
select visitor_class as N_ame from tavern_visitors;


--8. Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level grouping (lvl 1-10, 10-20, etc)

-- I tried writing a single query that could do all of these steps in one execution
-- when that failed, I broke it down into separate functions
select humanoid_name,visitor_class, visitor_level into #visitor_levels from 
tavern_visitors 
join visitor_id on visitor_id.visitor_id=tavern_visitors.visitor_id 
join tavern_humanoids on tavern_humanoids.humanoid_id = visitor_id.humanoid_id
ALTER TABLE #visitor_levels
ADD lvl_1_19 smallint, lvl_20_39 smallint, lvl_40_60 smallint;
update #visitor_levels  
set lvl_1_19 = (select visitor_level where visitor_level<20), lvl_20_39 = (select visitor_level where 40>visitor_level AND visitor_level>20), lvl_40_60 =(select visitor_level where visitor_level>40)
from #visitor_levels;
select * from #visitor_levels;
drop table #visitor_levels;


-- 9. Write a series of INSERT commands that will insert the statuses of one table into another of your choosing using SELECT statements (See our lab in class - The INSERT commands should be generated). It’s ok if the data doesn’t match or make sense! :) Remember, INSERT Commands look like: INSERT INTO Table1 (column1, column2) VALUES (column1, column2)

-- I'm not sure what this is asking me to do. I'll have to ask about this one in class and then update my query. 

--from class : incomplete notes
create table #col(
col1 varchar(50),
col2 varchar(50),
col3 varchar(50)
);

select table_name,column_name from information_schema.columns where information_schema.columns.column_name like '%status%'

select column_name from information_schema.columns where information_schema.columns.column_name like 'status'

select concat(service_desc.status_id, service_status.service_status,tavern_rooms.room_attr,tavern_rooms.room_status) Into #status_table from INFORMATION_SCHEMA.columns
(col1, information_schema.columns) values (service_status.service_status, col1)

concat (insert into #servicestatus)

select * from #servicestatus;
select concat('insert INTO ' (name) Values (',servicestatus.statusname,')') from servicestatus;';

select * from INFORMATION_SCHEMA.columns