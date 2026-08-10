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

CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME2 NOT NULL,
    StartDate DATETIME2 NULL,
    EndDate DATETIME2 NULL,
    ShipDate DATETIME2 NULL,
    OrderStatus VARCHAR(20) NOT NULL
        CHECK (OrderStatus IN
        ('Pending', 'Processing', 'Shipped', 'Completed', 'Cancelled')),
    TotalAmount DECIMAL(12,2) NOT NULL
        CHECK (TotalAmount >= 0),
    CreatedDate DATETIME2 NOT NULL,
    LastModifiedDate DATETIME2 NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails
(
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,

    OrderID INT NOT NULL,
    ProductID INT NOT NULL,

    Quantity INT NOT NULL
        CHECK (Quantity > 0),

    UnitPrice DECIMAL(10,2) NOT NULL
        CHECK (UnitPrice >= 0),

    DiscountPercent DECIMAL(5,2) NOT NULL
        DEFAULT 0
        CHECK (DiscountPercent >= 0 AND DiscountPercent <= 100),

    LineTotal AS
        (Quantity * UnitPrice * (1 - DiscountPercent / 100.0)),

    CreatedDate DATETIME2 NOT NULL,
    LastModifiedDate DATETIME2 NULL,

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);

CREATE TABLE Payments
(
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,

    OrderID INT NOT NULL,

    PaymentStatus VARCHAR(20) NOT NULL
        CHECK (PaymentStatus IN
        ('Pending', 'Paid', 'Failed', 'Refunded')),

    PaymentMethod VARCHAR(20) NOT NULL
        CHECK (PaymentMethod IN
        ('UPI', 'Card', 'Cash', 'NetBanking')),

    PaymentAmount DECIMAL(12,2) NOT NULL
        CHECK (PaymentAmount >= 0),

    PaymentDate DATETIME2 NULL,

    CreatedDate DATETIME2 NOT NULL,
    LastModifiedDate DATETIME2 NULL,

    CONSTRAINT FK_Payments_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
);
