// CLICKEABLE TABLE ROWS


document.addEventListener("turbolinks:load", function() {
	$('.row').on('click', (e) => {
		window.location = e.target.dataset.link;
	});
});

