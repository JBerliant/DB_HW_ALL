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


--4. Write a stored procedure that deletes a Tavern ( don’t run it yet or rollback your transaction if you do )

--5. Write a trigger that watches for deleted taverns and use it to remove taverns, supplies, rooms, and services tied to it
--6. Write a stored procedure that uses the function from the last assignment that returns open rooms with their prices, and automatically book the lowest price room with a guest for one day
--7. Write a trigger that watches for new bookings and adds a new sale for the guest for a service (for free if you can in your schema)