/********************************************
 *	UC: Complementos de Bases de Dados 2023/2024
 *
 *	Projeto 1ª Fase
 *      
 *      CREATES
 *
 *		Rita Briosa 202000793
 *		André Gamito 202002446
 *	    Victor Medina 202301023
 *		Turma: 2ºL_EI-SW-03 - sala F155 (15:00h - 17:00h)
 *	
 ********************************************/

USE master

-- Creation of the AdventureWorks database
go
DROP DATABASE IF EXISTS AdventureWorks
CREATE DATABASE AdventureWorks
go


-- Create the Category table to manage the general categories of the products.
CREATE TABLE Category (
    CategoryKey INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

-- Create the ProductSubCategory table that now includes a reference to the Category table.
CREATE TABLE ProductSubCategory (
    ProductSubcategoryKey INT PRIMARY KEY,
    CategoryKey INT NOT NULL,
    EnglishProductSubcategoryName VARCHAR(255) NOT NULL,
    SpanishProductSubcategoryName VARCHAR(255) NOT NULL,
    FrenchProductSubcategoryName VARCHAR(255) NOT NULL,
    FOREIGN KEY (CategoryKey) REFERENCES Category(CategoryKey)
);

-- Create Currency table
CREATE TABLE Currency (
    CurrencyKey INT PRIMARY KEY,
    CurrencyAlternateKey VARCHAR(50) NOT NULL UNIQUE,
    CurrencyName VARCHAR(255) NOT NULL
);

-- Create the Product table
CREATE TABLE Product (
    ProductKey INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    ProductNumber VARCHAR(50) NOT NULL UNIQUE,
    Color VARCHAR(50),
    StandardCost DECIMAL(19,4) NOT NULL,
    ListPrice DECIMAL(19,4) NOT NULL,
    ProductSubcategoryKey INT NOT NULL,
    FOREIGN KEY (ProductSubcategoryKey) REFERENCES ProductSubCategory(ProductSubcategoryKey)
);

-- Create the User table to manage ERP system users, including customers and other roles.
CREATE TABLE UserInf (
    UserKey INT PRIMARY KEY,
    UserName VARCHAR(255) NOT NULL,
    UserEmail VARCHAR(255) NOT NULL UNIQUE,
    UserPassword VARCHAR(255) NOT NULL, -- The password must be stored as a hash.
    UserRole VARCHAR(255) NOT NULL, -- Example: 'Customer', 'Admin', etc.
    SecurityQuestion VARCHAR(255) NOT NULL,
    SecurityAnswer VARCHAR(255) NOT NULL
);

-- Create the Customer table that now includes a reference to User
CREATE TABLE Customer (
    CustomerKey INT PRIMARY KEY,
    UserKey INT NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FOREIGN KEY (UserKey) REFERENCES UserInf(UserKey)
);

-- Create the Order table to manage orders
CREATE TABLE [Order] (
    OrderKey INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ShipDate DATE,
    ProductKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    SalesTerritoryKey INT NOT NULL,
    CurrencyKey INT NOT NULL,
    FOREIGN KEY (ProductKey) REFERENCES Product(ProductKey),
    FOREIGN KEY (CustomerKey) REFERENCES Customer(CustomerKey),
    --FOREIGN KEY (SalesTerritoryKey) REFERENCES SalesTerritory(SalesTerritoryKey),
    FOREIGN KEY (CurrencyKey) REFERENCES Currency(CurrencyKey)
);

-- Create the SentEmails table to simulate the sending of mails.
CREATE TABLE SentEmails (
    EmailID INT PRIMARY KEY IDENTITY(1,1),
    Recipient VARCHAR(255) NOT NULL,
    Message TEXT NOT NULL,
    Timestamp DATETIME DEFAULT GETDATE() NOT NULL
);
