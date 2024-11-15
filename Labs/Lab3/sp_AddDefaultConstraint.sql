ALTER PROCEDURE sp_AddDefaultConstraint
    @tableName NVARCHAR(128),
    @defaultValue NVARCHAR(128),
    @columnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + 
    ' ADD CONSTRAINT default_' + @columnName +
    ' DEFAULT ' + @defaultValue + 
    ' FOR ' + @columnName

    EXEC sp_executesql @sql
END