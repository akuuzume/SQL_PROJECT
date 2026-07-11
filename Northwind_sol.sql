//BEGINNER

SELECT CategoryName,Description FROM Northwind.dbo.Categories;
SELECT * FROM Northwind.dbo.Shippers;
SELECT * FROM Northwind.dbo.Employees;
SELECT FirstName,LastName,HireDate FROM Northwind.dbo.Employees where Title='Sales Representative';
SELECT FirstName,LastName,HireDate FROM Northwind.dbo.Employees where Title='Sales Representative' and Country='USA';
SELECT *FROM Northwind.dbo.Orders where EmployeeID=5;
SELECT OrderID,OrderDate FROM Northwind.dbo.Orders where EmployeeID=5;
SELECT SupplierID, ContactName, ContactTitle from Northwind.dbo.Suppliers where ContactTitle !='Marketing Manager';
select ProductID,ProductName from Northwind.dbo.Products where ProductName like '%queso%';
select ShipCountry,OrderID,CustomerID from Northwind.dbo.Orders where ShipCountry in ('France', 'Belgium');
select ShipCountry,OrderID, CustomerID from Northwind.dbo.Orders where ShipCountry in ('Brazil','Mexico','Argentina','Venezuela');
select FirstName,LastName,Title,BirthDate from Northwind.dbo.Employees Order by BirthDate;
select FirstName,LastName,Title,convert(date,BirthDate) as DateOnly from Northwind.dbo.Employees Order by (BirthDate);
select FirstName,LastName, CONCAT(FirstName,' ',LastName) as FullName from Northwind.dbo.Employees;
select OrderID,UnitPrice,Quantity,UnitPrice*Quantity as TotalPrice from Northwind.dbo.[Order Details];
select count(CustomerID) as TotalCustomers from Northwind.dbo.Customers;
select * from Northwind.dbo.Orders;
select [First Order]=min(OrderDate) from Northwind.dbo.Orders;
select distinct ShipCountry from Northwind.dbo.Orders order by ShipCountry;
select * from Northwind.dbo.Customers;
select ContactTitle, count(ContactTitle)[Count ContactTitle] from Northwind.dbo.Customers group by ContactTitle order by [Count ContactTitle] DESC;
select  * from  Northwind.dbo.Products;
select  * from  Northwind.dbo.Suppliers;
select p.ProductID,p.ProductName,s.CompanyName[Supplier] from Northwind.dbo.Suppliers as s inner join Northwind.dbo.Products as p on s.SupplierID=p.SupplierID;
select * from Northwind.dbo.Shippers;
select o.OrderID,s.CompanyName[Shipper],convert(date,o.OrderDate) as DateOnly from Northwind.dbo.Orders as o  join Northwind.dbo.Shippers as s on s.ShipperID=o.ShipVia where OrderID<10300 order by o.OrderID;
select * from Northwind.dbo.Categories;

//INTERMEDIATE

select c.CategoryName, count(p.CategoryID)[TotalProduct] from Northwind.dbo.Products as p left join  Northwind.dbo.Categories as c on c.CategoryID=p.CategoryID group by c.CategoryName order by TotalProduct DESC ;
select * from Northwind.dbo.Customers;
select City,Country, TotalCustomers=Count(*) from Northwind.dbo.Customers group by City,Country order by count(*) DESC;
select ProductID, productName, UnitsInStock,ReorderLevel from Northwind.dbo.Products where UnitsInStock<ReorderLevel order by  ProductID;
select ProductID, productName,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued from Northwind.dbo.Products where UnitsInStock+UnitsOnOrder<=ReorderLevel and Discontinued=0;
select CustomerID,CompanyName,Region from Northwind.dbo.Customers group by Region,CompanyName,CustomerID order by case when region is null then 1 else 0 end,Region ;
select top 3 ShipCountry, avg(Freight)[Average Cost] from Northwind.dbo.Orders group by ShipCountry order by [Average Cost]DESC;
select ShipCountry, avg(Freight)[Average Cost] from Northwind.dbo.Orders WHERE OrderDate >= '2015-01-01' AND OrderDate < '2016-01-01' group by ShipCountry order by  [Average Cost]DESC;
select top 3 ShipCountry,avg(Freight)[Freight Charges] from Northwind.dbo.Orders where OrderDate>=Dateadd(year,-1,(SELECT MAX(OrderDate) FROM Northwind.dbo.Orders)) group by ShipCountry order by [Freight Charges] DESC;
select * from Northwind.dbo.[Order Details];
select * from Northwind.dbo.Employees;
select ee.EmployeeID,ee.LastName,o.OrderID,p.ProductName from Northwind.dbo.Products as p inner join Northwind.dbo.[Order Details] as o on p.ProductID=o.ProductID inner join (select e.EmployeeID,e.LastName,ord.OrderID from Northwind.dbo.Employees as e left join Northwind.dbo.Orders as ord on ord.EmployeeID=e.EmployeeID) as ee on ee.OrderID=o.OrderID order by EmployeeID DESC;
select c.CustomerID from Northwind.dbo.Customers as c left join Northwind.dbo.Orders as o on  c.CustomerID=o.CustomerID where o.CustomerID is NULL;  
select c.CustomerID,o.CustomerID from Northwind.dbo.Customers as c left join Northwind.dbo.Orders as o on c.CustomerID=o.CustomerID and o.EmployeeID!=4 where o.CustomerID is NUll;
select c.CustomerID,c.CompanyName,o.OrderID,sum(ord.UnitPrice*ord.Quantity)[Cost]from Northwind.dbo.Customers as c  join Northwind.dbo.Orders as o on c.CustomerID=o.CustomerID  join Northwind.dbo.[Order Details] as ord on ord.OrderID=o.OrderID  where o.OrderDate>='20160101' AND o.OrderDate<'20170101' group by c.CompanyName,c.CustomerID,o.OrderID having sum(ord.UnitPrice*ord.Quantity)>10000 order by Cost DESC ;
select c.CustomerID,c.CompanyName,sum(ord.UnitPrice*ord.Quantity)[Cost]from Northwind.dbo.Customers as c  join Northwind.dbo.Orders as o on c.CustomerID=o.CustomerID  join Northwind.dbo.[Order Details] as ord on ord.OrderID=o.OrderID  where o.OrderDate>='20160101' AND o.OrderDate<'20170101' group by c.CompanyName,c.CustomerID having sum(ord.UnitPrice*ord.Quantity)>15000 order by Cost DESC ;
select c.CustomerID,c.CompanyName,sum(ord.UnitPrice*ord.Quantity)[Cost],sum(ord.UnitPrice*ord.Quantity*(1-ord.Discount))[Cost with discount]from Northwind.dbo.Customers as c  join Northwind.dbo.Orders as o on c.CustomerID=o.CustomerID  join Northwind.dbo.[Order Details] as ord on ord.OrderID=o.OrderID  where o.OrderDate>='19960101' AND o.OrderDate<'19970101' group by c.CompanyName,c.CustomerID having sum(ord.UnitPrice*ord.Quantity)>15000 order by [Cost with discount] DESC ;
select o.EmployeeID, o.OrderID,convert(date,OrderDate)[DateofOrder] from Northwind.dbo.Orders as o where OrderDate=EOMONTH(OrderDate) order by o.EmployeeID,o.OrderID;
select top 10 o.OrderID, count(ord.ProductID) as Counting from Orders as o join [Order Details] as ord on o.OrderID=ord.OrderID  group by o.OrderID order by Counting DESC;
select top (2) percent OrderID from Orders order by NEWID();
select OrderID from [Order Details]  where Quantity>=60 group by OrderID having count(*)>1;
select * from [Order Details]  where OrderID in(select OrderID from [Order Details]  where Quantity>=60 group by OrderID having count(*)>1) and Quantity>=60;
select ord.OrderID, ProductID, UnitPrice, Quantity, Discount from [Order Details] as ord join (select OrderID from [Order Details] as ord where Quantity >= 60 group by OrderID, Quantity having count(*) > 1) as PotentialProblemOrders on PotentialProblemOrders.OrderID = ord.OrderID order by OrderID, ProductID;
select CustomerID,OrderID,RequiredDate,ShippedDate from Orders where cast(RequiredDate as date)<cast(ShippedDate as date);
select e.LastName,o.EmployeeID,count(o.OrderID) as lateOrders from Orders as o left join Employees as e on e.EmployeeID=o.EmployeeID where cast(RequiredDate as date)<cast(ShippedDate as date) group by o.EmployeeID,e.LastName order by lateOrders DESC;
select e.EmployeeID,e.LastName,count(OrderID)[orders by employee],count(case when cast(RequiredDate as date)<cast(ShippedDate as date) then 1 end ) as [Late Orders] from Employees as e left join Orders as o on o.EmployeeID=e.EmployeeID  group by e.EmployeeID,e.LastName;
select e.LastName,e.EmployeeID,count(o.OrderID) from Employees as e left join Orders as o on o.EmployeeID=e.EmployeeID  group by e.LastName,e.EmployeeID having count(o.OrderID)=0;
select * from [Order Details];

//ADVANCED
with order_totals as(
select OrderID,sum(UnitPrice*Quantity) as Total_Price from [Order Details] group by OrderID
)
,high_value as(
 select *,
 case 
	when Total_Price>=10000 then 'High Value'
	else 'Regular Customer'
 end as Customer_Category
 from order_totals
),
orders_1996 as(
select CustomerID, OrderID, OrderDate from Orders where YEAR(OrderDate)=1996
)
select * from high_value as h inner join orders_1996 as o on h.OrderID=o.OrderID where h.Total_Price>=10000 order by Total_Price DESC ;

with order_totals as(
select OrderID,Total_Price=UnitPrice*Quantity from [Order Details]
),
customer_details as( 
select c.CustomerID,c.CompanyName,o.OrderID from Customers as c inner join Orders as o on c.CustomerID=o.CustomerID
)
select cc.CustomerID,cc.CompanyName,sum(oo.Total_Price)  from order_totals as oo inner join customer_details as cc on cc.OrderID=oo.OrderID group by cc.CompanyName,cc.CustomerID having sum(oo.Total_Price)>=15000;

with order_totals as(
select OrderID,Total_Price=UnitPrice*Quantity,Total_Price_with_discount=UnitPrice*Quantity*(1-Discount) from [Order Details]
),
customer_details as( 
select c.CustomerID,c.CompanyName,o.OrderID from Customers as c inner join Orders as o on c.CustomerID=o.CustomerID
)
select cc.CustomerID,cc.CompanyName,sum(oo.Total_Price)[Total_Price],sum(oo.Total_Price_with_discount)[Total_Price_with_discount]  from order_totals as oo inner join customer_details as cc on cc.OrderID=oo.OrderID group by cc.CompanyName,cc.CustomerID having sum(oo.Total_Price)>=1000 and sum(oo.Total_Price_with_discount)>=1000 order by Total_Price DESC;

select EmployeeID,OrderID,OrderDate from Orders where OrderDate=EOMonth(orderDate) order by EmployeeID,OrderID

select top 10 orderID, count(*)[top lines] from [Order Details] group by OrderID order by [top lines] DESC

37
select top (2) percent OrderID from orders order by NEWID()

38
select OrderID from [Order Details] where Quantity>=60 group by OrderID,Quantity having count(*)>1 

39
with PossibleDuplicates as(
	select OrderID from [Order Details] where Quantity>=60 group by OrderID,Quantity having count(*)>1 
)

select * from [Order Details] where OrderID in (select OrderID from PossibleDuplicates) order by OrderID

40

Select
 od.OrderID
,od.ProductID
,od.UnitPrice
,od.Quantity
,od.Discount
From [Order Details] as od 
Join (
Select
OrderID
From [Order Details]
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
) pp
on pp.OrderID = od.OrderID
Order by od.OrderID, od.ProductID

41
select distinct OrderID,OrderDate=CONVERT(date,OrderDate),RequiredDate=CONVERT(date,RequiredDate),ShippedDate=CONVERT(date,OrderDate) from Orders where RequiredDate<ShippedDate

42

select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofLateOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID where RequiredDate<ShippedDate group by e.EmployeeID,(e.FirstName+' '+e.LastName) order by NumberofLateOrders DESC

43
with LaterOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofLateOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID where RequiredDate<ShippedDate group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
),
TotalNumberOfOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
)


select lo.Employee_Name, tno.NumberofOrders,lo.NumberofLateOrders from LaterOrders as lo left join TotalNumberOfOrders as tno on lo.EmployeeID=tno.EmployeeID order by lo.NumberofLateOrders desc

44

with LaterOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofLateOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID where RequiredDate<ShippedDate group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
),
TotalNumberOfOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
)


select e.EmployeeID,lo.Employee_Name, tno.NumberofOrders,lo.NumberofLateOrders from employees as e join LaterOrders as lo on e.EmployeeID=lo.EmployeeID left join TotalNumberOfOrders as tno on lo.EmployeeID=tno.EmployeeID order by lo.NumberofLateOrders desc

45

with LaterOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofLateOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID where RequiredDate<ShippedDate group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
),
TotalNumberOfOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
)


select e.EmployeeID,lo.Employee_Name, tno.NumberofOrders,IsNull(lo.NumberofLateOrders,0) as NumberofLateOrders from employees as e join LaterOrders as lo on e.EmployeeID=lo.EmployeeID left join TotalNumberOfOrders as tno on lo.EmployeeID=tno.EmployeeID order by lo.NumberofLateOrders desc

46
with LaterOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofLateOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID where RequiredDate<ShippedDate group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
),
TotalNumberOfOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
)


select lo.Employee_Name, tno.NumberofOrders,lo.NumberofLateOrders ,(lo.NumberofLateOrders*100.0/tno.NumberofOrders) as PercentageLateOrders from LaterOrders as lo left join TotalNumberOfOrders as tno on lo.EmployeeID=tno.EmployeeID order by lo.NumberofLateOrders desc

47
with LaterOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofLateOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID where RequiredDate<ShippedDate group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
),
TotalNumberOfOrders as(
	select (e.FirstName+' '+e.LastName) as Employee_Name,e.EmployeeID,count(*) as NumberofOrders from orders as o left join employees as e on o.EmployeeID=e.EmployeeID group by e.EmployeeID,(e.FirstName+' '+e.LastName) 
)


select lo.Employee_Name, tno.NumberofOrders,lo.NumberofLateOrders ,ROUND(CAST(lo.NumberofLateOrders AS DECIMAL(10,2)) / tno.NumberofOrders, 2) as PercentageLateOrders from LaterOrders as lo left join TotalNumberOfOrders as tno on lo.EmployeeID=tno.EmployeeID order by lo.NumberofLateOrders desc

48 and 49
with order_totals as(
select OrderID,sum(UnitPrice*Quantity) as Total_Price from [Order Details] group by OrderID
)
,high_value as(
 select *,
 case 
	when Total_Price>=10000 then 'Very High Value'
	when Total_Price>=5000 and Total_Price< 10000 then 'High Value'
	when Total_Price>=1000 and Total_Price< 5000 then 'Mid Value'
	else 'Low Value'
 end as Customer_Category
 from order_totals
),
orders_1996 as(
select CustomerID, OrderID, OrderDate from Orders where YEAR(OrderDate)=1997
)
select * from high_value as h inner join orders_1996 as o on h.OrderID=o.OrderID  order by o.CustomerID DESC 

50
with order_totals as(
select OrderID,sum(UnitPrice*Quantity) as Total_Price from [Order Details] group by OrderID
)
,high_value as(
 select *,
 case 
	when Total_Price>=10000 then 'Very High Value'
	when Total_Price>=5000 and Total_Price< 10000 then 'High Value'
	when Total_Price>=1000 and Total_Price< 5000 then 'Mid Value'
	else 'Low Value'
 end as Customer_Category
 from order_totals
),
numberPerCategory as(
select Customer_Category,count(*) as numberPerCategory  from high_value  group by Customer_Category 
)

select *,cast(numberPerCategory * 100.0 / SUM(numberPerCategory) OVER() as decimal(5,2)) as PercentagePerCategory from numberPerCategory

51

with order_totals as(
select OrderID,sum(UnitPrice*Quantity) as Total_Price from [Order Details] group by OrderID
)
,high_value as(
 select *,
 case 
	when Total_Price>=10000 then 'Very High Value'
	when Total_Price>=5000 and Total_Price< 10000 then 'High Value'
	when Total_Price>=1000 and Total_Price< 5000 then 'Mid Value'
	else 'Low Value'
 end as Customer_Category
 from order_totals
)

select o.CustomerID,c.CompanyName,ot.Total_Price,hv.Customer_Category from order_totals as ot left join high_value as hv on ot.OrderID=hv.OrderID left join Orders as o on ot.OrderID=o.OrderID left join customers as c on o.CustomerID=c.CustomerID

52
select distinct country from Suppliers union 
select distinct country from Customers

53
SELECT s.Country AS SupplierCountry,c.Country AS CustomerCountry FROM (SELECT DISTINCT Country FROM Suppliers) as s FULL OUTER JOIN (SELECT DISTINCT Country FROM Customers) c ON s.Country = c.Country

54

SELECT ISNULL(s.Country,c.Country) as Country,isnull(s.TotalSuppliersPerCountry,0) as TotalSuppliersPerCountry ,isnull(c.TotalCustomersPerCountry,0) as TotalCustomersPerCountry FROM (SELECT DISTINCT count(*) as TotalSuppliersPerCountry, Country FROM Suppliers group by Country) as s FULL OUTER JOIN (SELECT DISTINCT count(*) as TotalCustomersPerCountry, Country FROM Customers group by Country) c ON s.Country = c.Country

