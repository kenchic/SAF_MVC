USE [SAF]
GO

/****** Object:  Table [SAF].[bdCliente]    Script Date: 20/01/2021 12:03:24 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [SAF].[bdCliente](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCiudad] [smallint] NOT NULL,
	[Identificacion] [varchar](20) NOT NULL,
	[Nombre1] [varchar](25) NOT NULL,
	[Nombre2] [varchar](25) NULL,
	[Apellido1] [varchar](25) NOT NULL,
	[Apellido2] [varchar](25) NULL,
	[Nombre]  AS (((((([Nombre1]+' ')+[Nombre2])+' ')+[Apellido1])+' ')+[Apellido2]),
	[Direccion] [varchar](200) NOT NULL,
	[Telefono] [varchar](50) NOT NULL,
	[Celular] [varchar](50) NULL,
	[Correo] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdClientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [SAF].[bdCliente]  WITH CHECK ADD  CONSTRAINT [FK_bdClienteCiudad] FOREIGN KEY([idCiudad])
REFERENCES [SAF].[bdCiudad] ([Id])
GO

ALTER TABLE [SAF].[bdCliente] CHECK CONSTRAINT [FK_bdClienteCiudad]
GO