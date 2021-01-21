USE [SAF]
GO

/****** Object:  Table [SAF].[bdCorteOrdenServicio]    Script Date: 20/01/2021 12:05:24 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdCorteOrdenServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[bdCorte] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


