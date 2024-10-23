<<<<<<< HEAD
--example 1
create procedure uspDisplayMessage
as
begin
print 'Welcome!...'
end
execute uspDisplayMessage
/*(or)
exec uspDisplayMessage
(or)
uspDisplayMessage*/

--example 2
select * from production.products

create proc uspProductList
as
begin
select Product_name,list_price from production.products
order by product_name
end

drop procedure uspProductList

exec uspProductList

sp_help uspProductList

use BikeStores;
go
exec sp_databases;
--alter procedure
--create proc uspProductList
alter proc uspProductList
as
begin
select Product_name,model_year,list_price from production.products order by list_price desc
end

uspProductList

exec sp_rename 'uspProductList','uspMyProductList'
--parameter in stored procedure
--input,output parameter
create proc uspFindProducts(@modelyear as int)
as
begin
select * from production.products where model_year=@modelyear
end
uspFindProducts 2019

--multiple parameter
CREATE PROC uspFindProductsbyRange (@minPrice decimal, @maxPrice decimal)
AS
BEGIN
SELECT * from production.products where
list_price>=@minPrice AND  list_price<=@maxPrice
END;

uspFindProductsbyRange 100,3000

--using named Parameter
uspFindProductsbyRange
@maxPrice=12000,
@minPrice=5000

--optional parameter
create proc uspFindProductsByName
(@minPrice as decimal=2000,@maxPrice decimal,@name as varchar(max))
as
begin
select * from production.products where list_price>=@minPrice and list_price<=@maxPrice
and
product_name like '%'+@name+'%'
end

uspFindProductsByName 100,1000,'Sun'
--uspFindProductsByName @maxPrice=3000,@name='trek'

CREATE PROCEDURE uspFindProductCountByModelYear (@modelyear int, @productCount int OUTPUT)
AS
BEGIN
select Product_name, list_Price from production.products
WHERE
model_year=@modelyear
select @productCount=@@ROWCOUNT
END

DECLARE @count int;
EXEC uspFindProductCountByModelYear @modelyear=2016, @productCount=@count OUT;;
select @count as 'Number of Products Found';

--can one stored procedure call another stored procedure

CREATE PROC usp_GetAllCustomers
AS
BEGIN
select *
from sales.customers
END

--sp_rename 'usp_GetAllCunstomers', 'usp_GetAllCustomers'

usp_GetAllCustomers

CREATE PROC usp_GetCustomerOrders
@customerId INT
AS
BEGIN
SELECT * FROM sales.orders
WHERE
customer_id=@customerId
END

usp_GetCustomerOrders 1


ALTER PROC usp_GetCustomerData (@cusomterId INT)
AS
BEGIN
EXEC usp_GetAllCustomers;
EXEC usp_GetCustomerOrders @cusomterId;
END

exec usp_GetCustomerData 1

--USDfunction

--Scalar valued function 
create Function GetAllProducts()
RETURNS INT
AS
BEGIN
RETURN (SELECT COUNT(*) from production.products)
END
PRINT dbo.GetAllProducts()

--Table Valued function

--Inline Table valued Function ==> Contain single select statement

Create function GetProductById(@productId int)
Returns Table
as RETURN (Select * from production.products where product_id=@productId)
select * from GetProductById(4)

CREATE FUNCTION ILTVF_GetEmployees()
Returns Table
as
RETURN (SELECT ID,Name,CAST(DOB as DATE)as DOB from Employee)

--multi statement
CREATE FUNCTION MSTVF_GetEmployee()
RETURNS @TempTable Table (ID int,Name varchar(50),DOB Date)
AS
Begin
Insert into @TempTable
Select ID,Name,CAST(DOB as Date) From Employee
Return
End

select * from Employee
select *from MSTVF_GetEmployee()
select *from ILTVF_GetEmployees();

--the data in original table will be modified if we use inline statement
update ILTVF_GetEmployees() Set Name='Geeetha' where ID=1

--cannot update because it is taking the data from temp table
update MSTVF_GetEmployee() Set Name='sitha' where ID=2

select * from sales.orders
select * from sales.order_items

select * from production.products


Create proc usp_GetAllProduct
WITH ENCRYPTION
AS
BEGIN
select * from production.products
END

exec usp_GetAllProduct

sp_help 'usp_GetAllProduct'
sp_help 'getCustomersByProduct'
select * from SYSCOMments where ID=OBJECT_ID('usp_GetAllProduct')

=======
--example 1
create procedure uspDisplayMessage
as
begin
print 'Welcome!...'
end
execute uspDisplayMessage
/*(or)
exec uspDisplayMessage
(or)
uspDisplayMessage*/

--example 2
select * from production.products

create proc uspProductList
as
begin
select Product_name,list_price from production.products
order by product_name
end

drop procedure uspProductList

exec uspProductList

sp_help uspProductList

use BikeStores;
go
exec sp_databases;
--alter procedure
--create proc uspProductList
alter proc uspProductList
as
begin
select Product_name,model_year,list_price from production.products order by list_price desc
end

uspProductList

exec sp_rename 'uspProductList','uspMyProductList'
--parameter in stored procedure
--input,output parameter
create proc uspFindProducts(@modelyear as int)
as
begin
select * from production.products where model_year=@modelyear
end
uspFindProducts 2019

--multiple parameter
CREATE PROC uspFindProductsbyRange (@minPrice decimal, @maxPrice decimal)
AS
BEGIN
SELECT * from production.products where
list_price>=@minPrice AND  list_price<=@maxPrice
END;

uspFindProductsbyRange 100,3000

--using named Parameter
uspFindProductsbyRange
@maxPrice=12000,
@minPrice=5000

--optional parameter
create proc uspFindProductsByName
(@minPrice as decimal=2000,@maxPrice decimal,@name as varchar(max))
as
begin
select * from production.products where list_price>=@minPrice and list_price<=@maxPrice
and
product_name like '%'+@name+'%'
end

uspFindProductsByName 100,1000,'Sun'
--uspFindProductsByName @maxPrice=3000,@name='trek'

CREATE PROCEDURE uspFindProductCountByModelYear (@modelyear int, @productCount int OUTPUT)
AS
BEGIN
select Product_name, list_Price from production.products
WHERE
model_year=@modelyear
select @productCount=@@ROWCOUNT
END

DECLARE @count int;
EXEC uspFindProductCountByModelYear @modelyear=2016, @productCount=@count OUT;;
select @count as 'Number of Products Found';

--can one stored procedure call another stored procedure

CREATE PROC usp_GetAllCustomers
AS
BEGIN
select *
from sales.customers
END

--sp_rename 'usp_GetAllCunstomers', 'usp_GetAllCustomers'

usp_GetAllCustomers

CREATE PROC usp_GetCustomerOrders
@customerId INT
AS
BEGIN
SELECT * FROM sales.orders
WHERE
customer_id=@customerId
END

usp_GetCustomerOrders 1


ALTER PROC usp_GetCustomerData (@cusomterId INT)
AS
BEGIN
EXEC usp_GetAllCustomers;
EXEC usp_GetCustomerOrders @cusomterId;
END

exec usp_GetCustomerData 1

--USDfunction

--Scalar valued function 
create Function GetAllProducts()
RETURNS INT
AS
BEGIN
RETURN (SELECT COUNT(*) from production.products)
END
PRINT dbo.GetAllProducts()

--Table Valued function

--Inline Table valued Function ==> Contain single select statement

Create function GetProductById(@productId int)
Returns Table
as RETURN (Select * from production.products where product_id=@productId)
select * from GetProductById(4)

CREATE FUNCTION ILTVF_GetEmployees()
Returns Table
as
RETURN (SELECT ID,Name,CAST(DOB as DATE)as DOB from Employee)

--multi statement
CREATE FUNCTION MSTVF_GetEmployee()
RETURNS @TempTable Table (ID int,Name varchar(50),DOB Date)
AS
Begin
Insert into @TempTable
Select ID,Name,CAST(DOB as Date) From Employee
Return
End

select * from Employee
select *from MSTVF_GetEmployee()
select *from ILTVF_GetEmployees();

--the data in original table will be modified if we use inline statement
update ILTVF_GetEmployees() Set Name='Geeetha' where ID=1

--cannot update because it is taking the data from temp table
update MSTVF_GetEmployee() Set Name='sitha' where ID=2

select * from sales.orders
select * from sales.order_items

select * from production.products


Create proc usp_GetAllProduct
WITH ENCRYPTION
AS
BEGIN
select * from production.products
END

exec usp_GetAllProduct

sp_help 'usp_GetAllProduct'
sp_help 'getCustomersByProduct'
select * from SYSCOMments where ID=OBJECT_ID('usp_GetAllProduct')

>>>>>>> b76643a7d2fdfdbfbb267c07b997d087bbfb53d6
select * from SYSCOMments where ID=OBJECT_ID('getCustomersByProduct')