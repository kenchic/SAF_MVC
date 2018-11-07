USE [SAFseg]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[bdArtefactoHistorial](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[idArtefacto] [int] NOT NULL,
	[idRequerimiento] [int] NOT NULL,
	[Objetivo] [varchar](max) NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[Extension] [varchar](10) NOT NULL,
	[Archivo] [varbinary](max) NOT NULL,	
 CONSTRAINT [PK_bdArtefactoHistorial] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[bdArtefactoHistorial]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoHistorialArtefacto] FOREIGN KEY([idArtefacto])
REFERENCES [dbo].[bdArtefacto] ([Id])
GO

ALTER TABLE [dbo].[bdArtefactoHistorial] CHECK CONSTRAINT [FK_bdArtefactoHistorialArtefacto]
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdArtefactoHistorial'
GO


