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

EXEC sp_ModifyColumn 'RaceResults', 'total_time', 'DECIMAL(10,2)'
EXEC sp_ModifyColumn 'RaceResults', 'total_time', 'INT'
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_AddColumn
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128),
    @columnType NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + ' ADD ' + @columnName + ' ' + @columnType

    EXEC sp_executesql @sql
END

EXEC sp_AddColumn 'Teams', 'coloana_noua', 'INT'
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_RemoveColumn
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + ' DROP COLUMN ' + @columnName

    EXEC sp_executesql @sql
END

EXEC sp_RemoveColumn 'Teams', 'coloana_noua'
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_AddDefaultConstraint
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

EXEC sp_AddDefaultConstraint 'RaceResults', '0', 'total_time'
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_RemoveDefaultConstraint
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + 
    ' DROP CONSTRAINT default_' + @columnName

    EXEC sp_executesql @sql
END

EXEC sp_RemoveDefaultConstraint 'RaceResults', 'total_time'
GO

--------------------------------------------

EXEC sp_CreateTable NewTable, 'id INT NOT NULL, name NVARCHAR(128)'
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_AddPrimaryKey
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + 
    ' ADD CONSTRAINT PK__' + @tableName + '__' + @columnName +
    ' PRIMARY KEY (' + @columnName + ')'

    EXEC sp_executesql @sql
END

EXEC sp_AddPrimaryKey NewTable, id
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_RemovePrimaryKey
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + 
    ' DROP CONSTRAINT PK__' + @tableName + '__' + @columnName

    EXEC sp_executesql @sql
END

EXEC sp_RemovePrimaryKey NewTable, id
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_AddCandidateKey
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + 
    ' ADD CONSTRAINT CK__' + @tableName + '__' + @columnName +
    ' UNIQUE (' + @columnName + ')'

    EXEC sp_executesql @sql
END

EXEC sp_AddCandidateKey NewTable, id
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_RemoveCandidateKey
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + 
    ' DROP CONSTRAINT CK__' + @tableName + '__' + @columnName

    EXEC sp_executesql @sql
END

EXEC sp_RemoveCandidateKey NewTable, id
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_AddForeignKey
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128),
    @refTableName NVARCHAR(128),
    @refColumnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + 
    ' ADD CONSTRAINT FK__' + @tableName + '__' + @columnName +
    ' FOREIGN KEY (' + @columnName + ') REFERENCES ' + @refTableName + '(' + @refColumnName + ')'

    EXEC sp_executesql @sql
END

EXEC sp_AddForeignKey NewTable, id, Teams, id
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_RemoveForeignKey
    @tableName NVARCHAR(128),
    @columnName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'ALTER TABLE ' + @tableName + 
    ' DROP CONSTRAINT FK__' + @tableName + '__' + @columnName

    EXEC sp_executesql @sql
END

EXEC sp_RemoveForeignKey NewTable, id
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_CreateTable
    @tableName NVARCHAR(128),
    @columns NVARCHAR(MAX)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'CREATE TABLE ' + @tableName + ' (' + @columns + ')'

    EXEC sp_executesql @sql
END

EXEC sp_CreateTable NewTable, 'id INT NOT NULL, name NVARCHAR(128)'
GO

--------------------------------------------

CREATE OR ALTER PROCEDURE sp_DropTable
    @tableName NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'DROP TABLE ' + @tableName

    EXEC sp_executesql @sql
END

EXEC sp_DropTable NewTable
GO

--------------------------------------------

EXEC sp_DropTable NewTable
GO

--------------------------------------------