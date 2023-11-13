/********************************************
 *	UC: Complementos de Bases de Dados 2023/2024
 *
 *	Projeto 1ª Fase
 *      
 *      METADADOS
 *
 *		Rita Briosa 202000793
 *		André Gamito 202002446
 *	    Victor Medina 202301023
 *		Turma: 2ºL_EI-SW-03 - sala F155 (15:00h - 17:00h)
 *	
 ********************************************/

  USE AdventureWorks

--------------------------------------------------------------------------------------------------------------------------------------------

 GO 
  CREATE PROCEDURE GenerateTableInfo
AS
BEGIN
    -- Create table to store information about the tables
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TableInfo')
    CREATE TABLE TableInfo (
        TableName VARCHAR(50) NOT NULL,
        ColumnName VARCHAR(50) NOT NULL,
        DataType VARCHAR(50) NOT NULL,
        Size INT,
        Constraints VARCHAR(100),
        ReferencedTable VARCHAR(50),
        ForeignKeyAction VARCHAR(50),
        ChangeTimestamp DATETIME
    )

    -- Insert information about the tables in the TableInfo table
    INSERT INTO TableInfo (TableName, ColumnName, DataType, Size, Constraints, ReferencedTable, ForeignKeyAction, ChangeTimestamp)
    SELECT
        t.name AS TableName,
        c.name AS ColumnName,
        TYPE_NAME(c.system_type_id) AS DataType,
        c.max_length AS Size,
        CASE
            WHEN ic.column_id IS NOT NULL THEN 'PK'
            WHEN c.is_nullable = 0 THEN 'NOT NULL'
            ELSE ''
        END AS Constraints,
        CASE
            WHEN fk.referenced_object_id IS NOT NULL THEN rt.name
            ELSE ''
        END AS ReferencedTable,
        CASE
            WHEN fk.referenced_object_id IS NOT NULL THEN fk.delete_referential_action_desc
            ELSE ''
        END AS ForeignKeyAction,
        GETDATE() AS ChangeTimestamp
    FROM sys.columns c
    INNER JOIN sys.tables t ON c.object_id = t.object_id
    LEFT JOIN sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    LEFT JOIN sys.foreign_keys fk ON fk.parent_object_id = c.object_id AND fk.parent_column_id = c.column_id
    LEFT JOIN sys.tables rt ON fk.referenced_object_id = rt.object_id
END



---View that provides data on the most recent execution:
GO
CREATE VIEW RecentExecutionData
AS
SELECT *
FROM TableInfo
WHERE ChangeTimestamp = (
    SELECT MAX(ChangeTimestamp)
    FROM TableInfo
)

--Stored procedure to record the number of records and estimated space occupied per table:
GO
CREATE PROCEDURE RegisterTableStats
AS
BEGIN
    -- Create table to store table statistics
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TableStats')
    CREATE TABLE TableStats (
        TableName VARCHAR(50) NOT NULL,
        RecordCount INT,
        SpaceUsedKB INT,
        ChangeTimestamp DATETIME
    )

    -- Insert table statistics into the TableStats table
    INSERT INTO TableStats (TableName, RecordCount, SpaceUsedKB, ChangeTimestamp)
    SELECT
        t.name AS TableName,
        SUM(p.rows) AS RecordCount,
        SUM(a.used_pages) * 8 AS SpaceUsedKB,
        GETDATE() AS ChangeTimestamp
    FROM sys.tables t
    INNER JOIN sys.indexes i ON t.object_id = i.object_id
    INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
    WHERE i.type IN (0, 1, 7)
    GROUP BY t.name
END