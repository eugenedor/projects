USE ToolsStore
GO

--
-- procedure sp_set_equipment_isactive
--
ALTER PROCEDURE dbo.SP_SET_EQUIPMENT_ISACTIVE
	@IsActive BIT
AS
BEGIN
	UPDATE dbo.SK_EQUIPMENT
	SET IsActive = @IsActive;
END
