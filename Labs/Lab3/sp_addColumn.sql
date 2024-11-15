CREATE PROCEDURE sp_AddColumn
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128),
    @columnType NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + ' ADD ' + @columnName + ' ' + @columnType

    EXEC sp_executesql @sql
END