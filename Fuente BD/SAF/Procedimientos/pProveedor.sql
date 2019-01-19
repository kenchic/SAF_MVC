USE [SAF]
GO

/****** Object:  StoredProcedure [dbo].[pProveedor]    Script Date: 14/01/2019 10:49:56 p.m. ******/
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

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pProveedor'
GO


