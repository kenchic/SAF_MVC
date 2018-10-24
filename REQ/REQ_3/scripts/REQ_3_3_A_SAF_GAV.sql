USE [SAF]
GO

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

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdAgente'
GO

CREATE PROCEDURE [dbo].[pAgente]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Activo FROM Agente

	IF (@Accion = 1)
		SELECT Id, Nombre, Activo FROM Agente WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Activo FROM 
			Agente 
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM parseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO Agente 
			SELECT * FROM (SELECT
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo]
			FROM parseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Agente
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE A
			SET Nombre = Agente.Nombre,
				Activo = Agente.Activo
			FROM Agente AS A
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(bit,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM parseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Agente ON A.Id = Agente.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE A
			FROM Agente AS A
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From parseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Agente ON A.Id = Agente.Id
		END
END
GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pAgente'
GO

SET ANSI_PADDING OFF
GO