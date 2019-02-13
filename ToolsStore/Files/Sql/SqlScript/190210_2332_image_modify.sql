USE ToolsStore;
GO

EXEC sp_rename 'dbo.CT_IMAGE.Name', 'FileName', 'COLUMN';
GO

SET DATEFORMAT ymd;

DECLARE @t TABLE (ImageId BIGINT, DateLoad DATETIME NOT NULL)

INSERT INTO @t (ImageId, DateLoad)
SELECT i.ImageId, i.DateLoad
FROM dbo.CT_IMAGE i;

ALTER TABLE dbo.CT_IMAGE 
	DROP COLUMN DateLoad ;  

ALTER TABLE dbo.CT_IMAGE
	ADD Size INT NULL;

ALTER TABLE dbo.CT_IMAGE
	ADD DateLoad datetime NULL;

UPDATE i
SET i.DateLoad = t.DateLoad
FROM dbo.CT_IMAGE i
     JOIN @t t
	   ON i.ImageId = t.ImageId

ALTER TABLE dbo.CT_IMAGE
	ALTER COLUMN MimeType NVARCHAR(50) NULL;

ALTER TABLE dbo.CT_IMAGE
	ALTER COLUMN FileName NVARCHAR(100) NULL;

ALTER TABLE dbo.CT_IMAGE
	ALTER COLUMN DateLoad DATETIME NOT NULL;
GO