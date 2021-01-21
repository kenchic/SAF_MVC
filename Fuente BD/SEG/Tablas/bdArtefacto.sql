USE [SAF]
GO

/****** Object:  Table [SEG].[bdArtefacto]    Script Date: 20/01/2021 12:18:38 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SEG].[bdArtefacto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idSistema] [tinyint] NOT NULL,
	[Tipo] [varchar](10) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdArtefacto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SEG].[bdArtefacto]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoSistema] FOREIGN KEY([idSistema])
REFERENCES [SEG].[bdSistema] ([Id])
GO

ALTER TABLE [SEG].[bdArtefacto] CHECK CONSTRAINT [FK_bdArtefactoSistema]
GO


