--assignment:7
--Create a trigger to updates the Stock (quantity) table whenever new order placed in orders tables
create trigger trgUpdateStockOnOrder
on sales.orders
after insert
as
begin
update production.stocks
set quantity = s.quantity - oi.quantity
from production.stocks s
join sales.order_items oi on s.product_id = oi.product_id
join inserted o on oi.order_id = o.order_id
where s.store_id = o.store_id
end
select * from production.stocks
--assignment:8
--Create a trigger to that prevents deletion of a customer if they have existing orders.
create trigger trgPreventCustomerDeletion
on sales.customers
instead of delete
as
begin
if exists (
select 1
from sales.orders o
join deleted d on o.customer_id = d.customer_id)
begin
raiserror ('Cannot delete customer with existing orders.', 16, 1);
rollback transaction;
end
else
begin
delete from sales.customers
where customer_id in (select customer_id from deleted);
end
end
delete from sales.customers
where customer_id = 49
select * from sales.customers
select * from sales.orders

--assignment :9
-- Create Employee,Employee_Audit  insert some test data
create table Employee1 (
employee_id int identity(1,1) primary key,
name nvarchar(50),
position nvarchar(50),
salary decimal(10, 2),
hire_date datetime default getdate()
)
create table Employee_Audit (
audit_id int identity(1,1) primary key,
employee_id int,
name nvarchar(50),
position nvarchar(50),
salary decimal(10, 2),
change_date datetime default getdate(),
audit_action nvarchar(50)
)
insert into Employee1 (name, position, salary)
values ('Aara',  'Manager', 60000),
       ('Luna', 'Developer', 55000),
       ('Sana', 'Tester', 40000)
--	b) Create a Trigger that logs changes to the Employee Table into an Employee_Audit Table
create trigger trgLogEmployeeChanges
on Employee1
after update, delete
as
begin
if exists (select 1 from inserted)
begin
insert into Employee_Audit (employee_id,name, position, salary, audit_action)
select i.employee_id, i.name, i.position, i.salary, 'UPDATE'
from inserted i
join deleted d on i.employee_id = d.employee_id;
end
if exists (select 1 from deleted)
begin
insert into Employee_Audit (employee_id,name, position, salary, audit_action)
select d.employee_id, d.name, d.position, d.salary, 'DELETE'
from deleted d;
end
end
update Employee1
set salary = 65000
where employee_id = 1;
delete from Employee1
where employee_id = 2;
select * from Employee_Audit
select * from Employee1
--assignment:10
/*10) create Room Table with below columns:
RoomID,RoomType,Availability
create Bookins Table with below columns:
BookingID,RoomID,CustomerName,CheckInDate,CheckInDate
Insert some test data with both  the tables
Ensure both the tables are having Entity relationship
Write a transaction that books a room for a customer, ensuring the room is marked as unavailable.*/
create table Room (
RoomID int primary key identity(1,1),
RoomType nvarchar(50),
Availability bit 
)
create table Bookings (
BookingID int primary key identity(1,1),
RoomID int,
CustomerName nvarchar(100),
CheckInDate datetime,
CheckOutDate datetime,
foreign key (RoomID) references Room(RoomID) on delete cascade on update cascade
)
insert into Room (RoomType, Availability)
values 
('Single', 1),
('Double', 1),
('Suite', 1)
begin transaction;
if exists (
select 1 from Room
where RoomID = 1 and Availability = 1
)
begin
insert into Bookings (RoomID, CustomerName, CheckInDate, CheckOutDate)
values (1,'Ram','2024-09-09','2024-09-11')
update Room
set Availability = 0
where RoomID = 1
commit transaction;
end
else
begin
rollback transaction;
raiserror('Room is not available for booking', 16, 1);
end
select * from Bookings
select * from Room
begin transaction;
if exists (
select 1 from Room
where RoomID = 1 and Availability = 1
)
begin
insert into Bookings (RoomID, CustomerName, CheckInDate, CheckOutDate)
values (1, 'John', '2024-12-01', '2024-12-05');
update Room
set Availability = 0
where RoomID = 1;
commit transaction;
end
else
begin
rollback transaction;
raiserror('Room is not available for booking', 16, 1);
end
