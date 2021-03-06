USE [ToolsStore]
GO
/****** Object:  StoredProcedure [dbo].[SP_IM_CATEGORY]    Script Date: 26.07.2018 23:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_IM_CATEGORY]
	@code     nvarchar(100),
	@name     nvarchar(250),
	@ord      int            = null
AS
BEGIN
	DECLARE @tempMessage NVARCHAR(MAX) = NULL

	IF (NULLIF(@code, '') IS NULL)
	BEGIN
		SET @tempMessage = 'Код - пустое значение'
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	MERGE dbo.CT_CATEGORY AS target
	USING (SELECT @code, @name, @ord, getdate()) AS source (Code, Name, Ord, DateLoad)
	ON (target.code = source.code)
	WHEN MATCHED THEN
		UPDATE SET Name       = source.Name,
				   Ord        = source.Ord,
				   DateLoad   = source.DateLoad
	WHEN NOT MATCHED THEN
		INSERT (Code, Name, Ord, DateLoad)
		VALUES (source.Code, source.Name, source.Ord, source.DateLoad);

END