$('#pushRight').click(function () {
	$('body').addClass('animate-menu-push');
	$('body').toggleClass('animate-menu-push-right')
	$('.animate-menu-left').toggleClass('animate-menu-open')
})

$(document).ready(function () {
	$('#menu').load('/Usuario/UsuarioMenu');
});

function cargarView(view) {
	$('#content').load(view);
}