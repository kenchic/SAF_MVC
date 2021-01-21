USE [SAF]
GO

/****** Object:  Table [SEG].[bdAuditoria]    Script Date: 20/01/2021 12:19:05 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SEG].[bdArtefactoHistoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idSesion] [bigint] NOT NULL,
	[Tabla] [varchar](50) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Operacion] [varchar](50) NOT NULL,
	[Observacion] [varchar](500) NULL,
	[Detalle] [varchar](max) NOT NULL,
 CONSTRAINT [PK_bdAuditoria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


