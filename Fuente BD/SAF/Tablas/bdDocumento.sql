USE [SAF]
GO

/****** Object:  Table [dbo].[bdDocumento]    Script Date: 17/06/2019 01:37:48 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdDocumento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idTipoDocumento] [tinyint] NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Anulado] [bit] NOT NULL,
 CONSTRAINT [PK_bdMovimientos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [dbo].[bdBodega] ([Id])
GO

ALTER TABLE [dbo].[bdDocumento] CHECK CONSTRAINT [FK_bdDocumentoBodegaDestino]
GO

ALTER TABLE [dbo].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [dbo].[bdBodega] ([Id])
GO

ALTER TABLE [dbo].[bdDocumento] CHECK CONSTRAINT [FK_bdDocumentoBodegaOrigen]
GO

ALTER TABLE [dbo].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoTipoDocumento] FOREIGN KEY([idTipoDocumento])
REFERENCES [dbo].[bdTipoDocumento] ([Id])
GO

ALTER TABLE [dbo].[bdDocumento] CHECK CONSTRAINT [FK_bdDocumentoTipoDocumento]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdDocumento'
GO


