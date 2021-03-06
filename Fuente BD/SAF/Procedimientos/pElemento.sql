USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pElemento]    Script Date: 20/01/2021 11:02:47 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [SAF].[pElemento]  
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


