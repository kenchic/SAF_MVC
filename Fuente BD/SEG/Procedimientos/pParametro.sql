USE [SAF]
GO
/****** Object:  StoredProcedure [SEG].[pParametro]    Script Date: 20/01/2021 12:15:59 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [SEG].[pParametro]  
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




