USE [SAF]
GO

/****** Object:  Trigger [SAF].[tProyectoInsertar]    Script Date: 03/02/2020 03:34:41 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [SAF].[tProyectoInsertar] ON [SAF].[bdProyecto] 
FOR INSERT
AS

BEGIN

	INSERT INTO bdContrato
	SELECT I.Id, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM INSERTED AS I
	
END

GO


