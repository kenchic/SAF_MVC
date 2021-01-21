USE [SAF]
GO

/****** Object:  Table [SAF].[bdReposicionServicio]    Script Date: 20/01/2021 12:12:02 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdReposicionServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idDevolucionServicio] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](5) NOT NULL,
 CONSTRAINT [PK_bdReposicionServicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdReposicionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionServicioBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdReposicionServicio] CHECK CONSTRAINT [FK_bdReposicionServicioBodegaDestino]
GO

ALTER TABLE [SAF].[bdReposicionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionServicioBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO

ALTER TABLE [SAF].[bdReposicionServicio] CHECK CONSTRAINT [FK_bdReposicionServicioBodegaOrigen]
GO

ALTER TABLE [SAF].[bdReposicionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionServicioDevolucionServicio] FOREIGN KEY([idDevolucionServicio])
REFERENCES [SAF].[bdDevolucionServicio] ([Id])
GO

ALTER TABLE [SAF].[bdReposicionServicio] CHECK CONSTRAINT [FK_bdReposicionServicioDevolucionServicio]
GO

ALTER TABLE [SAF].[bdReposicionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionServicioDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO

ALTER TABLE [SAF].[bdReposicionServicio] CHECK CONSTRAINT [FK_bdReposicionServicioDocumentoTipo]
GO


