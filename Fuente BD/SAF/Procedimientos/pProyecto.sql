USE [SAF]
GO

/****** Object:  StoredProcedure [dbo].[pProyecto]    Script Date: 18/03/2019 02:31:48 p.m. ******/
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

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pProyecto'
GO


