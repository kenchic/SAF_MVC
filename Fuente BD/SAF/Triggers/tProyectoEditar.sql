USE [SAF]
GO

/****** Object:  Trigger [SAF].[tProyectoEditar]    Script Date: 25/05/2019 10:07:57 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [SAF].[tProyectoEditar] ON [SAF].[bdProyecto] 
FOR UPDATE
AS

BEGIN

	DECLARE @IdSesion BIGINT
	DECLARE @Detalle VARCHAR(MAX)

	SELECT @IdSesion = Id FROM SEG.bdSesion WHERE IdSesionBD = @@SPID

	SELECT @Detalle = '{ "Anterior": { ' + SEG.fJsonINT('idCliente',idCliente) + ',' + SEG.fJsonINT('idCiudad',idCiudad) + ',' + SEG.fJsonVAR('Nombre', Nombre) + ',' + SEG.fJsonVAR('Tipo', Tipo)  + 
							',' + SEG.fJsonVAR('Direccion', Direccion) + 
							',' + SEG.fJsonVAR('Telefono', Telefono) + ',' + SEG.fJsonVAR('Observacion', Observacion) + ',' + SEG.fJsonDATE('Fecha', Fecha) + ',' + SEG.fJsonVAR('FormaContacto', FormaContacto) + 
							',' + SEG.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SEG.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SEG.fJsonVAR('NombreResponsable', NombreResponsable) + 
							',' + SEG.fJsonVAR('TelResponsable', TelResponsable) + ',' + SEG.fJsonBIT('Activo', Activo) + ',' + SEG.fJsonTINY('Estado', Estado)  + '}, '
	FROM DELETED D

	SELECT @Detalle = @Detalle + '"nuevo": { ' + SEG.fJsonINT('idCliente',idCliente) + ',' + SEG.fJsonINT('idCiudad',idCiudad) + ',' + SEG.fJsonVAR('Nombre', Nombre) + ',' + SEG.fJsonVAR('Tipo', Tipo)  + 
							',' + SEG.fJsonVAR('Direccion', Direccion) + 
							',' + SEG.fJsonVAR('Telefono', Telefono) + ',' + SEG.fJsonVAR('Observacion', Observacion) + ',' + SEG.fJsonDATE('Fecha', Fecha) + ',' + SEG.fJsonVAR('FormaContacto', FormaContacto) + 
							',' + SEG.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SEG.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SEG.fJsonVAR('NombreResponsable', NombreResponsable) + 
							',' + SEG.fJsonVAR('TelResponsable', TelResponsable) + ',' + SEG.fJsonBIT('Activo', Activo) + ',' + SEG.fJsonTINY('Estado', Estado)  + '} }'
	FROM INSERTED AS I 

	INSERT INTO SEG.bdAuditoria (idSesion, Tabla, Fecha, Operacion, Observacion, Detalle)
	VALUES ( @IdSesion ,'bdProyecto', GETDATE(),'Editar','', @Detalle)

END


GO


