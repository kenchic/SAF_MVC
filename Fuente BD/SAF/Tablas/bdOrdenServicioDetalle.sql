USE [SAF]
GO

/****** Object:  Table [SAF].[bdOrdenServicioDetalle]    Script Date: 20/01/2021 12:10:28 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdOrdenServicioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idOrdenServicio] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO


