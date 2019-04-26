USE [SAF]
GO
/****** Object:  StoredProcedure [dbo].[pAgente]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pAgente]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Agente ON A.Id = Agente.Id
		END
END


--GO

--EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pAgente'
--GO
GO
/****** Object:  StoredProcedure [dbo].[pBodega]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pBodega]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Bodega ON A.Id = Bodega.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pCiudad]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pCiudad]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Ciudad ON A.Id = Ciudad.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pCliente]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pCliente]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Cliente ON C.Id = Cliente.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pConductor]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pConductor]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Conductor ON A.Id = Conductor.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pContrato]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pContrato]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
/****** Object:  StoredProcedure [dbo].[pElemento]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pElemento]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Elemento ON E.Id = Elemento.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pGrupoElemento]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pGrupoElemento]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS GrupoElemento ON A.Id = GrupoElemento.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pListaPrecio]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pListaPrecio]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
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
						FROM SAFseg.dbo.fParseJSON
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
						FROM SAFseg.dbo.fParseJSON
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
					FROM SAFseg.dbo.fParseJSON
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
				FROM SAFseg.dbo.fParseJSON
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
/****** Object:  StoredProcedure [dbo].[pListaPrecioDetalle]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pListaPrecioDetalle]  
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
				FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS ListaPrecioDetalle ON A.Id = ListaPrecioDetalle.Id
		END
END




GO
/****** Object:  StoredProcedure [dbo].[pParametro]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pParametro]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS ListaPrecio ON A.Codigo = ListaPrecio.Codigo
		END
END





GO
/****** Object:  StoredProcedure [dbo].[pProveedor]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pProveedor]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
			(@json)
			) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END
END





GO
/****** Object:  StoredProcedure [dbo].[pProyecto]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pProyecto]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Proyecto ON P.Id = Proyecto.Id
		END
END



GO
/****** Object:  StoredProcedure [dbo].[pTipoDocumento]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pTipoDocumento]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdTipoDocumento

	IF (@Accion = 1)
		SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdTipoDocumento WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Consecutivo,  Operacion, EsSistema, Activo FROM bdTipoDocumento
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdTipoDocumento 
			SELECT * FROM (SELECT					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Consecutivo' THEN convert(BIGINT,StringValue) ELSE 0 END) AS Consecutivo,
					max(CASE WHEN name='Operacion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Operacion,
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS EsSistema,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean' OR ValueType = 'int'
			GROUP BY parent_ID) TipoDocumento
		END
	
	IF(@Accion = 4)
		BEGIN
			UPDATE A
			SET Nombre = TipoDocumento.Nombre,
				Consecutivo = TipoDocumento.Consecutivo,
				Operacion = TipoDocumento.Operacion,
				EsSistema = TipoDocumento.EsSistema,
				Activo = TipoDocumento.Activo
			FROM bdTipoDocumento AS A
			INNER JOIN 
			(SELECT
					max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS Id,					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Nombre,
					max(CASE WHEN name='Consecutivo' THEN convert(BIGINT,StringValue) ELSE 0 END) AS Consecutivo,
					max(CASE WHEN name='Operacion' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS Operacion,
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS EsSistema,
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS Activo
			FROM SAFseg.dbo.fParseJSON
			(@json)
			) AS TipoDocumento ON A.Id = TipoDocumento.Id
		END
	
	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM bdTipoDocumento AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS Id
			FROM SAFseg.dbo.fParseJSON
			(@json)
			) AS ListaPrecio ON A.Id = ListaPrecio.Id
		END
END


GO
/****** Object:  StoredProcedure [dbo].[pTipoMantenimiento]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pTipoMantenimiento]  
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
/****** Object:  StoredProcedure [dbo].[pUnidadMedida]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pUnidadMedida]  
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			FROM SAFseg.dbo.fParseJSON
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
			From SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS UnidadMedida ON A.Id = UnidadMedida.Id
		END
END




GO
/****** Object:  Table [dbo].[bdAgente]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdBodega]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  Table [dbo].[bdCiudad]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdCliente]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  Table [dbo].[bdConductor]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdConductor](
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
/****** Object:  Table [dbo].[bdContrato]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  Table [dbo].[bdElemento]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  Table [dbo].[bdGrupoElemento]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  Table [dbo].[bdListaPrecio]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdListaPrecioDetalle]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bdListaPrecioDetalle](
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
/****** Object:  Table [dbo].[bdParametro]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdParametro](
	[Codigo] [varchar](10) NOT NULL,
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
/****** Object:  Table [dbo].[bdProveedor]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  Table [dbo].[bdProyecto]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  Table [dbo].[bdTipoDocumento]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  Table [dbo].[bdTipoMantenimiento]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  Table [dbo].[bdUnidadMedida]    Script Date: 25/04/2019 06:40:01 p.m. ******/
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
/****** Object:  View [dbo].[vBodega]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vBodega]
AS
SELECT B.Id, B.idCliente, B.idProveedor, B.Nombre, B.Activo, B.EsSistema,C.Nombre ClienteNombre, P.Nombre ProveedorNombre
FROM bdBodega B
INNER JOIN bdCliente C ON B.idCliente = C.Id
INNER JOIN bdProveedor P ON B.idProveedor = P.Id


GO
/****** Object:  View [dbo].[vCliente]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCliente]
AS
SELECT C.Id, C.idCiudad, C.Identificacion, C.Nombre1, C.Nombre2, C.Apellido1, C.Apellido2, C.Nombre, C.Direccion, C.Telefono, C.Celular, C.Correo, C.Activo, U.Nombre CiudadNombre
FROM bdCliente C
INNER JOIN bdCiudad U ON C.idCiudad = U.Id
GO
/****** Object:  View [dbo].[vContrato]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vContrato]
AS
SELECT C.Id, C.idProyecto, C.idListaPrecio, C.idAgente, C.InformacionBD, C.ContratoAlquiler, C.CartaPagare, C.Pagare, C.LetraCambio, C.GarantiasCondiciones 
     , C.Deposito, C.Anticipo, C.PersonaJuridica, C.PersonaNatural, C.FotoCopiaCedula, C.FotoCopiaNit, C.CamaraComercio, C.DescuentoAlquiler, C.DescuentoVenta
     , C.DescuentoReposicion, C.DescuentoMantenimiento, C.DescuentoTransporte, C.PorcentajeAgente, A.Nombre AgenteNombre, L.Nombre ListaPrecioNombre
FROM bdContrato AS C
INNER JOIN bdListaPrecio L ON C.idListaPrecio = L.Id
LEFT JOIN bdAgente AS A ON C.idAgente = A.Id


GO
/****** Object:  View [dbo].[vElemento]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vElemento]
AS
SELECT  E.Id ,E.idGrupoElemento, E.idUnidadMedida, E.Referencia, E.Nombre, E.Mt2, E.Peso, E.Rotacion, E.Activo, GE.Nombre GrupoElementoNombre, U.Nombre UnidadMedidaNombre
FROM bdElemento E
INNER JOIN bdGrupoElemento GE ON E.idGrupoElemento = GE.Id
INNER JOIN bdUnidadMedida U ON E.idUnidadMedida = U.Id

GO
/****** Object:  View [dbo].[vListaPrecioDetalle]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vListaPrecioDetalle]
AS
SELECT  LPD.Id, LPD.idListaPrecio, LPD.idElemento, LPD.PrecioAlquiler, LPD.PrecioVenta, LPD.PrecioPerdida, LP.Nombre ListaPrecioNombre, E.Nombre ElementoNombre
FROM bdListaPrecioDetalle LPD
INNER JOIN bdListaPrecio LP ON LPD.idListaPrecio = LP.Id
INNER JOIN bdElemento E ON LPD.idElemento = E.Id

GO
/****** Object:  View [dbo].[vProyecto]    Script Date: 25/04/2019 06:40:01 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vProyecto]
AS
SELECT P.Id, P.idCliente, P.idCiudad, P.Nombre, P.Tipo, P.Direccion, P.Telefono, P.Observacion, P.Fecha, P.FormaContacto, P.SistemaMedida, P.IdentificacionResponsable, P.NombreResponsable, P.TelResponsable, P.Activo, P.Estado
	   ,U.Nombre CiudadNombre, C.Nombre ClienteNombre, CN.Id idContrato
FROM bdProyecto P
INNER JOIN bdCiudad U ON P.idCiudad = U.Id
INNER JOIN bdCliente C ON P.idCliente = C.Id
INNER JOIN bdContrato CN ON P.Id = CN.idProyecto


GO
ALTER TABLE [dbo].[bdBodega]  WITH CHECK ADD  CONSTRAINT [FK_bdBodegaCliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[bdCliente] ([Id])
GO
ALTER TABLE [dbo].[bdBodega] CHECK CONSTRAINT [FK_bdBodegaCliente]
GO
ALTER TABLE [dbo].[bdBodega]  WITH CHECK ADD  CONSTRAINT [FK_bdBodegaProveedor] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[bdProveedor] ([Id])
GO
ALTER TABLE [dbo].[bdBodega] CHECK CONSTRAINT [FK_bdBodegaProveedor]
GO
ALTER TABLE [dbo].[bdCliente]  WITH CHECK ADD  CONSTRAINT [FK_bdClienteCiudad] FOREIGN KEY([idCiudad])
REFERENCES [dbo].[bdCiudad] ([Id])
GO
ALTER TABLE [dbo].[bdCliente] CHECK CONSTRAINT [FK_bdClienteCiudad]
GO
ALTER TABLE [dbo].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoAgente] FOREIGN KEY([idAgente])
REFERENCES [dbo].[bdAgente] ([Id])
GO
ALTER TABLE [dbo].[bdContrato] CHECK CONSTRAINT [FK_bdContratoAgente]
GO
ALTER TABLE [dbo].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoListaPrecio] FOREIGN KEY([idListaPrecio])
REFERENCES [dbo].[bdListaPrecio] ([Id])
GO
ALTER TABLE [dbo].[bdContrato] CHECK CONSTRAINT [FK_bdContratoListaPrecio]
GO
ALTER TABLE [dbo].[bdContrato]  WITH CHECK ADD  CONSTRAINT [FK_bdContratoProyecto] FOREIGN KEY([idProyecto])
REFERENCES [dbo].[bdProyecto] ([Id])
GO
ALTER TABLE [dbo].[bdContrato] CHECK CONSTRAINT [FK_bdContratoProyecto]
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
ALTER TABLE [dbo].[bdListaPrecioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdListaPrecioDetalleElemento] FOREIGN KEY([idElemento])
REFERENCES [dbo].[bdElemento] ([Id])
GO
ALTER TABLE [dbo].[bdListaPrecioDetalle] CHECK CONSTRAINT [FK_bdListaPrecioDetalleElemento]
GO
ALTER TABLE [dbo].[bdListaPrecioDetalle]  WITH CHECK ADD  CONSTRAINT [FK_bdListaPrecioDetalleListaPrecio] FOREIGN KEY([idListaPrecio])
REFERENCES [dbo].[bdListaPrecio] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[bdListaPrecioDetalle] CHECK CONSTRAINT [FK_bdListaPrecioDetalleListaPrecio]
GO
ALTER TABLE [dbo].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdProyecto_bdProyecto] FOREIGN KEY([Id])
REFERENCES [dbo].[bdProyecto] ([Id])
GO
ALTER TABLE [dbo].[bdProyecto] CHECK CONSTRAINT [FK_bdProyecto_bdProyecto]
GO
ALTER TABLE [dbo].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdProyectoCiudad] FOREIGN KEY([idCiudad])
REFERENCES [dbo].[bdCiudad] ([Id])
GO
ALTER TABLE [dbo].[bdProyecto] CHECK CONSTRAINT [FK_bdProyectoCiudad]
GO
ALTER TABLE [dbo].[bdProyecto]  WITH CHECK ADD  CONSTRAINT [FK_bdProyectoCliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[bdCliente] ([Id])
GO
ALTER TABLE [dbo].[bdProyecto] CHECK CONSTRAINT [FK_bdProyectoCliente]
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pAgente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pConductor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pContrato'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pGrupoElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pListaPrecio'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pListaPrecioDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pProveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pProyecto'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pTipoDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pTipoMantenimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pUnidadMedida'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdAgente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdConductor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdContrato'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdGrupoElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdListaPrecio'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdListaPrecioDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdParametro'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdProveedor'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdProyecto'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdTipoDocumento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdTipoMantenimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdUnidadMedida'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBodega'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCliente'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vContrato'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vElemento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vListaPrecioDetalle'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProyecto'
GO
