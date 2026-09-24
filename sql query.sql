select * from inventory db
select COUNT(*) as Total_Transactions from inventory db
select SUM(Stock_In) as Total_Stock_In from inventory db
select SUM(Stock_Out) as Total_Stock_Out from inventory db
with LatestStock as
(
select *, ROW_NUMBER() over
(
partition by Product_ID
order by Date DESC,
Transaction_ID DESC
) as rn
from inventory db
) select SUM(Current_Stock) as Current_Stock from LatestStock where rn=1;
with LatestStock as
(
select *, ROW_NUMBER() over
(
PARTITION by Product_ID
order by Date DESC,
Transaction_ID DESC
) as rn
from inventory db_accessadmin)
select SUM(Stock_Value_AED) as Total_Stock_VAlue_AED from LatestStock where rn=1;
with LatestStock as 
(
select *, ROW_NUMBER() over
(
PARTITION by Product_ID
order by Date DESC,
Transaction_ID DESC
) as rn
from inventory db_accessadmin)
select COUNT(*) as Reorder_Items from LatestStock where rn=1 and Reorder_Status='Reorder Required';
select 
YEAR(Date) as year,
MONTH(Date) as month,
SUM(Stock_In) as Total_Stock_In,
SUM(Stock_Out) as Total_Stock_Out
from inventory db
Group by
YEAR(Date),
MONTH(Date)
order by 
year,
month;
select 
Category,
SUM(Stock_Value_AED) as
Stock_Value_AED
from [Inventory db]
Group by Category
order by Stock_Value_AED DESC;
Select Reorder_Status,
COUNT(*) as Transaction_Count
from inventory db_accessadmin Group by Reorder_Status;
select Top 10
PRODUCT_Name,
SUM(Stock_Value_AED) as
Stock_Value_AED
from [Inventory db]
group by Product_Name
order by Stock_Value_AED DESC;
select Category,
SUM(Stock_In) as Stock_In,
SUM(Stock_Out) as Stock_Out
from [Inventory db]
Group by Category
order by Category


