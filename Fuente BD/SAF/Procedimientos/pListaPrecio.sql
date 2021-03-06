USE [SAF]
GO
/****** Object:  StoredProcedure [SAF].[pListaPrecio]    Script Date: 20/01/2021 11:03:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [SAF].[pListaPrecio]  
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



