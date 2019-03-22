USE [SAF]
GO

/****** Object:  Table [dbo].[bdElemento]    Script Date: 19/03/2019 09:34:22 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdElemento](
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

ALTER TABLE [dbo].[bdElemento]  WITH CHECK ADD  CONSTRAINT [FK_bdElementoGrupoElemento] FOREIGN KEY([idGrupoElemento])
REFERENCES [dbo].[bdGrupoElemento] ([Id])
GO

ALTER TABLE [dbo].[bdElemento] CHECK CONSTRAINT [FK_bdElementoGrupoElemento]
GO

ALTER TABLE [dbo].[bdElemento]  WITH CHECK ADD  CONSTRAINT [FK_bdElementoUnidadMedida] FOREIGN KEY([idUnidadMedida])
REFERENCES [dbo].[bdUnidadMedida] ([Id])
GO

ALTER TABLE [dbo].[bdElemento] CHECK CONSTRAINT [FK_bdElementoUnidadMedida]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdElemento'
GO


