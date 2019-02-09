USE ToolsStore
GO

ALTER PROCEDURE dbo.SP_GET_LOAD_RULE
	@Path     nvarchar(1000)
AS
BEGIN
	SELECT lr.LoadRuleId, 
	       lr.Code, 
		   lr.Pattern as FileName, 
		   lr.IsActive, 
		   lr.Method as MethodLoad, 
		   isnull(@Path + '\', '') + lrs.PathToFile + '\' as PathToXsd, 
		   lrs.FileName XsdName, 
		   lr.Descr, 
		   lr.Ord
	FROM dbo.MT_LOAD_RULE lr
	     join dbo.MT_LOAD_RULE_SPEC lrs
		   on lr.LoadRuleId = lrs.LoadRuleId
END
