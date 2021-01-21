USE [SAF]
GO

/****** Object:  Table [SAF].[bdBodega]    Script Date: 20/01/2021 12:02:30 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdBodega](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL,
	[idProveedor] [smallint] NULL,
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

ALTER TABLE [SAF].[bdBodega]  WITH NOCHECK ADD  CONSTRAINT [FK_bdBodegaCliente] FOREIGN KEY([idCliente])
REFERENCES [SAF].[bdCliente] ([Id])
GO

ALTER TABLE [SAF].[bdBodega] NOCHECK CONSTRAINT [FK_bdBodegaCliente]
GO

ALTER TABLE [SAF].[bdBodega]  WITH NOCHECK ADD  CONSTRAINT [FK_bdBodegaProveedor] FOREIGN KEY([idProveedor])
REFERENCES [SAF].[bdProveedor] ([Id])
GO

ALTER TABLE [SAF].[bdBodega] NOCHECK CONSTRAINT [FK_bdBodegaProveedor]
GO