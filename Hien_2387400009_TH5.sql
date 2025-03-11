use store
--1. Truy vấn số lượng cửa hàng
select count(store_id) as [so_luong_cua_hang] from stores
--2. Truy vấn số lượng nhân viên
select count(staff_id) as [so_luong_nhan_vien] from staffs
--3. Nhân viên nào có ít đơn hàng bị từ chối nhất
select top 1 staffs.staff_id,staffs.first_name,staffs.last_name, COUNT(orders.order_status) as [so_lan] from orders
join staffs on orders.staff_id=staffs.staff_id
where orders.order_status=3
group by staffs.staff_id,staffs.first_name,staffs.last_name
order by so_lan asc
--4. Truy vấn những khách hàng dùng hotmail
select * from customers
where email like '%hotmail%'
--5. Truy vấn danh sách các thành phố có khách hàng sinh sống.
select distinct city from customers
--6. Truy vấn số lượng khách hàng theo từng thành phố
select city, count(customers.customer_id) as [so_luong_khach_hang] from customers
group by city
--7. Bang nào có nhiều khách hàng sinh sống nhất.
select top 1 customers.[state], count(customers.customer_id) as [total_customer] from customers
group by customers.[state]
order by total_customer desc
--8. Truy vấn số lượng nhãn hàng (brands).
select count(brand_id) as [so_luong_nhan_hang] from brands
--9. Truy vấn tổng số lượng xe có trong kho của mỗi cửa hàng.
select distinct stores.store_name, sum(stocks.quantity) as [total] from stocks
join stores on stocks.store_id=stores.store_id
group by stores.store_name
--10. Truy vấn số lượng sản phẩm theo từng nhãn hàng.
select distinct brands.brand_name, count(products.product_id) as [total] from brands
join products on brands.brand_id=products.brand_id
group by brands.brand_name
--11. Truy vấn số lượng sản phẩm theo từng phân loại (category).
select categories.category_name, count(products.product_id) from products
join categories on products.category_id=categories.category_id
group by categories.category_name 
--12. Truy vấn tổng số lượng đã bán ra của những xe thuộc phân loại Cruisers Bicycles.
select sum(order_items.quantity) as [total_sold] from order_items
join products on order_items.product_id=products.product_id
join categories on products.category_id=categories.category_id
join orders on order_items.order_id=orders.order_id
where categories.category_name='Cruisers Bicycles' and orders.order_status=4
--13. Truy vấn tổng số lượng bán ra của 3 nhãn hàng bán chạy nhất.
select top 3 brands.brand_name,sum(order_items.quantity) as [total_sold] from order_items
join products on order_items.product_id=products.product_id
join orders on order_items.order_id=orders.order_id
join brands on products.brand_id=brands.brand_id
where orders.order_status=4
group by brands.brand_name
order by total_sold desc
--14. Truy vấn tổng số lượng xe bán ra trong năm 2018.
select sum(order_items.quantity) as [total_sold_18] from order_items
join orders on order_items.order_id=orders.order_id
where orders.order_status=4 and year(orders.order_date)=2018
--15. Truy vấn số lượng đơn hàng theo tháng & năm (gom nhóm theo tháng & năm cùng lúc)
select year(order_date) as [year], month(order_date) as [month] ,count(orders.order_id) as [so_luong_order] from orders
where order_status=4
group by year(order_date),month(order_date)
order by [year] asc,[month] asc
--16. Truy vấn số lượng đơn hàng trung bình theo năm (gợi ý: kết quả từ một sub query có thể được dùng trong phép tính, ví dụ select 18/(select count(brand_id) from brands) ).
select distinct ((select count(orders.order_id) from orders ))*1.0 /(select count(distinct year(order_date))*1.0 from orders) from orders
--17. Truy vấn sản phẩm (product) bán chạy nhất (theo tổng số lượng) nửa đầu năm 2018
select top 1 products.product_name, sum(order_items.quantity) as [total_product] from order_items
join products on order_items.product_id=products.product_id
join orders on order_items.order_id=orders.order_id
where orders.order_status=4 and (year(orders.order_date)=2018 and month(orders.order_date) <=6)
group by products.product_name
order by total_product desc
--18. Truy vấn nhãn hàng bán chạy nhất (theo tổng số lượng) trong nửa cuối năm 2017.
select top 1 brands.brand_name, sum(order_items.quantity) as [total_brand] from order_items
join products on order_items.product_id=products.product_id
join orders on order_items.order_id=orders.order_id
join brands on products.brand_id=brands.brand_id
where orders.order_status=4 and (year(orders.order_date)=2017 and month(orders.order_date) > 6)
group by brands.brand_name
order by total_brand desc
--19. Truy vấn loại xe (category) bán được ít nhất nhất trong quý 3 (tháng 7→9) năm 2017.
select top 1 categories.category_name, sum(order_items.quantity) as [total_category] from order_items
join products on order_items.product_id=products.product_id
join orders on order_items.order_id=orders.order_id
join categories on products.category_id=categories.category_id
where orders.order_status=4 and (year(orders.order_date)=2017 and month(orders.order_date) between 7 and 9)
group by categories.category_name
order by total_category asc
--20. Truy vấn nhân viên bán được ít xe nhất và số lượng xe nv này bán được trong quý 2 (tháng 4→6) năm 2017.
create view staff_that as
(select top 1 staffs.staff_id, sum(order_items.quantity) as [so_xe_da_ban] from orders
join staffs on orders.staff_id=staffs.staff_id
join order_items on orders.order_id=order_items.order_id
group by staffs.staff_id
order by so_xe_da_ban asc);
select staffs.staff_id,staffs.first_name, staffs.last_name,sum(order_items.quantity) as [number_bike] from orders
join order_items on order_items.order_id=orders.order_id
join staffs on orders.staff_id=staffs.staff_id
where staffs.staff_id=(select staff_id from staff_that ) and (year(orders.order_date)=2017 and month(orders.order_date) between 4 and 6)
group by staffs.staff_id,staffs.first_name,staffs.last_name



