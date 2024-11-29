CREATE OR ALTER PROCEDURE GetColumns
    @TableName NVARCHAR(128)
AS
BEGIN
    -- create a cursor that runs over the columns of the Athletes table
    DECLARE ColumnCursor CURSOR SCROLL FOR
    SELECT COLUMN_NAME, DATA_TYPE
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName;

    DECLARE @ColumnName NVARCHAR(128);
    DECLARE @DataType NVARCHAR(128);

    OPEN ColumnCursor;

    FETCH NEXT FROM ColumnCursor INTO @ColumnName, @DataType;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- substitute
        PRINT 'Column: ' + @ColumnName + ', Data Type: ' + @DataType;

        FETCH NEXT FROM ColumnCursor INTO @ColumnName, @DataType;
    END;

    CLOSE ColumnCursor;
    OPEN ColumnCursor;

    FETCH LAST FROM ColumnCursor INTO @ColumnName, @DataType;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- substitute
        PRINT 'Column: ' + @ColumnName + ', Data Type: ' + @DataType;

        FETCH PRIOR FROM ColumnCursor INTO @ColumnName, @DataType;
    END;

    CLOSE ColumnCursor;
    DEALLOCATE ColumnCursor;
END;
GO

EXEC GetColumns 'Athletes';
GO

SELECT * 
FROM Athletes
ORDER BY id DESC;