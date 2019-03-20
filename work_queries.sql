/*
update #visitor_levels lvl_1_19, lvl_20_39, lvl_40_60) 
set lvl_1_19 =  case

(select visitor_level from #visitor_levels
where visitor_level < 20),
set lvl_20_39 = (select visitor_level into lvl_20_39 from #visitor_levels
where visitor_level>19 AND visitor_level<40),
set lvl_40_60 = (select visitor_level from #visitor_levels
where visitor_level > 39);


drop table #visitor_levels;


/*select * from tavern_visitors
inner join
visitor_id on visitor_id.visitor_id = tavern_visitors.visitor_id
join tavern_humanoids on tavern_humanoids.humanoid_id =visitor_id.humanoid_id
;
*/

-- review HW #7*/
select service_id as N_ame from service_desc
union all 
select visitor_class as N_ame from tavern_visitors; 



/* Class notes  3/11

JOINS:
INNER vs OUTER

SELECT [columns] FROM [table] INNER / OUTER JOIN [table 2] ON 
([table].[column] = [table2].[column]);
 -- this is especially straightforward when we are using PK so that we know the data types and the data will match up

 composite joins


 
 compound joins
 

 */
 select * from tavern_humanoids cross join employee_id;
  cross join tavern_employment;
 tavern_humanoids.humanoid_id = employee_id.humanoid_id;

  select * from tavern_humanoids cross join employee_id;
  cross join tavern_employment;
 tavern_humanoids.humanoid_id = employee_id.humanoid_id;


select * from tavern_visitors inner join visitor_id on (visitor_id.visitor_id = tavern_visitors.visitor_id) inner join tavern_humanoids on (tavern_humanoids.humanoid_id = visitor_id.humanoid_id);

select * from tavern_visitors inner join visitor_id on (visitor_id.visitor_id = tavern_visitors.visitor_id) inner join tavern_humanoids on (tavern_humanoids.humanoid_id = visitor_id.humanoid_id) where visitor_level>15;

--AGGREGATE FUNCTIONS  - can use with group by
-- AVG
-- MAX
-- COUNT
-- min
-- SUM


select 'hello' 
FROM INFORMATION_SCHEMA.COLUMNS
SELECT *
FROM INFORMATION_SCHEMA.TABLES WHERE table_Name = 'Tavern_info'
select * from sys.all_columns




select * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
S
/* LAB 
 SELECT * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
 select * from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
 */ 
 select * from INFORMATION_SCHEMA.COLUMNS 
 select * from INFORMATION_SCHEMA.TABLES 
 select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS



-- and here is my answer to the lab:  CREATE query 
SELECT CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Tavern_info' 
UNION ALL 
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, 
	( CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL Then CONCAT ('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') 
		Else '' END) , 
	CASE WHEN refConst.CONSTRAINT_NAME IS NOT NULL Then (CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) 
		Else '' END , ',') 
as queryPiece FROM INFORMATION_SCHEMA.COLUMNS as cols 
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys 
	ON (keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME) 
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst 
	ON (refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME) 
LEFT JOIN (SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys 
	ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
WHERE cols.TABLE_NAME = 'Tavern_info' UNION ALL SELECT ')';




--HW5  #3
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


select * from classlvl

Declare @ColumnName as Varchar(50)
declare @ssql nvarchar(200)
declare @dataType nvarchar(150)

Set @ColumnName ='class'+
Set @dataType ='nvarchar(50)'
set @ssql = 'Alter table classlvl Add '+ @ColumnName+' '+ @dataType 


print @ssql 
exec sp_executesql @ssql
go
select* from classlvl
--CREATE PROCEDURE classcount
DECLARE @classmax smallint
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


DECLARE @name NVARCHAR(MAX) = 'class'
DECLARE @lvl  NVARCHAR(MAX) = 'lvl'

DECLARE @sql NVARCHAR(MAX) = 'ALTER TABLE #guestclasses ADD '+@name+' nvarchar(10) null'
--DECLARE @sql2 NVARCHAR(50)= 'ALTER TABLE #guestclasses ADD '+@lvl+' nvarchar(10) null'

EXEC sys.sp_executesql @sql;

set 
count(classlvl.guest_id)  >0 (concat(class_name, classlvl