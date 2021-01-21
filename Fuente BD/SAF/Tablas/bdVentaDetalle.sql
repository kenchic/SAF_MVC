USE [SAF]
GO

/****** Object:  Table [SAF].[bdVentaDetalle]    Script Date: 20/01/2021 12:13:12 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdVentaDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idVenta] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdVentaDetalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [SAF].[bdVentaDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO

ALTER TABLE [SAF].[bdVentaDetalle] CHECK CONSTRAINT [FK_bdVentaDetalleElemento]
GO

ALTER TABLE [SAF].[bdVentaDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaDetalleVenta] FOREIGN KEY([idVenta])
REFERENCES [SAF].[bdVenta] ([Id])
GO

ALTER TABLE [SAF].[bdVentaDetalle] CHECK CONSTRAINT [FK_bdVentaDetalleVenta]
GO


