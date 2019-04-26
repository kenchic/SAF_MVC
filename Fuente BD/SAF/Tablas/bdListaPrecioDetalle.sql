USE [SAF]
GO

/****** Object:  Table [dbo].[bdListaPrecioDetalle]    Script Date: 24/04/2019 09:07:57 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bdListaPrecioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idListaPrecio] [tinyint] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[PrecioAlquiler] [int] NOT NULL,
	[PrecioVenta] [int] NOT NULL,
	[PrecioPerdida] [int] NOT NULL,
 CONSTRAINT [PK_bdDetallesListasPrecios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[bdListaPrecioDetalle] ADD  CONSTRAINT [DF_bdListaPrecioDetalle_PrecioAlquiler]  DEFAULT ((0)) FOR [PrecioAlquiler]
GO

ALTER TABLE [dbo].[bdListaPrecioDetalle] ADD  CONSTRAINT [DF_bdListaPrecioDetalle_PrecioVenta]  DEFAULT ((0)) FOR [PrecioVenta]
GO

ALTER TABLE [dbo].[bdListaPrecioDetalle] ADD  CONSTRAINT [DF_bdListaPrecioDetalle_PrecioPerdida]  DEFAULT ((0)) FOR [PrecioPerdida]
GO

ALTER TABLE [dbo].[bdListaPrecioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdListaPrecioDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO

ALTER TABLE [dbo].[bdListaPrecioDetalle] CHECK CONSTRAINT [FK_bdListaPrecioDetalleElemento]
GO

ALTER TABLE [dbo].[bdListaPrecioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdListaPrecioDetalleListaPrecio] FOREIGN KEY([idListaPrecio])
REFERENCES [dbo].[bdListaPrecio] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[bdListaPrecioDetalle] CHECK CONSTRAINT [FK_bdListaPrecioDetalleListaPrecio]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdListaPrecioDetalle'
GO


