USE [SAF]
GO

/****** Object:  Table [SEG].[bdRolUsuario]    Script Date: 20/01/2021 12:21:09 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SEG].[bdRolUsuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRolUsuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SEG].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRol] FOREIGN KEY([idRol])
REFERENCES [SEG].[bdRol] ([Id])
GO

ALTER TABLE [SEG].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRol]
GO

ALTER TABLE [SEG].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRolUsuario] FOREIGN KEY([Id])
REFERENCES [SEG].[bdRolUsuario] ([Id])
GO

ALTER TABLE [SEG].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRolUsuario]
GO


