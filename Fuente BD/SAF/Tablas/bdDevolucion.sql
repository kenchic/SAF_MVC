USE [SAF]
GO

/****** Object:  Table [SAF].[bdDevolucion]    Script Date: 20/01/2021 12:06:07 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdDevolucion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idProyecto] [smallint] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[idConductor] [smallint] NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[ValorTransporte] [numeric](8, 0) NULL,
	[PesoEquipo] [numeric](6, 2) NULL,
	[ValorEquipo] [numeric](10, 0) NULL,
	[EntregaCliente] [bit] NULL,
	[EntregaParcial] [bit] NULL,
	[Estado] [varchar](10) NULL,
 CONSTRAINT [PK_bdDevolucion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionBodegaDestino]
GO

ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionBodegaOrigen]
GO

ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionConductor] FOREIGN KEY([idConductor])
REFERENCES [SAF].[bdConductor] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionConductor]
GO

ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionDocumentoTipo]
GO

ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionProyecto] FOREIGN KEY([idProyecto])
REFERENCES [SAF].[bdProyecto] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionProyecto]
GO


