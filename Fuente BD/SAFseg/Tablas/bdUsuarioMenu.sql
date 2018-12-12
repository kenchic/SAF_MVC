USE [SAFseg]
GO

/****** Object:  Table [dbo].[bdUsuarioMenu]    Script Date: 11/12/2018 10:05:32 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdUsuarioMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[idMenu] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdUsuarioMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [dbo].[bdMenu] ([Id])
GO

ALTER TABLE [dbo].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Menu]
GO

ALTER TABLE [dbo].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Usuario] FOREIGN KEY([Id])
REFERENCES [dbo].[bdUsuarioMenu] ([Id])
GO

ALTER TABLE [dbo].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Usuario]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdUsuarioMenu'
GO


