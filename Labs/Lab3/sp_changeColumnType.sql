-- Stored procedure to Modify the type of a column
-- CREATE PROCEDURE sp_ModifyColumn if it doesn't exist

CREATE OR ALTER PROCEDURE sp_ModifyColumn
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128),
    @newType NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + ' ALTER COLUMN ' + @columnName + ' ' + @newType

    EXEC sp_executesql @sql
END