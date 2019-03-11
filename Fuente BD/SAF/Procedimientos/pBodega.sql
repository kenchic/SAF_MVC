USE [SAF]
GO
/****** Object:  StoredProcedure [dbo].[pBodega]    Script Date: 08/03/2019 09:12:53 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[pBodega]  
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
					max(CASE WHEN name='idCliente' THEN convert(VARCHAR(200),StringValue) ELSE '' END) AS [idCliente],
					max(CASE WHEN name='idProveedor' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [idProveedor],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
					max(CASE WHEN name='EsSistema' THEN convert(BIT,StringValue) ELSE 0 END) AS [EsSistema]
			FROM SAFseg.dbo.fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
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


