USE ToolsStore
GO

--
--DROP RS_ORDER_CONTENT
--
IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('dbo.RS_ORDER_CONTENT') AND type = N'U')
BEGIN
  ALTER TABLE dbo.RS_ORDER_CONTENT 
    DROP CONSTRAINT FK_RS_ORDER_CONTENT_RS_PRODUCT;
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('dbo.RS_ORDER_CONTENT') AND type = N'U')
BEGIN
  ALTER TABLE dbo.RS_ORDER_CONTENT 
    DROP CONSTRAINT FK_RS_ORDER_CONTENT_RS_PRICE;
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('dbo.RS_ORDER_CONTENT') AND type = N'U')
BEGIN
  ALTER TABLE dbo.RS_ORDER_CONTENT 
    DROP CONSTRAINT FK_RS_ORDER_CONTENT_RS_ORDER;
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('dbo.RS_ORDER_CONTENT') AND type = N'U')
BEGIN
  DROP INDEX FK_RS_ORDER_CONTENT_RS_PRODUCT ON dbo.RS_ORDER_CONTENT
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('dbo.RS_ORDER_CONTENT') AND type = N'U')
BEGIN
  DROP INDEX FK_RS_ORDER_CONTENT_RS_PRICE ON dbo.RS_ORDER_CONTENT
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('dbo.RS_ORDER_CONTENT') AND type = N'U')
BEGIN
  DROP INDEX FK_RS_ORDER_CONTENT_RS_ORDER ON dbo.RS_ORDER_CONTENT
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID('dbo.RS_ORDER_CONTENT') AND type = N'U')
BEGIN
  DROP TABLE dbo.RS_ORDER_CONTENT;
END
GO


--
--CREATE RS_ORDER_CONTENT
--
CREATE TABLE dbo.RS_ORDER_CONTENT (
  OrderContentId bigint IDENTITY,
  OrderId bigint NOT NULL,
  ProductId bigint NOT NULL,
  PriceId bigint NULL,
  Quantity int NOT NULL,
  CONSTRAINT PK_RS_ORDER_CONTENT PRIMARY KEY CLUSTERED (OrderContentId)
)
ON [PRIMARY]
GO

CREATE INDEX FK_RS_ORDER_CONTENT_RS_ORDER
  ON dbo.RS_ORDER_CONTENT (OrderId)
  ON [PRIMARY]
GO

CREATE INDEX FK_RS_ORDER_CONTENT_RS_PRICE
  ON dbo.RS_ORDER_CONTENT (PriceId)
  ON [PRIMARY]
GO

CREATE INDEX FK_RS_ORDER_CONTENT_RS_PRODUCT
  ON dbo.RS_ORDER_CONTENT (ProductId)
  ON [PRIMARY]
GO

ALTER TABLE dbo.RS_ORDER_CONTENT
  ADD CONSTRAINT FK_RS_ORDER_CONTENT_RS_ORDER FOREIGN KEY (OrderId) REFERENCES dbo.RS_ORDER (OrderId)
GO

ALTER TABLE dbo.RS_ORDER_CONTENT
  ADD CONSTRAINT FK_RS_ORDER_CONTENT_RS_PRICE FOREIGN KEY (PriceId) REFERENCES dbo.RS_PRICE (PriceId)
GO

ALTER TABLE dbo.RS_ORDER_CONTENT
  ADD CONSTRAINT FK_RS_ORDER_CONTENT_RS_PRODUCT FOREIGN KEY (ProductId) REFERENCES dbo.RS_PRODUCT (ProductId)
GO

SELECT OBJECT_ID('dbo.RS_ORDER_CONTENT') AS objectId;
GO