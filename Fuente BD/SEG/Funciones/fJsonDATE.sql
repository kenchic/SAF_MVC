USE [SAFseg]
GO

/****** Object:  UserDefinedFunction [SEG].[fJsonDATE]    Script Date: 25/05/2019 10:03:19 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [SEG].[fJsonDATE] (@NombreIn VARCHAR(100), @FechaIn DATETIME)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @fecha VARCHAR(50)	
	SET @fecha ='"' + @NombreIn + '":"'

	IF (@FechaIn IS NOT NULL)
		BEGIN
			SET @fecha = @fecha + CONVERT(VARCHAR, @FechaIn, 9)
		END
    RETURN @fecha + '"'
END
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'FUNCTION',@level1name=N'fJsonDATE'
GO


