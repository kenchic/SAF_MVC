USE [SAF]
GO

/****** Object:  Table [dbo].[bdContrato]    Script Date: 14/03/2019 10:13:34 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bdContrato](
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

ALTER TABLE [dbo].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoAgente] FOREIGN KEY([idAgente])
REFERENCES [dbo].[bdAgente] ([Id])
GO

ALTER TABLE [dbo].[bdContrato] CHECK CONSTRAINT [FK_bdContratoAgente]
GO

ALTER TABLE [dbo].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoListaPrecio] FOREIGN KEY([idListaPrecio])
REFERENCES [dbo].[bdListaPrecio] ([Id])
GO

ALTER TABLE [dbo].[bdContrato] CHECK CONSTRAINT [FK_bdContratoListaPrecio]
GO

ALTER TABLE [dbo].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoProyecto] FOREIGN KEY([idProyecto])
REFERENCES [dbo].[bdProyecto] ([Id])
GO

ALTER TABLE [dbo].[bdContrato] CHECK CONSTRAINT [FK_bdContratoProyecto]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdContrato'
GO


