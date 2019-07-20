USE ToolsStore
GO

CREATE FUNCTION dbo.FN_SPLIT2
(    
    @String   NVARCHAR(MAX),
    @Delimiter NVARCHAR(100)
)
RETURNS @RtnValue TABLE 
(
    Id    INT IDENTITY(1,1),
    Value NVARCHAR(MAX)
) 
AS
BEGIN 
    WHILE (CHARINDEX(@Delimiter,@String) > 0)
    BEGIN
        INSERT INTO @RtnValue (Value)
        SELECT LTRIM(RTRIM(SUBSTRING(@String, 1, CHARINDEX(@Delimiter,@String) - 1))) Value

        SET @String = RIGHT(@String, LEN(@String) - (CHARINDEX(@Delimiter,@String) - 1) - LEN(@Delimiter))
    END
    
    INSERT INTO @RtnValue (Value)
    SELECT LTRIM(RTRIM(@String)) Value

    RETURN;
END