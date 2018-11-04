USE ToolsStore
GO

IF DB_NAME() <> N'ToolsStore' SET NOEXEC ON
GO

--
-- Change transaction localization level (�������� ������� ����������� ����������)
--
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

--
-- begin transaction
--
BEGIN TRANSACTION
GO

--
--rs_product add isactive null
--
ALTER TABLE dbo.RS_PRODUCT 
  ADD IsActive BIT NULL;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--rs_product.isactive = 0
--
UPDATE dbo.RS_PRODUCT
SET IsActive = 1;
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
--rs_product.isactive not null
--
ALTER TABLE dbo.RS_PRODUCT 
  ALTER COLUMN IsActive BIT NOT NULL; 
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- commit transaction
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
GO

--
-- set noexec to off (���������� NOEXEC � ��������� off)
--
SET NOEXEC OFF
GO