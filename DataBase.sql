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

USE AdventureWorks

-- Create the Category table to manage the general categories of the products.
DROP TABLE IF EXISTS Category
CREATE TABLE Category (
    CategoryKey INT PRIMARY KEY,
    CategoryName VARCHAR(255)  NULL
);

-- Create the ProductSubCategory table that now includes a reference to the Category table.
DROP TABLE IF EXISTS ProductSubCategory
CREATE TABLE ProductSubCategory (
    ProductSubcategoryKey INT PRIMARY KEY,
    CategoryKey INT NULL,
    EnglishProductSubcategoryName VARCHAR(255) NOT NULL,
    SpanishProductSubcategoryName VARCHAR(255) NOT NULL,
    FrenchProductSubcategoryName VARCHAR(255) NOT NULL,
    FOREIGN KEY (CategoryKey) REFERENCES Category(CategoryKey)
);

-- Create Currency table
DROP TABLE IF EXISTS Currency
CREATE TABLE Currency (
    CurrencyKey INT PRIMARY KEY,
    CurrencyAlternateKey VARCHAR(50)  NULL UNIQUE,
    CurrencyName VARCHAR(255)  NULL
);

-- Create the Product table
DROP TABLE IF EXISTS Product
CREATE TABLE Product (
    ProductKey INT PRIMARY KEY,
    ProductName VARCHAR(255) NULL,
    ProductNumber VARCHAR(50)  NULL ,
    Color VARCHAR(50),
    StandardCost DECIMAL(19,4)  NULL,
    ListPrice DECIMAL(19,4)  NULL,
    ProductSubcategoryKey INT  NULL,
    FOREIGN KEY (ProductSubcategoryKey) REFERENCES ProductSubCategory(ProductSubcategoryKey)
);

-- Create the User table to manage ERP system users, including customers and other roles.
DROP TABLE IF EXISTS UserInf
CREATE TABLE UserInf (
    UserKey INT PRIMARY KEY,
    UserName VARCHAR(255)  NULL,
    UserEmail VARCHAR(255)  NULL UNIQUE,
    UserPassword VARCHAR(255)  NULL, -- The password must be stored as a hash.
    UserRole VARCHAR(255)  NULL, -- Example: 'Customer', 'Admin', etc.
    SecurityQuestion VARCHAR(255)  NULL,
    SecurityAnswer VARCHAR(255)  NULL
);

-- Create the Customer table that now includes a reference to User
DROP TABLE IF EXISTS Customer
CREATE TABLE Customer (
    CustomerKey INT PRIMARY KEY,
    UserKey INT NOT NULL,
    FirstName VARCHAR(255)  NULL,
    LastName VARCHAR(255)  NULL,
    FOREIGN KEY (UserKey) REFERENCES UserInf(UserKey)
);

-- Create the Order table to manage orders
DROP TABLE IF EXISTS [Order]
CREATE TABLE [Order] (
    --OrderKey VARCHAR(50) PRIMARY KEY,
    OrderDate INT NOT NULL,
    DueDate DATE NOT NULL,
    ShipDate DATE,
    ProductKey INT  NULL,
    CustomerKey INT  NULL,
    SalesTerritoryKey INT  NULL,
    CurrencyKey INT  NULL,
    FOREIGN KEY (ProductKey) REFERENCES Product(ProductKey),
    FOREIGN KEY (CustomerKey) REFERENCES Customer(CustomerKey),
    --FOREIGN KEY (SalesTerritoryKey) REFERENCES SalesTerritory(SalesTerritoryKey),
    FOREIGN KEY (CurrencyKey) REFERENCES Currency(CurrencyKey)
);

-- Create the Customer table that now includes a reference to User
DROP TABLE IF EXISTS OrderTerritory
CREATE TABLE OrderTerritory (
    OrderTerritoryKey INT PRIMARY KEY,
    OrderTerritoryCountry VARCHAR(255)  NULL,
);

-- Create the SentEmails table to simulate the sending of mails.
DROP TABLE IF EXISTS SentEmails
CREATE TABLE SentEmails (
    EmailID INT PRIMARY KEY IDENTITY(1,1),
    Recipient VARCHAR(255)  NULL,
    Message TEXT  NULL,
    Timestamp DATETIME DEFAULT GETDATE()  NULL
);
