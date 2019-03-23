USE ToolsStore
GO

CREATE FUNCTION dbo.FN_SPLIT
(
    @String    NVARCHAR(4000),
    @Delimiter NVARCHAR(5)
)
RETURNS @SplittedValues TABLE
(
    Id      INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Value   NVARCHAR(100) 
)
AS
BEGIN
    DECLARE @Pos INT;

    WHILE LEN(@String) > 0
    BEGIN 
        SELECT @Pos = CASE CHARINDEX(@Delimiter, @String) 
						  WHEN 0 THEN LEN(@String) 
						  ELSE CHARINDEX(@Delimiter, @String)
					  END;

        IF NOT EXISTS(SELECT Value 
		              FROM @SplittedValues 
					  WHERE Value = (SELECT CAST(SUBSTRING(@String, 1, @Pos-1) AS NVARCHAR(100))))
		  INSERT INTO @SplittedValues (Value)  
		  SELECT CAST(SUBSTRING(@String, 1, @Pos-1) AS NVARCHAR(100))

        SELECT @String = CASE 
		                     WHEN @Pos != LEN(@String) THEN RIGHT(@String, LEN(@String) - @Pos)
                             ELSE ''
					     END
    END 
    
	RETURN;
END 