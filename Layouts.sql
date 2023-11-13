/********************************************
 *	UC: Complementos de Bases de Dados 2023/2024
 *
 *	Projeto 1ª Fase
 *      
 *      LAYOUTS
 *
 *		Rita Briosa 202000793
 *		André Gamito 202002446
 *	    Victor Medina 202301023
 *		Turma: 2ºL_EI-SW-03 - sala F155 (15:00h - 17:00h)
 *	
 ********************************************/

use AdventureWorks

--------------------------------------------------------------------------------------------------------------------------------------------------

-- Analisar o espaço ocupado por registro de cada tabela:

-- Space occupied per record in each table
SELECT 
    OBJECT_NAME(p.object_id) AS TableName,
    SUM(a.total_pages) * 8 AS SpaceOccupiedKB
FROM sys.partitions p
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE p.index_id < 2
GROUP BY p.object_id
ORDER BY SpaceOccupiedKB DESC


-- Space occupied by each table with the current number of records
SELECT 
    t.name AS TableName,
    SUM(p.rows) AS RecordCount,
    SUM(a.total_pages) * 8 AS SpaceOccupiedKB
FROM sys.tables t
INNER JOIN sys.indexes i ON t.object_id = i.object_id
INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE i.type IN (0, 1, 7)
GROUP BY t.name
ORDER BY SpaceOccupiedKB DESC


-- Growth rate per table
SELECT 
    t.name AS TableName,
    SUM(a.total_pages) * 8 AS SpaceOccupiedKB,
    (SUM(a.total_pages) * 8) / SUM(p.rows) AS GrowthRateKBPerRecord
FROM sys.tables t
INNER JOIN sys.indexes i ON t.object_id = i.object_id
INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE i.type IN (0, 1, 7)
GROUP BY t.name
ORDER BY GrowthRateKBPerRecord DESC

--------------------------------------------------------------------------------------------------------------------------------------------------

--Dimensionar o número e tipos de acessos:

--(...)

