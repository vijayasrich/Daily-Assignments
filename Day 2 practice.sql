create database practice
create table Employee
(
id int,
name varchar(50),
Salary int,
Gender varchar(10),
City varchar(50),
Dept varchar(50)
)
insert into Employee values(3,'Aara',50000,'Female','Chennai','IT')
insert into Employee values(2,'Luna',40000,'Female','Hyderabad','IT')
insert into Employee values(1,'Sara',30000,'Female','Chennai','HR')
insert into Employee values(4,'Deepak',50000,'Male','Chennai','HR')
insert into Employee values(5,'Ajay',35000,'Male','Hyderabad','IT')
insert into Employee values(6,'Ram',45000,'Male','Pune','IT')
insert into Employee values(9,'Meera',30000,'Female','Mumbai','IT')
insert into Employee values(8,'Sunil',60000,'Male','Chennai','IT')
insert into Employee values(7,'Gayatri',40000,'Female','Banglore','IT')
insert into Employee values(10,'Snigdha',50000,'Female','Chennai','sales')
select * from Employee
create index IX_EMPLOYEE_ID
on EMPLOYEE(ID asc)
create clustered index IX_EMPLOYEE_ID1
on EMPLOYEE(ID asc)
create table Employee1
(Id int primary key,
Name varchar(50),
Salary int,
Gender varchar(10),
City varchar(50),
Dept varchar(50)
)
select * from Employee1
insert into Employee1 values(3,'Aara',50000,'Female','Chennai','IT')
insert into Employee1 values(2,'Luna',40000,'Female','Hyderabad','IT')
insert into Employee1 values(1,'Sara',30000,'Female','Chennai','HR')
insert into Employee1 values(4,'Deepak',50000,'Male','Chennai','HR')
insert into Employee1 values(5,'Ajay',35000,'Male','Hyderabad','IT')
insert into Employee1 values(6,'Ram',45000,'Male','Pune','IT')
insert into Employee1 values(9,'Meera',30000,'Female','Mumbai','IT')
insert into Employee1 values(8,'Sunil',60000,'Male','Chennai','IT')
insert into Employee1 values(7,'Gayatri',40000,'Female','Banglore','IT')
insert into Employee1 values(10,'Snigdha',50000,'Female','Chennai','sales')

select * from sales.customers
--Example of unique index
create unique index idx_unique_email
on sales.customers(email)
--example for clustered index
create clustered index IX_EMPLOYEE_ID1
on EMPLOYEE(ID asc)
--non clustered index
create nonclustered index idx_name
on sales.customers(first_name,last_name)

create table Department
(
Id int,
Name varchar(100)
)
insert into Department
values(1,'HR'),
(1,'Admin')
select * from Department

create clustered index idx_dept_id
on Department(Id)
insert into Department values(2,'IT'),
(3,'Sales'),
(2,'Information tech')
insert into Department (Name) values('Insurance')

--views
create table tblEmployee
(
Id int primary key,
Name nvarchar(30),
Salary int,
Gender nvarchar(10),
DepartmentId int
)
create table tblDepartment
(
DeptId int primary key,
DeptName nvarchar(20)
)

insert into tblDepartment values(1,'IT')
insert into tblDepartment values(2,'Payroll')
insert into tblDepartment values(3,'HR')
insert into tblDepartment values(4,'Admin')

insert into tblEmployee values(1,'Aara',7000,'Female',3)
insert into tblEmployee values(2,'Luna',4000,'Female',2)
insert into tblEmployee values(3,'Ajay',6000,'Male',1)
insert into tblEmployee values(4,'Laara',4500,'Female',4)
insert into tblEmployee values(5,'Meera',5000,'Female',1)
insert into tblEmployee values(6,'Karthik',3000,'Male',3)

select Id,Name,Salary,Gender,DeptName
from tblEmployee
join tblDepartment
on tblemployee.DepartmentId=tblDepartment.DeptId
create view vWEmployeesByDepartment
as
select Id,Name,Salary,Gender,DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId

select * from vWEmployeesByDepartment
select * from tblEmployee
update vWEmployeesByDepartment set Name='sara' where Id=5
insert into vWEmployeesByDepartment values(7,'Ram',3500,'Male','IT')
Create View vWITDepartment_Employees
as 
Select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment. DeptId
where tblDepartment.DeptName = 'IT'

select * from vWITDepartment_Employees

--View that returns all columns except Salary column:

Create View vWEmployeesNonConfidentialData
as
Select Id, Name, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId

Create View vWEmployeesCountByDepartment
as
Select DeptName, COUNT (Id) as TotalEmployees
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId
Group By DeptName

select* from vWEmployeesCountByDepartment

sp_helptext vWEmployeesCountByDepartment

create table orders(
order_id int primary key,
customer_id int,
order_date date
)

create table order_audit(
audit_id int identity primary key,
order_id int,
customer_id int,
order_date date,
audit_date datetime default getdate())
alter table Order_Audit add audit_information varchar(max)

select * from Orders
select * from order_audit
create trigger trgAfterInsertOrder
on Orders
after insert
as
begin
declare @auditInfo nvarchar(1000)
set @auditInfo='Data Inserted'
insert into order_audit(order_id,customer_id,order_date,audit_information)
select order_id,customer_id,order_date,@auditInfo
from inserted
end
insert into orders values(1001,31,'10-10-2024')
insert into orders values(1002,41,'10-08-2024')
update orders set customer_id=32 where order_id=1
update orders set customer_id=31 where order_id=1001
----------Example:After or For trigger with update
create trigger trgAfterUpdateOrder
on Orders
for update
as
begin
declare @auditInfo nvarchar(1000)
set @auditInfo='Data changed'
insert into order_audit(order_id,customer_id,order_date,audit_information)
select order_id,customer_id,order_date,@auditInfo
from inserted
end

update orders set customer_id=33,order_date='10-11-2024'
where order_id=1001
update Orders set customer_id=32,order_date='10-10-2022'
where ORDER_ID=1001

----Example for Instead of trigger
create view vwEmployeeDetails
as
select Id,Name,Gender,DeptName from tblEmployee e
join tblDepartment d
on e.DepartmentId=d.DeptId
select * from vwEmployeeDetails
insert vwEmployeeDetails values(7,'Tina','Female','HR')

create trigger tr_vwEmployeeDetails_InsteadOfInsert
on vwEmployeeDetails
instead of insert
as
begin
declare @deptId int
select @deptId=DeptId from tblDepartment
join inserted
on inserted.DeptName=tblDepartment.DeptName

if(@deptId is null)
begin
raiserror('Invalid Department Name .Statement Terminated',16,1)
return 
end
insert into tblEmployee(Id,Name,Gender,DepartmentId)
select Id,Name,Gender,@deptId
from inserted
end
insert vwEmployeeDetails values(7,'Tina','Female','HR')
insert vwEmployeeDetails values(8,'Raju','Male','Banking')
---transaction by using bikstores database
begin transaction
insert into sales.orders(customer_id,order_status,order_date,required_date,shipped_date,store_id,staff_id)
values(49,4,'20170228','20170301','20170302',2,6)
insert into sales.order_items(order_id,item_id,product_id,quantity,list_price,discount)
values(93,12,8,2,269.99,0.07)
if @@error=0
begin
commit transaction
print 'Insertion successful!...'
end
else
begin
rollback transaction
print 'Something went wrong while insertion'
end
select * from sales.order_items
select * from production.products where product_id=8


create table Customers
(customer_id int primary key,
name varchar(100),active bit)
create table Orders1
(order_id int primary key,
customer_id int foreign key references Customers(customer_id),
order_status varchar(100))
insert into Customers values(1,'kim',1),(2,'Pam',1)
insert into Orders1 values(101,1,'Pending'),(102,2,'Pending')

select * from Customers
select * from Orders1
--transaction A
begin transaction
update Customers set Name='John'
where customer_id=1
waitfor delay '00:00:05';
update Orders1 set order_status='Processed'
where order_id=101
commit transaction 
--transaction B
begin transaction
update Orders1 set order_status='Shipped'
where order_id=101
waitfor delay '00:00:05'
update Customers set Name='Aara'
where customer_id=1
commit transaction

