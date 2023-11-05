/********************************************
 *	UC: Complementos de Bases de Dados 2023/2024
 *
 *	Projeto 1ª Fase
 *      
 *      INSERTS
 *
 *		Rita Briosa 202000793
 *		André Gamito 202002446
 *	    Victor Medina 202301023
 *		Turma: 2ºL_EI-SW-03 - sala F155 (15:00h - 17:00h)
 *	
 ********************************************/

 USE AdventureWorks



INSERT INTO AdventureWorks.dbo.Product(
	ProductKey,
	ProductName,
	--ProductNumber,
	Color,
	StandardCost,
	ListPrice,
	ProductSubcategoryKey
)
SELECT 
	ProductKey,
	EnglishProductCategoryName,
	--ProductNumber,
	Color,
	StandardCost,
	ListPrice,
	ProductSubcategoryKey
FROM oldCSV.dbo.ProductDB


SELECT * FROM Product;

--****************************************************************************************--

INSERT INTO AdventureWorks.dbo.ProductSubCategory(
	ProductSubcategoryKey,
	--CategoryKey,
	EnglishProductSubcategoryName,
	SpanishProductSubcategoryName,
	FrenchProductSubcategoryName
)
SELECT 
	ProductSubcategoryKey,
    EnglishProductSubcategoryName,
	SpanishProductSubcategoryName,
	FrenchProductSubcategoryName
FROM oldCSV.dbo.ProductSubCategory


SELECT * FROM ProductSubCategory;

--****************************************************************************************--

INSERT INTO AdventureWorks.dbo.Currency(
	CurrencyKey,
	CurrencyAlternateKey,
	CurrencyName
)
SELECT 
    CurrencyKey,
    CurrencyAlternateKey,
    CurrencyName
FROM oldCSV.dbo.Currency


SELECT * FROM Currency;

--****************************************************************************************--

INSERT INTO AdventureWorks.dbo.OrderTerritory(
	OrderTerritoryKey,
	OrderTerritoryCountry
)
SELECT 
    SalesTerritoryKey,
    SalesTerritoryCountry
FROM oldCSV.dbo.SalesTerritory


SELECT * FROM OrderTerritory;

--****************************************************************************************--

INSERT INTO AdventureWorks.dbo.UserInf(
	UserKey,
	UserName,
	UserEmail
)
SELECT 
    CustomerKey,
    FirstName,
	EmailAddress
FROM oldCSV.dbo.CustomerBD


SELECT * FROM UserInf;

--****************************************************************************************--

INSERT INTO AdventureWorks.dbo.Customer(
	CustomerKey,
	UserKey,
	FirstName,
    LastName
)
SELECT 
    CustomerKey,
    CustomerKey,
	FirstName,
    LastName
FROM oldCSV.dbo.CustomerBD


SELECT * FROM Customer;

--****************************************************************************************--

INSERT INTO AdventureWorks.dbo.[Order](

    OrderDate,
	DueDate,
    ShipDate,
    ProductKey,
    CustomerKey,
    SalesTerritoryKey,
    CurrencyKey
)
SELECT 
    OrderDateKey,
	DueDate,
    ShipDate,
    ProductKey,
    CustomerKey,
    SalesTerritoryKey,
    CurrencyKey
FROM oldCSV.dbo.sales7BD


SELECT * FROM [Order];

