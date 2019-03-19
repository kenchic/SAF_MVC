USE [SAF]
GO

/****** Object:  StoredProcedure [dbo].[pContrato]    Script Date: 15/03/2019 04:20:04 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[pContrato]  
(
	@Accion INT = 0, --0:Listar Todos, 1: Listar Activos, 2: Consultar, 3: Insertar, 4: Editar, 5: Borrar
	@Json NVARCHAR(max)	
)
AS 
BEGIN
	IF(@Accion = 0)
		SELECT Id, idProyecto, idListaPrecio, idAgente, InformacionBD, ContratoAlquiler, CartaPagare, Pagare, LetraCambio, GarantiasCondiciones 
				 , Deposito, Anticipo, PersonaJuridica, PersonaNatural, FotoCopiaCedula, FotoCopiaNit, CamaraComercio, DescuentoAlquiler, DescuentoVenta
				 , DescuentoReposicion, DescuentoMantenimiento, DescuentoTransporte, PorcentajeAgente, AgenteNombre, ListaPrecioNombre
		FROM vContrato

	IF(@Accion = 1)
		SELECT Id, idProyecto, idListaPrecio, idAgente, InformacionBD, ContratoAlquiler, CartaPagare, Pagare, LetraCambio, GarantiasCondiciones 
				 , Deposito, Anticipo, PersonaJuridica, PersonaNatural, FotoCopiaCedula, FotoCopiaNit, CamaraComercio, DescuentoAlquiler, DescuentoVenta
				 , DescuentoReposicion, DescuentoMantenimiento, DescuentoTransporte, PorcentajeAgente, AgenteNombre, ListaPrecioNombre
		FROM vContrato

	IF(@Accion = 2)
		BEGIN
			SELECT Id, idProyecto, idListaPrecio, idAgente, InformacionBD, ContratoAlquiler, CartaPagare, Pagare, LetraCambio, GarantiasCondiciones 
				 , Deposito, Anticipo, PersonaJuridica, PersonaNatural, FotoCopiaCedula, FotoCopiaNit, CamaraComercio, DescuentoAlquiler, DescuentoVenta
				 , DescuentoReposicion, DescuentoMantenimiento, DescuentoTransporte, PorcentajeAgente, AgenteNombre, ListaPrecioNombre
		    FROM vContrato 
			WHERE Id = 
			(SELECT      
				   max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) 
		END

	IF(@Accion = 3)
		BEGIN
			PRINT 'Se insertar en el momento de insertar el proyecto'
		END

	IF(@Accion = 4)
		BEGIN

			UPDATE C
			SET idListaPrecio = Contrato.idListaPrecio,
				idAgente = Contrato.idAgente,
				InformacionBD = Contrato.InformacionBD,
				ContratoAlquiler = Contrato.ContratoAlquiler, 
				CartaPagare = Contrato.CartaPagare, 
				Pagare = Contrato.Pagare, 
				LetraCambio = Contrato.LetraCambio, 
				GarantiasCondiciones = Contrato.GarantiasCondiciones, 
				Deposito = Contrato.Deposito, 
				Anticipo = Contrato.Anticipo, 
				PersonaJuridica = Contrato.PersonaJuridica, 
				PersonaNatural = Contrato.PersonaNatural, 
				FotoCopiaCedula = Contrato.FotoCopiaCedula, 
				FotoCopiaNit = Contrato.FotoCopiaNit, 
				CamaraComercio = Contrato.CamaraComercio, 
				DescuentoAlquiler = Contrato.DescuentoAlquiler, 
				DescuentoVenta = Contrato.DescuentoVenta, 
				DescuentoReposicion = Contrato.DescuentoReposicion, 
				DescuentoMantenimiento = Contrato.DescuentoMantenimiento, 
				DescuentoTransporte = Contrato.DescuentoTransporte, 
				PorcentajeAgente = Contrato.PorcentajeAgente				
			FROM bdContrato AS C
			INNER JOIN 
			(SELECT
				    max(CASE WHEN name='Id' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [Id],
					max(CASE WHEN name='idListaPrecio' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idListaPrecio],
					max(CASE WHEN name='idAgente' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [idAgente],					
					max(CASE WHEN name='InformacionBD' THEN convert(BIT,StringValue) ELSE 0 END) AS [InformacionBD],
					max(CASE WHEN name='ContratoAlquiler' THEN convert(BIT,StringValue) ELSE 0 END) AS [ContratoAlquiler],
					max(CASE WHEN name='CartaPagare' THEN convert(BIT,StringValue) ELSE 0 END) AS [CartaPagare],
					max(CASE WHEN name='Pagare' THEN convert(BIT,StringValue) ELSE 0 END) AS [Pagare],
					max(CASE WHEN name='LetraCambio' THEN convert(BIT,StringValue) ELSE 0 END) AS [LetraCambio],
					max(CASE WHEN name='GarantiasCondiciones' THEN convert(BIT,StringValue) ELSE 0 END) AS [GarantiasCondiciones],
					max(CASE WHEN name='Deposito' THEN convert(BIT,StringValue) ELSE 0 END) AS [Deposito],
					max(CASE WHEN name='Anticipo' THEN convert(BIT,StringValue) ELSE 0 END) AS [Anticipo],
					max(CASE WHEN name='PersonaJuridica' THEN convert(BIT,StringValue) ELSE 0 END) AS [PersonaJuridica],
					max(CASE WHEN name='PersonaNatural' THEN convert(BIT,StringValue) ELSE 0 END) AS [PersonaNatural],
					max(CASE WHEN name='FotoCopiaCedula' THEN convert(BIT,StringValue) ELSE 0 END) AS [FotoCopiaCedula],
					max(CASE WHEN name='FotoCopiaNit' THEN convert(BIT,StringValue) ELSE 0 END) AS [FotoCopiaNit],
					max(CASE WHEN name='CamaraComercio' THEN convert(BIT,StringValue) ELSE 0 END) AS [CamaraComercio],
					max(CASE WHEN name='DescuentoAlquiler' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoAlquiler],
					max(CASE WHEN name='DescuentoVenta' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoVenta],
					max(CASE WHEN name='DescuentoReposicion' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoReposicion],
					max(CASE WHEN name='DescuentoMantenimiento' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoMantenimiento],
					max(CASE WHEN name='DescuentoTransporte' THEN convert(INT,StringValue) ELSE 0 END) AS [DescuentoTransporte],
					max(CASE WHEN name='PorcentajeAgente' THEN convert(SMALLINT,StringValue) ELSE 0 END) AS [PorcentajeAgente]
			FROM SAFseg.dbo.fParseJSON
			(
				  @json
			)) AS Contrato ON C.Id = Contrato.Id

		END

	IF(@Accion = 5)
		BEGIN
			PRINT 'No se permite eliminar'
		END
END




GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'19.0.1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'pContrato'
GO


