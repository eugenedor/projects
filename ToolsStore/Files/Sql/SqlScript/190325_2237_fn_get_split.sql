USE ToolsStore
GO

CREATE FUNCTION dbo.FN_GET_SPLIT
(
    @String    NVARCHAR(4000),
    @Delimiter NVARCHAR(5),
	@Position  INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @Value NVARCHAR(100)

	SELECT @Value = LEFT(t.Value, 100)
	FROM dbo.FN_SPLIT(@String, @Delimiter, 1) t
	WHERE t.Id = @Position;

	RETURN ISNULL(LTRIM(RTRIM(@Value)), '');
END
