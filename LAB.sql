/* 
create stored procedure
adds a supply sale and deducts from tavern inventory appropriately
input will be sale_id (will collect sku and tavern_id, and qty)
then will access inventory of tavern_id and subtract quantity for that sku, and timestamp update

CREATE PROCEDURE UpdateTavern
@Tavern varchar(30), @LocId int, @OId int, @floors int, @TavernId int
AS BEGIN
Update Taverns SET (Name = @Tavern, LocationId = @LocId, OwnerId = @OId, Floors = @floors) 
	WHERE Id = @TavernId;
END


EXEC UpdateTavern
@Tavern=‘The Prancing Pony II’, @LocId=2, @OId=3, @Floors=10, @TavernId=1
SELECT * FROM Taverns
*/

drop procedure if exists inv_updates
create PROCEDURE inv_update
@item_sale int
AS
BEGIN
--SELECT item_sku, qty, tavern_id FROM tavern_item_sales tis WHERE @item_sale = tis.it_sale
Update tavern_inventory set item_qty = (item_qty - tis.qty)
from tavern_item_sales tis join tavern_inventory ti on tis.item_sku = ti.item_sku
WHERE (tis.item_sku = ti.item_sku) AND (it_sale = @item_sale)
END

EXEC inv_update @item_sale = 2

SELECT * FROM tavern_inventory


SELECT * FROM INSERTED
tavern_item_sales

create trigger tis_inv_upd
ON tavern_item_sales AFTER INSERT
AS
BEGIN
DECLARE @item_sale int
DECLARE @item_sku int
DECLARE @qty int 
SELECT @item_sale = it_sale from INSERTED
SELECT @item_sku = item_sku from INSERTED
SELECT @qty = qty FROM INSERTED
Update tavern_inventory set item_qty = (item_qty - tis.qty)
from tavern_item_sales tis join tavern_inventory ti on tis.item_sku = ti.item_sku
WHERE (tis.item_sku = ti.item_sku) AND (it_sale = @item_sale)
END