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
