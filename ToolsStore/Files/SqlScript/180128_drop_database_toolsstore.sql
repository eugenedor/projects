USE master;  
GO 
 
IF DB_ID (N'ToolsStore') IS NULL
  RETURN;
ALTER DATABASE ToolsStore
SET SINGLE_USER --or RESTRICTED_USER
WITH ROLLBACK IMMEDIATE;
GO

IF DB_ID (N'ToolsStore') IS NULL
  RETURN;
DROP DATABASE ToolsStore;
GO