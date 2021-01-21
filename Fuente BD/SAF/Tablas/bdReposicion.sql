USE [SAF]
GO

/****** Object:  Table [SAF].[bdReposicion]    Script Date: 20/01/2021 12:11:40 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdReposicion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdReposicion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdReposicion]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdReposicion] CHECK CONSTRAINT [FK_bdReposicionBodegaDestino]
GO

ALTER TABLE [SAF].[bdReposicion]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdReposicion] CHECK CONSTRAINT [FK_bdReposicionBodegaOrigen]
GO

ALTER TABLE [SAF].[bdReposicion]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionDevolucion] FOREIGN KEY([idDevolucion])
REFERENCES [SAF].[bdDevolucion] ([Id])
GO

ALTER TABLE [SAF].[bdReposicion] CHECK CONSTRAINT [FK_bdReposicionDevolucion]
GO

ALTER TABLE [SAF].[bdReposicion]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO

ALTER TABLE [SAF].[bdReposicion] CHECK CONSTRAINT [FK_bdReposicionDocumentoTipo]
GO


