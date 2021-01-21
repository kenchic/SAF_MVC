USE [SAF]
GO

/****** Object:  Table [SAF].[bdCorteDetalle]    Script Date: 20/01/2021 12:05:10 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdCorteDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCorte] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO


