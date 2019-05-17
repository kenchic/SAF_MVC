USE [SAF]
GO

/****** Object:  Trigger [dbo].[tProyectoEditar]    Script Date: 25/05/2019 10:07:57 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[tProyectoEditar] ON [dbo].[bdProyecto] 
FOR UPDATE
AS

BEGIN

	DECLARE @IdSesion BIGINT
	DECLARE @Detalle VARCHAR(MAX)

	SELECT @IdSesion = Id FROM SAFseg.dbo.bdSesion WHERE IdSesionBD = @@SPID

	SELECT @Detalle = '{ "Anterior": { ' + SAFseg.dbo.fJsonINT('idCliente',idCliente) + ',' + SAFseg.dbo.fJsonINT('idCiudad',idCiudad) + ',' + SAFseg.dbo.fJsonVAR('Nombre', Nombre) + ',' + SAFseg.dbo.fJsonVAR('Tipo', Tipo)  + 
							',' + SAFseg.dbo.fJsonVAR('Direccion', Direccion) + 
							',' + SAFseg.dbo.fJsonVAR('Telefono', Telefono) + ',' + SAFseg.dbo.fJsonVAR('Observacion', Observacion) + ',' + SAFseg.dbo.fJsonDATE('Fecha', Fecha) + ',' + SAFseg.dbo.fJsonVAR('FormaContacto', FormaContacto) + 
							',' + SAFseg.dbo.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SAFseg.dbo.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SAFseg.dbo.fJsonVAR('NombreResponsable', NombreResponsable) + 
							',' + SAFseg.dbo.fJsonVAR('TelResponsable', TelResponsable) + ',' + SAFseg.dbo.fJsonBIT('Activo', Activo) + ',' + SAFseg.dbo.fJsonTINY('Estado', Estado)  + '}, '
	FROM DELETED D

	SELECT @Detalle = @Detalle + '"nuevo": { ' + SAFseg.dbo.fJsonINT('idCliente',idCliente) + ',' + SAFseg.dbo.fJsonINT('idCiudad',idCiudad) + ',' + SAFseg.dbo.fJsonVAR('Nombre', Nombre) + ',' + SAFseg.dbo.fJsonVAR('Tipo', Tipo)  + 
							',' + SAFseg.dbo.fJsonVAR('Direccion', Direccion) + 
							',' + SAFseg.dbo.fJsonVAR('Telefono', Telefono) + ',' + SAFseg.dbo.fJsonVAR('Observacion', Observacion) + ',' + SAFseg.dbo.fJsonDATE('Fecha', Fecha) + ',' + SAFseg.dbo.fJsonVAR('FormaContacto', FormaContacto) + 
							',' + SAFseg.dbo.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SAFseg.dbo.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SAFseg.dbo.fJsonVAR('NombreResponsable', NombreResponsable) + 
							',' + SAFseg.dbo.fJsonVAR('TelResponsable', TelResponsable) + ',' + SAFseg.dbo.fJsonBIT('Activo', Activo) + ',' + SAFseg.dbo.fJsonTINY('Estado', Estado)  + '} }'
	FROM INSERTED AS I 

	INSERT INTO SAFseg.dbo.bdAuditoria (idSesion, Tabla, Fecha, Operacion, Observacion, Detalle)
	VALUES ( @IdSesion ,'bdProyecto', GETDATE(),'Editar','', @Detalle)

END


GO


