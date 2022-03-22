USE IEPM
GO
CREATE TABLE [dbo].[Account](
	[Username] VARCHAR(20) NOT NULL,
	[Password] VARCHAR(10) NOT NULL,
	PRIMARY KEY([Username])
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
	[DOB] DATE,
	[Gender] BIT,
	[Description] NVARCHAR(300),
	PRIMARY KEY([Customer_ID])
)
GO
CREATE TABLE [dbo].[Supplier](
	[Supplier_ID] INT NOT NULL IDENTITY(1, 1),
	[Supplier_Name] NVARCHAR(200) NOT NULL,
	[Address] NVARCHAR(200),
	[Phone] VARCHAR(10),
	[DOB] DATE,
	[Gender] BIT,
	[Description] NVARCHAR(300),
	PRIMARY KEY([Supplier_ID])
)
GO
CREATE TABLE [dbo].[Product](
	[Product_ID] BIGINT NOT NULL IDENTITY(1, 1),
	[Product_Name] NVARCHAR(100) NOT NULL,
	[Brand_ID] INT FOREIGN KEY REFERENCES [Brand]([Brand_ID]),
	[Category_ID] INT FOREIGN KEY REFERENCES [Category](Category_ID),
	[Cost] INT NOT NULL,
	[Price] INT NOT NULL,
	[Unit] NVARCHAR(100) NOT NULL,
	[Quantity] INT NOT NULL,
	[Status] INT NOT NULL,
	[Description] NVARCHAR(300),
	PRIMARY KEY([Product_ID])
)


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
	[Discount] FLOAT NOT NULL,
	[Discount_Type] BIT NOT NULL,
	[Pay] FLOAT NOT NULL,
	[Total_Amount] FLOAT NOT NULL,
	[Status] INT NOT NULL,
	[Description] NVARCHAR(300),
	PRIMARY KEY([Import_Invoice_ID])
)
GO
CREATE TABLE [dbo].[Import_Invoice_Detail](
	[Import_Invoice_Detail_ID] INT NOT NULL IDENTITY(1, 1),
	[Import_Invoice_ID] INT FOREIGN KEY REFERENCES [Import_Invoice]([Import_Invoice_ID]),
	[Product_ID] BIGINT FOREIGN KEY REFERENCES [Product]([Product_ID]),
	[Unit_Price] FLOAT NOT NULL,
	[Quantity] INT NOT NULL,
	PRIMARY KEY([Import_Invoice_Detail_ID], [Product_ID])
)
GO
CREATE TABLE [dbo].[Return_Invoice](
	[Return_Invoice_ID] INT NOT NULL IDENTITY(1, 1),
	[Date] DATE NOT NULL,
	[Supplier_ID] INT FOREIGN KEY REFERENCES [Supplier]([Supplier_ID]),
	[Discount] FLOAT NOT NULL,
	[Discount_Type] BIT NOT NULL,
	[Pay] FLOAT NOT NULL,
	[Total_Amount] FLOAT NOT NULL,
	[Status] INT NOT NULL,
	[Description] NVARCHAR(300),
	PRIMARY KEY([Return_Invoice_ID])
)
GO
CREATE TABLE [dbo].[Return_Invoice_Detail](
	[Return_Invoice_Detail_ID] INT NOT NULL IDENTITY(1, 1),
	[Return_Invoice_ID] INT FOREIGN KEY REFERENCES [Return_Invoice]([Return_Invoice_ID]),
	[Product_ID] BIGINT FOREIGN KEY REFERENCES [Product]([Product_ID]),
	[Unit_Price] FLOAT NOT NULL,
	[Quantity] INT NOT NULL,
	PRIMARY KEY([Return_Invoice_Detail_ID], [Product_ID])
)
GO 
CREATE TABLE [dbo].[Order](
	[Order_ID] INT NOT NULL IDENTITY(1, 1),
	[Date] DATETIME NOT NULL,
	[Customer_ID] INT FOREIGN KEY REFERENCES [Customer]([Customer_ID]),
	[Discount] FLOAT NOT NULL,
	[Pay] FLOAT NOT NULL,
	[Discount_Type] BIT NOT NULL,
	[Total_Amount] FLOAT NOT NULL,
	[Status] INT NOT NULL,
	[Description] NVARCHAR(300),
	PRIMARY KEY([Order_ID])
)
GO
CREATE TABLE [dbo].[Order_Detail](
	[Order_Detail_ID] INT NOT NULL IDENTITY(1, 1),
	[Order_ID] INT FOREIGN KEY REFERENCES [Order]([Order_ID]),
	[Product_ID] BIGINT FOREIGN KEY REFERENCES [Product]([Product_ID]),
	[Unit_Price] FLOAT NOT NULL,
	[Quantity] INT NOT NULL,
	PRIMARY KEY([Order_Detail_ID], [Product_ID])
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
	INSERT INTO [dbo].[Product](Product_Name, Category_ID, Brand_ID, Cost, Price, Unit, Quantity, Status)
	VALUES('Product ' + CAST(@RUN AS VARCHAR(10)), 8, 9, 40, 45, N'Cái', 0, 1)
	SET @RUN = @RUN + 1;
END


select Count(*) from product


INSERT INTO Supplier(Supplier_Name, phone) VALUES ('Lam', '111') 
delete from supplier where supplier_id = 2
INSERT INTO Supplier(Supplier_Name, Phone) VALUES ('Lam', '0385981070') 