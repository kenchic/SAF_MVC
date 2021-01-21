USE [SAF]
GO

/****** Object:  Table [SAF].[bdDevolucionDetalle]    Script Date: 20/01/2021 12:06:25 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdDevolucionDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdDevolucionDetalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [SAF].[bdDevolucionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionDetalleDevolucion] FOREIGN KEY([idDevolucion])
REFERENCES [SAF].[bdDevolucion] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucionDetalle] CHECK CONSTRAINT [FK_bdDevolucionDetalleDevolucion]
GO

ALTER TABLE [SAF].[bdDevolucionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO

ALTER TABLE [SAF].[bdDevolucionDetalle] CHECK CONSTRAINT [FK_bdDevolucionDetalleElemento]
GO


