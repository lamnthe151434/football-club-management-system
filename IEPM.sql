use master
drop database IEPM
create database IEPM
USE IEPM
GO
CREATE TABLE [dbo].[Account](
	[Username] VARCHAR(20) NOT NULL,
	[Password] VARCHAR(10) NOT NULL,
	PRIMARY KEY([Username])
)
GO
CREATE TABLE [dbo].[Store](
	[Store_Name] NVARCHAR(200) NOT NULL,
	[Owner] NVARCHAR(100) NOT NULL,
	[Address] NVARCHAR(200) NOT NULL,
	[Phone] NVARCHAR(10) NOT NULL CONSTRAINT [TenDigits] CHECK (LEN([PHONE]) = 10),
	PRIMARY KEY([Store_Name])
)
GO
CREATE TABLE [dbo].[Category](
	[Category_ID] INT NOT NULL IDENTITY(1, 1),
	[Category_Name] NVARCHAR(100) NOT NULL, 
	[Description] NVARCHAR(300),
	PRIMARY KEY([Category_ID])
)
GO
CREATE TABLE [dbo].[Brand](
	[Brand_ID] INT NOT NULL IDENTITY(1, 1),
	[Brand_Name] NVARCHAR(100) NOT NULL, 
	[Description] NVARCHAR(300),
	PRIMARY KEY([Brand_ID])
)
GO
CREATE TABLE [dbo].[Customer](
	[Customer_ID] INT NOT NULL IDENTITY(1, 1),
	[Customer_Name] NVARCHAR(200) NOT NULL,
	[Address] NVARCHAR(200),
	[Phone] VARCHAR(10),
	[Email] VARCHAR(100),
	PRIMARY KEY([Customer_ID])
)
GO
CREATE TABLE [dbo].[Supplier](
	[Supplier_ID] INT NOT NULL IDENTITY(1, 1),
	[Supplier_Name] NVARCHAR(200) NOT NULL,
	[Address] NVARCHAR(200),
	[Phone] VARCHAR(10),
	[Email] VARCHAR(100),
	PRIMARY KEY([Supplier_ID])
)
GO
CREATE TABLE [dbo].[Unit](
	[Unit_ID] INT NOT NULL IDENTITY(1,1),
	[Unit_Name] NVARCHAR NOT NULL
	PRIMARY KEY([Unit_ID])
)
GO
CREATE TABLE [dbo].[Product](
	[Product_ID] BIGINT NOT NULL,
	[Product_Name] NVARCHAR(100) NOT NULL,
	[Brand_ID] INT FOREIGN KEY REFERENCES [Brand]([Brand_ID]),
	[Category_ID] INT FOREIGN KEY REFERENCES [Category](Category_ID),
	[Cost] INT NOT NULL,
	[Price] INT NOT NULL,
	[Unit] NVARCHAR NOT NULL,
	[Quantity] INT NOT NULL,
	[Status] BIT NOT NULL,
	PRIMARY KEY([Product_ID])
)
GO
CREATE TABLE [dbo].[Product_Supplier](
	[Product_ID] BIGINT FOREIGN KEY REFERENCES [Product]([Product_ID]),
	[Supplier_ID] INT FOREIGN KEY REFERENCES [Supplier]([Supplier_ID]),
	PRIMARY KEY([Product_ID], [Supplier_ID])
)
GO
CREATE TABLE [dbo].[Import_Invoice](
	[Import_Invoice_ID] INT NOT NULL IDENTITY(1, 1),
	[Date] DATE NOT NULL,
	[Supplier_ID] INT FOREIGN KEY REFERENCES [Supplier]([Supplier_ID]),
	PRIMARY KEY([Import_Invoice_ID])
)
GO
CREATE TABLE [dbo].[Import_Invoice_Detail](
	[Import_Invoice_Detail_ID] INT NOT NULL IDENTITY(1, 1),
	[Import_Invoice_ID] INT FOREIGN KEY REFERENCES [Import_Invoice]([Import_Invoice_ID]),
	[Product_ID] BIGINT FOREIGN KEY REFERENCES [Product]([Product_ID]),
	[Quantity] INT NOT NULL,
	PRIMARY KEY([Import_Invoice_Detail_ID])
)
GO
CREATE TABLE [dbo].[Return_Invoice](
	[Return_Invoice_ID] INT NOT NULL IDENTITY(1, 1),
	[Date] DATE NOT NULL,
	[Supplier_ID] INT FOREIGN KEY REFERENCES [Supplier]([Supplier_ID]),
	PRIMARY KEY([Return_Invoice_ID])
)
GO
CREATE TABLE [dbo].[Return_Invoice_Detail](
	[Return_Invoice_Detail_ID] INT NOT NULL IDENTITY(1, 1),
	[Return_Invoice_ID] INT FOREIGN KEY REFERENCES [Return_Invoice]([Return_Invoice_ID]),
	[Product_ID] BIGINT FOREIGN KEY REFERENCES [Product]([Product_ID])
	[Quantity] INT NOT NULL,
	PRIMARY KEY([Return_Invoice_Detail_ID])
)
GO 
CREATE TABLE [dbo].[Order](
	[Order_ID] INT NOT NULL IDENTITY(1, 1),
	[Date] DATE NOT NULL,
	[Customer_ID] INT FOREIGN KEY REFERENCES [Customer]([Customer_ID]),
	PRIMARY KEY([Order_ID])
)
GO
CREATE TABLE [dbo].[Order_Detail](
	[Order_Detail_ID] INT NOT NULL IDENTITY(1, 1),
	[Order_ID] INT FOREIGN KEY REFERENCES [Order]([Order_ID]),
	[Product_ID] BIGINT FOREIGN KEY REFERENCES [Product]([Product_ID]),
	[Quantity] INT NOT NULL,
	PRIMARY KEY([Order_Detail_ID])
)


-- Insert into [dbo].[Account]
INSERT INTO [dbo].[Account]([Username], [Password]) 
VALUES ('Admin', '55555')


SELECT * FROM [Category]
SELECT * FROM [Brand]
SELECT * FROM [Product]


DECLARE  @RUN INT = 1;

WHILE @RUN < 10 
BEGIN
	INSERT INTO [dbo].[Category](Category_Name, Description) VALUES('Category ' + CAST(@RUN AS VARCHAR(10)), 'Description ' +  CAST(@RUN AS VARCHAR(10)) )
	SET @RUN = @RUN + 1;
END

DECLARE  @RUN INT = 1;
WHILE @RUN < 10 
BEGIN
	INSERT INTO [dbo].[Brand](Brand_Name, Description) VALUES('Brand ' + CAST(@RUN AS VARCHAR(10)), 'Description ' +  CAST(@RUN AS VARCHAR(10)) )
	SET @RUN = @RUN + 1;
END

DECLARE  @RUN INT = 1;
WHILE @RUN <= 10
BEGIN
	INSERT INTO [dbo].[Product](Product_ID,Product_Name, Category_ID, Brand_ID, Cost, Price, Quantity, Status)
	VALUES(@RUN,'Product ' + CAST(@RUN AS VARCHAR(10)), 8, 9, 40, 45, 0, 1)
	SET @RUN = @RUN + 1;
END


select Count(*) from product