-- Stored procedures

CREATE PROCEDURE name_of_procedure
    @parameter1 INT,            -- input parameter
    @parameter2 VARCHAR(50),    -- input parameter
    @parameter3 DATE OUTPUT     -- output parameter
    @parameter4 INT OUTPUT      -- output parameter
AS
BEGIN
    SELECT @parameter3 = GETDATE(), @parameter4 = @parameter1 + @parameter2
    FROM table_name
    WHERE column_name = @parameter1;
END;



-- Execute stored procedure

EXEC name_of_procedure 1, 'string', @parameter3 OUTPUT, @parameter4 OUTPUT;



-- Declare variables

DECLARE @variable1 INT;