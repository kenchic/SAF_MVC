USE [SAFseg]
GO

/****** Object:  UserDefinedFunction [SEG].[fJsonINT]    Script Date: 25/05/2019 10:03:49 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [SEG].[fJsonINT] (@NombreIn VARCHAR(100), @NumeroIn INT)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @numero VARCHAR(50)	
	SET @numero = '"' + @NombreIn + '":"'

	IF (@NumeroIn IS NOT NULL)
		BEGIN
			SET @numero = @numero + CONVERT(VARCHAR, @NumeroIn)
		END
    RETURN @numero + '"'
END
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'FUNCTION',@level1name=N'fJsonINT'
GO


