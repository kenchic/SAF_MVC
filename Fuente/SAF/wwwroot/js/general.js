function cargarView(view) {
	$('#contenido').load(view);
}

function cerrarModal(idModal) {
	$('#' + idModal).modal('hide');
	$('body').removeClass('modal-open');
	$('.modal-backdrop').remove();
}

function mostrarVistaModal(urlIn) {
	$.ajax({
		url: urlIn,
		success: function (data) {
			$('#modalOperacion').html(data);
			$('#modalVista').modal({
				keyboard: true
			}, 'show');
		}
	});
}