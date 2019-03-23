USE ToolsStore
GO

CREATE FUNCTION dbo.FN_SPLIT
(
    @String    NVARCHAR(4000),
    @Delimiter NVARCHAR(5)
)
RETURNS @SplittedValues TABLE
(
    Id NVARCHAR(100) PRIMARY KEY
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

        IF NOT EXISTS(SELECT Id 
		              FROM @SplittedValues 
					  WHERE Id = (SELECT CAST(SUBSTRING(@String, 1, @Pos-1) AS NVARCHAR(100))))
		  INSERT INTO @SplittedValues   
		  SELECT CAST(SUBSTRING(@String, 1, @Pos-1) AS NVARCHAR(100))

        SELECT @String = CASE 
		                     WHEN @Pos != LEN(@String) THEN RIGHT(@String, LEN(@String) - @Pos)
                             ELSE ''
					     END
    END 
    
	RETURN;
END 