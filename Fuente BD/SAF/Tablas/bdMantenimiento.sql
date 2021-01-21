USE [SAF]
GO

/****** Object:  Table [SAF].[bdMantenimiento]    Script Date: 20/01/2021 12:09:51 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdMantenimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdMantenimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdMantenimientoBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdMantenimiento] CHECK CONSTRAINT [FK_bdMantenimientoBodegaDestino]
GO

ALTER TABLE [SAF].[bdMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdMantenimientoBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdMantenimiento] CHECK CONSTRAINT [FK_bdMantenimientoBodegaOrigen]
GO

ALTER TABLE [SAF].[bdMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdMantenimientoDevolucion] FOREIGN KEY([idDevolucion])
REFERENCES [SAF].[bdDevolucion] ([Id])
GO

ALTER TABLE [SAF].[bdMantenimiento] CHECK CONSTRAINT [FK_bdMantenimientoDevolucion]
GO

ALTER TABLE [SAF].[bdMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdMantenimientoDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO

ALTER TABLE [SAF].[bdMantenimiento] CHECK CONSTRAINT [FK_bdMantenimientoDocumentoTipo]
GO


