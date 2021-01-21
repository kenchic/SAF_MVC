USE [SAF]
GO

/****** Object:  Table [SEG].[bdSesion]    Script Date: 20/01/2021 12:21:30 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SEG].[bdSesion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[Token] [varchar](50) NOT NULL,
	[Terminal] [varchar](50) NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaFin] [datetime] NULL,
	[Tiempo] [int] NULL,
	[IdSesionBD] [int] NULL CONSTRAINT [DF_bdSesion_IdSesionBD]  DEFAULT ((0)),
 CONSTRAINT [PK_bdSesion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SEG].[bdSesion]  WITH CHECK ADD  CONSTRAINT [FK_bdSesionUsuario] FOREIGN KEY([idUsuario])
REFERENCES [SEG].[bdUsuario] ([Id])
GO

ALTER TABLE [SEG].[bdSesion] CHECK CONSTRAINT [FK_bdSesionUsuario]
GO


