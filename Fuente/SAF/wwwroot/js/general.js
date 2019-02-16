function cargarVista(view, divDestino = 'contenido') {
    $('#' + divDestino).load(view);
}

function cerrarModal(idModal) {
	$('#' + idModal).modal('hide');
	$('body').removeClass('modal-open');
}

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