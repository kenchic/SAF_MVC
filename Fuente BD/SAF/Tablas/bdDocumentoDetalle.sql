USE [SAF]
GO

/****** Object:  Table [dbo].[bdDocumentoDetalle]    Script Date: 17/06/2019 01:38:05 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bdDocumentoDetalle](
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

ALTER TABLE [dbo].[bdDocumentoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumento] FOREIGN KEY([idDocumento])
REFERENCES [dbo].[bdDocumento] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[bdDocumentoDetalle] CHECK CONSTRAINT [FK_bdDocumento]
GO

ALTER TABLE [dbo].[bdDocumentoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO

ALTER TABLE [dbo].[bdDocumentoDetalle] CHECK CONSTRAINT [FK_bdDocumentoDetalleElemento]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdDocumentoDetalle'
GO


