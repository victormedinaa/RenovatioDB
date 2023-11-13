/********************************************
 *	UC: Complementos de Bases de Dados 2023/2024
 *
 *	Projeto 1ª Fase
 *      
 *      PROGRAMAÇÃO
 *
 *		Rita Briosa 202000793
 *		André Gamito 202002446
 *	    Victor Medina 202301023
 *		Turma: 2ºL_EI-SW-03 - sala F155 (15:00h - 17:00h)
 *	
 ********************************************/

 USE AdventureWorks

-- GESTÃO DE ACESSOS

---Stored procedure to edit an access:

GO
 CREATE PROCEDURE EditAccess
    @UserKey INT,
    @UserName VARCHAR(255),
    @UserPassword VARCHAR(255)
AS
BEGIN
    UPDATE UserInf
    SET UserName = @UserName, UserPassword = @UserPassword
    WHERE UserKey = @UserKey
END

--- Stored procedure para adicionar um acesso:
GO
CREATE PROCEDURE AddAccess
    @UserName VARCHAR(255),
    @UserPassword VARCHAR(255)
AS
BEGIN
    INSERT INTO UserInf (UserName, UserPassword)
    VALUES (@UserName, @UserPassword)
END

--- Stored procedure to add an access:

GO
CREATE PROCEDURE RemoveAccess
    @UserKey INT,
AS
BEGIN
    DELETE FROM UserInf
    WHERE UserKey = @UserKey
END


--- Stored procedure to recover the password:
GO
CREATE PROCEDURE RecoverPassword
    @UserName VARCHAR(255),
    @SecurityQuestion VARCHAR(255),
    @SecurityAnswer VARCHAR(255),
    @newPassword VARCHAR(255) OUTPUT
AS
BEGIN
    SELECT @newPassword = UserPassword
    FROM UserInf
    WHERE Username = @username
        AND SecurityQuestion = @SecurityQuestion
        AND SecurityAnswer = @SecurityAnswer
END

---------------------------------------------------------
---Create views for the purchases of a given customer

GO
CREATE VIEW CustomerPurchases AS
SELECT C.CustomerKey, C.FirstName, P.ProductKey, P.ProductName AS ProductName, P.StandardCost
FROM Customer C
JOIN [Order] O ON C.CustomerKey = O.CustomerKey
JOIN Product P ON O.ProductKey = P.ProductKey
