USE [SAF]
GO

/****** Object:  Trigger [dbo].[tProyectoAuditoria]    Script Date: 03/02/2020 11:11:34 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tProyectoAuditoria] ON [dbo].[bdProyecto] 
FOR UPDATE, INSERT
AS

BEGIN
	DECLARE @IdSesion BIGINT
	DECLARE @Detalle VARCHAR(MAX)
	
	IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            IF EXISTS (SELECT * FROM DELETED) 
            	BEGIN --Actualizar
					SELECT @IdSesion = Id FROM SAFseg.dbo.bdSesion WHERE IdSesionBD = @@SPID
				
					SELECT @Detalle = '{ "Anterior": { ' + SAFseg.dbo.fJsonINT('idCliente',idCliente) + ',' + SAFseg.dbo.fJsonINT('idCiudad',idCiudad) + ',' + SAFseg.dbo.fJsonVAR('Nombre', Nombre) + ',' + SAFseg.dbo.fJsonVAR('Tipo', Tipo)  + 
											',' + SAFseg.dbo.fJsonVAR('Direccion', Direccion) + 
											',' + SAFseg.dbo.fJsonVAR('Telefono', Telefono) + ',' + SAFseg.dbo.fJsonVAR('Observacion', Observacion) + ',' + SAFseg.dbo.fJsonDATE('Fecha', Fecha) + ',' + SAFseg.dbo.fJsonVAR('FormaContacto', FormaContacto) + 
											',' + SAFseg.dbo.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SAFseg.dbo.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SAFseg.dbo.fJsonVAR('NombreResponsable', NombreResponsable) + 
											',' + SAFseg.dbo.fJsonVAR('TelResponsable', TelResponsable) + ',' + SAFseg.dbo.fJsonBIT('Activo', Activo) + ',' + SAFseg.dbo.fJsonTINY('Estado', Estado)  + '}, '
					FROM DELETED D
				
					SELECT @Detalle = @Detalle + '"Nuevo": { ' + SAFseg.dbo.fJsonINT('idCliente',idCliente) + ',' + SAFseg.dbo.fJsonINT('idCiudad',idCiudad) + ',' + SAFseg.dbo.fJsonVAR('Nombre', Nombre) + ',' + SAFseg.dbo.fJsonVAR('Tipo', Tipo)  + 
											',' + SAFseg.dbo.fJsonVAR('Direccion', Direccion) + 
											',' + SAFseg.dbo.fJsonVAR('Telefono', Telefono) + ',' + SAFseg.dbo.fJsonVAR('Observacion', Observacion) + ',' + SAFseg.dbo.fJsonDATE('Fecha', Fecha) + ',' + SAFseg.dbo.fJsonVAR('FormaContacto', FormaContacto) + 
											',' + SAFseg.dbo.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SAFseg.dbo.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SAFseg.dbo.fJsonVAR('NombreResponsable', NombreResponsable) + 
											',' + SAFseg.dbo.fJsonVAR('TelResponsable', TelResponsable) + ',' + SAFseg.dbo.fJsonBIT('Activo', Activo) + ',' + SAFseg.dbo.fJsonTINY('Estado', Estado)  + '} }'
					FROM INSERTED AS I 
				
					INSERT INTO SAFseg.dbo.bdAuditoria (idSesion, Tabla, Fecha, Operacion, Observacion, Detalle)
					VALUES ( @IdSesion ,'bdProyecto', GETDATE(),'Editar','', @Detalle)
            	END
            ELSE
				BEGIN --Insertar
					SELECT @IdSesion = Id FROM SAFseg.dbo.bdSesion WHERE IdSesionBD = @@SPID
			
					SELECT @Detalle = '{ "Nuevo": { ' + SAFseg.dbo.fJsonINT('idCliente',idCliente) + ',' + SAFseg.dbo.fJsonINT('idCiudad',idCiudad) + ',' + SAFseg.dbo.fJsonVAR('Nombre', Nombre) + ',' + SAFseg.dbo.fJsonVAR('Tipo', Tipo)  + 
											',' + SAFseg.dbo.fJsonVAR('Direccion', Direccion) + 
											',' + SAFseg.dbo.fJsonVAR('Telefono', Telefono) + ',' + SAFseg.dbo.fJsonVAR('Observacion', Observacion) + ',' + SAFseg.dbo.fJsonDATE('Fecha', Fecha) + ',' + SAFseg.dbo.fJsonVAR('FormaContacto', FormaContacto) + 
											',' + SAFseg.dbo.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SAFseg.dbo.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SAFseg.dbo.fJsonVAR('NombreResponsable', NombreResponsable) + 
											',' + SAFseg.dbo.fJsonVAR('TelResponsable', TelResponsable) + ',' + SAFseg.dbo.fJsonBIT('Activo', Activo) + ',' + SAFseg.dbo.fJsonTINY('Estado', Estado) + '} }'
					FROM INSERTED AS I 
				
					INSERT INTO SAFseg.dbo.bdAuditoria (idSesion, Tabla, Fecha, Operacion, Observacion, Detalle)
					VALUES ( @IdSesion ,'bdProyecto', GETDATE(),'Insertar','', @Detalle)
				END
        END
    ELSE IF EXISTS (SELECT * FROM DELETED)
        RAISERROR ('Esta acción no está permitida', 16, 1)
    ELSE
        RAISERROR ('Ninguna acción ejecutada', 16, 1)
END
GO


