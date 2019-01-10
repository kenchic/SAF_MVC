USE [SAF]
GO

/****** Object:  StoredProcedure [dbo].[pParametro]    Script Date: 09/01/2019 09:28:41 p.m. ******/
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

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pParametro'
GO


