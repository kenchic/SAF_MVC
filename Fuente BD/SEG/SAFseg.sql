USE [master]
GO
/****** Object:  Database [SAFseg]    Script Date: 30/03/2020 10:35:21 a.m. ******/
CREATE DATABASE [SAFseg] ON  PRIMARY 
( NAME = N'SAFseg', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\SAFseg.mdf' , SIZE = 12288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SAFseg_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\SAFseg_log.ldf' , SIZE = 13632KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SAFseg] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SAFseg].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SAFseg] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SAFseg] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SAFseg] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SAFseg] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SAFseg] SET ARITHABORT OFF 
GO
ALTER DATABASE [SAFseg] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SAFseg] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SAFseg] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SAFseg] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SAFseg] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SAFseg] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SAFseg] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SAFseg] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SAFseg] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SAFseg] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SAFseg] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SAFseg] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SAFseg] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SAFseg] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SAFseg] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SAFseg] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SAFseg] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SAFseg] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SAFseg] SET RECOVERY FULL 
GO
ALTER DATABASE [SAFseg] SET  MULTI_USER 
GO
ALTER DATABASE [SAFseg] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SAFseg] SET DB_CHAINING OFF 
GO
USE [SAFseg]
GO
/****** Object:  StoredProcedure [dbo].[pSesion]    Script Date: 30/03/2020 10:35:21 a.m. ******/
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
/****** Object:  StoredProcedure [dbo].[pSistema]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pSistema]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, Nombre, Version FROM bdSistema

	IF (@Accion = 1)
		SELECT Id, Nombre, Version FROM bdSistema

	IF(@Accion = 2)
		BEGIN
			SELECT Id, Nombre, Version FROM bdSistema
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'int'
			GROUP BY parent_ID) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdSistema 
			SELECT * FROM (SELECT					
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Version' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Version]
			FROM fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'int'
			GROUP BY parent_ID) Sistema
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE U
			SET Nombre = Sistema.Nombre,
				Version = Sistema.Version
			FROM bdSistema AS U
			INNER JOIN 
			(SELECT
				  max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				  max(CASE WHEN name='Version' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Version],
				  max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Sistema ON U.Id = Sistema.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE U
			FROM bdSistema AS U
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Sistema ON U.Id = Sistema.Id
		END
END


GO
/****** Object:  StoredProcedure [dbo].[pUsuario]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pUsuario]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar, 6: Autenticar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
		SELECT Id, idRol, Identificacion, Nombre, Apellido, Usuario, Clave, Correo, Activo, Admin FROM bdUsuario

	IF (@Accion = 1)
		SELECT Id, idRol, Identificacion, Nombre, Apellido, Usuario, Clave, Correo, Activo, Admin FROM bdUsuario WHERE Activo = 1

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idRol, Identificacion, Nombre, Apellido, Usuario, Clave, Correo, Activo, Admin FROM bdUsuario 
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) 
		END

	IF(@Accion = 3)
		BEGIN
			INSERT INTO bdUsuario 
			SELECT * FROM (SELECT
					max(CASE WHEN name='idRol' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idRol],
					max(CASE WHEN name='Identificacion' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Identificacion],
					max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
					max(CASE WHEN name='Apellido' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Apellido],
					max(CASE WHEN name='Usuario' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [Usuario],
					max(CASE WHEN name='Clave' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Clave],
					max(CASE WHEN name='Correo' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Correo],					
					max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
					max(CASE WHEN name='Admin' THEN convert(BIT,StringValue) ELSE 0 END) AS [Admin]
			FROM fParseJSON
			( @Json )
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) Usuario
		END

	IF(@Accion = 4)
		BEGIN
			UPDATE U
			SET Nombre = Usuario.Nombre,
				Activo = Usuario.Activo
			FROM bdUsuario AS U
			INNER JOIN 
			(SELECT
				   max(CASE WHEN name='Nombre' THEN convert(VARCHAR(100),StringValue) ELSE '' END) AS [Nombre],
				   max(CASE WHEN name='Activo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Activo],
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Usuario ON U.Id = Usuario.Id

		END

	IF(@Accion = 5)
		BEGIN
			DELETE U
			FROM bdUsuario AS U
			INNER JOIN 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(INT,StringValue) ELSE 0 END) AS [Id]
			From fParseJSON
			(
				  @json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Usuario ON U.Id = Usuario.Id
		END

	IF(@Accion = 6)
		BEGIN
			SELECT Id, idRol, Identificacion, Nombre, Apellido, U.Usuario, U.Clave, Correo, Activo, Admin 
			FROM bdUsuario AS U
			INNER JOIN 
			(SELECT 
				max(CASE WHEN name='Usuario' THEN convert(VARCHAR(15),StringValue) ELSE '' END) AS [Usuario],
				max(CASE WHEN name='Clave' THEN convert(VARCHAR(50),StringValue) ELSE '' END) AS [Clave]
			FROM fParseJSON
			(
				@json
			)
			WHERE ValueType = 'string' OR ValueType = 'boolean'
			GROUP BY parent_ID) AS Usuario ON U.Usuario = Usuario.Usuario AND U.Clave = Usuario.Clave
		END
END

GO
/****** Object:  StoredProcedure [dbo].[pUsuarioMenu]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pUsuarioMenu]  
(
	@Accion INT = 0, --0:Listar menus del usUario y menus relacionados con roles del usuario,
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF (@Accion = 0)
	BEGIN

		DECLARE @Usuario AS smallint 
		SET @Usuario =  (	SELECT      
							MAX(CASE WHEN name='Id' THEN convert(int,StringValue) ELSE 0 END) AS [Id]
							FROM fParseJSON ( @json )
							WHERE ValueType = 'int' OR ValueType = 'string' OR ValueType = 'boolean'
							GROUP BY parent_ID)

		CREATE TABLE ##TablaTemporal (Id smallint, Nombre varchar(50), Vista varchar(50), Orden int, SubOrden int, Imagen Varchar(100) )

		DECLARE @idMenu AS smallint 
		DECLARE @idMenuPadre AS smallint 
		DECLARE @Nombre AS Varchar(50)
		DECLARE @Vista AS Varchar(100)
		DECLARE @Orden AS smallint
		DECLARE @Image AS Varchar(100)
		DECLARE @exite AS smallint 
		DECLARE @OrdenPadre AS smallint 

		--Construir Usuario - Menu
		DECLARE UsuarioMenu 
		CURSOR FOR 
			SELECT M.id, M.idMenu, M.Nombre, M.Vista, M.Orden, M.Imagen 
			FROM bdUsuarioMenu UM 
			INNER JOIN bdMenu M ON UM.idMenu = M.Id AND UM.Activo = 1
			WHERE UM.idUsuario = @Usuario 

			UNION

			SELECT M.id, M.idMenu, M.Nombre, M.Vista, M.Orden, M.Imagen 
			FROM bdRolUsuario RU
			INNER JOIN bdRolMenu RM ON RU.idRol = RM.idRol AND RU.Activo = 1
			INNER JOIN bdMenu M ON RM.idMenu = M.Id AND RM.Activo = 1
			WHERE RU.idUsuario = @Usuario

			UNION

			SELECT M.id, M.idMenu, M.Nombre, M.Vista, M.Orden, M.Imagen 
			FROM bdRolUsuario RU
			INNER JOIN bdRol RP ON RU.idRol = RP.idRol AND RU.Activo = 1
			INNER JOIN bdRolMenu RM ON RP.Id = RM.idRol AND RM.Activo = 1
			INNER JOIN bdMenu M ON RM.idMenu = M.Id 
			WHERE  RU.idUsuario = @Usuario

		OPEN UsuarioMenu
		FETCH NEXT FROM UsuarioMenu INTO @idMenu, @idMenuPadre, @Nombre, @Vista, @Orden, @Image
		WHILE @@fetch_status = 0
		BEGIN
			IF ( @idMenuPadre is null)
			BEGIN			
				SELECT @exite = Id from ##TablaTemporal where Id = @idMenu
				IF (@exite IS NULL)
				BEGIN
					INSERT INTO ##TablaTemporal VALUES (@idMenu, @Nombre, @Vista, @Orden, null, @Image)			
					SELECT @OrdenPadre = Orden FROM bdMenu WHERE Id = @idMenu
				END
				INSERT INTO ##TablaTemporal
				SELECT M.id, M.Nombre, M.Vista, @OrdenPadre, M.Orden, M.Imagen FROM bdMenu M WHERE M.idMenu = @idMenu
			END
			ELSE
			BEGIN
				SELECT @exite = Id from ##TablaTemporal where Id = @idMenuPadre
				IF (@exite IS NULL)
				BEGIN	
					INSERT INTO ##TablaTemporal
					SELECT Id, Nombre, Vista, Orden, null, Imagen FROM bdMenu WHERE Id = @idMenuPadre

					SELECT @OrdenPadre = Orden FROM bdMenu WHERE Id = @idMenuPadre
				END

				SET @exite = NULL
				SELECT @exite = Id from ##TablaTemporal where Id = @idMenu
				IF (@exite IS NULL)
					INSERT INTO ##TablaTemporal VALUES (@idMenu, @Nombre, @Vista, @OrdenPadre, @Orden, @Image)
			END	
			FETCH NEXT FROM UsuarioMenu INTO  @idMenu, @idMenuPadre, @Nombre, @Vista, @Orden, @Image
		END

		CLOSE UsuarioMenu
		DEALLOCATE UsuarioMenu

		SELECT * FROM ##TablaTemporal ORDER BY Orden, SubOrden
		DROP TABLE ##TablaTemporal
	END
END

GO
/****** Object:  UserDefinedFunction [dbo].[fJsonBIT]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fJsonBIT] (@NombreIn VARCHAR(100), @EstadoIn BIT)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @estado VARCHAR(50)	
	SET @estado = '"' + @NombreIn + '":"'

	IF (@EstadoIn IS NOT NULL)
		BEGIN
			SET @estado = @estado + CONVERT(VARCHAR, @EstadoIn)
		END
    RETURN @estado + '"'
END
GO
/****** Object:  UserDefinedFunction [dbo].[fJsonDATE]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fJsonDATE] (@NombreIn VARCHAR(100), @FechaIn DATETIME)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @fecha VARCHAR(50)	
	SET @fecha ='"' + @NombreIn + '":"'

	IF (@FechaIn IS NOT NULL)
		BEGIN
			SET @fecha = @fecha + CONVERT(VARCHAR, @FechaIn, 9)
		END
    RETURN @fecha + '"'
END
GO
/****** Object:  UserDefinedFunction [dbo].[fJsonINT]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fJsonINT] (@NombreIn VARCHAR(100), @NumeroIn INT)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @numero VARCHAR(50)	
	SET @numero = '"' + @NombreIn + '":"'

	IF (@NumeroIn IS NOT NULL)
		BEGIN
			SET @numero = @numero + CONVERT(VARCHAR, @NumeroIn)
		END
    RETURN @numero + '"'
END
GO
/****** Object:  UserDefinedFunction [dbo].[fJsonTINY]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fJsonTINY] (@NombreIn VARCHAR(100), @NumeroIn TINYINT)
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @numero VARCHAR(50)	
	SET @numero = '"' + @NombreIn + '":"'

	IF (@NumeroIn IS NOT NULL)
		BEGIN
			SET @numero = @numero + CONVERT(VARCHAR, @NumeroIn)
		END
    RETURN @numero + '"'
END

GO
/****** Object:  UserDefinedFunction [dbo].[fJsonVAR]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fJsonVAR] (@NombreIn VARCHAR(100), @CampoIn VARCHAR(MAX))
RETURNS VARCHAR(50)
AS BEGIN
    DECLARE @campo VARCHAR(50)	
	SET @campo = '"' + @NombreIn + '":"'

	IF (@CampoIn IS NOT NULL)
		BEGIN
			SET @campo = @campo + CONVERT(VARCHAR, @CampoIn)
		END
    RETURN @campo + '"'
END

GO
/****** Object:  UserDefinedFunction [dbo].[fParseJSON]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fParseJSON]( @JSON NVARCHAR(MAX))

RETURNS @hierarchy TABLE
  (
   element_id INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
   sequenceNo [int] NULL, /* the place in the sequence for the element */
   parent_ID INT,/* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
   Object_ID INT,/* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
   NAME NVARCHAR(2000),/* the name of the object */
   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
  )
AS
BEGIN
  DECLARE
    @FirstObject INT, --the index of the first open bracket found in the JSON string
    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
    @Type NVARCHAR(10),--whether it denotes an object or an array
    @NextCloseDelimiterChar CHAR(1),--either a '}' or a ']'
    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
    @Start INT, --index of the start of the token that you are parsing
    @end INT,--index of the end of the token that you are parsing
    @param INT,--the parameter at the end of the next Object/Array token
    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
    @token NVARCHAR(200),--either a string or object
    @value NVARCHAR(MAX), -- the value as a string
    @SequenceNo int, -- the sequence number within a list
    @name NVARCHAR(200), --the name as a string
    @parent_ID INT,--the next parent ID to allocate
    @lenJSON INT,--the current length of the JSON String
    @characters NCHAR(36),--used to convert hex to decimal
    @result BIGINT,--the value of the hex symbol being parsed
    @index SMALLINT,--used for parsing the hex value
    @Escape INT --the index of the next escape character
   
 
  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the names of the elements, since they are 'escaped' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
    (
     String_ID INT IDENTITY(1, 1),
     StringValue NVARCHAR(MAX)
    )
  SELECT--initialise the characters to convert hex to ascii
    @characters='0123456789abcdefghijklmnopqrstuvwxyz',
    @SequenceNo=0, --set the sequence no. to something sensible.
  /* firstly we process all strings. This is done because [{} and ] aren't escaped in strings, which complicates an iterative parse. */
    @parent_ID=0;
  WHILE 1=1 --forever until there is nothing more to do
    BEGIN
      SELECT
        @start=PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
      IF @start=0 BREAK --no more so drop through the WHILE loop
      IF SUBSTRING(@json, @start+1, 1)='"'
        BEGIN --Delimited Name
          SET @start=@Start+1;
          SET @end=PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
        END
      IF @end=0 --no end delimiter to last string
        BREAK --no more
      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
      --now put in the escaped control characters
      SELECT @token=REPLACE(@token, FROMString, TOString)
      FROM
        (SELECT
          '\"' AS FromString, '"' AS ToString
         UNION ALL SELECT '\\', '\'
         UNION ALL SELECT '\/', '/'
         UNION ALL SELECT '\b', CHAR(08)
         UNION ALL SELECT '\f', CHAR(12)
         UNION ALL SELECT '\n', CHAR(10)
         UNION ALL SELECT '\r', CHAR(13)
         UNION ALL SELECT '\t', CHAR(09)
        ) substitutions
      SELECT @result=0, @escape=1
  --Begin to take out any hex escape codes
      WHILE @escape>0
        BEGIN
          SELECT @index=0,
          --find the next hex escape sequence
          @escape=PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
          IF @escape>0 --if there is one
            BEGIN
              WHILE @index<4 --there are always four digits to a \x sequence  
                BEGIN
                  SELECT --determine its value
                    @result=@result+POWER(16, @index)
                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
                                @characters)-1), @index=@index+1 ;
        
                END
                -- and replace the hex sequence by its unicode value
              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
            END
        END
      --now store the string away
      INSERT INTO @Strings (StringValue) SELECT @token
      -- and replace the string with a token
      SELECT @JSON=STUFF(@json, @start, @end+1,
                    '@string'+CONVERT(NVARCHAR(5), @@identity))
    END
  -- all strings are now removed. Now we find the first leaf. 
  WHILE 1=1  --forever until there is nothing more to do
  BEGIN
 
  SELECT @parent_ID=@parent_ID+1
  --find the first object or list by looking for the open bracket
  SELECT @FirstObject=PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)--object or array
  IF @FirstObject = 0 BREAK
  IF (SUBSTRING(@json, @FirstObject, 1)='{')
    SELECT @NextCloseDelimiterChar='}', @type='object'
  ELSE
    SELECT @NextCloseDelimiterChar=']', @type='array'
  SELECT @OpenDelimiter=@firstObject
 
  WHILE 1=1 --find the innermost object or list...
    BEGIN
      SELECT
        @lenJSON=LEN(@JSON+'|')-1
  --find the matching close-delimiter proceeding after the open-delimiter
      SELECT
        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
                                      @OpenDelimiter+1)
  --is there an intervening open-delimiter of either type
      SELECT @NextOpenDelimiter=PATINDEX('%[{[[]%',
             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
      IF @NextOpenDelimiter=0
        BREAK
      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
      IF @NextCloseDelimiter<@NextOpenDelimiter
        BREAK
      IF SUBSTRING(@json, @NextOpenDelimiter, 1)='{'
        SELECT @NextCloseDelimiterChar='}', @type='object'
      ELSE
        SELECT @NextCloseDelimiterChar=']', @type='array'
      SELECT @OpenDelimiter=@NextOpenDelimiter
    END
  ---and parse out the list or name/value pairs
  SELECT
    @contents=SUBSTRING(@json, @OpenDelimiter+1,
                        @NextCloseDelimiter-@OpenDelimiter-1)
  SELECT
    @JSON=STUFF(@json, @OpenDelimiter,
                @NextCloseDelimiter-@OpenDelimiter+1,
                '@'+@type+CONVERT(NVARCHAR(5), @parent_ID))
  WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin))<>0
    BEGIN
      IF @Type='Object' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
        BEGIN
          SELECT
            @SequenceNo=0,@end=CHARINDEX(':', ' '+@contents)--if there is anything, it will be a string-based name.
          SELECT  @start=PATINDEX('%[^A-Za-z@][@]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
          SELECT @token=SUBSTRING(' '+@contents, @start+1, @End-@Start-1),
            @endofname=PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
            @param=RIGHT(@token, LEN(@token)-@endofname+1)
          SELECT
            @token=LEFT(@token, @endofname-1),
            @Contents=RIGHT(' '+@contents, LEN(' '+@contents+'|')-@end-1)
          SELECT  @name=stringvalue FROM @strings
            WHERE string_id=@param --fetch the name
        END
      ELSE
        SELECT @Name=null,@SequenceNo=@SequenceNo+1
      SELECT
        @end=CHARINDEX(',', @contents)-- a string-token, object-token, list-token, number,boolean, or null
      IF @end=0
        SELECT  @end=PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @Contents+' ' collate SQL_Latin1_General_CP850_Bin)
          +1
       SELECT
         @start=PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e][\-]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)
		-- Edited: add more condition [\-] in order to detect negative number 08-20-2014
      --select @start,@end, LEN(@contents+'|'), @contents 
      SELECT
        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
        @Contents=RIGHT(@contents+' ', LEN(@contents+'|')-@end)

      IF SUBSTRING(@value, 1, 7)='@object'
        INSERT INTO @hierarchy
          (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
          SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 8, 5),
            SUBSTRING(@value, 8, 5), 'object'
      ELSE
        IF SUBSTRING(@value, 1, 6)='@array'
          INSERT INTO @hierarchy
            (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
            SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 7, 5),
              SUBSTRING(@value, 7, 5), 'array'
        ELSE
          IF SUBSTRING(@value, 1, 7)='@string'
            INSERT INTO @hierarchy
              (NAME, SequenceNo, parent_ID, StringValue, ValueType)
              SELECT @name, @SequenceNo, @parent_ID, stringvalue, 'string'
              FROM @strings
              WHERE string_id=SUBSTRING(@value, 8, 5)
          ELSE
            IF @value IN ('true', 'false')
              INSERT INTO @hierarchy
                (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                SELECT @name, @SequenceNo, @parent_ID, @value, 'boolean'
            ELSE
              IF @value='null'
                INSERT INTO @hierarchy
                  (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                  SELECT @name, @SequenceNo, @parent_ID, @value, ''
              ELSE
                IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0
                  INSERT INTO @hierarchy
                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                    SELECT @name, @SequenceNo, @parent_ID, @value, 'real'
                ELSE
                  INSERT INTO @hierarchy
                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                    SELECT @name, @SequenceNo, @parent_ID, @value, 'int'
      if @Contents=' ' Select @SequenceNo=0
    END
  END
INSERT INTO @hierarchy (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
  SELECT '-',1, NULL, '', @parent_id-1, @type
--
   RETURN
END




GO
/****** Object:  Table [dbo].[bdArtefacto]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdArtefacto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idTipoArtefacto] [tinyint] NOT NULL,
	[idEstado] [tinyint] NOT NULL,
	[idSistema] [tinyint] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
 CONSTRAINT [PK_bdArtefacto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdArtefactoEstado]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdArtefactoEstado](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_bdEstado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdArtefactoHistorial]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdArtefactoHistorial](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[idArtefacto] [int] NOT NULL,
	[idRequerimiento] [int] NOT NULL,
	[Objetivo] [varchar](max) NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[Extension] [varchar](10) NOT NULL,
	[Version] [varchar](10) NULL,
 CONSTRAINT [PK_bdArtefactoHistorial] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdArtefactoTipo]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdArtefactoTipo](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_bdTipoArtefacto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdAuditoria]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdAuditoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idSesion] [bigint] NOT NULL,
	[Tabla] [varchar](50) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Operacion] [varchar](50) NOT NULL,
	[Observacion] [varchar](500) NULL,
	[Detalle] [varchar](max) NOT NULL,
 CONSTRAINT [PK_bdAuditoria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdCatalogo]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdCatalogo](
	[Id] [varchar](20) NOT NULL,
	[Codigo] [varchar](10) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Valor1] [varchar](10) NULL,
	[Valor2] [varchar](10) NULL,
	[Valor3] [varchar](10) NULL,
 CONSTRAINT [PK_Catalogo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdMenu]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdMenu](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idMenu] [smallint] NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Vista] [varchar](100) NULL,
	[Orden] [smallint] NOT NULL,
	[Imagen] [varchar](100) NULL,
	[Activo] [bit] NOT NULL CONSTRAINT [DF_bdMenu_Activo]  DEFAULT ((0)),
 CONSTRAINT [PK_bdMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdRequerimiento]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdRequerimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[Estado] [varchar](10) NOT NULL CONSTRAINT [DF_bdRequerimiento_Estado]  DEFAULT ('I'),
 CONSTRAINT [PK_bdRequerimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdRol]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdRol](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdRolMenu]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdRolMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NOT NULL,
	[idMenu] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRolMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdRolUsuario]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdRolUsuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdRolUsuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdSesion]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdSesion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[Token] [varchar](50) NOT NULL,
	[Terminal] [varchar](50) NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaFin] [datetime] NULL,
	[Tiempo] [int] NULL,
	[IdSesionBD] [int] NULL CONSTRAINT [DF_bdSesion_IdSesionBD]  DEFAULT ((0)),
 CONSTRAINT [PK_bdSesion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdSistema]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdSistema](
	[Id] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Version] [varchar](20) NOT NULL,
 CONSTRAINT [PK_bdSistema] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdUsuario]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdUsuario](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[idRol] [smallint] NULL,
	[Identificacion] [varchar](50) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Apellido] [varchar](100) NOT NULL,
	[Usuario] [varchar](15) NOT NULL,
	[Clave] [varchar](50) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
	[Admin] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bdUsuarioMenu]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[bdUsuarioMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [smallint] NOT NULL,
	[idMenu] [smallint] NOT NULL,
	[Valor] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_bdUsuarioMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vArtefactoRequerimiento]    Script Date: 30/03/2020 10:35:21 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vArtefactoRequerimiento]
AS
SELECT     dbo.bdArtefacto.Id, dbo.bdArtefacto.idTipoArtefacto, dbo.bdArtefacto.Nombre, dbo.bdArtefacto.idEstado, dbo.bdArtefacto.idSistema, 
                      dbo.bdSistema.Nombre AS SistemaNombre, dbo.bdArtefacto.Descripcion AS ArtefactoDescripcion, dbo.bdArtefactoHistorial.Objetivo, 
                      dbo.bdArtefactoHistorial.Descripcion, dbo.bdArtefactoHistorial.Extension, dbo.bdArtefactoHistorial.Version, dbo.bdArtefactoHistorial.idRequerimiento, 
                      dbo.bdRequerimiento.Descripcion AS RequerimientoDescripcion, dbo.bdRequerimiento.Estado
FROM         dbo.bdRequerimiento RIGHT OUTER JOIN
                      dbo.bdArtefactoHistorial ON dbo.bdRequerimiento.Id = dbo.bdArtefactoHistorial.idRequerimiento RIGHT OUTER JOIN
                      dbo.bdSistema INNER JOIN
                      dbo.bdArtefacto ON dbo.bdSistema.Id = dbo.bdArtefacto.idSistema ON dbo.bdArtefactoHistorial.idArtefacto = dbo.bdArtefacto.Id

GO
ALTER TABLE [dbo].[bdArtefacto]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoEstado] FOREIGN KEY([idEstado])
REFERENCES [dbo].[bdArtefactoEstado] ([Id])
GO
ALTER TABLE [dbo].[bdArtefacto] CHECK CONSTRAINT [FK_bdArtefactoEstado]
GO
ALTER TABLE [dbo].[bdArtefacto]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoSistema] FOREIGN KEY([idSistema])
REFERENCES [dbo].[bdSistema] ([Id])
GO
ALTER TABLE [dbo].[bdArtefacto] CHECK CONSTRAINT [FK_bdArtefactoSistema]
GO
ALTER TABLE [dbo].[bdArtefacto]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoTipo] FOREIGN KEY([idTipoArtefacto])
REFERENCES [dbo].[bdArtefactoTipo] ([Id])
GO
ALTER TABLE [dbo].[bdArtefacto] CHECK CONSTRAINT [FK_bdArtefactoTipo]
GO
ALTER TABLE [dbo].[bdArtefactoHistorial]  WITH CHECK ADD  CONSTRAINT [FK_bdArtefactoHistorialArtefacto] FOREIGN KEY([idArtefacto])
REFERENCES [dbo].[bdArtefacto] ([Id])
GO
ALTER TABLE [dbo].[bdArtefactoHistorial] CHECK CONSTRAINT [FK_bdArtefactoHistorialArtefacto]
GO
ALTER TABLE [dbo].[bdMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdMenuPadre] FOREIGN KEY([idMenu])
REFERENCES [dbo].[bdMenu] ([Id])
GO
ALTER TABLE [dbo].[bdMenu] CHECK CONSTRAINT [FK_bdMenuPadre]
GO
ALTER TABLE [dbo].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [dbo].[bdMenu] ([Id])
GO
ALTER TABLE [dbo].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Menu]
GO
ALTER TABLE [dbo].[bdRolMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdRolMenu_Rol] FOREIGN KEY([idRol])
REFERENCES [dbo].[bdRol] ([Id])
GO
ALTER TABLE [dbo].[bdRolMenu] CHECK CONSTRAINT [FK_bdRolMenu_Rol]
GO
ALTER TABLE [dbo].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRol] FOREIGN KEY([idRol])
REFERENCES [dbo].[bdRol] ([Id])
GO
ALTER TABLE [dbo].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRol]
GO
ALTER TABLE [dbo].[bdRolUsuario]  WITH CHECK ADD  CONSTRAINT [FK_bdRolUsuario_bdRolUsuario] FOREIGN KEY([Id])
REFERENCES [dbo].[bdRolUsuario] ([Id])
GO
ALTER TABLE [dbo].[bdRolUsuario] CHECK CONSTRAINT [FK_bdRolUsuario_bdRolUsuario]
GO
ALTER TABLE [dbo].[bdSesion]  WITH CHECK ADD  CONSTRAINT [FK_bdSesionUsuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[bdUsuario] ([Id])
GO
ALTER TABLE [dbo].[bdSesion] CHECK CONSTRAINT [FK_bdSesionUsuario]
GO
ALTER TABLE [dbo].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Menu] FOREIGN KEY([idMenu])
REFERENCES [dbo].[bdMenu] ([Id])
GO
ALTER TABLE [dbo].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Menu]
GO
ALTER TABLE [dbo].[bdUsuarioMenu]  WITH CHECK ADD  CONSTRAINT [FK_bdUsuarioMenu_Usuario] FOREIGN KEY([Id])
REFERENCES [dbo].[bdUsuarioMenu] ([Id])
GO
ALTER TABLE [dbo].[bdUsuarioMenu] CHECK CONSTRAINT [FK_bdUsuarioMenu_Usuario]
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pSesion'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'20.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pSistema'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pUsuarioMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'fJsonBIT'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'fJsonDATE'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'fJsonINT'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'fJsonTINY'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'fJsonVAR'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'fParseJSON'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdArtefacto'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdArtefactoEstado'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'20.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdArtefactoHistorial'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdArtefactoTipo'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdAuditoria'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'20.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdCatalogo'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'20.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRequerimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRol'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRolMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdRolUsuario'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdSesion'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdSistema'
GO
EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'18.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bdUsuarioMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[27] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[45] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 9
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "bdRequerimiento"
            Begin Extent = 
               Top = 4
               Left = 660
               Bottom = 98
               Right = 811
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdArtefactoHistorial"
            Begin Extent = 
               Top = 2
               Left = 380
               Bottom = 168
               Right = 537
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdSistema"
            Begin Extent = 
               Top = 153
               Left = 207
               Bottom = 247
               Right = 358
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bdArtefacto"
            Begin Extent = 
               Top = 3
               Left = 15
               Bottom = 112
               Right = 169
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2265
         Table = 3075
         Output = 720
         Append = ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vArtefactoRequerimiento'
GO
USE [master]
GO
ALTER DATABASE [SAFseg] SET  READ_WRITE 
GO
