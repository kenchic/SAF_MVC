USE [SAF]
GO

/****** Object:  Table [SAF].[bdDevolucionServicioDetalle]    Script Date: 20/01/2021 12:06:53 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdDevolucionServicioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucionServicio] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO


