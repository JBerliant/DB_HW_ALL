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

--3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)

select humanoid_name, 


SELECT guest_id, count(classlvl.guest_id) as classcount FROM CLASSlvl 
join class on class.class_id = classlvl.class_id
group by guest_id
order by classcount desc

--CREATE PROCEDURE classcount
DROP TABLE IF EXISTS #guestclasses
DECLARE @classmax smallint`
--DECLARE @guestclass smallint
--DECLARE @rowcount smallint
DECLARE @count varchar(MAX)
DECLARE @classcol VARCHAR(50)
set @count = 0
SET @classmax  = (select top 1 count(classlvl.guest_id) as classcount FROM CLASSlvl  join class on class.class_id = classlvl.class_id
				 group by guest_id
				 order by classcount desc)
--SET @classcol = 'SELECT ' + @count
--create table #guestclasses(
--guest_id int)
While (@count <= @classmax)
Begin
SET @classcol = 'alter table #guestclasses add ' +@count+'nvarchar(10)'
SET @count = @count + 1
CONTINUE;
IF @count > @classmax BREAK;
END;

select * from #guestclasses

classname[@count] VARCHAR(50),


DECLARE @name NVARCHAR(MAX) = 'class'
DECLARE @lvl  NVARCHAR(MAX) = 'lvl'

DECLARE @sql NVARCHAR(MAX) = 'ALTER TABLE #guestclasses ADD '+@name+' nvarchar(10) null'
--DECLARE @sql2 NVARCHAR(50)= 'ALTER TABLE #guestclasses ADD '+@lvl+' nvarchar(10) null'

EXEC sys.sp_executesql @sql;

set 
count(classlvl.guest_id)  >0 (concat(class_name, classlvl




--4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)
--5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to 
--6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs
--7. Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one