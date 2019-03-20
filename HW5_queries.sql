--1. Write a query to return a “report” of all users and their roles 

SELECT humanoid_name, employee_role, admin_status, tavern_name, tavern_location FROM tavern_employment
JOIN employee_id ON employee_id.employee_id = tavern_employment.employee_id
JOIN tavern_humanoids ON tavern_humanoids.humanoid_id = employee_id.humanoid_id
JOIN tavern_info ON tavern_employment.tavern_id = tavern_info.tavern_id

--2. Write a query to return all classes and the count of guests that hold those classes 

SELECT class.class_name, count(classlvl.class_id) as classcount FROM CLASS
join classlvl on class.class_id = classlvl.class_id
group by class_name
order by classcount desc

--3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. 
--Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)

select humanoid_name, class_name, lvl, (case (lvl < 5) THEN (select 'Beginner' as lvl1_5) else '' end))  from guestclasses join class on guestclases.class_id = class.class_id join visitor_id on visitor_id.visitor_id=guestclasses.guest_id join tavern_humanoids on visitor_id.humanoid_id = tavern_humanoids.humanoid_id

select th.humanoid_name,class_name,lvl,
			CASE WHEN lvl < 5 THEN 'Beginner' ELSE '' END as lvl1_5, 
			CASE WHEN lvl BETWEEN 5 AND 10 THEN 'Intermediate' ELSE '' END as lvl5_10,
			CASE WHEN lvl >10 THEN 'Expert' ELSE '' END as lvl_10_up
	from classlvl
		join visitor_id vi on vi.visitor_id = classlvl.guest_id
		join tavern_humanoids th on vi.humanoid_id = th.humanoid_id
		join class on class.class_id = classlvl.class_id
	order by th.humanoid_name

-- this procecure executed correctly once- but I can't seem to get repeat success, 
-- it added columns for class1,lvl1,class2,lvl2 etc for as many as needed, but I can't get it just right.
/*
--select * from class
--select * from classlvl
---create table guestclasses(guest_name varchar(50), classname varchar(30) foreign key references class(class_name))
go

--DECLARE @clmax smallint
--set @clmax = (SELECT TOP 1 count(classlvl.guest_id) as classcount FROM CLASSlvl 
--join class on class.class_id = classlvl.class_id
--group by guest_id
--order by classcount desc)
Declare @cln varchar(max)='select *,'
DECLARE @cnt smallint = 1
while @cnt<=3
begin
set @cln = @cln + cast(@cnt as varchar) + ' as class' + cast(@cnt as varchar) + ' ,' + cast(@cnt as varchar) + ' as lvl' + cast(@cnt as varchar) +' ,'
set @cnt = @cnt+1
end
set @cln = substring(@cln,0,len(@cln)-1) + ' from classlvl'
exec(@cln)
go
*/


--INCOMPLETE -- I got stuck on some of this:
/*
DROP TABLE IF EXISTS guestclasses


SELECT guest_id, count(classlvl.guest_id) as classcount FROM CLASSlvl 
join class on class.class_id = classlvl.class_id
group by guest_id
order by classcount desc

update table guestclasses
go
select *from guestclasses
pivot(guest_id in ([class1],[class2],[class3])) as guestclass

go


alter table guestclasses
add primary key (guest_id,class_id), foreign key
(guest_id) references visitor_id(visitor_id), foreign key (class_id) references class(class_id)
select guest_id , count(guestclasses.class_id) as classcount from guestclasses join class on guestclasses.class_id=class.class_id group by guest_id order by classcount desc
join class on class.class_id = guestclasses.class_id
group by guest_id


SELECT guest_id FROM guestclasses
join class on class.class_id = guestclasses.class_id
group by guest_id

select * from guestclasses

*/

--4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)

DROP FUNCTION IF EXISTS lvlgroup;
CREATE FUNCTION lvlgroup(@lvl as int)
RETURNS VARCHAR(20)
AS BEGIN
DECLARE @group varchar (250)
set @group = (case
			WHEN @lvl < 5 THEN 'Beginner'
			WHEN @lvl BETWEEN 5 AND 10 THEN 'Intermediate'
			WHEN @lvl >10 THEN 'Expert'
			ELSE 'BAD INPUT' END)
RETURN @group
END 
go

select dbo.lvlgroup(16)
go


--5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to 

select * from room_stays rs join tavern_rooms tr on rs.room_id = tr.room_id 

drop function room_open;
GO 

CREATE FUNCTION room_open (@date as date)
RETURNS TABLE AS RETURN
select room_stays.room_id as available_rooms,tavern_id as tavern  --room_attr, room_rate, tavern_id
from room_stays join tavern_rooms on room_stays.room_id = tavern_rooms.room_id
WHERE (@date<convert(date,DATE_IN) AND @date<convert(date,DATE_OUT)) OR (@date>CONVERT(DATE,DATE_OUT) AND @date>CONVERT(DATE,DATE_IN));
--from room_stays WHERE @date NOT BETWEEN convert(date,DATE_IN) AND CONVERT(date,DATE_OUT);
SELECT* from dbo.room_open(convert(date,'1244-03-01')) as available_rooms


go


--6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs


CREATE FUNCTION rm_budget (@mincost dec(6,2), @maxcost dec(6,2))
RETURNS TABLE AS RETURN
select room_stays.room_id as in_budget, room_rate as per_night, tavern_id as tavern  --room_attr, room_rate, tavern_id
from room_stays join tavern_rooms on room_stays.room_id = tavern_rooms.room_id
WHERE room_rate BETWEEN @mincost AND @maxcost;
go

SELECT * from dbo.rm_budget(75.00,160.00) order by per_night asc


--7. Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one
DECLARE @mincost DEC
DECLARE @tavern int
SELECT top 1 @mincost = per_night from dbo.rm_budget(75.00,160.00) order by per_night asc
SELECT top 1 @tavern = tavern from dbo.rm_budget(75.00,160.00) order by per_night asc
insert into tavern_rooms(room_rate,tavern_id) values ((@mincost -.01), (select top 1 tavern_id from tavern_info where tavern_id != @tavern));

select * from tavern_rooms 
go