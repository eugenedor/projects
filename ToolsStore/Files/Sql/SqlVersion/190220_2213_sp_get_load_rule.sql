USE ToolsStore
GO

ALTER PROCEDURE dbo.SP_GET_LOAD_RULE
	@Path NVARCHAR(1000)
AS
BEGIN
  SET @Path = ISNULL(LOWER(LTRIM(RTRIM(@Path))), '');

  SET @Path = 	   
        CASE LEN(@Path) 
	      WHEN 0 THEN @Path
          ELSE CASE 
			     WHEN SUBSTRING(@Path, LEN(@Path), 1) = '\' THEN LEFT(@Path, LEN(@Path)-1)
				 ELSE @Path
			   END			  			 			   
        END;

  SELECT lr.LoadRuleId, 
	     lr.Code, 
	     lr.Pattern, 
	     lr.Method,
	     lr.Descr,
	     lr.IsActive, 
	     lr.Ord,
	     lrs.LoadRuleSpecId, 
	     lrs.FileName, 
	     ISNULL(@Path + '\', '') + lrs.PathToFile + '\' AS PathToFile, 
	     ISNULL(@Path + '\', '') + lrs.PathToFile + '\' + lrs.FileName AS PathName,
	     lrs.IsMain   
  FROM dbo.MT_LOAD_RULE lr
	   JOIN dbo.MT_LOAD_RULE_SPEC lrs
	     ON lr.LoadRuleId = lrs.LoadRuleId
  WHERE lr.IsActive = 1
  ORDER BY lr.Ord, CASE WHEN lrs.IsMain = 1 THEN 0 ELSE 1 END;
END
