USE ToolsStore
GO

ALTER PROCEDURE dbo.SP_GET_RULE_DATA
	@LoadRuleSpecId BIGINT
AS
BEGIN
  SELECT lrs.Data
  FROM dbo.MT_LOAD_RULE_SPEC lrs
  WHERE lrs.LoadRuleSpecId = @LoadRuleSpecId;
END
