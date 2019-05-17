USE [SAF]
GO
/****** Object:  Trigger [dbo].[tProyectoInsertar]    Script Date: 25/05/2019 10:06:58 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[tProyectoInsertar] ON [dbo].[bdProyecto] 
FOR INSERT
AS

BEGIN

	INSERT INTO bdContrato
	SELECT I.Id, 3, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM INSERTED AS I

	DECLARE @IdSesion BIGINT
	DECLARE @Detalle VARCHAR(MAX)

	SELECT @IdSesion = Id FROM SAFseg.dbo.bdSesion WHERE IdSesionBD = @@SPID
	SELECT @Detalle = '{ "nuevo": { ' + SAFseg.dbo.fJsonINT('idCliente',idCliente) + ',' + SAFseg.dbo.fJsonINT('idCiudad',idCiudad) + ',' + SAFseg.dbo.fJsonVAR('Nombre', Nombre) + ',' + SAFseg.dbo.fJsonVAR('Tipo', Tipo)  + 
							',' + SAFseg.dbo.fJsonVAR('Direccion', Direccion) + 
							',' + SAFseg.dbo.fJsonVAR('Telefono', Telefono) + ',' + SAFseg.dbo.fJsonVAR('Observacion', Observacion) + ',' + SAFseg.dbo.fJsonDATE('Fecha', Fecha) + ',' + SAFseg.dbo.fJsonVAR('FormaContacto', FormaContacto) + 
							',' + SAFseg.dbo.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SAFseg.dbo.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SAFseg.dbo.fJsonVAR('NombreResponsable', NombreResponsable) + 
							',' + SAFseg.dbo.fJsonVAR('TelResponsable', TelResponsable) + ',' + SAFseg.dbo.fJsonBIT('Activo', Activo) + ',' + SAFseg.dbo.fJsonTINY('Estado', Estado) + '} }'
	FROM INSERTED AS I 

	INSERT INTO SAFseg.dbo.bdAuditoria (idSesion, Tabla, Fecha, Operacion, Observacion, Detalle)
	VALUES ( @IdSesion ,'bdProyecto', GETDATE(),'Insertar','', @Detalle)

END
