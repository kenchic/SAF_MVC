USE [SAF]
GO
/****** Object:  User [saf]    Script Date: 19/01/2021 11:49:58 p.m. ******/
CREATE USER [saf] FOR LOGIN [saf] WITH DEFAULT_SCHEMA=[SAF]
GO
/****** Object:  User [seg]    Script Date: 19/01/2021 11:49:59 p.m. ******/
CREATE USER [seg] FOR LOGIN [seg] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Schema [SAF]    Script Date: 19/01/2021 11:49:59 p.m. ******/
CREATE SCHEMA [SAF]
GO
/****** Object:  Schema [SEG]    Script Date: 19/01/2021 11:49:59 p.m. ******/
CREATE SCHEMA [SEG]
GO
/****** Object:  StoredProcedure [SAF].[pAgente]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SAF].[pAgente]  
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
			SELECT Id, Nombre, Activo FROM bdAgente
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdAgente 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
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
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Agente ON A.Id = Agente.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdAgente AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS Agente ON A.Id = Agente.Id
		END
END


--GO

--EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pAgente'
--GO
GO
/****** Object:  StoredProcedure [SAF].[pBodega]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SAF].[pBodega]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idCliente, idProveedor, Nombre, Activo, EsSistema, ClienteNombre, ProveedorNombre FROM vBodega

	IF (@Accion = 1)
		SELECT Id, idCliente, idProveedor, Nombre, Activo, EsSistema, ClienteNombre, ProveedorNombre FROM vBodega WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT  Id, idCliente, idProveedor, Nombre, Activo, EsSistema, ClienteNombre, ProveedorNombre FROM vBodega
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdBodega 
			SELECT * FROM (SELECT
					max(CASE WHEN name='idCliente' THEN convert(int,StringValue) ELSE 0 END) AS [idCliente],
					max(CASE WHEN name='idProveedor' THEN convert(int,StringValue) ELSE 0 END) AS [idProveedor],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS [EsSistema]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
			GROUP BY parent_ID) Bodega
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET idCliente = Bodega.idCliente,
				idProveedor = Bodega.idProveedor,
				Nombre = Bodega.Nombre,
				Activo = Bodega.Activo,
				EsSistema = Bodega.EsSistema
			FROM bdBodega AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='idCliente' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [idCliente],
					max(CASE WHEN name='idProveedor' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [idProveedor],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS [EsSistema],
					max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Bodega ON A.Id = Bodega.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdBodega AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS Bodega ON A.Id = Bodega.Id
		END
END



GO
/****** Object:  StoredProcedure [SAF].[pCiudad]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SAF].[pCiudad]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdCiudad

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdCiudad WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM bdCiudad
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdCiudad 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Ciudad
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = Ciudad.Nombre,
				Activo = Ciudad.Activo
			FROM bdCiudad AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Ciudad ON A.Id = Ciudad.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdCiudad AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS Ciudad ON A.Id = Ciudad.Id
		END
END



GO
/****** Object:  StoredProcedure [SAF].[pCliente]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [SAF].[pCliente]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Nombre, Direccion, Telefono, Celular, Correo, Activo, CiudadNombre FROM VCliente

	IF (@Accion = 1)
		SELECT Id, idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Nombre, Direccion, Telefono, Celular, Correo, Activo, CiudadNombre FROM VCliente WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Nombre, Direccion, Telefono, Celular, Correo, Activo, CiudadNombre FROM VCliente
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdCliente (idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Telefono, Celular, Correo, Activo)
			SELECT idCiudad, Identificacion, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Telefono, Celular, Correo, Activo FROM (SELECT
					max(CASE WHEN name='idCiudad' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCiudad],
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(20),StringValue) ELSE '' END) AS [Identificacion],
					max(CASE WHEN name='Nombre1' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Nombre1],
					max(CASE WHEN name='Nombre2' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Nombre2],
					max(CASE WHEN name='Apellido1' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Apellido1],
					max(CASE WHEN name='Apellido2' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Apellido2],
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Direccion],
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Telefono],
					max(CASE WHEN name='Celular' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Celular],
					max(CASE WHEN name='Correo' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Correo],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Cliente
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE C
			SET idCiudad = Cliente.idCiudad,
				Identificacion = Cliente.Identificacion,
				Nombre1 = Cliente.Nombre1,
				Nombre2 = CASE WHEN Cliente.Nombre2 = 'null' THEN '' ELSE Cliente.Nombre2 END,
				Apellido1 = Cliente.Apellido1,
				Apellido2 = CASE WHEN Cliente.Apellido2 = 'null' THEN '' ELSE Cliente.Apellido2 END,
				Direccion = Cliente.Direccion,
				Telefono = Cliente.Telefono,
				Celular = CASE WHEN Cliente.Celular = 'null' THEN '' ELSE Cliente.Celular END,
				Correo = CASE WHEN Cliente.Correo = 'null' THEN '' ELSE Cliente.Correo END,
				Activo = Cliente.Activo
			FROM bdCliente AS C
			INNER JOIN 
			(SELECT
				    max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
					max(CASE WHEN name='idCiudad' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCiudad],
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(20),StringValue) ELSE '' END) AS [Identificacion],
					max(CASE WHEN name='Nombre1' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Nombre1],
					max(CASE WHEN name='Nombre2' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Nombre2],
					max(CASE WHEN name='Apellido1' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Apellido1],
					max(CASE WHEN name='Apellido2' THEN convert(VARCHAR(25),StringValue) ELSE '' END) AS [Apellido2],
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Direccion],
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Telefono],
					max(CASE WHEN name='Celular' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Celular],
					max(CASE WHEN name='Correo' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Correo],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Cliente ON C.Id = Cliente.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE C
			FROM bdCliente AS C
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS Cliente ON C.Id = Cliente.Id
		END
END



GO
/****** Object:  StoredProcedure [SAF].[pConductor]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SAF].[pConductor]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo, Placa FROM bdConductor

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo, Placa FROM bdConductor WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT  Id, Nombre, Activo, Placa FROM bdConductor
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdConductor 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Placa' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Placa],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Conductor
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = Conductor.Nombre,
				Placa = Conductor.Placa,
				Activo = Conductor.Activo
			FROM bdConductor AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Placa' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Placa],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Conductor ON A.Id = Conductor.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdConductor AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS Conductor ON A.Id = Conductor.Id
		END
END



GO
/****** Object:  StoredProcedure [SAF].[pContrato]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [SAF].[pContrato]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF(@Accion = 0)
		SELECT Id, idProyecto, idListaPrecio, idAgente, InformacionBD, ContratoAlquiler, CartaPagare, Pagare, LetraCambio, GarantiasCondiciones 
				 , Deposito, Anticipo, PersonaJuridica, PersonaNatural, FotoCopiaCedula, FotoCopiaNit, CamaraComercio, DescuentoAlquiler, DescuentoVenta
				 , DescuentoReposicion, DescuentoMantenimiento, DescuentoTransporte, PorcentajeAgente, AgenteNombre, ListaPrecioNombre
		FROM vContrato

	IF(@Accion = 1)
		SELECT Id, idProyecto, idListaPrecio, idAgente, InformacionBD, ContratoAlquiler, CartaPagare, Pagare, LetraCambio, GarantiasCondiciones 
				 , Deposito, Anticipo, PersonaJuridica, PersonaNatural, FotoCopiaCedula, FotoCopiaNit, CamaraComercio, DescuentoAlquiler, DescuentoVenta
				 , DescuentoReposicion, DescuentoMantenimiento, DescuentoTransporte, PorcentajeAgente, AgenteNombre, ListaPrecioNombre
		FROM vContrato

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idProyecto, idListaPrecio, idAgente, InformacionBD, ContratoAlquiler, CartaPagare, Pagare, LetraCambio, GarantiasCondiciones 
				 , Deposito, Anticipo, PersonaJuridica, PersonaNatural, FotoCopiaCedula, FotoCopiaNit, CamaraComercio, DescuentoAlquiler, DescuentoVenta
				 , DescuentoReposicion, DescuentoMantenimiento, DescuentoTransporte, PorcentajeAgente, AgenteNombre, ListaPrecioNombre
		    FROM vContrato 
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			PRINT 'Se insertar en el momento de insertar el proyecto'
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE C
			SET idListaPrecio = Contrato.idListaPrecio,
				idAgente = CASE WHEN Contrato.idAgente <= 0 THEN null ELSE Contrato.idAgente END, 
				InformacionBD = Contrato.InformacionBD,
				ContratoAlquiler = Contrato.ContratoAlquiler, 
				CartaPagare = Contrato.CartaPagare, 
				Pagare = Contrato.Pagare, 
				LetraCambio = Contrato.LetraCambio, 
				GarantiasCondiciones = Contrato.GarantiasCondiciones, 
				Deposito = Contrato.Deposito, 
				Anticipo = Contrato.Anticipo, 
				PersonaJuridica = Contrato.PersonaJuridica, 
				PersonaNatural = Contrato.PersonaNatural, 
				FotoCopiaCedula = Contrato.FotoCopiaCedula, 
				FotoCopiaNit = Contrato.FotoCopiaNit, 
				CamaraComercio = Contrato.CamaraComercio, 
				DescuentoAlquiler = Contrato.DescuentoAlquiler, 
				DescuentoVenta = Contrato.DescuentoVenta, 
				DescuentoReposicion = Contrato.DescuentoReposicion, 
				DescuentoMantenimiento = Contrato.DescuentoMantenimiento, 
				DescuentoTransporte = Contrato.DescuentoTransporte, 
				PorcentajeAgente = Contrato.PorcentajeAgente				
			FROM bdContrato AS C
			INNER JOIN 
			(SELECT
				    max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
					max(CASE WHEN name='idListaPrecio' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idListaPrecio],
					max(CASE WHEN name='idAgente' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idAgente],					
					max(CASE WHEN name='InformacionBD' THEN convert(BIT,StringValue) ELSE 0 END) AS [InformacionBD],
					max(CASE WHEN name='ContratoAlquiler' THEN convert(BIT,StringValue) ELSE 0 END) AS [ContratoAlquiler],
					max(CASE WHEN name='CartaPagare' THEN convert(BIT,StringValue) ELSE 0 END) AS [CartaPagare],
					max(CASE WHEN name='Pagare' THEN convert(BIT,StringValue) ELSE 0 END) AS [Pagare],
					max(CASE WHEN name='LetraCambio' THEN convert(BIT,StringValue) ELSE 0 END) AS [LetraCambio],
					max(CASE WHEN name='GarantiasCondiciones' THEN convert(BIT,StringValue) ELSE 0 END) AS [GarantiasCondiciones],
					max(CASE WHEN name='Deposito' THEN convert(BIT,StringValue) ELSE 0 END) AS [Deposito],
					max(CASE WHEN name='Anticipo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Anticipo],
					max(CASE WHEN name='PersonaJuridica' THEN convert(BIT,StringValue) ELSE 0 END) AS [PersonaJuridica],
					max(CASE WHEN name='PersonaNatural' THEN convert(BIT,StringValue) ELSE 0 END) AS [PersonaNatural],
					max(CASE WHEN name='FotoCopiaCedula' THEN convert(BIT,StringValue) ELSE 0 END) AS [FotoCopiaCedula],
					max(CASE WHEN name='FotoCopiaNit' THEN convert(BIT,StringValue) ELSE 0 END) AS [FotoCopiaNit],
					max(CASE WHEN name='CamaraComercio' THEN convert(BIT,StringValue) ELSE 0 END) AS [CamaraComercio],
					max(CASE WHEN name='DescuentoAlquiler' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoAlquiler],
					max(CASE WHEN name='DescuentoVenta' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoVenta],
					max(CASE WHEN name='DescuentoReposicion' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoReposicion],
					max(CASE WHEN name='DescuentoMantenimiento' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoMantenimiento],
					max(CASE WHEN name='DescuentoTransporte' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoTransporte],
					max(CASE WHEN name='PorcentajeAgente' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [PorcentajeAgente]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Contrato ON C.Id = Contrato.Id

		END

	IF(@Accion = 5)
		BEGIN
			PRINT 'No se permite eliminar'
		END
END




GO
/****** Object:  StoredProcedure [SAF].[pDocumento]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [SAF].[pDocumento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar, 6: Insertar Lista y Detalle, 7: Editar Lista y Detalle
	@Json NVARCHAR(max)	,
	@IdDocumento INT OUTPUT
)
AS 
BEGIN
	SET @IdDocumento = 0

	IF (@Accion = 0)
		SELECT Id, Numero, idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Fecha, Descripcion, Estado, DocumentoTipoNombre, BodegaOrigenNombre, BodegaDestinoNombre FROM vDocumento

	IF (@Accion = 1)
		SELECT Id, Numero, idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Fecha, Descripcion, Estado, DocumentoTipoNombre, BodegaOrigenNombre, BodegaDestinoNombre FROM vDocumento WHERE Estado = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Numero, idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Fecha, Descripcion, Estado, DocumentoTipoNombre, BodegaOrigenNombre, BodegaDestinoNombre FROM vDocumento
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdDocumento (idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Estado)
			SELECT idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Estado 
					FROM (SELECT
					max(CASE WHEN name='idDocumentoTipo' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idDocumentoTipo],
					max(CASE WHEN name='idBodegaOrigen' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaOrigen],
					max(CASE WHEN name='idBodegaDestino' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaDestino],
					max(CASE WHEN name='Numero' THEN convert(INT,StringValue) ELSE 0 END) AS [Numero],
					max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Descripcion],
					max(CASE WHEN name='Estado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Estado]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Documento
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE D
			SET idDocumentoTipo = Documento.idDocumentoTipo,
				idBodegaOrigen = Documento.idBodegaOrigen,
				idBodegaDestino = Documento.idBodegaDestino,
				Fecha = Documento.Fecha,
				Descripcion = Documento.Descripcion,
				Estado = Documento.Estado
			FROM bdDocumento AS D
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
				    max(CASE WHEN name='idDocumentoTipo' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idDocumentoTipo],
					max(CASE WHEN name='idUnidadMedida' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idBodegaOrigen],
					max(CASE WHEN name='idBodegaDestino' THEN convert(VARCHAR(50),StringValue) ELSE 0 END) AS [idBodegaDestino],
					max(CASE WHEN name='Fecha' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Fecha],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Descripcion],
					max(CASE WHEN name='Estado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Estado]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Documento ON D.Id = Documento.Id
		END

	IF(@Accion = 5)
		BEGIN
			DELETE D
			FROM bdDocumento AS D
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS Documento ON D.Id = Documento.Id
		END

	IF(@Accion = 6)
		BEGIN
			BEGIN TRANSACTION;  
			BEGIN TRY 

				--Insertar Documento				
				INSERT INTO bdDocumento (idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Estado)
						SELECT idDocumentoTipo, idBodegaOrigen, idBodegaDestino, Numero, Fecha, Descripcion, Estado 
						FROM (SELECT
						max(CASE WHEN name='idDocumentoTipo' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idDocumentoTipo],
						max(CASE WHEN name='idBodegaOrigen' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaOrigen],
						max(CASE WHEN name='idBodegaDestino' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaDestino],
						max(CASE WHEN name='Numero' THEN convert(INT,StringValue) ELSE 0 END) AS [Numero],
						max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
						max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Descripcion],
						max(CASE WHEN name='Estado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Estado]
							FROM SEG.fParseJSON
							( @Json )
						WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
						GROUP BY parent_ID) Documento
				WHERE Documento.Fecha <> ''

				SELECT @IdDocumento = SCOPE_IDENTITY()

				--Insertar Detalle
				INSERT INTO bdDocumentoDetalle (idDocumento, idElemento, Cantidad)
				SELECT @IdDocumento, idElemento, Cantidad
				FROM (SELECT
							max(CASE WHEN name='Fecha' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Fecha],
							max(CASE WHEN name='idElemento' THEN convert(INT,StringValue) ELSE 0 END) AS [idElemento],
							max(CASE WHEN name='Cantidad' THEN convert(INT,StringValue) ELSE 0 END) AS [Cantidad]
						FROM SEG.fParseJSON
							( @Json )
						WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
						GROUP BY parent_ID) DocumentoDetalle
				WHERE DocumentoDetalle.Fecha = '' AND DocumentoDetalle.Cantidad > 0 AND DocumentoDetalle.idElemento > 0
				
			END TRY  
			BEGIN CATCH  
				SELECT   
					ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;  
	
				IF @@TRANCOUNT > 0  
					ROLLBACK TRANSACTION;  
			END CATCH;  
  
			IF @@TRANCOUNT > 0  
				COMMIT TRANSACTION;  
		END

	IF(@Accion = 7)
		BEGIN
			BEGIN TRANSACTION;  
			BEGIN TRY
				--Editar Documento
				UPDATE A
				SET idDocumentoTipo = Documento.idDocumentoTipo,
					idBodegaOrigen = Documento.idBodegaOrigen,
					idBodegaDestino = Documento.idBodegaDestino,
					Fecha = Documento.Fecha,
					Descripcion = Documento.Descripcion,
					Estado =  Documento.Estado
				FROM bdDocumento AS A
				INNER JOIN 
					(SELECT
							max(CASE WHEN name='idDocumentoTipo' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idDocumentoTipo],
							max(CASE WHEN name='idBodegaOrigen' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaOrigen],
							max(CASE WHEN name='idBodegaDestino' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idBodegaDestino],
							max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha],
							max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Descripcion],
							max(CASE WHEN name='Estado' THEN convert(BIT,StringValue) ELSE 0 END) AS [Estado],
							max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
					FROM SEG.fParseJSON
						(@json)
					WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
					GROUP BY parent_ID) AS Documento ON A.Id = Documento.Id
				WHERE Documento.Fecha <> ''
					
				--Borrar Detalle
				DELETE DD
				FROM bdDocumentoDetalle DD
				INNER JOIN 
				(SELECT max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id],
						max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha]
				FROM SEG.fParseJSON
					(@json)
				WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
				GROUP BY parent_ID) AS Documento ON DD.idDocumento = Documento.Id 
				WHERE Documento.Fecha <> ''
				
				--Insertar Detalle
				SELECT @IdDocumento  = Documento.Id 
				FROM
				(SELECT max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id],
						max(CASE WHEN name='Fecha' THEN convert(DATETIME,StringValue) ELSE '' END) AS [Fecha]
				FROM SEG.fParseJSON
					(@json)
				WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
				GROUP BY parent_ID) AS Documento 
				WHERE Documento.Fecha <> ''

				INSERT INTO bdDocumentoDetalle (idDocumento, idElemento, Cantidad)
				SELECT @IdDocumento, idElemento, Cantidad
				FROM (SELECT
							max(CASE WHEN name='Fecha' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Fecha],
							max(CASE WHEN name='idElemento' THEN convert(INT,StringValue) ELSE 0 END) AS [idElemento],
							max(CASE WHEN name='Cantidad' THEN convert(INT,StringValue) ELSE 0 END) AS [Cantidad]
						FROM SEG.fParseJSON
							( @Json )
						WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
						GROUP BY parent_ID) DocumentoDetalle
				WHERE DocumentoDetalle.Fecha = '' AND DocumentoDetalle.Cantidad > 0 AND DocumentoDetalle.idElemento > 0

			END TRY  
			BEGIN CATCH  
				SELECT   
					ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;  
  
				IF @@TRANCOUNT > 0  
					ROLLBACK TRANSACTION;  
			END CATCH;  
  
			IF @@TRANCOUNT > 0  
				COMMIT TRANSACTION;  
		END
END





GO
/****** Object:  StoredProcedure [SAF].[pDocumentoDetalle]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [SAF].[pDocumentoDetalle]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idDocumento, idElemento, idBodegaDestino, idBodegaOrigen, Cantidad, ElementoNombre, BodegaDestinoNombre, BodegaOrigenNombre, Descripcion  FROM vDocumentoDetalle

	IF (@Accion = 1)
		SELECT Id, idDocumento, idElemento, idBodegaDestino, idBodegaOrigen, Cantidad, ElementoNombre, BodegaDestinoNombre, BodegaOrigenNombre, Descripcion FROM vDocumentoDetalle WHERE Cantidad > 0 

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idDocumento, idElemento, idBodegaDestino, idBodegaOrigen, Cantidad, ElementoNombre, BodegaDestinoNombre, BodegaOrigenNombre, Descripcion FROM vDocumentoDetalle
			WHERE idDocumento = 
			(SELECT      
				   max(CASE WHEN name='idDocumento' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

END






GO
/****** Object:  StoredProcedure [SAF].[pDocumentoTipo]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [SAF].[pDocumentoTipo]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdDocumentoTipo

	IF (@Accion = 1)
		SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdDocumentoTipo WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdDocumentoTipo
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdDocumentoTipo 
			SELECT * FROM (SELECT					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Consecutivo' THEN convert(BIGINT,StringValue) ELSE 0 END) AS Consecutivo,
					max(CASE WHEN name='Operacion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Operacion,
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS EsSistema,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
			GROUP BY parent_ID) DocumentoTipo
		END
	
	IF(@Accion = 4)
		BEGIN
			UPDATE A
			SET Nombre = DocumentoTipo.Nombre,
				Consecutivo = DocumentoTipo.Consecutivo,
				Operacion = DocumentoTipo.Operacion,
				EsSistema = DocumentoTipo.EsSistema,
				Activo = DocumentoTipo.Activo
			FROM bdDocumentoTipo AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS Id,					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Consecutivo' THEN convert(BIGINT,StringValue) ELSE 0 END) AS Consecutivo,
					max(CASE WHEN name='Operacion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Operacion,
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS EsSistema,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SEG.fParseJSON
			(@json)
			) AS DocumentoTipo ON A.Id = DocumentoTipo.Id
		END
	
	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdDocumentoTipo AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS Id
			FROM SEG.fParseJSON
			(@json)
			) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END
END


GO
/****** Object:  StoredProcedure [SAF].[pElemento]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [SAF].[pElemento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id ,idGrupoElemento, idUnidadMedida, Referencia, Nombre, Mt2, Peso, Rotacion, Activo, GrupoElementoNombre, UnidadMedidaNombre FROM vElemento

	IF (@Accion = 1)
		SELECT Id ,idGrupoElemento, idUnidadMedida, Referencia, Nombre, Mt2, Peso, Rotacion, Activo, GrupoElementoNombre, UnidadMedidaNombre FROM vElemento WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id ,idGrupoElemento, idUnidadMedida, Referencia, Nombre, Mt2, Peso, Rotacion, Activo, GrupoElementoNombre, UnidadMedidaNombre FROM vElemento
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdElemento (idGrupoElemento, idUnidadMedida, Referencia, Nombre, Mt2, Peso, Rotacion, Activo)
			SELECT idGrupoElemento, idUnidadMedida, Referencia, Nombre, Mt2, Peso, Rotacion, Activo FROM (SELECT
					max(CASE WHEN name='idGrupoElemento' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idGrupoElemento],
					max(CASE WHEN name='idUnidadMedida' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idUnidadMedida],
					max(CASE WHEN name='Referencia' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Referencia],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Mt2' THEN convert(FLOAT,StringValue) ELSE '' END) AS [Mt2],
					max(CASE WHEN name='Peso' THEN convert(FLOAT,StringValue) ELSE '' END) AS [Peso],
					max(CASE WHEN name='Rotacion' THEN convert(BIT,StringValue) ELSE 0 END) AS [Rotacion],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Elemento
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE E
			SET idGrupoElemento = Elemento.idGrupoElemento,
				idUnidadMedida = Elemento.idUnidadMedida,
				Referencia = Elemento.Referencia,
				Nombre =Elemento.Nombre,
				Mt2 = Elemento.Mt2,
				Peso = Elemento.Peso,
				Rotacion = Elemento.Rotacion,
				Activo = Elemento.Activo
			FROM bdElemento AS E
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
				    max(CASE WHEN name='idGrupoElemento' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idGrupoElemento],
					max(CASE WHEN name='idUnidadMedida' THEN convert(SMALLINT, StringValue) ELSE 0 END) AS [idUnidadMedida],
					max(CASE WHEN name='Referencia' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Referencia],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Mt2' THEN convert(FLOAT,StringValue) ELSE '' END) AS [Mt2],
					max(CASE WHEN name='Peso' THEN convert(FLOAT,StringValue) ELSE '' END) AS [Peso],
					max(CASE WHEN name='Rotacion' THEN convert(BIT,StringValue) ELSE 0 END) AS [Rotacion],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Elemento ON E.Id = Elemento.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE E
			FROM bdElemento AS E
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS Elemento ON E.Id = Elemento.Id
		END
END



GO
/****** Object:  StoredProcedure [SAF].[pGrupoElemento]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SAF].[pGrupoElemento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdGrupoElemento

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdGrupoElemento WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM bdGrupoElemento
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdGrupoElemento 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) GrupoElemento
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = GrupoElemento.Nombre,
				Activo = GrupoElemento.Activo
			FROM bdGrupoElemento AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS GrupoElemento ON A.Id = GrupoElemento.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdGrupoElemento AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS GrupoElemento ON A.Id = GrupoElemento.Id
		END
END



GO
/****** Object:  StoredProcedure [SAF].[pListaPrecio]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [SAF].[pListaPrecio]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar, 6: Insertar Lista y Detalle, 7: Editar Lista y Detalle
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdListaPrecio

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdListaPrecio WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM bdListaPrecio
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdListaPrecio 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) ListaPrecio
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE A
			SET Nombre = ListaPrecio.Nombre,
				Activo = ListaPrecio.Activo
			FROM bdListaPrecio AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdListaPrecio AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END

	IF(@Accion = 6)
		BEGIN
			BEGIN TRANSACTION;  
			BEGIN TRY 
				DECLARE @ID_LISTA AS INT

				--Insertar Lista
				INSERT INTO bdListaPrecio
				SELECT * 
				FROM (SELECT
							max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
							max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
						FROM SEG.fParseJSON
							( @Json )
						WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
						GROUP BY parent_ID) ListaPrecio
				WHERE ListaPrecio.Nombre <> ''

				SELECT @ID_LISTA = SCOPE_IDENTITY()

				--Insertar Detalle
				INSERT INTO bdListaPrecioDetalle
				SELECT @ID_LISTA, idElemento, PrecioAlquiler, PrecioVenta, PrecioPerdida
				FROM (SELECT
							max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
							max(CASE WHEN name='idElemento' THEN convert(INT,StringValue) ELSE 0 END) AS [idElemento],
							max(CASE WHEN name='PrecioAlquiler' THEN convert(INT,StringValue) ELSE 0 END) AS [PrecioAlquiler],
							max(CASE WHEN name='PrecioVenta' THEN convert(INT,StringValue) ELSE 0 END) AS [PrecioVenta],
							max(CASE WHEN name='PrecioPerdida' THEN convert(INT,StringValue) ELSE 0 END) AS [PrecioPerdida]
						FROM SEG.fParseJSON
							( @Json )
						WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
						GROUP BY parent_ID) ListaPrecio
				WHERE ListaPrecio.Nombre = ''
			END TRY  
			BEGIN CATCH  
				SELECT   
					ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;  
  
				IF @@TRANCOUNT > 0  
					ROLLBACK TRANSACTION;  
			END CATCH;  
  
			IF @@TRANCOUNT > 0  
				COMMIT TRANSACTION;  
		END

	IF(@Accion = 7)
		BEGIN
			BEGIN TRANSACTION;  
			BEGIN TRY
				--Editar Lista
				UPDATE A
				SET Nombre = ListaPrecio.Nombre,
					Activo = ListaPrecio.Activo
				FROM bdListaPrecio AS A
				INNER JOIN 
					(SELECT
							max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
							max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
							max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
					FROM SEG.fParseJSON
						(@json)
					WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
					GROUP BY parent_ID) AS ListaPrecio ON A.Id = ListaPrecio.Id
				WHERE ListaPrecio.Nombre <> ''
					
				--Editar Detalle
				UPDATE A
				SET PrecioAlquiler = ListaPrecioDetalle.PrecioAlquiler,
					PrecioVenta = ListaPrecioDetalle.PrecioVenta,
					PrecioPerdida = ListaPrecioDetalle.PrecioPerdida
				FROM bdListaPrecioDetalle AS A
				INNER JOIN 
				(SELECT
						max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id],
						max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
						max(CASE WHEN name='PrecioAlquiler' THEN convert(INT,StringValue) ELSE '' END) AS [PrecioAlquiler],
						max(CASE WHEN name='PrecioVenta' THEN convert(INT,StringValue) ELSE '' END) AS [PrecioVenta],
						max(CASE WHEN name='PrecioPerdida' THEN convert(INT,StringValue) ELSE '' END) AS [PrecioPerdida]
				FROM SEG.fParseJSON
					(@json)
				WHERE ValueType = 'string' OR ValueType = 'int'
				GROUP BY parent_ID) AS ListaPrecioDetalle ON A.Id = ListaPrecioDetalle.Id
				WHERE ListaPrecioDetalle.Nombre = ''
			END TRY  
			BEGIN CATCH  
				SELECT   
					ERROR_NUMBER() AS ErrorNumber  
					,ERROR_SEVERITY() AS ErrorSeverity  
					,ERROR_STATE() AS ErrorState  
					,ERROR_PROCEDURE() AS ErrorProcedure  
					,ERROR_LINE() AS ErrorLine  
					,ERROR_MESSAGE() AS ErrorMessage;  
  
				IF @@TRANCOUNT > 0  
					ROLLBACK TRANSACTION;  
			END CATCH;  
  
			IF @@TRANCOUNT > 0  
				COMMIT TRANSACTION;  
		END
END




GO
/****** Object:  StoredProcedure [SAF].[pListaPrecioDetalle]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [SAF].[pListaPrecioDetalle]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0 or @Accion = 1)
		SELECT Id, idListaPrecio, idElemento, ListaPrecioNombre, ElementoNombre, PrecioAlquiler, PrecioVenta, PrecioPerdida FROM vListaPrecioDetalle

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idListaPrecio, idElemento, ListaPrecioNombre, ElementoNombre, PrecioAlquiler, PrecioVenta, PrecioPerdida FROM vListaPrecioDetalle
			WHERE idListaPrecio = 
				(SELECT      
					   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
				FROM SEG.fParseJSON
				( @json )
			) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdListaPrecioDetalle 
			SELECT * FROM (SELECT
					max(CASE WHEN name='idListaPrecio' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [idListaPrecio],
					max(CASE WHEN name='idElemento' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [idElemento],
					max(CASE WHEN name='PrecioAlquiler' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [PrecioAlquiler],
					max(CASE WHEN name='PrecioVenta' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [PrecioVenta],
					max(CASE WHEN name='PrecioPerdida' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [PrecioPerdida]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) ListaPrecioDetalle
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET PrecioAlquiler = ListaPrecioDetalle.PrecioAlquiler,
				PrecioVenta = ListaPrecioDetalle.PrecioVenta,
				PrecioPerdida = ListaPrecioDetalle.PrecioPerdida
			FROM bdListaPrecioDetalle AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id],
				   max(CASE WHEN name='PrecioAlquiler' THEN convert(INT,StringValue) ELSE '' END) AS [PrecioAlquiler],
				   max(CASE WHEN name='PrecioVenta' THEN convert(INT,StringValue) ELSE '' END) AS [PrecioVenta],
				   max(CASE WHEN name='PrecioPerdida' THEN convert(INT,StringValue) ELSE '' END) AS [PrecioPerdida]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS ListaPrecioDetalle ON A.Id = ListaPrecioDetalle.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdListaPrecioDetalle AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS ListaPrecioDetalle ON A.Id = ListaPrecioDetalle.Id
		END
END




GO
/****** Object:  StoredProcedure [SAF].[pProveedor]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SAF].[pProveedor]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Identificacion, Nombre, Iniciales, Telefono, Direccion, Activo FROM bdProveedor

	IF (@Accion = 1)
		SELECT Id, Identificacion, Nombre, Iniciales, Telefono, Direccion, Activo FROM bdProveedor WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Identificacion, Nombre, Iniciales, Telefono, Direccion, Activo FROM bdProveedor
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(VARCHAR(10),StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdProveedor 
			SELECT * FROM (SELECT									
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(20),StringValue) ELSE '' END) AS Identificacion,
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Iniciales' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS Iniciales,
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Descripcion,
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Valor,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Proveedor
		END
	
	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Identificacion = Proveedor.Identificacion,
				Nombre = Proveedor.Nombre,
				Iniciales = Proveedor.Iniciales,
				Telefono = Proveedor.Telefono,
				Direccion = Proveedor.Direccion,
				Activo = Proveedor.Activo
			FROM bdProveedor AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(smallint,StringValue) ELSE 0 END) AS Id,					
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(20),StringValue) ELSE '' END) AS Identificacion,
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Iniciales' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS Iniciales,
					max(CASE WHEN name='Telefono' THEN (CASE WHEN StringValue = 'null' THEN NULL ELSE convert(VARCHAR(10),StringValue) END) ELSE '' END) AS Telefono,
					max(CASE WHEN name='Direccion' THEN (CASE WHEN StringValue = 'null' THEN NULL ELSE convert(VARCHAR(10),StringValue) END) ELSE '' END) AS Direccion,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SEG.fParseJSON
			(@json)
			) AS Proveedor ON A.Id = Proveedor.Id
		END
	
	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdProveedor AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(smallint,StringValue) ELSE 0 END) AS Id
			FROM SEG.fParseJSON
			(@json)
			) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END
END





GO
/****** Object:  StoredProcedure [SAF].[pProyecto]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [SAF].[pProyecto]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, Fecha, FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, Activo, Estado
	           ,CiudadNombre, ClienteNombre, idContrato FROM vProyecto

	IF (@Accion = 1)
		SELECT Id, idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, Fecha, FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, Activo, Estado
	           ,CiudadNombre, ClienteNombre, idContrato FROM vProyecto WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, Fecha, FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, Activo, Estado
	           ,CiudadNombre, ClienteNombre, idContrato FROM vProyecto 
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdProyecto (idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, Fecha, FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, Activo, Estado)
			SELECT idCliente, idCiudad, Nombre, Tipo, Direccion, Telefono, Observacion, GETDATE(), FormaContacto, SistemaMedida, IdentificacionResponsable, NombreResponsable, TelResponsable, 1, 1
			       FROM (SELECT
				    max(CASE WHEN name='idCliente' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCliente],
					max(CASE WHEN name='idCiudad' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCiudad],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Tipo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Tipo],					
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Direccion],
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Telefono],
					max(CASE WHEN name='Observacion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Observacion],
					max(CASE WHEN name='FormaContacto' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [FormaContacto],
					max(CASE WHEN name='SistemaMedida' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [SistemaMedida],
					max(CASE WHEN name='IdentificacionResponsable' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [IdentificacionResponsable],
					max(CASE WHEN name='NombreResponsable' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [NombreResponsable],
					max(CASE WHEN name='TelResponsable' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [TelResponsable]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Proyecto
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE P
			SET idCliente = Proyecto.idCliente,
				idCiudad = Proyecto.idCiudad,
				Nombre = Proyecto.Nombre,
				Tipo = Proyecto.Tipo, 
				Direccion = CASE WHEN Proyecto.Direccion = 'null' THEN '' ELSE Proyecto.Direccion END,
				Telefono = CASE WHEN Proyecto.Telefono = 'null' THEN '' ELSE Proyecto.Telefono END,
				Observacion = CASE WHEN Proyecto.Observacion = 'null' THEN '' ELSE Proyecto.Observacion END,				
				FormaContacto = CASE WHEN Proyecto.FormaContacto = 'null' THEN '' ELSE Proyecto.FormaContacto END,
				SistemaMedida = CASE WHEN Proyecto.SistemaMedida = 'null' THEN '' ELSE Proyecto.SistemaMedida END, 
				IdentificacionResponsable = CASE WHEN Proyecto.IdentificacionResponsable = 'null' THEN '' ELSE Proyecto.IdentificacionResponsable END,  
				NombreResponsable = CASE WHEN Proyecto.NombreResponsable = 'null' THEN '' ELSE Proyecto.NombreResponsable END, 
				TelResponsable = CASE WHEN Proyecto.TelResponsable = 'null' THEN '' ELSE Proyecto.TelResponsable END
			FROM bdProyecto AS P
			INNER JOIN 
			(SELECT
				    max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
					max(CASE WHEN name='idCliente' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCliente],
					max(CASE WHEN name='idCiudad' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idCiudad],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Tipo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Tipo],					
					max(CASE WHEN name='Direccion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Direccion],
					max(CASE WHEN name='Telefono' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Telefono],
					max(CASE WHEN name='Observacion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS [Observacion],					
					max(CASE WHEN name='FormaContacto' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [FormaContacto],
					max(CASE WHEN name='SistemaMedida' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [SistemaMedida],
					max(CASE WHEN name='IdentificacionResponsable' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [IdentificacionResponsable],
					max(CASE WHEN name='NombreResponsable' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [NombreResponsable],
					max(CASE WHEN name='TelResponsable' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [TelResponsable]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Proyecto ON P.Id = Proyecto.Id

		END

	IF(@Accion = 5)
		BEGIN
			UPDATE P
			SET Activo = 0
			FROM bdProyecto AS P
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS Proyecto ON P.Id = Proyecto.Id
		END
END



GO
/****** Object:  StoredProcedure [SAF].[pTipoMantenimiento]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SAF].[pTipoMantenimiento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Valor, Activo FROM bdTipoMantenimiento

	IF (@Accion = 1)
		SELECT Id, Nombre, Valor, Activo FROM bdTipoMantenimiento WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Valor, Activo FROM bdTipoMantenimiento
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdTipoMantenimiento 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Valor' THEN convert(numeric(18,0),StringValue) ELSE 0 END) AS Valor,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'real'
			GROUP BY parent_ID) TipoMantenimiento
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = TipoMantenimiento.Nombre,
				Valor = TipoMantenimiento.Valor,
				Activo = TipoMantenimiento.Activo
			FROM bdTipoMantenimiento AS A
			INNER JOIN 
			(SELECT				   
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id],
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Valor' THEN convert(numeric(18,0),StringValue) ELSE 0 END) AS Valor,
				   max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS TipoMantenimiento ON A.Id = TipoMantenimiento.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdTipoMantenimiento AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS TipoMantenimiento ON A.Id = TipoMantenimiento.Id
		END
END



GO
/****** Object:  StoredProcedure [SAF].[pUnidadMedida]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [SAF].[pUnidadMedida]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM bdUnidadMedida

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM bdUnidadMedida WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM bdUnidadMedida
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdUnidadMedida 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) UnidadMedida
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = UnidadMedida.Nombre,
				Activo = UnidadMedida.Activo
			FROM bdUnidadMedida AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS UnidadMedida ON A.Id = UnidadMedida.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdUnidadMedida AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From SEG.fParseJSON
			(
				  @json
			)) AS UnidadMedida ON A.Id = UnidadMedida.Id
		END
END




GO
/****** Object:  StoredProcedure [SEG].[pParametro]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SEG].[pParametro]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Codigo, Nombre, Descripcion, Valor, Activo FROM bdParametro

	IF (@Accion = 1)
		SELECT Codigo, Nombre, Descripcion, Valor, Activo FROM bdParametro WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Codigo, Nombre, Descripcion, Valor, Activo FROM bdParametro
			WHERE Codigo = 
			(SELECT      
				   max(CASE WHEN name='Codigo' THEN convert(VARCHAR(10),StringValue) ELSE '0' END) AS [Id]
			FROM SEG.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdParametro 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Codigo' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS Codigo,					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS Descripcion,
					max(CASE WHEN name='Valor' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS Valor,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Parametro
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = Parametro.Nombre,
				Descripcion = Parametro.Descripcion,
				Valor = Parametro.Valor,
				Activo = Parametro.Activo
			FROM bdParametro AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Codigo' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS Codigo,					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Descripcion' THEN convert(VARCHAR(500),StringValue) ELSE '' END) AS Descripcion,
					max(CASE WHEN name='Valor' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS Valor,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM SEG.fParseJSON
			(
				  @json
			)) AS Parametro ON A.Codigo = Parametro.Codigo

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdParametro AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Codigo' THEN convert(VARCHAR(10),StringValue) ELSE '' END) AS [Codigo]
			From SEG.fParseJSON
			(
				  @json
			)) AS ListaPrecio ON A.Codigo = ListaPrecio.Codigo
		END
END





GO
/****** Object:  StoredProcedure [SEG].[pSesion]    Script Date: 19/01/2021 11:49:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SEG].[pSesion]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Sesion Activas, 2: Consultar, 3: Insertar, 4: Abrir Conexion, 5: Cerrar Conexion
	@Json NVARCHAR(max),
	@Id_Sesion INT = 0 OUTPUT
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idUsuario, Token, Terminal, FechaInicio, FechaFin, Tiempo FROM bdSesion

	IF (@Accion = 1)
		SELECT Id, idUsuario, Token, Terminal, FechaInicio, FechaFin, Tiempo FROM bdSesion WHERE FechaFin IS NULL

	IF (@Accion = 2)
		BEGIN
			SELECT Id, idUsuario, Token, Terminal, FechaInicio, FechaFin, Tiempo FROM bdSesion 
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'int'
			GROUP BY parent_ID) 
		END

	IF (@Accion = 3)
		BEGIN
			SELECT @Id_Sesion = Id 
			FROM bdSesion
			WHERE FechaFin IS NULL AND idUsuario = 
			(
					SELECT idUsuario
					FROM (SELECT
								max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE '' END) AS [idUsuario]
						FROM fParseJSON
						( @Json )
					WHERE ValueType = 'int') Sesion 
			) AND
			Token = 
			(
					SELECT Token
					FROM (SELECT
								max(CASE WHEN name='Token' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Token]
						FROM fParseJSON
						( @Json )
					WHERE ValueType = 'string') Sesion 
			)

			IF (@Id_Sesion IS NULL OR @Id_Sesion <= 0 )
				BEGIN
					UPDATE S
					SET FechaFin = GETDATE()
					FROM bdSesion S
					WHERE FechaFin IS NULL AND idUsuario = 
					(
							SELECT idUsuario
							FROM (SELECT
										max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE '' END) AS [idUsuario]
								FROM fParseJSON
								( @Json )
							WHERE ValueType = 'int') Sesion 
					)					

					INSERT INTO bdSesion 
					SELECT idUsuario, Token, 'SERVER', CONVERT( VARCHAR(22), FechaInicio ,108), null, null, 0
					FROM (SELECT
								max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE '' END) AS [idUsuario],
								max(CASE WHEN name='Token' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Token],
								max(CASE WHEN name='Terminal' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Terminal],
								max(CASE WHEN name='FechaInicio' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [FechaInicio],
								max(CASE WHEN name='FechaFin' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [FechaFin],
								max(CASE WHEN name='Tiempo' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Tiempo]					
						FROM fParseJSON
						( @Json )
					WHERE ValueType = 'string' OR ValueType = 'int') Sesion

					SELECT @Id_Sesion = SCOPE_IDENTITY()
				END
		END

	IF (@Accion = 4)
		BEGIN
			UPDATE S
			SET IdSesionBd =  @@SPID 
			FROM bdSesion AS S
			WHERE Id = 
			(
					SELECT IdSession
					FROM (SELECT
								max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE '' END) AS [IdSession]
						FROM fParseJSON
						( @Json )
					WHERE ValueType = 'int') Sesion 
			)		
		END
	IF (@Accion = 5)
		BEGIN
			UPDATE S
			SET IdSesionBd =  0 
			FROM bdSesion AS S
			WHERE Id = 
			(
					SELECT IdSession
					FROM (SELECT
								max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE '' END) AS [IdSession]
						FROM fParseJSON
						( @Json )
					WHERE ValueType = 'int') Sesion 
			)		
		END
END


GO
/****** Object:  StoredProcedure [SEG].[pSistema]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SEG].[pSistema]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Codigo, Version FROM bdSistema

	IF (@Accion = 1)
		SELECT Id, Codigo, Version FROM bdSistema

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Codigo, Version FROM bdSistema
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'int'
			GROUP BY parent_ID) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdSistema 
			SELECT * FROM (SELECT					
					max(CASE WHEN name='Codigo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Codigo],
					max(CASE WHEN name='Version' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Version]
			FROM fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'int'
			GROUP BY parent_ID) Sistema
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE U
			SET Codigo = Sistema.Codigo,
				Version = Sistema.Version
			FROM bdSistema AS U
			INNER JOIN 
			(SELECT
				  max(CASE WHEN name='Codigo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Codigo],
				  max(CASE WHEN name='Version' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Version],
				  max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Sistema ON U.Id = Sistema.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE U
			FROM bdSistema AS U
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Sistema ON U.Id = Sistema.Id
		END
END



GO
/****** Object:  StoredProcedure [SEG].[pUsuario]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SEG].[pUsuario]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar, 6: Autenticar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idRol, Identificacion, Nombre, Apellido, Usuario, Clave, Correo, Activo, Admin FROM bdUsuario

	IF (@Accion = 1)
		SELECT Id, idRol, Identificacion, Nombre, Apellido, Usuario, Clave, Correo, Activo, Admin FROM bdUsuario WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idRol, Identificacion, Nombre, Apellido, Usuario, Clave, Correo, Activo, Admin FROM bdUsuario 
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdUsuario 
			SELECT * FROM (SELECT
					max(CASE WHEN name='idRol' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idRol],
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Identificacion],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Apellido' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Apellido],
					max(CASE WHEN name='Usuario' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [Usuario],
					max(CASE WHEN name='Clave' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Clave],
					max(CASE WHEN name='Correo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Correo],					
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
					max(CASE WHEN name='Admin' THEN convert(BIT,StringValue) ELSE 0 END) AS [Admin]
			FROM fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Usuario
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE U
			SET Nombre = Usuario.Nombre,
				Activo = Usuario.Activo
			FROM bdUsuario AS U
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Usuario ON U.Id = Usuario.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE U
			FROM bdUsuario AS U
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Usuario ON U.Id = Usuario.Id
		END

	IF(@Accion = 6)
		BEGIN
			SELECT Id, idRol, Identificacion, Nombre, Apellido, U.Usuario, U.Clave, Correo, Activo, Admin 
			FROM bdUsuario AS U
			INNER JOIN 
			(SELECT 
				max(CASE WHEN name='Usuario' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [Usuario],
				max(CASE WHEN name='Clave' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Clave]
			FROM fParseJSON
			(
				@json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Usuario ON U.Usuario = Usuario.Usuario AND U.Clave = Usuario.Clave
		END
END


GO
/****** Object:  StoredProcedure [SEG].[pUsuarioMenu]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SEG].[pUsuarioMenu]  
(
	@Accion INT = 0, --0:Listar menus del usUario y menus relacionados con roles del usuario,
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
	BEGIN

		DECLARE @Usuario AS smallint 
		SET @Usuario =  (	SELECT      
							MAX(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
							FROM fParseJSON ( @json )
							WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
							GROUP BY parent_ID)

		CREATE TABLE ##TablaTemporal (Id smallint, Nombre varchar(50), Vista varchar(50), Orden int, SubOrden int, Imagen Varchar(100) )

		DECLARE @idMenu AS smallint 
		DECLARE @idMenuPadre AS smallint 
		DECLARE @Nombre AS Varchar(50)
		DECLARE @Vista AS Varchar(100)
		DECLARE @Orden AS smallint
		DECLARE @Image AS Varchar(100)
		DECLARE @exite AS smallint 
		DECLARE @OrdenPadre AS smallint 

		--Construir Usuario - Menu
		DECLARE UsuarioMenu 
		CURSOR FOR 
			SELECT M.id, M.idMenu, M.Nombre, M.Vista, M.Orden, M.Imagen 
			FROM bdUsuarioMenu UM 
			INNER JOIN bdMenu M ON UM.idMenu = M.Id AND UM.Activo = 1
			WHERE UM.idUsuario = @Usuario 

			UNION

			SELECT M.id, M.idMenu, M.Nombre, M.Vista, M.Orden, M.Imagen 
			FROM bdRolUsuario RU
			INNER JOIN bdRolMenu RM ON RU.idRol = RM.idRol AND RU.Activo = 1
			INNER JOIN bdMenu M ON RM.idMenu = M.Id AND RM.Activo = 1
			WHERE RU.idUsuario = @Usuario

			UNION

			SELECT M.id, M.idMenu, M.Nombre, M.Vista, M.Orden, M.Imagen 
			FROM bdRolUsuario RU
			INNER JOIN bdRol RP ON RU.idRol = RP.idRol AND RU.Activo = 1
			INNER JOIN bdRolMenu RM ON RP.Id = RM.idRol AND RM.Activo = 1
			INNER JOIN bdMenu M ON RM.idMenu = M.Id 
			WHERE  RU.idUsuario = @Usuario

		OPEN UsuarioMenu
		FETCH NEXT FROM UsuarioMenu INTO @idMenu, @idMenuPadre, @Nombre, @Vista, @Orden, @Image
		WHILE @@fetch_status = 0
		BEGIN
			IF ( @idMenuPadre is null)
			BEGIN			
				SELECT @exite = Id from ##TablaTemporal where Id = @idMenu
				IF (@exite IS NULL)
				BEGIN
					INSERT INTO ##TablaTemporal VALUES (@idMenu, @Nombre, @Vista, @Orden, null, @Image)			
					SELECT @OrdenPadre = Orden FROM bdMenu WHERE Id = @idMenu
				END
				INSERT INTO ##TablaTemporal
				SELECT M.id, M.Nombre, M.Vista, @OrdenPadre, M.Orden, M.Imagen FROM bdMenu M WHERE M.idMenu = @idMenu
			END
			ELSE
			BEGIN
				SELECT @exite = Id from ##TablaTemporal where Id = @idMenuPadre
				IF (@exite IS NULL)
				BEGIN	
					INSERT INTO ##TablaTemporal
					SELECT Id, Nombre, Vista, Orden, null, Imagen FROM bdMenu WHERE Id = @idMenuPadre

					SELECT @OrdenPadre = Orden FROM bdMenu WHERE Id = @idMenuPadre
				END

				SET @exite = NULL
				SELECT @exite = Id from ##TablaTemporal where Id = @idMenu
				IF (@exite IS NULL)
					INSERT INTO ##TablaTemporal VALUES (@idMenu, @Nombre, @Vista, @OrdenPadre, @Orden, @Image)
			END	
			FETCH NEXT FROM UsuarioMenu INTO  @idMenu, @idMenuPadre, @Nombre, @Vista, @Orden, @Image
		END

		CLOSE UsuarioMenu
		DEALLOCATE UsuarioMenu

		SELECT * FROM ##TablaTemporal ORDER BY Orden, SubOrden
		DROP TABLE ##TablaTemporal
	END
END


GO
/****** Object:  UserDefinedFunction [SEG].[fJsonBIT]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [SEG].[fJsonBIT] (@NombreIn VARCHAR(100), @EstadoIn BIT)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @estado VARCHAR(50)	
	SET @estado = '"' + @NombreIn + '":"'

	IF (@EstadoIn IS NOT NULL)
		BEGIN
			SET @estado = @estado + CONVERT(VARCHAR, @EstadoIn)
		END
    RETURN @estado + '"'
END

GO
/****** Object:  UserDefinedFunction [SEG].[fJsonDATE]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [SEG].[fJsonDATE] (@NombreIn VARCHAR(100), @FechaIn DATETIME)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @fecha VARCHAR(50)	
	SET @fecha ='"' + @NombreIn + '":"'

	IF (@FechaIn IS NOT NULL)
		BEGIN
			SET @fecha = @fecha + CONVERT(VARCHAR, @FechaIn, 9)
		END
    RETURN @fecha + '"'
END

GO
/****** Object:  UserDefinedFunction [SEG].[fJsonINT]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [SEG].[fJsonINT] (@NombreIn VARCHAR(100), @NumeroIn INT)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @numero VARCHAR(50)	
	SET @numero = '"' + @NombreIn + '":"'

	IF (@NumeroIn IS NOT NULL)
		BEGIN
			SET @numero = @numero + CONVERT(VARCHAR, @NumeroIn)
		END
    RETURN @numero + '"'
END

GO
/****** Object:  UserDefinedFunction [SEG].[fJsonTINY]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [SEG].[fJsonTINY] (@NombreIn VARCHAR(100), @NumeroIn TINYINT)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @numero VARCHAR(50)	
	SET @numero = '"' + @NombreIn + '":"'

	IF (@NumeroIn IS NOT NULL)
		BEGIN
			SET @numero = @numero + CONVERT(VARCHAR, @NumeroIn)
		END
    RETURN @numero + '"'
END


GO
/****** Object:  UserDefinedFunction [SEG].[fJsonVAR]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [SEG].[fJsonVAR] (@NombreIn VARCHAR(100), @CampoIn VARCHAR(MAX))
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @campo VARCHAR(50)	
	SET @campo = '"' + @NombreIn + '":"'

	IF (@CampoIn IS NOT NULL)
		BEGIN
			SET @campo = @campo + CONVERT(VARCHAR, @CampoIn)
		END
    RETURN @campo + '"'
END


GO
/****** Object:  UserDefinedFunction [SEG].[fParseJSON]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [SEG].[fParseJSON]( @JSON NVARCHAR(MAX))

RETURNS @hierarchy TABLE
  (
   element_id INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
   sequenceNo [int] NULL, /* the place in the sequence for the element */
   parent_ID INT,/* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
   Object_ID INT,/* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
   NAME NVARCHAR(2000),/* the name of the object */
   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
  )
AS
BEGIN
  DECLARE
    @FirstObject INT, --the index of the first open bracket found in the JSON string
    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
    @Type NVARCHAR(10),--whether it denotes an object or an array
    @NextCloseDelimiterChar CHAR(1),--either a '}' or a ']'
    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
    @Start INT, --index of the start of the token that you are parsing
    @end INT,--index of the end of the token that you are parsing
    @param INT,--the parameter at the end of the next Object/Array token
    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
    @token NVARCHAR(200),--either a string or object
    @value NVARCHAR(MAX), -- the value as a string
    @SequenceNo int, -- the sequence number within a list
    @name NVARCHAR(200), --the name as a string
    @parent_ID INT,--the next parent ID to allocate
    @lenJSON INT,--the current length of the JSON String
    @characters NCHAR(36),--used to convert hex to decimal
    @result BIGINT,--the value of the hex symbol being parsed
    @index SMALLINT,--used for parsing the hex value
    @Escape INT --the index of the next escape character
   
 
  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the names of the elements, since they are 'escaped' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
    (
     String_ID INT IDENTITY(1, 1),
     StringValue NVARCHAR(MAX)
    )
  SELECT--initialise the characters to convert hex to ascii
    @characters='0123456789abcdefghijklmnopqrstuvwxyz',
    @SequenceNo=0, --set the sequence no. to something sensible.
  /* firstly we process all strings. This is done because [{} and ] aren't escaped in strings, which complicates an iterative parse. */
    @parent_ID=0;
  WHILE 1=1 --forever until there is nothing more to do
    BEGIN
      SELECT
        @start=PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
      IF @start=0 BREAK --no more so drop through the WHILE loop
      IF SUBSTRING(@json, @start+1, 1)='"'
        BEGIN --Delimited Name
          SET @start=@Start+1;
          SET @end=PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
        END
      IF @end=0 --no end delimiter to last string
        BREAK --no more
      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
      --now put in the escaped control characters
      SELECT @token=REPLACE(@token, FROMString, TOString)
      FROM
        (SELECT
          '\"' AS FromString, '"' AS ToString
         UNION ALL SELECT '\\', '\'
         UNION ALL SELECT '\/', '/'
         UNION ALL SELECT '\b', CHAR(08)
         UNION ALL SELECT '\f', CHAR(12)
         UNION ALL SELECT '\n', CHAR(10)
         UNION ALL SELECT '\r', CHAR(13)
         UNION ALL SELECT '\t', CHAR(09)
        ) substitutions
      SELECT @result=0, @escape=1
  --Begin to take out any hex escape codes
      WHILE @escape>0
        BEGIN
          SELECT @index=0,
          --find the next hex escape sequence
          @escape=PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
          IF @escape>0 --if there is one
            BEGIN
              WHILE @index<4 --there are always four digits to a \x sequence  
                BEGIN
                  SELECT --determine its value
                    @result=@result+POWER(16, @index)
                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
                                @characters)-1), @index=@index+1 ;
        
                END
                -- and replace the hex sequence by its unicode value
              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
            END
        END
      --now store the string away
      INSERT INTO @Strings (StringValue) SELECT @token
      -- and replace the string with a token
      SELECT @JSON=STUFF(@json, @start, @end+1,
                    '@string'+CONVERT(NVARCHAR(5), @@identity))
    END
  -- all strings are now removed. Now we find the first leaf. 
  WHILE 1=1  --forever until there is nothing more to do
  BEGIN
 
  SELECT @parent_ID=@parent_ID+1
  --find the first object or list by looking for the open bracket
  SELECT @FirstObject=PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)--object or array
  IF @FirstObject = 0 BREAK
  IF (SUBSTRING(@json, @FirstObject, 1)='{')
    SELECT @NextCloseDelimiterChar='}', @type='object'
  ELSE
    SELECT @NextCloseDelimiterChar=']', @type='array'
  SELECT @OpenDelimiter=@firstObject
 
  WHILE 1=1 --find the innermost object or list...
    BEGIN
      SELECT
        @lenJSON=LEN(@JSON+'|')-1
  --find the matching close-delimiter proceeding after the open-delimiter
      SELECT
        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
                                      @OpenDelimiter+1)
  --is there an intervening open-delimiter of either type
      SELECT @NextOpenDelimiter=PATINDEX('%[{[[]%',
             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
      IF @NextOpenDelimiter=0
        BREAK
      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
      IF @NextCloseDelimiter<@NextOpenDelimiter
        BREAK
      IF SUBSTRING(@json, @NextOpenDelimiter, 1)='{'
        SELECT @NextCloseDelimiterChar='}', @type='object'
      ELSE
        SELECT @NextCloseDelimiterChar=']', @type='array'
      SELECT @OpenDelimiter=@NextOpenDelimiter
    END
  ---and parse out the list or name/value pairs
  SELECT
    @contents=SUBSTRING(@json, @OpenDelimiter+1,
                        @NextCloseDelimiter-@OpenDelimiter-1)
  SELECT
    @JSON=STUFF(@json, @OpenDelimiter,
                @NextCloseDelimiter-@OpenDelimiter+1,
                '@'+@type+CONVERT(NVARCHAR(5), @parent_ID))
  WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin))<>0
    BEGIN
      IF @Type='Object' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
        BEGIN
          SELECT
            @SequenceNo=0,@end=CHARINDEX(':', ' '+@contents)--if there is anything, it will be a string-based name.
          SELECT  @start=PATINDEX('%[^A-Za-z@][@]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
          SELECT @token=SUBSTRING(' '+@contents, @start+1, @End-@Start-1),
            @endofname=PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
            @param=RIGHT(@token, LEN(@token)-@endofname+1)
          SELECT
            @token=LEFT(@token, @endofname-1),
            @Contents=RIGHT(' '+@contents, LEN(' '+@contents+'|')-@end-1)
          SELECT  @name=stringvalue FROM @strings
            WHERE string_id=@param --fetch the name
        END
      ELSE
        SELECT @Name=null,@SequenceNo=@SequenceNo+1
      SELECT
        @end=CHARINDEX(',', @contents)-- a string-token, object-token, list-token, number,boolean, or null
      IF @end=0
        SELECT  @end=PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @Contents+' ' collate SQL_Latin1_General_CP850_Bin)
          +1
       SELECT
         @start=PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e][\-]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)
		-- Edited: add more condition [\-] in order to detect negative number 08-20-2014
      --select @start,@end, LEN(@contents+'|'), @contents 
      SELECT
        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
        @Contents=RIGHT(@contents+' ', LEN(@contents+'|')-@end)

      IF SUBSTRING(@value, 1, 7)='@object'
        INSERT INTO @hierarchy
          (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
          SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 8, 5),
            SUBSTRING(@value, 8, 5), 'object'
      ELSE
        IF SUBSTRING(@value, 1, 6)='@array'
          INSERT INTO @hierarchy
            (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
            SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 7, 5),
              SUBSTRING(@value, 7, 5), 'array'
        ELSE
          IF SUBSTRING(@value, 1, 7)='@string'
            INSERT INTO @hierarchy
              (NAME, SequenceNo, parent_ID, StringValue, ValueType)
              SELECT @name, @SequenceNo, @parent_ID, stringvalue, 'string'
              FROM @strings
              WHERE string_id=SUBSTRING(@value, 8, 5)
          ELSE
            IF @value IN ('true', 'false')
              INSERT INTO @hierarchy
                (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                SELECT @name, @SequenceNo, @parent_ID, @value, 'boolean'
            ELSE
              IF @value='null'
                INSERT INTO @hierarchy
                  (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                  SELECT @name, @SequenceNo, @parent_ID, @value, ''
              ELSE
                IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0
                  INSERT INTO @hierarchy
                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                    SELECT @name, @SequenceNo, @parent_ID, @value, 'real'
                ELSE
                  INSERT INTO @hierarchy
                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                    SELECT @name, @SequenceNo, @parent_ID, @value, 'int'
      if @Contents=' ' Select @SequenceNo=0
    END
  END
INSERT INTO @hierarchy (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
  SELECT '-',1, NULL, '', @parent_id-1, @type
--
   RETURN
END





GO
/****** Object:  Table [SAF].[bdAgente]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdAgente](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdAgentes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdBodega]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdBodega](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL,
	[idProveedor] [smallint] NULL,
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
/****** Object:  Table [SAF].[bdCiudad]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdCiudad](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdCiudades] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdCliente]    Script Date: 19/01/2021 11:50:00 p.m. ******/
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
/****** Object:  Table [SAF].[bdConductor]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdConductor](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NOT NULL,
	[Placa] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdConductores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdContrato]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdContrato](
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
/****** Object:  Table [SAF].[bdCorte]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdCorte](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idRemision] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdCorteDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdCorteDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCorte] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdCorteOrdenServicio]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdCorteOrdenServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[bdCorte] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdCorteOrdenServicioDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdCorteOrdenServicioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idCorteOrdenServicio] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdDevolucion]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdDevolucion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idProyecto] [smallint] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[idConductor] [smallint] NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[ValorTransporte] [numeric](8, 0) NULL,
	[PesoEquipo] [numeric](6, 2) NULL,
	[ValorEquipo] [numeric](10, 0) NULL,
	[EntregaCliente] [bit] NULL,
	[EntregaParcial] [bit] NULL,
	[Estado] [varchar](10) NULL,
 CONSTRAINT [PK_bdDevolucion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdDevolucionDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdDevolucionDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdDevolucionDetalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdDevolucionServicio]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdDevolucionServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idProveedor] [smallint] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdDevolucionServicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdDevolucionServicioDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdDevolucionServicioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDevolucionServicio] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdDocumento]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdDocumento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Descripcion] [varchar](1000) NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdMovimientos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdDocumentoDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdDocumentoDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[idDocumento] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bd] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdDocumentoTipo]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdDocumentoTipo](
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
/****** Object:  Table [SAF].[bdElemento]    Script Date: 19/01/2021 11:50:00 p.m. ******/
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
/****** Object:  Table [SAF].[bdGrupoElemento]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdGrupoElemento](
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
/****** Object:  Table [SAF].[bdListaPrecio]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdListaPrecio](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdListasPrecios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdListaPrecioDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdListaPrecioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idListaPrecio] [tinyint] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[PrecioAlquiler] [int] NOT NULL CONSTRAINT [DF_bdListaPrecioDetalle_PrecioAlquiler]  DEFAULT ((0)),
	[PrecioVenta] [int] NOT NULL CONSTRAINT [DF_bdListaPrecioDetalle_PrecioVenta]  DEFAULT ((0)),
	[PrecioPerdida] [int] NOT NULL CONSTRAINT [DF_bdListaPrecioDetalle_PrecioPerdida]  DEFAULT ((0)),
 CONSTRAINT [PK_bdDetallesListasPrecios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdMantenimiento]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdMantenimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdMantenimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdMantenimientoDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdMantenimientoDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idReposicion] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[TipoMantenimiento] [varchar](5) NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdOrdenServicio]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdOrdenServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idRemision] [int] NOT NULL,
	[idProveedor] [smallint] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdOrdenServicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdOrdenServicioDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdOrdenServicioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idOrdenServicio] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdProveedor]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdProveedor](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Identificacion] [varchar](20) NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Iniciales] [varchar](10) NOT NULL,
	[Telefono] [varchar](100) NULL,
	[Direccion] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdProveedores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdProyecto]    Script Date: 19/01/2021 11:50:00 p.m. ******/
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
/****** Object:  Table [SAF].[bdRemision]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdRemision](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idProyecto] [smallint] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[idConductor] [smallint] NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Transporte] [bit] NULL,
	[ValorTransporte] [numeric](8, 0) NULL,
	[Despachado] [bit] NULL,
	[EquipoAdecuado] [bit] NULL,
	[PesoEquipo] [numeric](6, 2) NULL,
	[ValorEquipo] [numeric](10, 0) NULL,
	[Estado] [varchar](10) NULL,
 CONSTRAINT [PK_bdRemision] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdRemisionDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdRemisionDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRemision] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdRemisionDetalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdReposicion]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdReposicion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idDevolucion] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdReposicion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdReposicionDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdReposicionDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idReposicion] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdReposicionServicio]    Script Date: 19/01/2021 11:50:00 p.m. ******/
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
/****** Object:  Table [SAF].[bdReposicionServicioDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdReposicionServicioDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idReposicion] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [SAF].[bdUnidadMedida]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdUnidadMedida](
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
/****** Object:  Table [SAF].[bdVenta]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SAF].[bdVenta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idBodegaOrigen] [int] NOT NULL,
	[idBodegaDestino] [int] NOT NULL,
	[idRemision] [int] NOT NULL,
	[idDocumentoTipo] [tinyint] NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[Estado] [varchar](5) NOT NULL,
 CONSTRAINT [PK_bdVenta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SAF].[bdVentaDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SAF].[bdVentaDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idVenta] [int] NOT NULL,
	[idElemento] [smallint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_bdVentaDetalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [SEG].[bdArtefacto]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdArtefacto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idSistema] [tinyint] NOT NULL,
	[Tipo] [varchar](10) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_bdArtefacto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdArtefactoHistorial]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdArtefactoHistorial](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[idArtefacto] [int] NOT NULL,
	[idRequerimiento] [int] NOT NULL,
	[Objetivo] [varchar](max) NOT NULL,
	[Version] [varchar](10) NULL,
 CONSTRAINT [PK_bdArtefactoHistorial] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdAuditoria]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdAuditoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idSesion] [bigint] NOT NULL,
	[Tabla] [varchar](50) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Operacion] [varchar](50) NOT NULL,
	[Observacion] [varchar](500) NULL,
	[Detalle] [varchar](max) NOT NULL,
 CONSTRAINT [PK_bdAuditoria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdCatalogo]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [SEG].[bdCatalogo](
	[Id] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_bdCatalogo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdCatalogoDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
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
/****** Object:  Table [SEG].[bdMenu]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdMenu](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idMenu] [smallint] NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Vista] [varchar](100) NULL,
	[Orden] [smallint] NOT NULL,
	[Imagen] [varchar](100) NULL,
	[Activo] [bit] NOT NULL CONSTRAINT [DF_bdMenu_Activo]  DEFAULT ((0)),
 CONSTRAINT [PK_bdMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdParametro]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdParametro](
	[Codigo] [varchar](20) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](500) NULL,
	[Valor] [varchar](200) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_ParametroSistema] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdRequerimiento]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdRequerimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[Estado] [varchar](5) NOT NULL CONSTRAINT [DF_bdRequerimiento_Estado]  DEFAULT ('I'),
 CONSTRAINT [PK_bdRequerimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdRol]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdRol](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdRolMenu]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdRolMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NOT NULL,
	[idMenu] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRolMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdRolUsuario]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdRolUsuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRolUsuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdSesion]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdSesion](
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
/****** Object:  Table [SEG].[bdSistema]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdSistema](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](10) NOT NULL,
	[Version] [varchar](20) NOT NULL,
 CONSTRAINT [PK_bdSistema] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdUsuario]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdUsuario](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NULL,
	[Identificacion] [varchar](50) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Apellido] [varchar](100) NOT NULL,
	[Usuario] [varchar](15) NOT NULL,
	[Clave] [varchar](50) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
	[Admin] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SEG].[bdUsuarioMenu]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SEG].[bdUsuarioMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[idMenu] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdUsuarioMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [SAF].[vBodega]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SAF].[vBodega]
AS
SELECT     B.Id, B.idCliente, B.idProveedor, B.Nombre, B.Activo, B.EsSistema, C.Nombre AS ClienteNombre, P.Nombre AS ProveedorNombre
FROM         SAF.bdBodega AS B LEFT OUTER JOIN
                      SAF.bdCliente AS C ON B.idCliente = C.Id LEFT OUTER JOIN
                      SAF.bdProveedor AS P ON B.idProveedor = P.Id

GO
/****** Object:  View [SAF].[vCliente]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SAF].[vCliente]
AS
SELECT C.Id, C.idCiudad, C.Identificacion, C.Nombre1, C.Nombre2, C.Apellido1, C.Apellido2, C.Nombre, C.Direccion, C.Telefono, C.Celular, C.Correo, C.Activo, U.Nombre CiudadNombre
FROM bdCliente C
INNER JOIN bdCiudad U ON C.idCiudad = U.Id
GO
/****** Object:  View [SAF].[vContrato]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [SAF].[vContrato]
AS
SELECT C.Id, C.idProyecto, C.idListaPrecio, C.idAgente, C.InformacionBD, C.ContratoAlquiler, C.CartaPagare, C.Pagare, C.LetraCambio, C.GarantiasCondiciones 
     , C.Deposito, C.Anticipo, C.PersonaJuridica, C.PersonaNatural, C.FotoCopiaCedula, C.FotoCopiaNit, C.CamaraComercio, C.DescuentoAlquiler, C.DescuentoVenta
     , C.DescuentoReposicion, C.DescuentoMantenimiento, C.DescuentoTransporte, C.PorcentajeAgente, A.Nombre AgenteNombre, L.Nombre ListaPrecioNombre
FROM bdContrato AS C
INNER JOIN bdListaPrecio L ON C.idListaPrecio = L.Id
LEFT JOIN bdAgente AS A ON C.idAgente = A.Id


GO
/****** Object:  View [SAF].[vDocumento]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SAF].[vDocumento]
AS
SELECT     D.Id, D.idDocumentoTipo, D.idBodegaOrigen, D.idBodegaDestino, D.Numero, D.Fecha, D.Descripcion, D.Estado, TD.Nombre AS DocumentoTipoNombre, 
                      BO.Nombre AS BodegaOrigenNombre, BD.Nombre AS BodegaDestinoNombre
FROM         SAF.bdDocumento AS D INNER JOIN
                      SAF.bdDocumentoTipo AS TD ON D.idDocumentoTipo = TD.Id INNER JOIN
                      SAF.bdBodega AS BO ON D.idBodegaOrigen = BO.Id INNER JOIN
                      SAF.bdBodega AS BD ON D.idBodegaDestino = BD.Id

GO
/****** Object:  View [SAF].[vDocumentoDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SAF].[vDocumentoDetalle]
AS
SELECT     DD.Id, DD.idElemento, DD.idDocumento, D.Descripcion, D.idBodegaDestino, D.idBodegaOrigen, DD.Cantidad, E.Nombre AS ElementoNombre, 
                      BO.Nombre AS BodegaOrigenNombre, BD.Nombre AS BodegaDestinoNombre
FROM         SAF.bdDocumentoDetalle AS DD INNER JOIN
                      SAF.bdDocumento AS D ON DD.idDocumento = D.Id INNER JOIN
                      SAF.bdElemento AS E ON DD.idElemento = E.Id INNER JOIN
                      SAF.bdBodega AS BO ON D.idBodegaOrigen = BO.Id INNER JOIN
                      SAF.bdBodega AS BD ON D.idBodegaDestino = BD.Id

GO
/****** Object:  View [SAF].[vElemento]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SAF].[vElemento]
AS
SELECT  E.Id ,E.idGrupoElemento, E.idUnidadMedida, E.Referencia, E.Nombre, E.Mt2, E.Peso, E.Rotacion, E.Activo, GE.Nombre GrupoElementoNombre, U.Nombre UnidadMedidaNombre
FROM bdElemento E
INNER JOIN bdGrupoElemento GE ON E.idGrupoElemento = GE.Id
INNER JOIN bdUnidadMedida U ON E.idUnidadMedida = U.Id

GO
/****** Object:  View [SAF].[vListaPrecioDetalle]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SAF].[vListaPrecioDetalle]
AS
SELECT  LPD.Id, LPD.idListaPrecio, LPD.idElemento, LPD.PrecioAlquiler, LPD.PrecioVenta, LPD.PrecioPerdida, LP.Nombre ListaPrecioNombre, E.Nombre ElementoNombre
FROM bdListaPrecioDetalle LPD
INNER JOIN bdListaPrecio LP ON LPD.idListaPrecio = LP.Id
INNER JOIN bdElemento E ON LPD.idElemento = E.Id

GO
/****** Object:  View [SAF].[vProyecto]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SAF].[vProyecto]
AS
SELECT P.Id, P.idCliente, P.idCiudad, P.Nombre, P.Tipo, P.Direccion, P.Telefono, P.Observacion, P.Fecha, P.FormaContacto, P.SistemaMedida, P.IdentificacionResponsable, P.NombreResponsable, P.TelResponsable, P.Activo, P.Estado
	   ,U.Nombre CiudadNombre, C.Nombre ClienteNombre, CN.Id idContrato
FROM bdProyecto P
INNER JOIN bdCiudad U ON P.idCiudad = U.Id
INNER JOIN bdCliente C ON P.idCliente = C.Id
INNER JOIN bdContrato CN ON P.Id = CN.idProyecto


GO
/****** Object:  View [SEG].[vArtefactoRequerimiento]    Script Date: 19/01/2021 11:50:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SEG].[vArtefactoRequerimiento]
AS
SELECT     SEG.bdArtefacto.Id, SEG.bdArtefacto.Tipo, bdArtefactoTipo.Descripcion, SEG.bdArtefacto.Nombre, SEG.bdArtefacto.Estado AS ArtefactoEstado, 
                      bdArtefactoEstado.Descripcion AS ArtefactoEstadoDes, SEG.bdArtefacto.idSistema, SEG.bdArtefacto.Descripcion AS ArtefactoDescripcion, 
                      SEG.bdArtefactoHistorial.Objetivo, SEG.bdArtefactoHistorial.Version, SEG.bdArtefactoHistorial.idArtefacto, SEG.bdArtefactoHistorial.idRequerimiento, 
                      SEG.bdRequerimiento.Descripcion AS RequerimientoDescripcion, SEG.bdRequerimiento.Estado, bdRequerimientoEstado.Descripcion AS RequerimientoEstadoDes, 
                      SEG.bdSistema.Codigo, bdSistemaCodigo.Descripcion AS SistemaCodigoDes
FROM         SEG.bdCatalogoDetalle AS bdArtefactoTipo INNER JOIN
                      SEG.bdSistema INNER JOIN
                      SEG.bdArtefacto ON SEG.bdSistema.Id = SEG.bdArtefacto.idSistema ON bdArtefactoTipo.Codigo = SEG.bdArtefacto.Tipo INNER JOIN
                      SEG.bdCatalogoDetalle AS bdArtefactoEstado ON SEG.bdArtefacto.Estado = bdArtefactoEstado.Codigo INNER JOIN
                      SEG.bdCatalogoDetalle AS bdSistemaCodigo ON SEG.bdSistema.Codigo = bdSistemaCodigo.Codigo LEFT OUTER JOIN
                      SEG.bdArtefactoHistorial LEFT OUTER JOIN
                      SEG.bdRequerimiento INNER JOIN
                      SEG.bdCatalogoDetalle AS bdRequerimientoEstado ON SEG.bdRequerimiento.Estado = bdRequerimientoEstado.Codigo ON 
                      SEG.bdArtefactoHistorial.idRequerimiento = SEG.bdRequerimiento.Id ON SEG.bdArtefacto.Id = SEG.bdArtefactoHistorial.idArtefacto


GO
ALTER TABLE [SAF].[bdBodega]  WITH NOCHECK ADD  CONSTRAINT [FK_bdBodegaCliente] FOREIGN KEY([idCliente])
REFERENCES [SAF].[bdCliente] ([Id])
GO
ALTER TABLE [SAF].[bdBodega] NOCHECK CONSTRAINT [FK_bdBodegaCliente]
GO
ALTER TABLE [SAF].[bdBodega]  WITH NOCHECK ADD  CONSTRAINT [FK_bdBodegaProveedor] FOREIGN KEY([idProveedor])
REFERENCES [SAF].[bdProveedor] ([Id])
GO
ALTER TABLE [SAF].[bdBodega] NOCHECK CONSTRAINT [FK_bdBodegaProveedor]
GO
ALTER TABLE [SAF].[bdCliente]  WITH CHECK ADD  CONSTRAINT [FK_bdClienteCiudad] FOREIGN KEY([idCiudad])
REFERENCES [SAF].[bdCiudad] ([Id])
GO
ALTER TABLE [SAF].[bdCliente] CHECK CONSTRAINT [FK_bdClienteCiudad]
GO
ALTER TABLE [SAF].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoAgente] FOREIGN KEY([idAgente])
REFERENCES [SAF].[bdAgente] ([Id])
GO
ALTER TABLE [SAF].[bdContrato] CHECK CONSTRAINT [FK_bdContratoAgente]
GO
ALTER TABLE [SAF].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoListaPrecio] FOREIGN KEY([idListaPrecio])
REFERENCES [SAF].[bdListaPrecio] ([Id])
GO
ALTER TABLE [SAF].[bdContrato] CHECK CONSTRAINT [FK_bdContratoListaPrecio]
GO
ALTER TABLE [SAF].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoProyecto] FOREIGN KEY([idProyecto])
REFERENCES [SAF].[bdProyecto] ([Id])
GO
ALTER TABLE [SAF].[bdContrato] CHECK CONSTRAINT [FK_bdContratoProyecto]
GO
ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionBodegaDestino]
GO
ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionBodegaOrigen]
GO
ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionConductor] FOREIGN KEY([idConductor])
REFERENCES [SAF].[bdConductor] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionConductor]
GO
ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionDocumentoTipo]
GO
ALTER TABLE [SAF].[bdDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionProyecto] FOREIGN KEY([idProyecto])
REFERENCES [SAF].[bdProyecto] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucion] CHECK CONSTRAINT [FK_bdDevolucionProyecto]
GO
ALTER TABLE [SAF].[bdDevolucionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionDetalleDevolucion] FOREIGN KEY([idDevolucion])
REFERENCES [SAF].[bdDevolucion] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucionDetalle] CHECK CONSTRAINT [FK_bdDevolucionDetalleDevolucion]
GO
ALTER TABLE [SAF].[bdDevolucionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucionDetalle] CHECK CONSTRAINT [FK_bdDevolucionDetalleElemento]
GO
ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioBodegaDestino]
GO
ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioBodegaOrigen]
GO
ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioDevolucion] FOREIGN KEY([idDevolucion])
REFERENCES [SAF].[bdDevolucion] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioDevolucion]
GO
ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioDocumentoTipo]
GO
ALTER TABLE [SAF].[bdDevolucionServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdDevolucionServicioProveedor] FOREIGN KEY([idProveedor])
REFERENCES [SAF].[bdProveedor] ([Id])
GO
ALTER TABLE [SAF].[bdDevolucionServicio] CHECK CONSTRAINT [FK_bdDevolucionServicioProveedor]
GO
ALTER TABLE [SAF].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdDocumento] CHECK CONSTRAINT [FK_bdDocumentoBodegaDestino]
GO
ALTER TABLE [SAF].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdDocumento] CHECK CONSTRAINT [FK_bdDocumentoBodegaOrigen]
GO
ALTER TABLE [SAF].[bdDocumento]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO
ALTER TABLE [SAF].[bdDocumento] CHECK CONSTRAINT [FK_bdDocumentoTipo]
GO
ALTER TABLE [SAF].[bdDocumentoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumento] FOREIGN KEY([idDocumento])
REFERENCES [SAF].[bdDocumento] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [SAF].[bdDocumentoDetalle] CHECK CONSTRAINT [FK_bdDocumento]
GO
ALTER TABLE [SAF].[bdDocumentoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdDocumentoDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO
ALTER TABLE [SAF].[bdDocumentoDetalle] CHECK CONSTRAINT [FK_bdDocumentoDetalleElemento]
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
ALTER TABLE [SAF].[bdListaPrecioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdListaPrecioDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO
ALTER TABLE [SAF].[bdListaPrecioDetalle] CHECK CONSTRAINT [FK_bdListaPrecioDetalleElemento]
GO
ALTER TABLE [SAF].[bdListaPrecioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdListaPrecioDetalleListaPrecio] FOREIGN KEY([idListaPrecio])
REFERENCES [SAF].[bdListaPrecio] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [SAF].[bdListaPrecioDetalle] CHECK CONSTRAINT [FK_bdListaPrecioDetalleListaPrecio]
GO
ALTER TABLE [SAF].[bdMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdMantenimientoBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdMantenimiento] CHECK CONSTRAINT [FK_bdMantenimientoBodegaDestino]
GO
ALTER TABLE [SAF].[bdMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdMantenimientoBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdMantenimiento] CHECK CONSTRAINT [FK_bdMantenimientoBodegaOrigen]
GO
ALTER TABLE [SAF].[bdMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdMantenimientoDevolucion] FOREIGN KEY([idDevolucion])
REFERENCES [SAF].[bdDevolucion] ([Id])
GO
ALTER TABLE [SAF].[bdMantenimiento] CHECK CONSTRAINT [FK_bdMantenimientoDevolucion]
GO
ALTER TABLE [SAF].[bdMantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_bdMantenimientoDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO
ALTER TABLE [SAF].[bdMantenimiento] CHECK CONSTRAINT [FK_bdMantenimientoDocumentoTipo]
GO
ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioBodegaDestino]
GO
ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioBodegaOrigen]
GO
ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO
ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioDocumentoTipo]
GO
ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioProveedor] FOREIGN KEY([idProveedor])
REFERENCES [SAF].[bdProveedor] ([Id])
GO
ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioProveedor]
GO
ALTER TABLE [SAF].[bdOrdenServicio]  WITH CHECK ADD  CONSTRAINT [FK_bdOrdenServicioRemision] FOREIGN KEY([idRemision])
REFERENCES [SAF].[bdRemision] ([Id])
GO
ALTER TABLE [SAF].[bdOrdenServicio] CHECK CONSTRAINT [FK_bdOrdenServicioRemision]
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
ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionBodegaDestino]
GO
ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionBodegaOrigen]
GO
ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionConductor] FOREIGN KEY([idConductor])
REFERENCES [SAF].[bdConductor] ([Id])
GO
ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionConductor]
GO
ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO
ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionDocumentoTipo]
GO
ALTER TABLE [SAF].[bdRemision]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionProyecto] FOREIGN KEY([idProyecto])
REFERENCES [SAF].[bdProyecto] ([Id])
GO
ALTER TABLE [SAF].[bdRemision] CHECK CONSTRAINT [FK_bdRemisionProyecto]
GO
ALTER TABLE [SAF].[bdRemisionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO
ALTER TABLE [SAF].[bdRemisionDetalle] CHECK CONSTRAINT [FK_bdRemisionDetalleElemento]
GO
ALTER TABLE [SAF].[bdRemisionDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdRemisionDetalleRemision] FOREIGN KEY([idRemision])
REFERENCES [SAF].[bdRemision] ([Id])
GO
ALTER TABLE [SAF].[bdRemisionDetalle] CHECK CONSTRAINT [FK_bdRemisionDetalleRemision]
GO
ALTER TABLE [SAF].[bdReposicion]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdReposicion] CHECK CONSTRAINT [FK_bdReposicionBodegaDestino]
GO
ALTER TABLE [SAF].[bdReposicion]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdReposicion] CHECK CONSTRAINT [FK_bdReposicionBodegaOrigen]
GO
ALTER TABLE [SAF].[bdReposicion]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionDevolucion] FOREIGN KEY([idDevolucion])
REFERENCES [SAF].[bdDevolucion] ([Id])
GO
ALTER TABLE [SAF].[bdReposicion] CHECK CONSTRAINT [FK_bdReposicionDevolucion]
GO
ALTER TABLE [SAF].[bdReposicion]  WITH CHECK ADD  CONSTRAINT [FK_bdReposicionDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO
ALTER TABLE [SAF].[bdReposicion] CHECK CONSTRAINT [FK_bdReposicionDocumentoTipo]
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
ALTER TABLE [SAF].[bdVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaBodegaDestino] FOREIGN KEY([idBodegaDestino])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdVenta] CHECK CONSTRAINT [FK_bdVentaBodegaDestino]
GO
ALTER TABLE [SAF].[bdVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaBodegaOrigen] FOREIGN KEY([idBodegaOrigen])
REFERENCES [SAF].[bdBodega] ([Id])
GO
ALTER TABLE [SAF].[bdVenta] CHECK CONSTRAINT [FK_bdVentaBodegaOrigen]
GO
ALTER TABLE [SAF].[bdVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaDocumentoTipo] FOREIGN KEY([idDocumentoTipo])
REFERENCES [SAF].[bdDocumentoTipo] ([Id])
GO
ALTER TABLE [SAF].[bdVenta] CHECK CONSTRAINT [FK_bdVentaDocumentoTipo]
GO
ALTER TABLE [SAF].[bdVenta]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaRemision] FOREIGN KEY([idRemision])
REFERENCES [SAF].[bdRemision] ([Id])
GO
ALTER TABLE [SAF].[bdVenta] CHECK CONSTRAINT [FK_bdVentaRemision]
GO
ALTER TABLE [SAF].[bdVentaDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [SAF].[bdElemento] ([Id])
GO
ALTER TABLE [SAF].[bdVentaDetalle] CHECK CONSTRAINT [FK_bdVentaDetalleElemento]
GO
ALTER TABLE [SAF].[bdVentaDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdVentaDetalleVenta] FOREIGN KEY([idVenta])
REFERENCES [SAF].[bdVenta] ([Id])
GO
ALTER TABLE [SAF].[bdVentaDetalle] CHECK CONSTRAINT [FK_bdVentaDetalleVenta]
GO
ALTER TABLE [SEG].[bdArtefacto]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoSistema] FOREIGN KEY([idSistema])
REFERENCES [SEG].[bdSistema] ([Id])
GO
ALTER TABLE [SEG].[bdArtefacto] CHECK CONSTRAINT [FK_bdArtefactoSistema]
GO
ALTER TABLE [SEG].[bdArtefactoHistorial]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoHistorialArtefacto] FOREIGN KEY([idArtefacto])
REFERENCES [SEG].[bdArtefacto] ([Id])
GO
ALTER TABLE [SEG].[bdArtefactoHistorial] CHECK CONSTRAINT [FK_bdArtefactoHistorialArtefacto]
GO
ALTER TABLE [SEG].[bdCatalogoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdCatalogoDetalle_bdCatalogo] FOREIGN KEY([idCatalogo])
REFERENCES [SEG].[bdCatalogo] ([Id])
GO
ALTER TABLE [SEG].[bdCatalogoDetalle] CHECK CONSTRAINT [FK_bdCatalogoDetalle_bdCatalogo]
GO
ALTER TABLE [SEG].[bdMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdMenuPadre] FOREIGN KEY([idMenu])
REFERENCES [SEG].[bdMenu] ([Id])
GO
ALTER TABLE [SEG].[bdMenu] CHECK CONSTRAINT [FK_bdMenuPadre]
GO
ALTER TABLE [SEG].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [SEG].[bdMenu] ([Id])
GO
ALTER TABLE [SEG].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Menu]
GO
ALTER TABLE [SEG].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Rol] FOREIGN KEY([idRol])
REFERENCES [SEG].[bdRol] ([Id])
GO
ALTER TABLE [SEG].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Rol]
GO
ALTER TABLE [SEG].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRol] FOREIGN KEY([idRol])
REFERENCES [SEG].[bdRol] ([Id])
GO
ALTER TABLE [SEG].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRol]
GO
ALTER TABLE [SEG].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRolUsuario] FOREIGN KEY([Id])
REFERENCES [SEG].[bdRolUsuario] ([Id])
GO
ALTER TABLE [SEG].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRolUsuario]
GO
ALTER TABLE [SEG].[bdSesion]  WITH CHECK ADD  CONSTRAINT [FK_bdSesionUsuario] FOREIGN KEY([idUsuario])
REFERENCES [SEG].[bdUsuario] ([Id])
GO
ALTER TABLE [SEG].[bdSesion] CHECK CONSTRAINT [FK_bdSesionUsuario]
GO
ALTER TABLE [SEG].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [SEG].[bdMenu] ([Id])
GO
ALTER TABLE [SEG].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Menu]
GO
ALTER TABLE [SEG].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Usuario] FOREIGN KEY([Id])
REFERENCES [SEG].[bdUsuarioMenu] ([Id])
GO
ALTER TABLE [SEG].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Usuario]
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pAgente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pConductor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pContrato'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pDocumentoTipo'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pGrupoElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pListaPrecio'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pListaPrecioDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pProveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pProyecto'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pTipoMantenimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'PROCEDURE',@level1name=N'pUnidadMedida'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'PROCEDURE',@level1name=N'pParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdAgente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdConductor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdContrato'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdDocumentoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdDocumentoTipo'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdGrupoElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdListaPrecio'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdListaPrecioDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdProveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdProyecto'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'TABLE',@level1name=N'bdUnidadMedida'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'TABLE',@level1name=N'bdParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 115
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 5
               Left = 481
               Bottom = 114
               Right = 632
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "P"
            Begin Extent = 
               Top = 135
               Left = 451
               Bottom = 244
               Right = 602
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vContrato'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[15] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 115
               Right = 200
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TD"
            Begin Extent = 
               Top = 6
               Left = 238
               Bottom = 115
               Right = 389
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BO"
            Begin Extent = 
               Top = 6
               Left = 427
               Bottom = 115
               Right = 578
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BD"
            Begin Extent = 
               Top = 6
               Left = 616
               Bottom = 115
               Right = 767
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 115
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 115
               Right = 389
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "E"
            Begin Extent = 
               Top = 6
               Left = 427
               Bottom = 115
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BO"
            Begin Extent = 
               Top = 6
               Left = 626
               Bottom = 115
               Right = 777
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BD"
            Begin Extent = 
               Top = 6
               Left = 815
               Bottom = 115
               Right = 966
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vDocumentoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vDocumentoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vDocumentoDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vListaPrecioDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'SAF', @level1type=N'VIEW',@level1name=N'vProyecto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[27] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[46] 4[29] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[45] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "bdArtefactoHistorial"
            Begin Extent = 
               Top = 0
               Left = 230
               Bottom = 127
               Right = 387
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdRequerimiento"
            Begin Extent = 
               Top = 4
               Left = 472
               Bottom = 98
               Right = 623
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdRequerimientoEstado"
            Begin Extent = 
               Top = 17
               Left = 674
               Bottom = 160
               Right = 825
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "bdArtefactoTipo"
            Begin Extent = 
               Top = 244
               Left = 415
               Bottom = 353
               Right = 566
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdSistema"
            Begin Extent = 
               Top = 137
               Left = 288
               Bottom = 231
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdArtefacto"
            Begin Extent = 
               Top = 167
               Left = 28
               Bottom = 319
               Right = 182
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "bdArtefactoEstado"
            Begin Extent = 
               Top = 310
               Left = 239
               Bottom = 465
               Rig' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ht = 390
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdSistemaCodigo"
            Begin Extent = 
               Top = 178
               Left = 730
               Bottom = 287
               Right = 881
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 17
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 3795
         Alias = 2265
         Table = 3075
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'SEG', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO
