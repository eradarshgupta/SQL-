-- Q 1
create table Salespeople (
snum int,
sname varchar(20),
city varchar(20),
comm decimal(4,2)
);

insert into Salespeople values (1001,'Peel','London',0.12),
(1002,'Serres','San Jose',0.13),
(1003,'Axelrod','New York',0.10),
(1004,'Motika','London',0.11),
(1007,'Rafkin','Barcelona',0.15);

select * from Salespeople;

-- Q 2
create table Cust(
cnum int,
cname varchar(20),
city varchar(20),
rating int, 
snum int
);

insert into Cust values (2001,'Hoffman','London',100,1001),
(2002,'Giovanne','Rome',200,1003),
(2003,'Liu','San Jose',300,1002),
(2004,'Grass','Berlin',100,1002),
(2006,'Clemens','London',300,1007),
(2007,'Pereira','Rome',100,1004),
(2008,'James','London',200,1007);

select * from Cust;

-- Q 3
create table Orders (
onum int,
amt decimal (6,2),
odate date,
cnum int,
snum int
);

insert into Orders values (3001,18.69,'1994-10-03',2008,1007),
(3002,1900.10,'1994-10-03',2007,1004),
(3003,767.19,'1994-10-03',2001,1001),
(3005,5160.45,'1994-10-03',2003,1002),
(3006,1098.16,'1994-10-04',2008,1007),
(3007,75.75,'1994-10-05',2004,1002),
(3008,4723.00,'1994-10-05',2006,1001),
(3009,1713.23,'1994-10-04',2002,1003),
(3010,1309.95,'1994-10-06',2004,1002),
(3011,9891.88,'1994-10-06',2006,1001);

select * from Orders;

-- Q 4 
select s.sname as Salespeople, c.cname as Customer_name, c.city as City
from Salespeople s 
inner join Cust c 
on s.city = c.city;

-- Q 5
select cname as Customers, sname as Salesperson
from Cust
inner join Salespeople
on Salespeople.snum = Cust.snum 
inner join Orders
on Orders.cnum = Cust.cnum and Orders.snum = Salespeople.snum;

-- Q 6 
select Orders.onum, Orders.amt, Orders.odate, Orders.cnum, Orders.snum
from Orders
inner join Salespeople
on Orders.snum = Salespeople.snum
inner join Cust
on Orders.cnum = Cust.cnum
where Cust.city <> Salespeople.city;

-- Q 7
select o.onum, c.cname, s.sname 
from Orders o 
join Cust c on c.cnum = o.cnum 
join Salespeople s on s.snum = o.snum;

-- Q 8
select c1.cnum, c1.cname, c1.rating, c2.cnum, c2.cname, c2.rating
from cust c1, cust c2
where c1.rating = c2.rating
and c1.cnum <> c2.cnum;

-- Q 9 
select c1.cname as "Customer Name 1", c2.cname as "Customer Name 2" 
from Cust c1 
inner join Orders o1 on c1.cnum = o1.cnum 
inner join Orders o2 on o1.snum = o2.snum 
inner join Cust c2 on o2.cnum = c2.cnum 
where c1.cnum <> c2.cnum 
group by c1.cname, c2.cname;

-- Q 10
select s1.sname, s2.sname 
from Salespeople s1, Salespeople s2 
where s1.city = s2.city 
and s1.comm <> s2.comm;

-- Q 11 
select o.onum, o.amt, o.odate 
from orders o
inner join cust c
on o.cnum = c.cnum 
inner join salespeople s
on o.snum = s.snum
where c.cnum = 2008 and s.snum = c.snum;

-- Q 12
select * 
from Orders 
where amt > (select avg(amt) from orders where odate = '1994-10-04');

-- Q 13
select o.onum, o.amt, o.odate, o.cnum, o.snum
from Orders o
join Salespeople s
on o.snum = s.snum
where s.city = 'London';

-- Q 14
select c.cnum, c.cname, c.city, c.rating 
from Cust c 
join Salespeople s 
on c.snum = s.snum 
where c.cnum > (select snum from Salespeople where sname = 'Serres') + 1000;

-- Q 15
select count(c.cnum) 
from Cust c 
inner join Salespeople s on c.snum = s.snum 
where c.rating > (select avg(rating) from Cust where city = 'San Jose') 
and s.city = 'San Jose';

-- Q 16
select s.sname, c.cname
from Salespeople s join Orders o
on s.snum = o.snum
join Cust c
on o.cnum = c.cnum
group by s.sname, c.cname;
