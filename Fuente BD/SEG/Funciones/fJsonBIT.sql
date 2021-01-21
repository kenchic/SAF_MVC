USE [SAFseg]
GO

/****** Object:  UserDefinedFunction [SEG].[fJsonBIT]    Script Date: 25/05/2019 10:03:02 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [SEG].[fJsonBIT] (@NombreIn VARCHAR(100), @EstadoIn BIT)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @estado VARCHAR(50)	
	SET @estado = '"' + @NombreIn + '":"'

	IF (@EstadoIn IS NOT NULL)
		BEGIN
			SET @estado = @estado + CONVERT(VARCHAR, @EstadoIn)
		END
    RETURN @estado + '"'
END
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'FUNCTION',@level1name=N'fJsonBIT'
GO


