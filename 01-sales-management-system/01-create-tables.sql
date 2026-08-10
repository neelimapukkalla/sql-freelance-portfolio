CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Address VARCHAR(250),
    CreatedDate DATETIME2 NOT NULL,
    LastModifiedDate DATETIME2 NULL
);

CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    SKU VARCHAR(50) NOT NULL UNIQUE,
    ProductName VARCHAR(150) NOT NULL,
    ProductColor VARCHAR(50),
    Cost DECIMAL(10,2) NOT NULL CHECK (Cost >= 0),
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice >= 0),
    StockQuantity INT NOT NULL CHECK (StockQuantity >= 0),
    CreatedDate DATETIME2 NOT NULL,
    LastModifiedDate DATETIME2 NULL
);
