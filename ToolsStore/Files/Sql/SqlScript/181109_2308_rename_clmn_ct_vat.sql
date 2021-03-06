USE ToolsStore
GO

IF DB_NAME() <> N'ToolsStore' SET NOEXEC ON
GO

--
-- Change transaction localization level (Изменить уровень локализации транзакции)
--
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

--
-- begin transaction
--
BEGIN TRANSACTION
GO

--
--Table CT_VAT rename column Rem to IsActive
--
EXEC sp_RENAME 'CT_VAT.Rem' , 'IsActive', 'COLUMN'
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--update IsActive
--
UPDATE CT_VAT
SET IsActive = CASE IsActive WHEN 0 THEN 1 ELSE 0 END;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--alter v_product
--
ALTER VIEW dbo.V_PRODUCT
AS 
SELECT pr.ProductId, pr.EquipmentId, eq.CategoryId, pr.ModelId, md.BrandId, pr.ImageId, 
	   pr.Name, pr.Descr, pr.Mass, pr.Length, pr.Width, pr.Height, pr.Color, pr.Power, pr.Kit,
	   eq.Name EquipmentName, eq.NameExtra EquipmentNameExtra,
	   ct.Name CategoryName, br.Name BrandName, md.Name ModelName,
	   im.Data, im.MimeType, im.Name ImageName,
	   prc.PriceWithVat, prc.PriceWithoutVat, prc.DateBegin, prc.DateEnd,
	   v.Code VatCode, v.Name VatName, v.IsActive VatIsActive
FROM RS_PRODUCT pr
     JOIN SK_EQUIPMENT eq
	   ON pr.EquipmentId = eq.EquipmentId
     LEFT JOIN CT_CATEGORY ct 
	   ON eq.CategoryId = ct.CategoryId     
     JOIN SK_MODEL md 
	   ON pr.ModelId = md.ModelId
	 JOIN CT_BRAND br 
	   ON md.BrandId = br.BrandId
	 LEFT JOIN CT_IMAGE im
	   ON pr.ImageId = im.ImageId
     LEFT JOIN RS_PRICE prc 
	   ON pr.ProductId = prc.ProductId
          AND GETDATE() BETWEEN prc.DateBegin AND prc.DateEnd
	 LEFT JOIN CT_VAT v 
	   ON prc.VatId = v.VatId
	      AND v.IsActive = 1;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- procedure sp_im_vat
--
ALTER PROCEDURE dbo.SP_IM_VAT
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
-- commit transaction
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
GO

--
-- set noexec to off (Установить NOEXEC в состояние off)
--
SET NOEXEC OFF
GO