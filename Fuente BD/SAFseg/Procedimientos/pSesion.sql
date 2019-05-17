USE [SAFseg]
GO

/****** Object:  StoredProcedure [dbo].[pSesion]    Script Date: 25/05/2019 10:13:36 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pSesion]  
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

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pSesion'
GO


