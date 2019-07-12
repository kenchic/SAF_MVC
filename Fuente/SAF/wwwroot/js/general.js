function cargarVista(view, divDestino = 'contenido') {
    $('#' + divDestino).load(view);
}

//Función para mostrar modales
function abrirVistaModal(urlIn, divDestino, idModal) {
    $.ajax({
        url: urlIn,
        success: function (data) {
            $('#' + divDestino).html(data);
            $('#' + idModal).modal({
                backdrop: "static",
                keyboard: false,
                role: "dialog",                
                show: true
            });
        }
    });
}

//Función para cerrar modales
function cerrarModal(idModal) {
    $('#' + idModal).modal('hide');
    $('body').removeClass('modal-open');
}

//Función para ocultar o mostrar menu izq.
function abrirMenu() {
    if (document.getElementById("menu").style.width === "0px")
    {
        document.getElementById("menu").style.width = "250px";
        document.getElementById("contenidoPrincipal").style.marginLeft = "250px";
    }
    else
    {
        document.getElementById("menu").style.width = "0px";
        document.getElementById("contenidoPrincipal").style.marginLeft = "0px";
    }
}

//Funciones de inicio y fin de request
$(document).ajaxStart(function () {
    $('#cargando').fadeIn();
    }).ajaxStop(function () {
        $('#cargando').fadeOut();
});