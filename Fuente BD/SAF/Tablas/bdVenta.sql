USE [SAF]
GO

/****** Object:  Table [SAF].[bdVenta]    Script Date: 20/01/2021 12:12:36 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdVenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idRemision] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](5) NOT NULL,
 CONSTRAINT [PK_bdVenta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdVenta] CHECK CONSTRAINT [FK_bdVentaBodegaDestino]
GO

ALTER TABLE [SAF].[bdVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdVenta] CHECK CONSTRAINT [FK_bdVentaBodegaOrigen]
GO

ALTER TABLE [SAF].[bdVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO

ALTER TABLE [SAF].[bdVenta] CHECK CONSTRAINT [FK_bdVentaDocumentoTipo]
GO

ALTER TABLE [SAF].[bdVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaRemision] FOREIGN KEY([idRemision])
REFERENCES [SAF].[bdRemision] ([Id])
GO

ALTER TABLE [SAF].[bdVenta] CHECK CONSTRAINT [FK_bdVentaRemision]
GO


