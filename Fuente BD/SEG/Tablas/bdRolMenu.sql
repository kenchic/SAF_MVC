USE [SAF]
GO

/****** Object:  Table [SEG].[bdRolMenu]    Script Date: 20/01/2021 12:20:58 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SEG].[bdRolMenu](
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

ALTER TABLE [SEG].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [SEG].[bdMenu] ([Id])
GO

ALTER TABLE [SEG].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Menu]
GO

ALTER TABLE [SEG].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Rol] FOREIGN KEY([idRol])
REFERENCES [SEG].[bdRol] ([Id])
GO

ALTER TABLE [SEG].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Rol]
GO


