USE [SAF]
GO

/****** Object:  Table [SAF].[bdListaPrecioDetalle]    Script Date: 20/01/2021 12:09:33 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdListaPrecioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idListaPrecio] [tinyint] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[PrecioAlquiler] [int] NOT NULL CONSTRAINT [DF_bdListaPrecioDetalle_PrecioAlquiler]  DEFAULT ((0)),
	[PrecioVenta] [int] NOT NULL CONSTRAINT [DF_bdListaPrecioDetalle_PrecioVenta]  DEFAULT ((0)),
	[PrecioPerdida] [int] NOT NULL CONSTRAINT [DF_bdListaPrecioDetalle_PrecioPerdida]  DEFAULT ((0)),
 CONSTRAINT [PK_bdDetallesListasPrecios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [SAF].[bdListaPrecioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdListaPrecioDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO

ALTER TABLE [SAF].[bdListaPrecioDetalle] CHECK CONSTRAINT [FK_bdListaPrecioDetalleElemento]
GO

ALTER TABLE [SAF].[bdListaPrecioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdListaPrecioDetalleListaPrecio] FOREIGN KEY([idListaPrecio])
REFERENCES [SAF].[bdListaPrecio] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [SAF].[bdListaPrecioDetalle] CHECK CONSTRAINT [FK_bdListaPrecioDetalleListaPrecio]
GO