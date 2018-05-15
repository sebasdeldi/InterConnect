

document.addEventListener("turbolinks:load", function() {
	// CLICKEABLE TABLE ROWS

	$('.row').on('click', (e) => {
		window.location = e.target.dataset.link;
	});

});

