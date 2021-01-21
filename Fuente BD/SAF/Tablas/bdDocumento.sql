USE [SAF]
GO

/****** Object:  Table [SAF].[bdDocumento]    Script Date: 20/01/2021 12:07:06 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdDocumento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdMovimientos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdDocumento] CHECK CONSTRAINT [FK_bdDocumentoBodegaDestino]
GO

ALTER TABLE [SAF].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdDocumento] CHECK CONSTRAINT [FK_bdDocumentoBodegaOrigen]
GO

ALTER TABLE [SAF].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO

ALTER TABLE [SAF].[bdDocumento] CHECK CONSTRAINT [FK_bdDocumentoTipo]
GO
