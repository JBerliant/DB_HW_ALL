--1. Write a stored procedure that takes a class name and returns all guests that have any levels of that class
CREATE PROCEDURE has_class
@class varchar(20)
AS
SET NOCOUNT ON
declare @id smallint
select @id  = class.class_id from class where class_name = @class
SELECT humanoid_name nam, class_name cn, lvl from classlvl lvl 
join visitor_id vi on vi.visitor_id =lvl.guest_id
join class cl on cl.class_id = lvl.class_id
join tavern_humanoids th on th.humanoid_id = vi.humanoid_id
WHERE lvl.class_id = @id
OR cl.class_name = @class
go
exec has_class @class = 'summoner'
go

--2. Write a stored procedure that takes a guest id and returns the total that guest spent on services
drop procedure if exists custo
go

CREATE PROCEDURE custo 
@id INT
AS
SET NOCOUNT ON
DECLARE @total dec(6,2)
set @total = 
(select sum(total_sale) total from
	(
	select customer_id, total_sale from tavern_sales ts
	union
	select customer_id, total_sale from tavern_item_sales tis
	union
	select guest_id, sale_amt from room_stays rs	
	)
    as total where customer_id = @id)
if @total IS NOT NULL 
	select @total
ELSE
	select 'BAD INPUT'
go


exec custo @id = 600006
go
--3. Write a stored procedure that takes a level and an optional argument that determines whether the procedure returns guests of that level and higher or that level and lower
DROP PROCEDURE IF EXISTS lvlnet
GO

CREATE PROCEDURE lvlnet
@lvl smallint,
@updown VARCHAR(10) = NULL
AS
SET NOCOUNT ON
	IF (@updown = 'up')
	BEGIN
	(
	SELECT humanoid_name nam, class_name cn, lvl from classlvl lvl 
	join visitor_id vi on vi.visitor_id =lvl.guest_id
	join class cl on cl.class_id = lvl.class_id
	join tavern_humanoids th on th.humanoid_id = vi.humanoid_id
	WHERE lvl >= @lvl
	)END
	ELSE IF (@updown = 'down')
	BEGIN
	(
	SELECT humanoid_name nam, class_name cn, lvl from classlvl lvl 
	join visitor_id vi on vi.visitor_id =lvl.guest_id
	join class cl on cl.class_id = lvl.class_id
	join tavern_humanoids th on th.humanoid_id = vi.humanoid_id
	WHERE lvl<=@lvl)
	END
	ELSE
	BEGIN
	(
	SELECT humanoid_name nam, class_name cn, lvl from classlvl lvl 
	join visitor_id vi on vi.visitor_id =lvl.guest_id
	join class cl on cl.class_id = lvl.class_id
	join tavern_humanoids th on th.humanoid_id = vi.humanoid_id
	WHERE lvl =@lvl)
	END
	go

EXEC lvlnet @lvl = 23, @updown ='up'
go


--4. Write a stored procedure that deletes a Tavern ( don’t run it yet or rollback your transaction if you do )
DROP PROCEDURE IF EXISTS rmTavern
go

CREATE PROCEDURE rmTavern
@id int
AS
SET NOCOUNT ON
delete from tavern_info where tavern_id = @id
go
select tavern_id from tavern_info
--BEGIN TRAN
--EXEC rmTavern @id = 26425352
--ROLLBACK TRAN
go

--5. Write a trigger that watches for deleted taverns and use it to remove taverns, supplies, rooms, and services tied to it

CREATE TABLE old_tav_ref
(old_id INT PRIMARY KEY, old_nm VARCHAR(250), old_loc VARCHAR(250))
go

DROP TRIGGER IF EXISTS dtref
go
/*
method #1 (the cheating method) = set all FKs to ON DELETE CASCADE
method #2  delete the records that we don't care about, 
but don't delete things like 
	employee history
	sales history
	visitor/guest/customer information
INSTEAD update / modify referencing records
 1. alter tables to CASCADE ON UPDATE or NULL on delete
 2. INSTEAD OF DELETE  -- change to null or remove from view or delete unimportant records
	but update other records to continue to hold values for sales and customer information
	(can set to NULL For those records so that record data will be retained
3. I couldn't determine the best sequence or procedures for this on our schema and it seemed outisde
of the scope of what I could do on my own

INSTEAD OF DELETE

CREATE TRIGGER dtref ON tavern_info FOR DELETE
AS
DECLARE @id int

--first: create a bkup record of the old tavern (for sales history, and other reference)
INSERT INTO  old_tav_ref (old_id, old_nm, old_loc) SELECT 'old_'+tavern_id,tavern_name,tavern_location FROM DELETED

-- then remove inventory, rooms, services from old taverns        
-- **extra, if time : alter foreign keys of visitor_id, employment_id, classlvl
--ALTER TABLE 
--PRIMARY KEY,

DELETE tavern_id FROM (
tavern_inventory
service_status,
delivery_received,
tavern_item_sales
tavern_item_sales 
tavern_employment,
tavern_sales,
visitor_id,
tavern_rooms) where tavern_id = @id;
*/
GO

--6. Write a stored procedure that uses the function from the last assignment that returns open rooms with their prices, and automatically book the lowest price room with a guest for one day
DROP PROCEDURE IF EXISTS cheap_avial
GO

CREATE PROCEDURE cheap_avail
@guest_id int,
@date as date
AS 
SET NOCOUNT ON
DECLARE @rmid INT
DECLARE @rate DEC(6,2)
DECLARE @tavid INT
Select top 1 @rmid = room_stays.room_id, @rate = room_rate, @tavid = tavern_id--room_attr, room_rate, tavern_id
from room_stays join tavern_rooms on room_stays.room_id = tavern_rooms.room_id
WHERE 
		((@date<convert(date,DATE_IN)) AND (@date<convert(date,DATE_OUT)))
	OR  ((@date>CONVERT(DATE,DATE_OUT)) AND (@date>CONVERT(DATE,DATE_IN)))
ORDER by room_rate asc
INSERT INTO room_stays (room_id, guest_id, DATE_IN,DATE_OUT,days_stayed, sale_amt, time_of_sale)
SELECT @rmid, @guest_id,@date,DATEADD(dy,1,@date),1,@rate, GETDATE()
go

BEGIN TRAN
EXEC cheap_avail @guest_id = 600007, @date = '1244-03-01'
go
select * from room_stays
ROLLBACK TRAN
go

--7. Write a trigger that watches for new bookings and adds a new sale for the guest for a service (for free if you can in your schema)
DROP TRIGGER IF EXISTS bookr
GO
CREATE TRIGGER bookr on room_stays AFTER INSERT
AS
DECLARE @guest_id INT
DECLARE @sale_time datetime2(0)
DECLARE @rmid INT
declare @tavid INT
SELECT @rmid = room_id, @guest_id = guest_id, @sale_time = time_of_sale from INSERTED
SELECT @tavid = tavern_id from tavern_rooms where room_id=@rmid
INSERT INTO tavern_sales (customer_id, service_id, service_price, service_qty, total_sale, sale_datetime, tavern_id)
SELECT @guest_id,7,0.00,1,0.00,@sale_time,@tavid

select* from tavern_sales

