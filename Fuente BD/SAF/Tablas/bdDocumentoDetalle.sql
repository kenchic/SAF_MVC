USE [SAF]
GO

/****** Object:  Table [SAF].[bdDocumentoDetalle]    Script Date: 20/01/2021 12:08:26 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SAF].[bdDocumentoDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[idDocumento] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bd] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [SAF].[bdDocumentoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumento] FOREIGN KEY([idDocumento])
REFERENCES [SAF].[bdDocumento] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [SAF].[bdDocumentoDetalle] CHECK CONSTRAINT [FK_bdDocumento]
GO

ALTER TABLE [SAF].[bdDocumentoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO

ALTER TABLE [SAF].[bdDocumentoDetalle] CHECK CONSTRAINT [FK_bdDocumentoDetalleElemento]
GO