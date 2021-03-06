USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pListaPrecioDetalle]    Script Date: 20/01/2021 11:15:49 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [SAF].[pListaPrecioDetalle]  
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



