SET CONCAT_NULL_YIELDS_NULL, ANSI_NULLS, ANSI_PADDING, QUOTED_IDENTIFIER, ANSI_WARNINGS, ARITHABORT, XACT_ABORT ON
SET NUMERIC_ROUNDABORT, IMPLICIT_TRANSACTIONS OFF
GO

USE ToolsStore
GO

IF DB_NAME() <> N'ToolsStore' SET NOEXEC ON
GO


--
-- Изменить уровень локализации транзакции
--
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

--
-- Начать транзакцию
--
BEGIN TRANSACTION
GO

--
-- Создать процедуру [dbo].[SP_GET_LOAD_RULE]
--
GO

CREATE PROCEDURE [dbo].[SP_GET_LOAD_RULE]
	@Path     nvarchar(1000)
AS
BEGIN
	SELECT LoadRuleId, 
	       Code, 
		   FileName, 
		   IsActive, 
		   MethodLoad, 
		   isnull(@Path + '\', '') + PathToXsd + '\' as PathToXsd, 
		   XsdName, 
		   Descr, 
		   Ord
	FROM dbo.MT_LOAD_RULE
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_IM_VAT]
--
GO

CREATE PROCEDURE [dbo].[SP_IM_VAT]
	@vat      bigint,
	@name     nvarchar(100),
	@rem      bit = null
AS
BEGIN
	DECLARE @tempMessage NVARCHAR(MAX) = NULL

	IF (@vat IS NULL)
	BEGIN
		SET @tempMessage = 'Код - пустое значение'
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	MERGE dbo.CT_VAT AS target
	USING (SELECT @vat, @name, @rem, getdate()) AS source (Vat, Name, Rem, DateLoad)
	ON (target.Vat = source.Vat)
	WHEN MATCHED THEN
		UPDATE SET Name       = source.Name,
				   Rem        = source.Rem,
				   DateLoad   = source.DateLoad
	WHEN NOT MATCHED THEN
		INSERT (Vat, Name, Rem, DateLoad)
		VALUES (source.Vat, source.Name, source.Rem, source.DateLoad);

END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_IM_CATEGORY]
--
GO
CREATE PROCEDURE [dbo].[SP_IM_CATEGORY]
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
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Фиксировать транзакцию
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
GO

--
-- Установить NOEXEC в состояние off
--
SET NOEXEC OFF
GO