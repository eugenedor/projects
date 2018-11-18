SET CONCAT_NULL_YIELDS_NULL, ANSI_NULLS, ANSI_PADDING, QUOTED_IDENTIFIER, ANSI_WARNINGS, ARITHABORT, XACT_ABORT ON
SET NUMERIC_ROUNDABORT, IMPLICIT_TRANSACTIONS OFF
GO


USE [ToolsStore2]
GO

IF DB_NAME() <> N'ToolsStore2' SET NOEXEC ON
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

--
-- procedure sp_im_vat
--
CREATE PROCEDURE [dbo].[SP_IM_VAT]
	@code     int,
	@name     nvarchar(100),
	@isactive bit = null
AS
BEGIN
	DECLARE @tempMessage NVARCHAR(MAX) = NULL

	IF (@code IS NULL)
	BEGIN
		SET @tempMessage = 'Код - пустое значение'
		RAISERROR (@tempMessage , 16, 1) 
		RETURN(0)
	END

	MERGE dbo.CT_VAT AS target
	USING (SELECT @code, @name, @isactive, getdate()) AS source (Code, Name, IsActive, DateLoad)
	ON (target.Code = source.Code)
	WHEN MATCHED THEN
		UPDATE SET Name     = source.Name,
				   IsActive = source.IsActive,
				   DateLoad = source.DateLoad
	WHEN NOT MATCHED THEN
		INSERT (Code, Name, IsActive, DateLoad)
		VALUES (source.Code, source.Name, source.IsActive, source.DateLoad);

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
-- Создать процедуру [dbo].[SP_SET_EQUIPMENT_ISACTIVE]
--
GO

--
-- procedure sp_refresh_equipment_isactive
--
CREATE PROCEDURE [dbo].[SP_SET_EQUIPMENT_ISACTIVE]
	@isactive bit
AS
BEGIN
	UPDATE dbo.SK_EQUIPMENT
	SET IsActive = @isactive;
END
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Создать процедуру [dbo].[SP_RFR_EQUIPMENT_ISACTIVE]
--
GO

--
-- procedure sp_refresh_equipment_isactive
--
CREATE PROCEDURE [dbo].[SP_RFR_EQUIPMENT_ISACTIVE]
AS
BEGIN
	UPDATE eq
	SET eq.IsActive = CASE WHEN pr.EquipmentId IS NOT NULL THEN 1 ELSE 0 END
	FROM dbo.SK_EQUIPMENT eq
		 LEFT JOIN (SELECT DISTINCT p.EquipmentId 
					FROM dbo.RS_PRODUCT p
					WHERE p.IsActive = 1) pr
		   ON eq.EquipmentId = pr.EquipmentId;

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