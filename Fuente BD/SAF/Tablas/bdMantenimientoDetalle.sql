USE [SAF]
GO

/****** Object:  Table [SAF].[bdMantenimientoDetalle]    Script Date: 20/01/2021 12:10:08 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdMantenimientoDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idReposicion] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[TipoMantenimiento] [varchar](5) NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


