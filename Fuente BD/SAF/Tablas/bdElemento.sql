USE [SAF]
GO

/****** Object:  Table [SAF].[bdElemento]    Script Date: 20/01/2021 12:08:53 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdElemento](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idGrupoElemento] [tinyint] NOT NULL,
	[idUnidadMedida] [tinyint] NOT NULL,
	[Referencia] [varchar](50) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Mt2] [float] NOT NULL,
	[Peso] [float] NOT NULL,
	[Rotacion] [bit] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdElementos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdElemento]  WITH CHECK ADD  CONSTRAINT [FK_bdElementoGrupoElemento] FOREIGN KEY([idGrupoElemento])
REFERENCES [SAF].[bdGrupoElemento] ([Id])
GO

ALTER TABLE [SAF].[bdElemento] CHECK CONSTRAINT [FK_bdElementoGrupoElemento]
GO

ALTER TABLE [SAF].[bdElemento]  WITH CHECK ADD  CONSTRAINT [FK_bdElementoUnidadMedida] FOREIGN KEY([idUnidadMedida])
REFERENCES [SAF].[bdUnidadMedida] ([Id])
GO

ALTER TABLE [SAF].[bdElemento] CHECK CONSTRAINT [FK_bdElementoUnidadMedida]
GO
