USE [SAF]
GO
/****** Object:  StoredProcedure [dbo].[PAgente]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PAgente]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdAgente

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdAgente WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM 
			bdAgente 
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM parseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdAgente 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM parseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Agente
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = Agente.Nombre,
				Activo = Agente.Activo
			FROM bdAgente AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM parseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Agente ON A.Id = Agente.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdAgente AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From parseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Agente ON A.Id = Agente.Id
		END
END


GO
/****** Object:  Table [dbo].[bdAgente]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdAgente](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdAgentes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdAgentes_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdBodega]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdBodega](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL CONSTRAINT [DF_bdBodega_idCliente]  DEFAULT ((0)),
	[idProveedor] [smallint] NULL CONSTRAINT [DF_bdBodega_idProveedor]  DEFAULT ((0)),
	[Nombre] [varchar](50) NOT NULL,
	[EsSistema] [bit] NOT NULL CONSTRAINT [DF_bdBodega_EsSistema]  DEFAULT ((0)),
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdBodegas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdCiudad]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdCiudad](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdCiudades] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdCiudades_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdCliente]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdCliente](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCiudad] [smallint] NOT NULL,
	[Identificacion] [varchar](20) NOT NULL,
	[Nombre1] [varchar](25) NOT NULL,
	[Nombre2] [varchar](25) NULL,
	[Apellido1] [varchar](25) NOT NULL,
	[Apellido2] [varchar](25) NULL,
	[Nombre]  AS (((((([Nombre1]+' ')+[Nombre2])+' ')+[Apellido1])+' ')+[Apellido2]),
	[Direccion] [varchar](200) NOT NULL,
	[Telefono] [varchar](50) NULL,
	[Celular] [varchar](50) NULL,
	[Correo] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdClientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdClientes_Identificacion] UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdClientes_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdConductor]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdConductor](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NOT NULL,
	[Activo] [bit] NOT NULL,
	[Placa] [varchar](50) NOT NULL,
 CONSTRAINT [PK_bdConductores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdConductores_Placa] UNIQUE NONCLUSTERED 
(
	[Placa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdContrato]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdContrato](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idProyecto] [smallint] NOT NULL,
	[idListaPrecio] [tinyint] NOT NULL,
	[idAgente] [smallint] NULL,
	[InformacionBD] [bit] NOT NULL,
	[ContratoAlquiler] [bit] NOT NULL,
	[CartaPagare] [bit] NOT NULL,
	[Pagare] [bit] NOT NULL,
	[LetraCambio] [bit] NOT NULL,
	[GarantiasCondiciones] [bit] NOT NULL,
	[Deposito] [bit] NOT NULL,
	[Anticipo] [bit] NOT NULL,
	[PersonaJuridica] [bit] NOT NULL,
	[PersonaNatural] [bit] NOT NULL,
	[FotoCopiaCedula] [bit] NOT NULL,
	[FotoCopiaNit] [bit] NOT NULL,
	[CamaraComercio] [bit] NOT NULL,
	[DescuentoAlquiler] [tinyint] NOT NULL,
	[DescuentoVenta] [tinyint] NOT NULL,
	[DescuentoReposicion] [tinyint] NOT NULL,
	[DescuentoMantenimiento] [tinyint] NOT NULL,
	[DescuentoTransporte] [tinyint] NOT NULL,
	[PorcentajeAgente] [tinyint] NULL,
 CONSTRAINT [PK_bdContratos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdCorte]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdCorte](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idProyectoVenta] [smallint] NULL,
	[idProyectoAlquiler] [smallint] NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Estado] [tinyint] NULL,
 CONSTRAINT [PK_bdCortes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdCortes_Numero] UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleCorte]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleCorte](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCorte] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[idRemision] [int] NULL,
	[idProveedor] [smallint] NULL,
	[Cantidad] [int] NULL,
 CONSTRAINT [PK_bdDetallesCortes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleDevolucion]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleDevolucion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdDetallesDevoluciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleDevolucionServicio]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleDevolucionServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucionServicio] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdDetallesDevolucionesServicios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleDocumento]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleDocumento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[idDocumento] [int] NOT NULL,
	[idBodegaDestino] [tinyint] NOT NULL,
	[idBodegaOrigen] [tinyint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bd] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleFactura]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdDetalleFactura](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idElemento] [smallint] NULL,
	[idFactura] [int] NULL,
	[Detalle] [varchar](4000) NULL,
	[Nombre] [varchar](100) NULL,
	[Dias] [tinyint] NULL,
	[Cantidad] [int] NULL,
	[ValorAlquiler] [int] NULL,
	[ValorUnidad] [int] NULL,
	[ValorTotal] [int] NULL,
 CONSTRAINT [PK_bdDetallesFacturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdDetalleListaPrecio]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleListaPrecio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idListaPrecios] [tinyint] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[PrecioAlquiler] [int] NOT NULL,
	[PrecioVenta] [int] NOT NULL,
	[PrecioPerdida] [int] NOT NULL,
 CONSTRAINT [PK_bdDetallesListasPrecios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleMantenimiento]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleMantenimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idMantenimiento] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[idTipoMantenimiento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdDetallesMantenimientos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleOrdenServicio]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleOrdenServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idOrdenServicio] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_dbDetallesOrdenesServicios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleRemision]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleRemision](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRemision] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdDetallesRemisiones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleRepDevolucionServicio]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleRepDevolucionServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRepDevolucionServicio] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdDetallesRepDevolucionesServicios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleReposicion]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleReposicion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idReposicion] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_dbDetallesReposiciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDetalleVenta]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDetalleVenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[idVenta] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_dbDetallesVentas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDevolucion]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDevolucion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idProyecto] [smallint] NOT NULL,
	[idConductor] [smallint] NULL,
	[Numero] [int] NOT NULL,
	[FechaAnunciada] [date] NULL,
	[FechaRecogida] [date] NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[EntregaCliente] [bit] NULL,
	[EntregaParcial] [bit] NULL,
	[TipoMantenimiento] [tinyint] NULL,
	[Hora] [time](7) NULL,
	[Estado] [tinyint] NULL,
	[ValorTransporte] [numeric](8, 0) NULL,
	[PesoEquipo] [numeric](6, 2) NULL,
	[ValorEquipo] [numeric](10, 0) NULL,
 CONSTRAINT [PK_bdDevoluciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdDevoluciones_Numero] UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDevolucionServicio]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdDevolucionServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idProveedor] [smallint] NOT NULL,
	[Numero] [int] NOT NULL,
 CONSTRAINT [PK_bdDevolucionesServicios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdDevolucionesServicios_Numero] UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdDocumento]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdDocumento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idTipoDocumento] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Anulado] [bit] NOT NULL,
 CONSTRAINT [PK_bdMovimientos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdDocumentoConfiguracion]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdDocumentoConfiguracion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idTipoDocumento] [tinyint] NOT NULL,
	[IDControl] [varchar](50) NOT NULL,
	[Label] [varchar](50) NOT NULL,
	[CeldaExcel] [varchar](10) NOT NULL,
	[FilaInicioDetalle] [varchar](10) NULL,
 CONSTRAINT [PK_DocumentoConfiguracion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdElemento]    Script Date: 14/09/2018 08:42:39 p.m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdElementos_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdElementos_Referencia] UNIQUE NONCLUSTERED 
(
	[Referencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdFactura]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdFactura](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCorte] [int] NULL,
	[Numero] [int] NOT NULL,
	[FechaEmision] [date] NULL,
	[FechaVencimiento] [date] NULL,
	[Son] [nvarchar](4000) NULL,
	[ParcialTotal] [numeric](10, 2) NULL,
	[Dcto] [int] NULL,
	[SubTotal] [numeric](10, 2) NULL,
	[Iva] [int] NULL,
	[Total] [numeric](10, 2) NULL,
	[Anulada] [bit] NULL,
	[idTipoFactura] [int] NULL,
	[idProyecto] [int] NULL,
	[idCliente] [int] NULL,
	[NombreCliente] [varchar](200) NULL,
 CONSTRAINT [PK_bdFacturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdFacturas_Numero] UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdGrupoElemento]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdGrupoElemento](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdGruposElementos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdListaPrecio]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdListaPrecio](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdListasPrecios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdListasPrecios_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdMantenimiento]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdMantenimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[Numero] [int] NOT NULL,
 CONSTRAINT [PK_bdMantenimientos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdMovimientoBodega]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdMovimientoBodega](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idElemeto] [smallint] NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idTipoDocumento] [tinyint] NOT NULL,
	[idDocumento] [int] NOT NULL,
	[idDetalleDocumento] [int] NOT NULL,
	[Fecha] [smalldatetime] NOT NULL,
	[Operacion] [varchar](20) NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdMovimientosBodegas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdOrdenServicio]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdOrdenServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRemision] [int] NULL,
	[idProveedor] [smallint] NOT NULL,
	[Numero] [int] NOT NULL,
 CONSTRAINT [PK_dbOrdenesServicios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_dbOrdenesServicios_Numero] UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdParametro]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdParametro](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TipoParametro] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdParametroSistema]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdParametroSistema](
	[Codigo] [char](10) NOT NULL,
	[idParametro] [smallint] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NULL,
	[Valor] [varchar](200) NOT NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_ParametroSistema] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdProveedor]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdProveedor](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Identificacion] [varchar](20) NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Iniciales] [char](5) NOT NULL,
	[Telefono] [varchar](50) NULL,
	[Direccion] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdProveedores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdProveedores_Iniciales] UNIQUE NONCLUSTERED 
(
	[Iniciales] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdProveedores_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdProyecto]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdProyecto](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[idCiudad] [smallint] NOT NULL,
	[NombreCliente] [varchar](200) NULL,
	[NombreCiudad] [varchar](200) NULL,
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
/****** Object:  Table [dbo].[bdProyectoAlquiler]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdProyectoAlquiler](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idProyecto] [smallint] NOT NULL,
 CONSTRAINT [PK_bdProyectosAlquiler] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdProyectoVenta]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdProyectoVenta](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idProyecto] [smallint] NOT NULL,
 CONSTRAINT [PK_bdProyectosVenta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdRemision]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdRemision](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idProyectoAlquiler] [smallint] NULL,
	[idProyectoVenta] [smallint] NULL,
	[idConductor] [smallint] NULL,
	[Numero] [int] NOT NULL,
	[FechaPedido] [date] NULL,
	[FechaEntrega] [date] NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[Hora] [time](7) NULL,
	[Estado] [tinyint] NULL,
	[Transporte] [bit] NULL,
	[ValorTransporte] [numeric](8, 0) NULL,
	[Despachado] [bit] NULL,
	[EquipoAdecuado] [bit] NULL,
	[PesoEquipo] [numeric](6, 2) NULL,
	[ValorEquipo] [numeric](10, 0) NULL,
 CONSTRAINT [PK_bdRemisiones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdRemisiones_Numero] UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdRepDevolucionServicio]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdRepDevolucionServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[Numero] [int] NOT NULL,
 CONSTRAINT [PK_bdRepDevolucionesServicios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdRepDevServicios_Numero] UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdReposicion]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdReposicion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[Numero] [int] NOT NULL,
 CONSTRAINT [PK_dbReposiciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_dbReposiciones_Numero] UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bdTipoDocumento]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdTipoDocumento](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Consecutivo] [bigint] NULL,
	[Operacion] [varchar](1) NOT NULL,
	[EsSistema] [bit] NOT NULL CONSTRAINT [DF_bdTipoDocumento_EsSistema]  DEFAULT ((0)),
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdTiposDocumentos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdTipoMantenimiento]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdTipoMantenimiento](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Valor] [numeric](18, 0) NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [PK_bdTipoMantenimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdUnidadMedida]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdUnidadMedida](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdUnidadesMedidas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdVenta]    Script Date: 14/09/2018 08:42:39 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdVenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRemision] [int] NOT NULL,
	[Numero] [int] NOT NULL,
 CONSTRAINT [PK_bdVentas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_bdVentas_Numero] UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[bdBodega]  WITH CHECK ADD  CONSTRAINT [FK_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[bdCliente] ([Id])
GO
ALTER TABLE [dbo].[bdBodega] CHECK CONSTRAINT [FK_Cliente]
GO
ALTER TABLE [dbo].[bdBodega]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[bdProveedor] ([Id])
GO
ALTER TABLE [dbo].[bdBodega] CHECK CONSTRAINT [FK_Proveedor]
GO
ALTER TABLE [dbo].[bdCliente]  WITH CHECK ADD  CONSTRAINT [FK_bdC_bdCiudades] FOREIGN KEY([idCiudad])
REFERENCES [dbo].[bdCiudad] ([Id])
GO
ALTER TABLE [dbo].[bdCliente] CHECK CONSTRAINT [FK_bdC_bdCiudades]
GO
ALTER TABLE [dbo].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdC_bdAgentes] FOREIGN KEY([idAgente])
REFERENCES [dbo].[bdAgente] ([Id])
GO
ALTER TABLE [dbo].[bdContrato] CHECK CONSTRAINT [FK_bdC_bdAgentes]
GO
ALTER TABLE [dbo].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdC_bdListasPrecios] FOREIGN KEY([idListaPrecio])
REFERENCES [dbo].[bdListaPrecio] ([Id])
GO
ALTER TABLE [dbo].[bdContrato] CHECK CONSTRAINT [FK_bdC_bdListasPrecios]
GO
ALTER TABLE [dbo].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdC_bdProyectos] FOREIGN KEY([Id])
REFERENCES [dbo].[bdProyecto] ([Id])
GO
ALTER TABLE [dbo].[bdContrato] CHECK CONSTRAINT [FK_bdC_bdProyectos]
GO
ALTER TABLE [dbo].[bdCorte]  WITH CHECK ADD  CONSTRAINT [FK_bdCortes_bdProyectosAlquileres] FOREIGN KEY([idProyectoAlquiler])
REFERENCES [dbo].[bdProyectoAlquiler] ([Id])
GO
ALTER TABLE [dbo].[bdCorte] CHECK CONSTRAINT [FK_bdCortes_bdProyectosAlquileres]
GO
ALTER TABLE [dbo].[bdCorte]  WITH CHECK ADD  CONSTRAINT [FK_bdCortes_bdProyectosVentas] FOREIGN KEY([idProyectoVenta])
REFERENCES [dbo].[bdProyectoVenta] ([Id])
GO
ALTER TABLE [dbo].[bdCorte] CHECK CONSTRAINT [FK_bdCortes_bdProyectosVentas]
GO
ALTER TABLE [dbo].[bdDetalleCorte]  WITH CHECK ADD  CONSTRAINT [FK_bdDC_bdCortes] FOREIGN KEY([idCorte])
REFERENCES [dbo].[bdCorte] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleCorte] CHECK CONSTRAINT [FK_bdDC_bdCortes]
GO
ALTER TABLE [dbo].[bdDetalleCorte]  WITH CHECK ADD  CONSTRAINT [FK_bdDC_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleCorte] CHECK CONSTRAINT [FK_bdDC_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleCorte]  WITH CHECK ADD  CONSTRAINT [FK_bdDC_bdProveedores] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[bdProveedor] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleCorte] CHECK CONSTRAINT [FK_bdDC_bdProveedores]
GO
ALTER TABLE [dbo].[bdDetalleDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_DD_bdDevoluciones] FOREIGN KEY([idDevolucion])
REFERENCES [dbo].[bdDevolucion] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleDevolucion] CHECK CONSTRAINT [FK_DD_bdDevoluciones]
GO
ALTER TABLE [dbo].[bdDetalleDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_DD_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleDevolucion] CHECK CONSTRAINT [FK_DD_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDDS_bdDevolucionesServicios] FOREIGN KEY([idDevolucionServicio])
REFERENCES [dbo].[bdDevolucionServicio] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleDevolucionServicio] CHECK CONSTRAINT [FK_bdDDS_bdDevolucionesServicios]
GO
ALTER TABLE [dbo].[bdDetalleDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDDServicios_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleDevolucionServicio] CHECK CONSTRAINT [FK_bdDDServicios_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDD_bdDocumentos] FOREIGN KEY([idDocumento])
REFERENCES [dbo].[bdDocumento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleDocumento] CHECK CONSTRAINT [FK_bdDD_bdDocumentos]
GO
ALTER TABLE [dbo].[bdDetalleDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDD_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleDocumento] CHECK CONSTRAINT [FK_bdDD_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_bdDF_bdFacturas] FOREIGN KEY([idFactura])
REFERENCES [dbo].[bdFactura] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleFactura] CHECK CONSTRAINT [FK_bdDF_bdFacturas]
GO
ALTER TABLE [dbo].[bdDetalleListaPrecio]  WITH CHECK ADD  CONSTRAINT [FK_bdDLP_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleListaPrecio] CHECK CONSTRAINT [FK_bdDLP_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleListaPrecio]  WITH CHECK ADD  CONSTRAINT [FK_bdDLP_bdListasPrecios] FOREIGN KEY([idListaPrecios])
REFERENCES [dbo].[bdListaPrecio] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleListaPrecio] CHECK CONSTRAINT [FK_bdDLP_bdListasPrecios]
GO
ALTER TABLE [dbo].[bdDetalleMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdD_bdMantenimientos] FOREIGN KEY([idMantenimiento])
REFERENCES [dbo].[bdMantenimiento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleMantenimiento] CHECK CONSTRAINT [FK_bdD_bdMantenimientos]
GO
ALTER TABLE [dbo].[bdDetalleMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdDM_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleMantenimiento] CHECK CONSTRAINT [FK_bdDM_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_DOS_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleOrdenServicio] CHECK CONSTRAINT [FK_DOS_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_DOS_dbOrdenesServicios] FOREIGN KEY([idOrdenServicio])
REFERENCES [dbo].[bdOrdenServicio] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleOrdenServicio] CHECK CONSTRAINT [FK_DOS_dbOrdenesServicios]
GO
ALTER TABLE [dbo].[bdDetalleRemision]  WITH CHECK ADD  CONSTRAINT [FK_DR_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleRemision] CHECK CONSTRAINT [FK_DR_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleRemision]  WITH CHECK ADD  CONSTRAINT [FK_DR_bdRemisiones] FOREIGN KEY([idRemision])
REFERENCES [dbo].[bdRemision] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleRemision] CHECK CONSTRAINT [FK_DR_bdRemisiones]
GO
ALTER TABLE [dbo].[bdDetalleRepDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDD_bdRepDevolucionesServicios] FOREIGN KEY([idRepDevolucionServicio])
REFERENCES [dbo].[bdRepDevolucionServicio] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleRepDevolucionServicio] CHECK CONSTRAINT [FK_bdDD_bdRepDevolucionesServicios]
GO
ALTER TABLE [dbo].[bdDetalleRepDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDRDS_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleRepDevolucionServicio] CHECK CONSTRAINT [FK_bdDRDS_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleReposicion]  WITH CHECK ADD  CONSTRAINT [FK_dbDR_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleReposicion] CHECK CONSTRAINT [FK_dbDR_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleReposicion]  WITH CHECK ADD  CONSTRAINT [FK_dbDR_dbReposiciones] FOREIGN KEY([idReposicion])
REFERENCES [dbo].[bdReposicion] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleReposicion] CHECK CONSTRAINT [FK_dbDR_dbReposiciones]
GO
ALTER TABLE [dbo].[bdDetalleVenta]  WITH CHECK ADD  CONSTRAINT [FK_dbDV_bdElementos] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleVenta] CHECK CONSTRAINT [FK_dbDV_bdElementos]
GO
ALTER TABLE [dbo].[bdDetalleVenta]  WITH CHECK ADD  CONSTRAINT [FK_dbDV_bdVentas] FOREIGN KEY([idVenta])
REFERENCES [dbo].[bdVenta] ([Id])
GO
ALTER TABLE [dbo].[bdDetalleVenta] CHECK CONSTRAINT [FK_dbDV_bdVentas]
GO
ALTER TABLE [dbo].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdD_bdProyectosAlquileres] FOREIGN KEY([idProyecto])
REFERENCES [dbo].[bdProyectoAlquiler] ([Id])
GO
ALTER TABLE [dbo].[bdDevolucion] CHECK CONSTRAINT [FK_bdD_bdProyectosAlquileres]
GO
ALTER TABLE [dbo].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevoluciones_bdConductores] FOREIGN KEY([idConductor])
REFERENCES [dbo].[bdConductor] ([Id])
GO
ALTER TABLE [dbo].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevoluciones_bdConductores]
GO
ALTER TABLE [dbo].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDS_bdDevoluciones] FOREIGN KEY([idDevolucion])
REFERENCES [dbo].[bdDevolucion] ([Id])
GO
ALTER TABLE [dbo].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDS_bdDevoluciones]
GO
ALTER TABLE [dbo].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDS_bdProveedores] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[bdProveedor] ([Id])
GO
ALTER TABLE [dbo].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDS_bdProveedores]
GO
ALTER TABLE [dbo].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdD_bdTiposDocumentos] FOREIGN KEY([idTipoDocumento])
REFERENCES [dbo].[bdTipoDocumento] ([Id])
GO
ALTER TABLE [dbo].[bdDocumento] CHECK CONSTRAINT [FK_bdD_bdTiposDocumentos]
GO
ALTER TABLE [dbo].[bdElemento]  WITH CHECK ADD  CONSTRAINT [FK_E_bdGruposElementos] FOREIGN KEY([idGrupoElemento])
REFERENCES [dbo].[bdGrupoElemento] ([Id])
GO
ALTER TABLE [dbo].[bdElemento] CHECK CONSTRAINT [FK_E_bdGruposElementos]
GO
ALTER TABLE [dbo].[bdElemento]  WITH CHECK ADD  CONSTRAINT [FK_E_bdUnidadesMedidas] FOREIGN KEY([idUnidadMedida])
REFERENCES [dbo].[bdUnidadMedida] ([Id])
GO
ALTER TABLE [dbo].[bdElemento] CHECK CONSTRAINT [FK_E_bdUnidadesMedidas]
GO
ALTER TABLE [dbo].[bdFactura]  WITH CHECK ADD  CONSTRAINT [FK_bdF_bdCortes] FOREIGN KEY([idCorte])
REFERENCES [dbo].[bdCorte] ([Id])
GO
ALTER TABLE [dbo].[bdFactura] CHECK CONSTRAINT [FK_bdF_bdCortes]
GO
ALTER TABLE [dbo].[bdMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdM_bdDevoluciones] FOREIGN KEY([idDevolucion])
REFERENCES [dbo].[bdDevolucion] ([Id])
GO
ALTER TABLE [dbo].[bdMantenimiento] CHECK CONSTRAINT [FK_bdM_bdDevoluciones]
GO
ALTER TABLE [dbo].[bdMovimientoBodega]  WITH CHECK ADD  CONSTRAINT [FK_BodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [dbo].[bdBodega] ([Id])
GO
ALTER TABLE [dbo].[bdMovimientoBodega] CHECK CONSTRAINT [FK_BodegaDestino]
GO
ALTER TABLE [dbo].[bdMovimientoBodega]  WITH CHECK ADD  CONSTRAINT [FK_BodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [dbo].[bdBodega] ([Id])
GO
ALTER TABLE [dbo].[bdMovimientoBodega] CHECK CONSTRAINT [FK_BodegaOrigen]
GO
ALTER TABLE [dbo].[bdMovimientoBodega]  WITH CHECK ADD  CONSTRAINT [FK_Elemento] FOREIGN KEY([idElemeto])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdMovimientoBodega] CHECK CONSTRAINT [FK_Elemento]
GO
ALTER TABLE [dbo].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOS_bdProveedores] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[bdProveedor] ([Id])
GO
ALTER TABLE [dbo].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOS_bdProveedores]
GO
ALTER TABLE [dbo].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_OS_bdRemisiones] FOREIGN KEY([idRemision])
REFERENCES [dbo].[bdRemision] ([Id])
GO
ALTER TABLE [dbo].[bdOrdenServicio] CHECK CONSTRAINT [FK_OS_bdRemisiones]
GO
ALTER TABLE [dbo].[bdParametroSistema]  WITH CHECK ADD  CONSTRAINT [FK_PS_bdParametros] FOREIGN KEY([idParametro])
REFERENCES [dbo].[bdParametro] ([Id])
GO
ALTER TABLE [dbo].[bdParametroSistema] CHECK CONSTRAINT [FK_PS_bdParametros]
GO
ALTER TABLE [dbo].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdP_bdCiudades] FOREIGN KEY([idCiudad])
REFERENCES [dbo].[bdCiudad] ([Id])
GO
ALTER TABLE [dbo].[bdProyecto] CHECK CONSTRAINT [FK_bdP_bdCiudades]
GO
ALTER TABLE [dbo].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdP_bdClientes] FOREIGN KEY([idCliente])
REFERENCES [dbo].[bdCliente] ([Id])
GO
ALTER TABLE [dbo].[bdProyecto] CHECK CONSTRAINT [FK_bdP_bdClientes]
GO
ALTER TABLE [dbo].[bdProyectoAlquiler]  WITH CHECK ADD  CONSTRAINT [FK_bdPA_bdProyectos] FOREIGN KEY([idProyecto])
REFERENCES [dbo].[bdProyecto] ([Id])
GO
ALTER TABLE [dbo].[bdProyectoAlquiler] CHECK CONSTRAINT [FK_bdPA_bdProyectos]
GO
ALTER TABLE [dbo].[bdProyectoVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdPV_bdProyectos] FOREIGN KEY([idProyecto])
REFERENCES [dbo].[bdProyecto] ([Id])
GO
ALTER TABLE [dbo].[bdProyectoVenta] CHECK CONSTRAINT [FK_bdPV_bdProyectos]
GO
ALTER TABLE [dbo].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdR_bdProyectosAlquileres] FOREIGN KEY([idProyectoAlquiler])
REFERENCES [dbo].[bdProyectoAlquiler] ([Id])
GO
ALTER TABLE [dbo].[bdRemision] CHECK CONSTRAINT [FK_bdR_bdProyectosAlquileres]
GO
ALTER TABLE [dbo].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdR_bdProyectosVentas] FOREIGN KEY([idProyectoVenta])
REFERENCES [dbo].[bdProyectoVenta] ([Id])
GO
ALTER TABLE [dbo].[bdRemision] CHECK CONSTRAINT [FK_bdR_bdProyectosVentas]
GO
ALTER TABLE [dbo].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisiones_bdConductores] FOREIGN KEY([idConductor])
REFERENCES [dbo].[bdConductor] ([Id])
GO
ALTER TABLE [dbo].[bdRemision] CHECK CONSTRAINT [FK_bdRemisiones_bdConductores]
GO
ALTER TABLE [dbo].[bdRepDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdRDS_bdDevoluciones] FOREIGN KEY([idDevolucion])
REFERENCES [dbo].[bdDevolucion] ([Id])
GO
ALTER TABLE [dbo].[bdRepDevolucionServicio] CHECK CONSTRAINT [FK_bdRDS_bdDevoluciones]
GO
ALTER TABLE [dbo].[bdVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdVentas_bdRemisiones] FOREIGN KEY([idRemision])
REFERENCES [dbo].[bdRemision] ([Id])
GO
ALTER TABLE [dbo].[bdVenta] CHECK CONSTRAINT [FK_bdVentas_bdRemisiones]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'XXXXCiudadXXXXX' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdCliente', @level2type=N'COLUMN',@level2name=N'idCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdFactura', @level2type=N'COLUMN',@level2name=N'idCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdProyecto', @level2type=N'COLUMN',@level2name=N'idCliente'
GO
