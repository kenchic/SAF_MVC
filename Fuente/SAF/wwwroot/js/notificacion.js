function Notificacion(notificacion) {
    var Titulo;    
    var Encabezado;
    var Icono;

    switch (notificacion.Tipo) {
        case "1":
            Titulo = ' Éxito';
            Encabezado = '<div class="toast-header bg-success text-white">';
            Icono = '<i class="fas fa-check-square rounded me-2"></i>';
            break;
        case "2":
            Titulo = ' Información';
            Encabezado = '<div class="toast-header bg-info text-white">';
            Icono = '<i class="fas fa-info-circle rounded me-2"></i>';
            break;
        case "3":
            Titulo = ' Alerta';
            Encabezado = '<div class="toast-header bg-warning text-white">';
            Icono = '<i class="fas fa-exclamation-triangle rounded me-2"></i>';
            break;
        case "4":
            Titulo = ' Error';
            Encabezado = '<div class="toast-header bg-danger text-white">';
            Icono = '<i class="fas fa-times-circle rounded me-2"></i>';
            break;
    }

    var htmlToast = $("#DivNotificacion").html();
    htmlToast += '<div class="toast" id="Notificacion">';
    htmlToast += Encabezado;
    htmlToast += Icono + '<strong class="me-auto">' + Titulo + '</strong>';
    htmlToast += '<small>' + notificacion.Fecha + '</small>';
    htmlToast += '<button type="button" class="btn-close close" aria-label="Close"></button>';
    htmlToast += '</div>';
    htmlToast += '<div class="toast-body">';
    htmlToast += notificacion.Mensaje;
    htmlToast += '</div>';
    htmlToast += '</div>';

    $("#DivNotificacion").html(htmlToast);
    $("#Notificacion").show();
    $("#Notificacion").on('click', '.close', function () {
        $("#Notificacion").hide();
    });
}