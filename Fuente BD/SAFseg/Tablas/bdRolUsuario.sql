USE [SAFseg]
GO

/****** Object:  Table [dbo].[bdRolUsuario]    Script Date: 11/12/2018 10:05:15 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdRolUsuario](
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

ALTER TABLE [dbo].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRol] FOREIGN KEY([idRol])
REFERENCES [dbo].[bdRol] ([Id])
GO

ALTER TABLE [dbo].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRol]
GO

ALTER TABLE [dbo].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRolUsuario] FOREIGN KEY([Id])
REFERENCES [dbo].[bdRolUsuario] ([Id])
GO

ALTER TABLE [dbo].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRolUsuario]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRolUsuario'
GO


