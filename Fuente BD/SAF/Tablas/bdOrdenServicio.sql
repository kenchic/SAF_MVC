USE [SAF]
GO

/****** Object:  Table [SAF].[bdOrdenServicio]    Script Date: 20/01/2021 12:10:17 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdOrdenServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idRemision] [int] NOT NULL,
	[idProveedor] [smallint] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdOrdenServicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioBodegaDestino]
GO

ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioBodegaOrigen]
GO

ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO

ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioDocumentoTipo]
GO

ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioProveedor] FOREIGN KEY([idProveedor])
REFERENCES [SAF].[bdProveedor] ([Id])
GO

ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioProveedor]
GO

ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioRemision] FOREIGN KEY([idRemision])
REFERENCES [SAF].[bdRemision] ([Id])
GO

ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioRemision]
GO


