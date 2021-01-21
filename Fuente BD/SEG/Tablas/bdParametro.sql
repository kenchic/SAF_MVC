USE [SAF]
GO

/****** Object:  Table [SEG].[bdParametro]    Script Date: 20/01/2021 12:20:26 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SEG].[bdParametro](
	[Codigo] [varchar](20) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](500) NULL,
	[Valor] [varchar](200) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_ParametroSistema] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO