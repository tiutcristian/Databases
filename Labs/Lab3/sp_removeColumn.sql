CREATE PROCEDURE sp_RemoveColumn
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + ' DROP COLUMN ' + @columnName

    EXEC sp_executesql @sql
END