USE [SAFseg]
GO

/****** Object:  Table [dbo].[bdCatalogo]    Script Date: 09/01/2020 04:42:39 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdCatalogo](
	[Id] [varchar](20) NOT NULL,
	[Codigo] [varchar](10) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Valor1] [varchar](10) NULL,
	[Valor2] [varchar](10) NULL,
	[Valor3] [varchar](10) NULL,
 CONSTRAINT [PK_Catalogo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'20.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdCatalogo'
GO