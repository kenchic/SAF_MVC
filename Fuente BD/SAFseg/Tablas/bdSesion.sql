USE [SAFseg]
GO

/****** Object:  Table [dbo].[bdSesion]    Script Date: 10/05/2019 08:05:10 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdSesion](
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

ALTER TABLE [dbo].[bdSesion]  WITH CHECK ADD  CONSTRAINT [FK_bdSesionUsuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[bdUsuario] ([Id])
GO

ALTER TABLE [dbo].[bdSesion] CHECK CONSTRAINT [FK_bdSesionUsuario]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdSesion'
GO


