USE [SAF]
GO

/****** Object:  Table [SEG].[bdMenu]    Script Date: 20/01/2021 12:20:15 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SEG].[bdMenu](
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

ALTER TABLE [SEG].[bdMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdMenuPadre] FOREIGN KEY([idMenu])
REFERENCES [SEG].[bdMenu] ([Id])
GO

ALTER TABLE [SEG].[bdMenu] CHECK CONSTRAINT [FK_bdMenuPadre]
GO


