USE [SAFseg]
GO

/****** Object:  Table [dbo].[bdArtefacto]    Script Date: 10/01/2019 10:07:23 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdArtefacto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idTipoArtefacto] [tinyint] NOT NULL,
	[idEstado] [tinyint] NOT NULL,
	[idSistema] [tinyint] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
 CONSTRAINT [PK_bdArtefacto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[bdArtefacto]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoEstado] FOREIGN KEY([idEstado])
REFERENCES [dbo].[bdArtefactoEstado] ([Id])
GO

ALTER TABLE [dbo].[bdArtefacto] CHECK CONSTRAINT [FK_bdArtefactoEstado]
GO

ALTER TABLE [dbo].[bdArtefacto]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoSistema] FOREIGN KEY([idSistema])
REFERENCES [dbo].[bdSistema] ([Id])
GO

ALTER TABLE [dbo].[bdArtefacto] CHECK CONSTRAINT [FK_bdArtefactoSistema]
GO

ALTER TABLE [dbo].[bdArtefacto]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoTipo] FOREIGN KEY([idTipoArtefacto])
REFERENCES [dbo].[bdArtefactoTipo] ([Id])
GO

ALTER TABLE [dbo].[bdArtefacto] CHECK CONSTRAINT [FK_bdArtefactoTipo]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdArtefacto'
GO


