USE [SAF]
GO

/****** Object:  Table [SAF].[bdDevolucionServicio]    Script Date: 20/01/2021 12:06:41 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdDevolucionServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idProveedor] [smallint] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdDevolucionServicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioBodegaDestino]
GO

ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioBodegaOrigen]
GO

ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioDevolucion] FOREIGN KEY([idDevolucion])
REFERENCES [SAF].[bdDevolucion] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioDevolucion]
GO

ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioDocumentoTipo]
GO

ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioProveedor] FOREIGN KEY([idProveedor])
REFERENCES [SAF].[bdProveedor] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioProveedor]
GO


