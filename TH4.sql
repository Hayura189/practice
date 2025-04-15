use csdl_04
--1
select count(id) as total_row_customer from Customer
select count(id) as total_row_supplier from Supplier
select count(id) as total_row_order from [Order]
select count(id) as total_row_product from Product
select count(id) as total_row_orderitem from OrderItem
--2
select * from Customer
where Country like 'USA'
--3
select * from Supplier
where Country like 'Japan'
--4
select * from Product
where unitprice between 10 and 20
--5
select count(id) as total_order_2013 from [Order]
where year(OrderDate)=2013
--6
select avg(TotalAmount) as average_order from [Order]
where year(OrderDate)=2013 and MONTH(OrderDate)=8
--7
select top 10 * from [Order]
order by TotalAmount desc
--8
select * from Product
where UnitPrice=(select max(UnitPrice) from product) or UnitPrice=(select min(UnitPrice) from Product)
--9
select count(distinct Country) from Customer
--10
select Supplier.CompanyName, Product.ProductName from Product
join Supplier on Product.SupplierId=Supplier.Id
where product.IsDiscontinued=1
--11
select top 5 ProductName from Product
order by Product.UnitPrice desc
--12
select top 6 Product.ProductName,sum(Quantity) as total_sold from OrderItem
join Product on OrderItem.ProductId=Product.Id
group by PRODUCT.ProductName
order by sum(quantity) desc
--13
select top 9 Product.ProductName,sum([OrderItem].Quantity*[OrderItem].UnitPrice) as total_item from OrderItem
join Product on OrderItem.ProductId=Product.Id
group by Product.ProductName
order by total_item desc
--14
select Country,count(id) as number_customer from Customer
group by country
--15
select month(OrderDate) as [month],count(id) as [numbers] from [Order]
where YEAR(OrderDate)=2013
group by month(OrderDate)
order by [month] asc
--16
select distinct Product.ProductName,Product.UnitPrice as [price_product],OrderItem.UnitPrice as [price_order] from OrderItem
join product on OrderItem.ProductId=Product.Id
where Product.UnitPrice != OrderItem.UnitPrice
--17
select sum([Order].TotalAmount) as total_order from [Order]
where year(OrderDate)=2014 and month(OrderDate)=3
--18
select month([order].OrderDate) as [month],count(distinct Customer.Id) as [number_customer] from [order]
join Customer on [Order].CustomerId=Customer.Id
where year([Order].OrderDate)=2013
group by month([Order].OrderDate)
--19
select distinct Customer.Id,Customer.FirstName,Customer.LastName,Customer.City,Customer.Country,Customer.Phone from OrderItem
join [Order] on OrderItem.OrderId=[Order].Id
join Customer on [Order].CustomerId=Customer.Id
join Product on OrderItem.ProductId=Product.Id
where Product.ProductName like 'Longlife Tofu'
--20
select * 
from OrderItem
right join Product on OrderItem.ProductId=Product.Id
where OrderItem.ProductId is null
--21
select Customer.Id,Customer.FirstName,Customer.LastName,Customer.City,Customer.Country,Customer.Phone from [Order]
right join Customer on [Order].CustomerId=Customer.Id
where [Order].CustomerId is null
--22
select Customer.Country, sum([Order].TotalAmount) as total_order_of_country from [Order]
join customer on [Order].CustomerId=Customer.Id
group by Customer.Country
--23
select year(OrderDate) as [year],avg([Order].TotalAmount) as [average_order_of_year] from [Order]
group by year(OrderDate)
--24
select month([order].OrderDate) as [month],count(distinct Product.Id) as [number_product_of_month] from OrderItem
join [Order] on OrderItem.OrderId=[Order].Id
join Product on OrderItem.ProductId=Product.Id
where year([Order].OrderDate)=2012
group by month([order].OrderDate)
--25
select OrderItem.OrderId,count(distinct OrderItem.ProductId) as [number_item] from OrderItem
join [Order] on OrderItem.OrderId=[Order].Id
group by OrderItem.OrderId
order by number_item desc
--26
select Supplier.CompanyName,count(Product.Id) as [number_product] from Product
join Supplier on Product.SupplierId=Supplier.Id
group by Supplier.CompanyName
order by number_product desc
--27
select month([Order].OrderDate) as [month],min(TotalAmount) as minimum from OrderItem
join [order] on OrderItem.OrderId=[Order].Id
where year([Order].OrderDate)=2014
group by month([Order].OrderDate)
--28
select Product.ProductName,sum(OrderItem.Quantity*OrderItem.UnitPrice) as [total_bill] from OrderItem
join [Order] on OrderItem.OrderId=[Order].Id
join Customer on [Order].CustomerId=Customer.Id
join Product on OrderItem.ProductId=Product.Id
where Customer.Country like 'Germany'
group by Product.ProductName
order by total_bill desc
--29
select Customer.Country,avg([Order].TotalAmount) from [Order]
join Customer on [Order].CustomerId=Customer.Id
group by Customer.Country
--30
select Supplier.CompanyName,sum(OrderItem.Quantity) from OrderItem
join Product on OrderItem.ProductId=Product.Id
join Supplier on Product.SupplierId=Supplier.Id
group by Supplier.CompanyName
