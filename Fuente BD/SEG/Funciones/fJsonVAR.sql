USE [SAFseg]
GO

/****** Object:  UserDefinedFunction [SEG].[fJsonVAR]    Script Date: 25/05/2019 10:05:50 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [SEG].[fJsonVAR] (@NombreIn VARCHAR(100), @CampoIn VARCHAR(MAX))
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @campo VARCHAR(50)	
	SET @campo = '"' + @NombreIn + '":"'

	IF (@CampoIn IS NOT NULL)
		BEGIN
			SET @campo = @campo + CONVERT(VARCHAR, @CampoIn)
		END
    RETURN @campo + '"'
END

GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'FUNCTION',@level1name=N'fJsonVAR'
GO


