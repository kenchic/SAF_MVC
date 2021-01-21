USE [SAF]
GO

/****** Object:  Table [SAF].[bdRemision]    Script Date: 20/01/2021 12:11:05 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdRemision](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idProyecto] [smallint] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[idConductor] [smallint] NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Transporte] [bit] NULL,
	[ValorTransporte] [numeric](8, 0) NULL,
	[Despachado] [bit] NULL,
	[EquipoAdecuado] [bit] NULL,
	[PesoEquipo] [numeric](6, 2) NULL,
	[ValorEquipo] [numeric](10, 0) NULL,
	[Estado] [varchar](10) NULL,
 CONSTRAINT [PK_bdRemision] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionBodegaDestino]
GO

ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionBodegaOrigen]
GO

ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionConductor] FOREIGN KEY([idConductor])
REFERENCES [SAF].[bdConductor] ([Id])
GO

ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionConductor]
GO

ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO

ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionDocumentoTipo]
GO

ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionProyecto] FOREIGN KEY([idProyecto])
REFERENCES [SAF].[bdProyecto] ([Id])
GO

ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionProyecto]
GO


