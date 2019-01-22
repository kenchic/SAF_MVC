USE [SAF]
GO

/****** Object:  Table [dbo].[bdTipoDocumento]    Script Date: 21/01/2019 09:27:27 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdTipoDocumento](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Consecutivo] [bigint] NULL,
	[Operacion] [varchar](1) NOT NULL,
	[EsSistema] [bit] NOT NULL CONSTRAINT [DF_bdTipoDocumento_EsSistema]  DEFAULT ((0)),
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdTiposDocumentos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdTipoDocumento'
GO


