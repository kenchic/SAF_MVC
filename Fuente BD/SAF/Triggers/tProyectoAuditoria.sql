USE [SAF]
GO

/****** Object:  Trigger [SAF].[tProyectoAuditoria]    Script Date: 03/02/2020 11:11:34 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [SAF].[tProyectoAuditoria] ON [SAF].[bdProyecto] 
FOR UPDATE, INSERT
AS

BEGIN
	DECLARE @IdSesion BIGINT
	DECLARE @Detalle VARCHAR(MAX)
	
	IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            IF EXISTS (SELECT * FROM DELETED) 
            	BEGIN --Actualizar
					SELECT @IdSesion = Id FROM SEG.bdSesion WHERE IdSesionBD = @@SPID
				
					SELECT @Detalle = '{ "Anterior": { ' + SEG.fJsonINT('idCliente',idCliente) + ',' + SEG.fJsonINT('idCiudad',idCiudad) + ',' + SEG.fJsonVAR('Nombre', Nombre) + ',' + SEG.fJsonVAR('Tipo', Tipo)  + 
											',' + SEG.fJsonVAR('Direccion', Direccion) + 
											',' + SEG.fJsonVAR('Telefono', Telefono) + ',' + SEG.fJsonVAR('Observacion', Observacion) + ',' + SEG.fJsonDATE('Fecha', Fecha) + ',' + SEG.fJsonVAR('FormaContacto', FormaContacto) + 
											',' + SEG.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SEG.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SEG.fJsonVAR('NombreResponsable', NombreResponsable) + 
											',' + SEG.fJsonVAR('TelResponsable', TelResponsable) + ',' + SEG.fJsonBIT('Activo', Activo) + ',' + SEG.fJsonTINY('Estado', Estado)  + '}, '
					FROM DELETED D
				
					SELECT @Detalle = @Detalle + '"Nuevo": { ' + SEG.fJsonINT('idCliente',idCliente) + ',' + SEG.fJsonINT('idCiudad',idCiudad) + ',' + SEG.fJsonVAR('Nombre', Nombre) + ',' + SEG.fJsonVAR('Tipo', Tipo)  + 
											',' + SEG.fJsonVAR('Direccion', Direccion) + 
											',' + SEG.fJsonVAR('Telefono', Telefono) + ',' + SEG.fJsonVAR('Observacion', Observacion) + ',' + SEG.fJsonDATE('Fecha', Fecha) + ',' + SEG.fJsonVAR('FormaContacto', FormaContacto) + 
											',' + SEG.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SEG.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SEG.fJsonVAR('NombreResponsable', NombreResponsable) + 
											',' + SEG.fJsonVAR('TelResponsable', TelResponsable) + ',' + SEG.fJsonBIT('Activo', Activo) + ',' + SEG.fJsonTINY('Estado', Estado)  + '} }'
					FROM INSERTED AS I 
				
					INSERT INTO SEG.bdAuditoria (idSesion, Tabla, Fecha, Operacion, Observacion, Detalle)
					VALUES ( @IdSesion ,'bdProyecto', GETDATE(),'Editar','', @Detalle)
            	END
            ELSE
				BEGIN --Insertar
					SELECT @IdSesion = Id FROM SEG.bdSesion WHERE IdSesionBD = @@SPID
			
					SELECT @Detalle = '{ "Nuevo": { ' + SEG.fJsonINT('idCliente',idCliente) + ',' + SEG.fJsonINT('idCiudad',idCiudad) + ',' + SEG.fJsonVAR('Nombre', Nombre) + ',' + SEG.fJsonVAR('Tipo', Tipo)  + 
											',' + SEG.fJsonVAR('Direccion', Direccion) + 
											',' + SEG.fJsonVAR('Telefono', Telefono) + ',' + SEG.fJsonVAR('Observacion', Observacion) + ',' + SEG.fJsonDATE('Fecha', Fecha) + ',' + SEG.fJsonVAR('FormaContacto', FormaContacto) + 
											',' + SEG.fJsonVAR('SistemaMedida', SistemaMedida) + ',' + SEG.fJsonVAR('IdentificacionResponsable', IdentificacionResponsable) + ',' + SEG.fJsonVAR('NombreResponsable', NombreResponsable) + 
											',' + SEG.fJsonVAR('TelResponsable', TelResponsable) + ',' + SEG.fJsonBIT('Activo', Activo) + ',' + SEG.fJsonTINY('Estado', Estado) + '} }'
					FROM INSERTED AS I 
				
					INSERT INTO SEG.bdAuditoria (idSesion, Tabla, Fecha, Operacion, Observacion, Detalle)
					VALUES ( @IdSesion ,'bdProyecto', GETDATE(),'Insertar','', @Detalle)
				END
        END
    ELSE IF EXISTS (SELECT * FROM DELETED)
        RAISERROR ('Esta acción no está permitida', 16, 1)
    ELSE
        RAISERROR ('Ninguna acción ejecutada', 16, 1)
END
GO


