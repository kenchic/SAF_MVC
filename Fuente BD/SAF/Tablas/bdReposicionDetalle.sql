USE [SAF]
GO

/****** Object:  Table [SAF].[bdReposicionDetalle]    Script Date: 20/01/2021 12:11:52 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdReposicionDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idReposicion] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO


