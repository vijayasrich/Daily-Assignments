--assignment:1
/*You need to create a stored procedure that retrieves a list of all customers who have purchased a specific product.
consider below tables Customers, Orders,Order_items and Products
Create a stored procedure,it should return a list of all customers who have purchased the specified product, 
including customer details like CustomerID, CustomerName, and PurchaseDate.
The procedure should take a ProductID as an input parameter.*/
create procedure GetCustomersByProducts @product_id int
as
begin
select C.customer_id,C.first_name,C.last_name,O.order_date as purchasedate
from sales.customers c 
inner join  sales.orders O on C.customer_id=O.customer_id
inner join sales.order_items OI on O.order_id=OI.order_id
where OI.product_id=@product_id
end
exec GetCustomersByProducts @product_id=5
--assignment:2
/*CREATE TABLE Department with the below columns
  ID,Name
populate with test data
CREATE TABLE Employee with the below columns
  ID,Name,Gender,DOB,DeptId
populate with test data*/
--department
create table Department(
Id int identity(1,1) primary key,
[Name] varchar(30) not null)
--employee
create table Employee(
Id int identity(1,1) primary key,
[Name] varchar(50) not null,
Gender char(1) not null,
DOB date,
DeptId int,
foreign key(DeptId) references Department(Id))
--values of department
insert into Department([Name]) 
values('IT'),
('Sales'),
('Hr')
select * from Department
insert into Employee ([Name], Gender, DOB, DeptId) values
('Aara', 'F', '2003-09-09', 1),
('Luna', 'F', '2000-09-20', 2),
('Ram', 'M', '2001-10-10', 3),
('Laasya', 'F', '2002-06-04', 3),
('Shyam', 'M', '2001-11-11', 1)
select * from Employee

--a) Create a procedure to update the Employee details in the Employee table based on the Employee id.
create proc UpdateEmployeeDetails
    @employeeid int,
    @newname nvarchar(100),
    @newgender char(1),
    @newdob date,
    @newdeptid int
as
begin
    update Employee
    set [Name] = @newname,
        Gender = @newgender,
        DOB = @newdob,
        DeptId = @newdeptid
    where Id = @employeeid;
end
exec UpdateEmployeeDetails @employeeid = 3, @newname = 'Harsha', @newgender = 'M', @newdob = '2000-09-02', @newdeptid = 3;

--b) Create a Procedure to get the employee information bypassing the employee gender and department id from the Employee table
create procedure getemployeesbygenderanddept
    @gender char(1),
    @deptid int
as
begin
    select 
        Id, [Name], Gender, DOB, DeptId
    from 
        Employee
    where 
        Gender = @gender and DeptId = @deptid;
end;
exec getemployeesbygenderanddept @Gender = 'M', @DeptId = 3;
--c) Create a Procedure to get the Count of Employee based on Gender(input)
create procedure getemployeecountbygender
    @gender char(1)
as
begin
    select 
        count(*) as employeecount
    from 
        Employee
    where 
        Gender = @gender;
end;
exec getemployeecountbygender @Gender = 'M';

--assignment:3
--Create a user Defined function to calculate the TotalPrice based on productid and Quantity Products Table
CREATE FUNCTION CalculateTotalPrice
(
    @ProductID INT,
    @Quantity INT
)
RETURNS DECIMAL(18, 2) 
AS
BEGIN
    DECLARE @Price DECIMAL(18, 2);
    SELECT @Price = list_price 
    FROM production.products
    WHERE product_id = @ProductID;
    RETURN @Price * @Quantity;
END;
SELECT dbo.CalculateTotalPrice(3, 5) AS TotalPrice;
--assignment:4
/*4) create a function that returns all orders for a specific customer,
including details such as OrderID, OrderDate, and the total amount of each order.*/
CREATE FUNCTION GetCustomerOrders
(
    @CustomerID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        O.order_id,
        O.order_date,
        SUM(OI.quantity * OI.list_price) AS TotalAmount
    FROM 
        sales.orders O
    INNER JOIN 
        sales.order_items OI ON O.order_id = OI.order_id
    WHERE 
        O.customer_id = @CustomerID
    GROUP BY 
        O.order_id, O.order_date
);
SELECT * FROM dbo.GetCustomerOrders(1);
--assignment:5
/*create a Multistatement table valued function that calculates the total sales for each product,
considering quantity and price.*/
CREATE FUNCTION CalculateTotalSalesPerProduct()
RETURNS @ProductSales TABLE 
(
    ProductID INT,
    TotalSales DECIMAL(18, 2)
)
AS
BEGIN
    -- Insert into the table variable the total sales for each product
    INSERT INTO @ProductSales (ProductID, TotalSales)
    SELECT 
        OI.product_id,
        SUM(OI.Quantity * OI.list_price) AS TotalSales
    FROM 
        sales.order_items OI
    GROUP BY 
        OI.product_id;

    RETURN;  -- Return the result set from the table variable
END;
SELECT * FROM dbo.CalculateTotalSalesPerProduct();
--assignment:6
/*create a  multi-statement table-valued function that 
lists all customers along with the total amount they have spent on orders.*/
CREATE FUNCTION CalculateTotalSpentPerCustomer()
RETURNS @CustomerSpending TABLE 
(
    CustomerID INT,
    CustomerName NVARCHAR(100),
    TotalSpent DECIMAL(18, 2)
)
AS
BEGIN
    -- Insert the total amount spent by each customer
    INSERT INTO @CustomerSpending (CustomerID, CustomerName, TotalSpent)
    SELECT 
        C.Customer_ID,
        CONCAT(C.first_name, ' ', C.last_name) AS CustomerName,
        SUM(OI.quantity * OI.list_price) AS TotalSpent
    FROM 
        sales.customers C
    INNER JOIN 
        sales.orders O ON C.customer_id = O.customer_id
    INNER JOIN 
        sales.order_items OI ON O.order_id = OI.order_id
    GROUP BY 
        C.customer_id, C.first_name,C.last_name;

    RETURN; 
END;
SELECT * FROM dbo.CalculateTotalSpentPerCustomer();

