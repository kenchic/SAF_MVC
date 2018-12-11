USE [SAFseg]
GO

/****** Object:  Table [dbo].[bdMenu]    Script Date: 03/12/2018 10:36:49 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdMenu](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idMenu] [smallint] NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Vista] [varchar](100) NULL,
	[Orden] [smallint] NOT NULL,
	[Imagen] [varchar](100) NULL,
	[Activo] [bit] NOT NULL CONSTRAINT [DF_bdMenu_Activo]  DEFAULT ((0)),
 CONSTRAINT [PK_bdMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[bdMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdMenuPadre] FOREIGN KEY([idMenu])
REFERENCES [dbo].[bdMenu] ([Id])
GO

ALTER TABLE [dbo].[bdMenu] CHECK CONSTRAINT [FK_bdMenuPadre]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdMenu'
GO


