USE [SAF]
GO

/****** Object:  Table [SEG].[bdCatalogoDetalle]    Script Date: 20/01/2021 12:20:04 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SEG].[bdCatalogoDetalle](
	[idCatalogo] [varchar](20) NOT NULL,
	[Codigo] [varchar](10) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Valor1] [varchar](10) NULL,
	[Valor2] [varchar](10) NULL,
	[Valor3] [varchar](10) NULL,
 CONSTRAINT [PK_bdCatalogoDetalle] PRIMARY KEY CLUSTERED 
(
	[idCatalogo] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SEG].[bdCatalogoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdCatalogoDetalle_bdCatalogo] FOREIGN KEY([idCatalogo])
REFERENCES [SEG].[bdCatalogo] ([Id])
GO

ALTER TABLE [SEG].[bdCatalogoDetalle] CHECK CONSTRAINT [FK_bdCatalogoDetalle_bdCatalogo]
GO


