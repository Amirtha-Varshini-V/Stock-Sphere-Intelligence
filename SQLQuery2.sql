use sphere
select * from [Inventory_Transactions data]
select COUNT (*) as Total_Taransactions from [Inventory_Transactions data] 
select SUM(Stock_In) as Total_Stock_In from [Inventory_Transactions data]
select SUM(Stock_Out) as Total_Stock_Out from [Inventory_Transactions data]
with LatestStock as
(
select *, ROW_NUMBER() over
(
Partition by Product_ID
order by Date DESC,
Transaction_ID DESC
) as rn
from [Inventory_Transactions data]
) select SUM(Current_Stock) as Current_Stock from LatestStock where rn=1;
with LatestStock as
(
select *, ROW_NUMBER() over
(
Partition by Product_ID
order by Date DESC,
Transaction_ID DESC
) as rn
from [Inventory_Transactions data])
select SUM(Stock_Value) as Total_Stock_Value from LatestStock where rn=1;
with LatestStock as
(
select *, ROW_NUMBER() over
(
PARTITION by Product_ID
order by Date DESC,
Transaction_ID DESC
) as rn
 from [Inventory_Transactions data])
 select COUNT(*) as Reorder_Items from LatestStock where rn=1 and Reorder_Status='Reorder Required';
 select 
 YEAR(Date) as year,
 MONTH(Date) as month,
 SUM(Stock_In) as Total_Stock_In,
 SUM(Stock_Out) as Total_Stock_Out
 from [Inventory_Transactions data]
 group by
 YEAR(Date),
 MONTH(Date)
 order by
 year,
 month;
 select Category,
 SUM(Stock_In) as Stock_In,
 SUM(Stock_Out) as Stock_Out
 from [Inventory_Transactions data]
 group by Category
 order by Category
 select Top 10
 Product_Name,
 SUM(Stock_VAlue) as
 Stock_Value
 from [Inventory_Transactions data]
 group by Product_Name
 order by Stock_Value Desc;
 select Category,
 SUM(Stock_Value) as
 Stock_Value
 from [Inventory_Transactions data]
 group by Category
 order by Stock_Value DESC;
 select Reorder_Status,
 COUNT(*) as Transaction_Count
 from [Inventory_Transactions data] group by Reorder_Status;



