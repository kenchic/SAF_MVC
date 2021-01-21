USE [SAF]
GO

/****** Object:  Table [SAF].[bdRemisionDetalle]    Script Date: 20/01/2021 12:11:32 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdRemisionDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRemision] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdRemisionDetalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [SAF].[bdRemisionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO

ALTER TABLE [SAF].[bdRemisionDetalle] CHECK CONSTRAINT [FK_bdRemisionDetalleElemento]
GO

ALTER TABLE [SAF].[bdRemisionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionDetalleRemision] FOREIGN KEY([idRemision])
REFERENCES [SAF].[bdRemision] ([Id])
GO

ALTER TABLE [SAF].[bdRemisionDetalle] CHECK CONSTRAINT [FK_bdRemisionDetalleRemision]
GO


