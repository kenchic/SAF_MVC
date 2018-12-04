USE [SAFseg]
GO

/****** Object:  Table [dbo].[bdRolMenu]    Script Date: 03/12/2018 09:41:55 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdRolMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NOT NULL,
	[idMenu] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRolMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [dbo].[bdMenu] ([Id])
GO

ALTER TABLE [dbo].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Menu]
GO

ALTER TABLE [dbo].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Rol] FOREIGN KEY([idRol])
REFERENCES [dbo].[bdRol] ([Id])
GO

ALTER TABLE [dbo].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Rol]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRolMenu'
GO


