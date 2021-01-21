USE [SAF]
GO

/****** Object:  Table [SAF].[bdCorteOrdenServicioDetalle]    Script Date: 20/01/2021 12:05:40 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdCorteOrdenServicioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCorteOrdenServicio] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO


