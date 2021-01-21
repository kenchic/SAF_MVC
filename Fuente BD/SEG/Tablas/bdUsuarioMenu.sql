USE [SAF]
GO

/****** Object:  Table [SEG].[bdUsuarioMenu]    Script Date: 20/01/2021 12:22:24 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SEG].[bdUsuarioMenu](
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

ALTER TABLE [SEG].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [SEG].[bdMenu] ([Id])
GO

ALTER TABLE [SEG].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Menu]
GO

ALTER TABLE [SEG].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Usuario] FOREIGN KEY([Id])
REFERENCES [SEG].[bdUsuarioMenu] ([Id])
GO

ALTER TABLE [SEG].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Usuario]
GO


