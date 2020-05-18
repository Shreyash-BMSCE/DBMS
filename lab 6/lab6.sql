create table customer( 
cust_no int, 
cname varchar(20), 
city varchar(20), 
primary key(cust_no)); 
 
create table orders( 
order_no int, 
odate date, 
cust_no int,  
ord_amt int, 
primary key(order_no), 
foreign key(cust_no) references customer(cust_no)); 
 
create table item( 
item_no int, 
unit_price int, 
primary key(item_no)); 
 
create table order_item( 
order_no int, 
item_no int , 
qty int, 
foreign key(order_no) references orders(order_no), 
foreign key(item_no) references item(item_no) on delete set NULL); 
 
create table warehouse( 
warehouse_no int, 
city varchar(20), 
primary key(warehouse_no)); 
 
create table shipment( 
order_no int, 
warehouse_no int, 
shit_date date, 
foreign key(order_no) references orders(order_no), 
foreign key(warehouse_no) references warehouse(warehouse_no)); 
 
 insert into customer values('&cust_no', '&cname', '&city'); 
 select * from customer; 
  
insert into orders values('&order_no', '&odate',' &cust_no', '&ord_amt'); 
select * from orders; 
 
insert into item values('&item_no',' &unit_price'); 
select *from item; 
 
insert into order_item values('&order_no', '&item_no',' &qty'); 
select *from order_item; 
 
insert into warehouse values('&warehouse_no', '&city'); 
select *from warehouse; 
 
insert into shipment values('&order_no', '&warehouse_no', '&shit_date'); 
select * from shipment; 
 
select C.cname, count(*) as NO_OF_ORDERS, avg(O.ord_amt) as 
AVG_ORDER_AMT 
 from customer C, orders O 
 where (C.cust_no = O.cust_no) group by cname; 
  
 select * from orders where order_no in ( 
 select order_no from shipment where warehouse_no in ( 
 select warehouse_no from warehouse where city='bangalore')); 
  
 delete from item 
 where item_no = 10; 
