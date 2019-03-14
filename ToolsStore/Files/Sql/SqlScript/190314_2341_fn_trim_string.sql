USE ToolsStore
GO

CREATE FUNCTION FN_TRIM_STRING
(
	@string NVARCHAR(4000)	
)
RETURNS NVARCHAR(4000)
AS
BEGIN
	DECLARE @str NVARCHAR(4000),
			@delimiter VARCHAR(5),
			@pos INT;
	
	SELECT @delimiter = ' ', @str = '';
	SELECT @string = LTRIM(RTRIM(@string));

	IF(@string IS NULL)
	BEGIN 
		SELECT @str = @string;
	END 
	ELSE
	BEGIN
		WHILE LEN(@string) > 0
		BEGIN 
			SELECT @pos = (CASE CHARINDEX(@delimiter, @string) WHEN 0 THEN LEN(@string) 
																	  ELSE CHARINDEX(@delimiter, @string) 
						   END);
	    
			IF (@pos != LEN(@string))
			BEGIN 
    			WHILE (SUBSTRING(@string,@pos,1) = SUBSTRING(@string,@pos+1,1))
				BEGIN
					SET @string = SUBSTRING(@string,1,@pos) + SUBSTRING(@string, @pos+2, LEN(@string));
				END
			END

			SELECT @str = ISNULL(@str,'') + SUBSTRING(@string, 1, @pos);
			SELECT @string = (CASE (LEN(@string) - @pos) WHEN 0 THEN ''
																ELSE RIGHT(@string, LEN(@string) - @pos) 
							  END);
		END
	END

	RETURN @str
END