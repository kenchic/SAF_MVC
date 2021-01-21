USE [SAF]
GO

/****** Object:  Table [SAF].[bdProyecto]    Script Date: 20/01/2021 12:40:30 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdProyecto](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[idCiudad] [smallint] NOT NULL,
	[Nombre] [varchar](200) NOT NULL,
	[Tipo] [varchar](100) NOT NULL,
	[Direccion] [varchar](100) NULL,
	[Telefono] [varchar](50) NULL,
	[Observacion] [varchar](500) NULL,
	[Fecha] [date] NOT NULL,
	[FormaContacto] [varchar](50) NULL,
	[SistemaMedida] [varchar](50) NULL,
	[IdentificacionResponsable] [varchar](15) NULL,
	[NombreResponsable] [varchar](200) NULL,
	[TelResponsable] [varchar](50) NULL,
	[Activo] [bit] NOT NULL CONSTRAINT [DF_bdProyecto_Activo]  DEFAULT ((1)),
	[Estado] [tinyint] NOT NULL CONSTRAINT [DF_bdProyecto_Estado]  DEFAULT ((1)),
 CONSTRAINT [PK_bdProyectos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdProyecto_bdProyecto] FOREIGN KEY([Id])
REFERENCES [SAF].[bdProyecto] ([Id])
GO

ALTER TABLE [SAF].[bdProyecto] CHECK CONSTRAINT [FK_bdProyecto_bdProyecto]
GO

ALTER TABLE [SAF].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdProyectoCiudad] FOREIGN KEY([idCiudad])
REFERENCES [SAF].[bdCiudad] ([Id])
GO

ALTER TABLE [SAF].[bdProyecto] CHECK CONSTRAINT [FK_bdProyectoCiudad]
GO

ALTER TABLE [SAF].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdProyectoCliente] FOREIGN KEY([idCliente])
REFERENCES [SAF].[bdCliente] ([Id])
GO

ALTER TABLE [SAF].[bdProyecto] CHECK CONSTRAINT [FK_bdProyectoCliente]
GO