CREATE PROCEDURE insertRowIntoTable(@tableName VARCHAR(255), @row INT) AS 
	DECLARE @ColumnName NVARCHAR(128);
    DECLARE @DataType NVARCHAR(128);
	DECLARE @sql NVARCHAR(255);
    DECLARE ColumnCursor CURSOR SCROLL FOR
    SELECT COLUMN_NAME, DATA_TYPE
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName;

	SET @sql = 'INSERT INTO ' + @tableName + ' VALUES('

    OPEN ColumnCursor;
    FETCH NEXT FROM ColumnCursor INTO @ColumnName, @DataType;
    WHILE @@FETCH_STATUS = 0 BEGIN
		IF @DataType = 'int' BEGIN
			SET @sql = @sql + CAST(@row AS VARCHAR(255)) + ',' -- row number
		END
		ELSE IF @DataType = 'varchar' BEGIN
			SET @sql = @sql + '''' + 'row_' + CAST(@row AS VARCHAR(255)) + ''',' -- "row_" + row number
		END
		ELSE IF @DataType = 'datetime' BEGIN
			SET @sql = @sql + '@GETDATE(),' -- current date
        END

		FETCH NEXT FROM ColumnCursor INTO @ColumnName, @DataType;
	END

	SET @sql = LEFT(@sql, LEN(@sql) - 1) + ')'; -- remove last comma
	EXEC (@sql)

	CLOSE ColumnCursor;
	DEALLOCATE ColumnCursor;
GO


CREATE PROCEDURE populateTable (@tableName VARCHAR(255), @rows INT) AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i <= @rows BEGIN
		EXEC insertRowIntoTable @tableName, @i
		SET @i = @i + 1
	END
GO


CREATE PROCEDURE addToTables (@tableName VARCHAR(255)) AS
	INSERT INTO Tables(Name) Values (@tableName);
GO


CREATE PROCEDURE addToViews(@viewName VARCHAR(255)) AS 
	INSERT INTO Views(Name) Values (@viewName);
GO


CREATE PROCEDURE addToTests(@testName VARCHAR(255)) AS 
	INSERT INTO Tests(Name) Values (@testName);
GO


CREATE PROCEDURE connectTableToTest(@tableName VARCHAR(255), @testName VARCHAR(255), @rows INT, @pos INT) AS
	DECLARE @tableId int
	DECLARE @testId int
	SET @tableId = (SELECT TableID FROM Tables WHERE Name=@tableName)
	SET @testId = (SELECT TestID FROM Tests WHERE Name=@testName)
	INSERT INTO TestTables VALUES(@testId, @tableId, @rows, @pos);
GO	

CREATE PROCEDURE connectViewToTest(@viewName VARCHAR(255), @testName VARCHAR(255)) AS
	DECLARE @viewId int
	DECLARE @testId int
	SET @viewId = (SELECT ViewID FROM Views WHERE Name=@viewName)
	SET @testId = (SELECT TestID FROM Tests WHERE Name=@testName)
	INSERT INTO TestViews  VALUES(@testId, @viewId);
GO


CREATE PROCEDURE runTest(@testName VARCHAR(255), @description VARCHAR(255)) AS
	DECLARE @testStartTime DATETIME2
	DECLARE @testRunId INT
	DECLARE @tableId INT
	DECLARE @table VARCHAR(255)
	DECLARE @rows INT
	DECLARE @pos INT
	DECLARE @command VARCHAR(255)
	DECLARE @tableInsertStartTime DATETIME2
	DECLARE @tableInsertEndTime DATETIME2
	DECLARE @testId INT
	DECLARE @view VARCHAR(255)
	DECLARE @viewId INT
	DECLARE @viewStartTime DATETIME2
	DECLARE @viewEndTime DATETIME2
	
	SET @testId = (SELECT TestId FROM Tests T WHERE T.Name = @testName)
	
	DECLARE tableCursor CURSOR SCROLL FOR 
		SELECT T1.Name, T1.TableId, T2.NoOfRows, T2.Position
		FROM Tables T1 INNER JOIN TestTables T2 ON T1.TableID = T2.TableID
		WHERE T2.TestID = @testId
		ORDER BY T2.Position ASC
	
	DECLARE viewCursor CURSOR SCROLL FOR 
		SELECT V.Name, V.ViewId
		FROM Views V INNER JOIN TestViews TV ON V.ViewID = TV.ViewID 
		WHERE TV.TestID = @testId
	
	
	SET @testStartTime = sysdatetime()
	
	INSERT INTO TestRuns(Description, StartAt, EndAt) VALUES(@description, @testStartTime, @testStartTime)
	SET @testRunId = SCOPE_IDENTITY()
	
	OPEN tableCursor
	FETCH FIRST FROM tableCursor INTO @table, @tableId, @rows, @pos
	WHILE @@FETCH_STATUS = 0 BEGIN
		EXEC ('DELETE FROM ' + @table)
		FETCH tableCursor INTO @table, @tableId, @rows, @pos
	END
	FETCH LAST FROM tableCursor INTO @table, @tableId, @rows, @pos
	WHILE @@FETCH_STATUS = 0 BEGIN
		EXEC populateTable @table, @rows
		SET @tableInsertEndTime = sysdatetime()
		INSERT INTO TestRunTables VALUES(@testRunId, @tableId, @tableInsertStartTime, @tableInsertEndTime)
		FETCH PRIOR FROM tableCursor INTO @table, @tableId, @rows, @pos
	END
	CLOSE tableCursor
	DEALLOCATE tableCursor 
	
	OPEN viewCursor
	FETCH viewCursor INTO @view, @viewId
	WHILE @@FETCH_STATUS = 0 BEGIN
		SET @viewStartTime = sysdatetime()
		EXEC ('SELECT * FROM ' + @view)
		SET @viewEndTime = sysdatetime()
		INSERT INTO TestRunViews VALUES(@testRunID, @viewId, @viewStartTime, @viewEndTime)
		FETCH viewCursor INTO @view, @viewId	
	END
	CLOSE viewCursor 
	DEALLOCATE viewCursor

	UPDATE TestRuns 
	SET EndAt = sysdatetime()
	WHERE TestRunID = @testRunId;
GO


CREATE VIEW some_view AS
	SELECT * FROM sth
GO





-- SETUP & TEST RUN
EXEC addToTests 'Test 1';
EXEC addToTables 'some_table';
-- ...
EXEC addToViews 'some_view';
-- ...
EXEC connectTableToTest 'some_table', 'Test 1', 100, 2;
-- ...
EXEC connectViewToTest 'some_view', 'Test 1';
-- ...
EXEC runTest 'Test 1', 'descriere test 1';