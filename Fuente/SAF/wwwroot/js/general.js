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

/*MENU*/
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
/*MENU*/

