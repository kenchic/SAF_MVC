USE [SAF]
GO

/****** Object:  Table [dbo].[bdProveedor]    Script Date: 14/01/2019 02:26:32 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdProveedor](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Identificacion] [varchar](20) NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Iniciales] [varchar](10) NOT NULL,
	[Telefono] [varchar](100) NULL,
	[Direccion] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdProveedores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdProveedor'
GO


