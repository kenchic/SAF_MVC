USE [SAF]
GO

/****** Object:  Table [SAF].[bdContrato]    Script Date: 20/01/2021 12:38:01 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdContrato](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idProyecto] [smallint] NOT NULL,
	[idListaPrecio] [tinyint] NOT NULL,
	[idAgente] [smallint] NULL,
	[InformacionBD] [bit] NOT NULL,
	[ContratoAlquiler] [bit] NOT NULL,
	[CartaPagare] [bit] NOT NULL,
	[Pagare] [bit] NOT NULL,
	[LetraCambio] [bit] NOT NULL,
	[GarantiasCondiciones] [bit] NOT NULL,
	[Deposito] [bit] NOT NULL,
	[Anticipo] [bit] NOT NULL,
	[PersonaJuridica] [bit] NOT NULL,
	[PersonaNatural] [bit] NOT NULL,
	[FotoCopiaCedula] [bit] NOT NULL,
	[FotoCopiaNit] [bit] NOT NULL,
	[CamaraComercio] [bit] NOT NULL,
	[DescuentoAlquiler] [tinyint] NOT NULL,
	[DescuentoVenta] [tinyint] NOT NULL,
	[DescuentoReposicion] [tinyint] NOT NULL,
	[DescuentoMantenimiento] [tinyint] NOT NULL,
	[DescuentoTransporte] [tinyint] NOT NULL,
	[PorcentajeAgente] [tinyint] NULL,
 CONSTRAINT [PK_bdContratos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [SAF].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoAgente] FOREIGN KEY([idAgente])
REFERENCES [SAF].[bdAgente] ([Id])
GO

ALTER TABLE [SAF].[bdContrato] CHECK CONSTRAINT [FK_bdContratoAgente]
GO

ALTER TABLE [SAF].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoListaPrecio] FOREIGN KEY([idListaPrecio])
REFERENCES [SAF].[bdListaPrecio] ([Id])
GO

ALTER TABLE [SAF].[bdContrato] CHECK CONSTRAINT [FK_bdContratoListaPrecio]
GO

ALTER TABLE [SAF].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoProyecto] FOREIGN KEY([idProyecto])
REFERENCES [SAF].[bdProyecto] ([Id])
GO

ALTER TABLE [SAF].[bdContrato] CHECK CONSTRAINT [FK_bdContratoProyecto]
GO
