USE [SAF]
GO

/****** Object:  Trigger [SAF].[tDocumentoInsertar]    Script Date: 03/07/2019 03:33:56 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [SAF].[tDocumentoInsertar] ON [SAF].[bdDocumento] 
AFTER INSERT
AS

BEGIN

	UPDATE bdTipoDocumento
	SET Consecutivo = Consecutivo + 1
	WHERE Id = (SELECT idTipoDocumento FROM INSERTED)

	UPDATE bdDocumento
    SET Numero = bdTipoDocumento.Consecutivo
    FROM bdDocumento
	INNER JOIN bdTipoDocumento ON bdTipoDocumento.Id = bdDocumento.idTipoDocumento
    INNER JOIN inserted I on I.Id = bdDocumento.Id
END

GO


