USE [SAF]
GO

/****** Object:  Table [dbo].[bdBodega]    Script Date: 11/03/2019 05:17:11 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdBodega](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL CONSTRAINT [DF_bdBodega_idCliente]  DEFAULT ((0)),
	[idProveedor] [smallint] NULL CONSTRAINT [DF_bdBodega_idProveedor]  DEFAULT ((0)),
	[Nombre] [varchar](50) NOT NULL,
	[EsSistema] [bit] NOT NULL CONSTRAINT [DF_bdBodega_EsSistema]  DEFAULT ((0)),
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdBodegas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[bdBodega]  WITH CHECK ADD  CONSTRAINT [FK_bdBodegaCliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[bdCliente] ([Id])
GO

ALTER TABLE [dbo].[bdBodega] CHECK CONSTRAINT [FK_bdBodegaCliente]
GO

ALTER TABLE [dbo].[bdBodega]  WITH CHECK ADD  CONSTRAINT [FK_bdBodegaProveedor] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[bdProveedor] ([Id])
GO

ALTER TABLE [dbo].[bdBodega] CHECK CONSTRAINT [FK_bdBodegaProveedor]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdBodega'
GO


