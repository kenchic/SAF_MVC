USE [SAF]
GO

/****** Object:  Trigger [dbo].[tProyecto]    Script Date: 14/03/2019 09:53:11 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tProyecto] ON [dbo].[bdProyecto] 
FOR INSERT
AS

INSERT INTO bdContrato
SELECT I.Id, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM INSERTED AS I
GO


