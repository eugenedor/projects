USE ToolsStore
GO


CREATE FUNCTION dbo.FN_GET_NUM
(
    @from INT,
    @to   INT
)
RETURNS @t TABLE
(
    Num INT
)
AS
BEGIN
	WITH t AS (SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) v(n))
	
	INSERT INTO @t (Num)
	SELECT tbl.n
	FROM (SELECT t1.n + t2.n*10 + t3.n*100 + t4.n*1000 + t5.n*10000 + t6.n*100000  as n
		  FROM t t1,     
			   t t2,
			   t t3,
			   t t4, 
			   t t5,
			   t t6) tbl
	WHERE tbl.n BETWEEN @from AND @to
	ORDER BY 1;
    
	RETURN;
END