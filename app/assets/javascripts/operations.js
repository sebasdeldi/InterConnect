

document.addEventListener("turbolinks:load", function() {
	// CLICKEABLE TABLE ROWS

	$('.row').on('click', (e) => {
		window.location = e.target.dataset.link;
	});

	$('.operations-redirection').on('click', (e) => {
		document.cookie = "redirect_tab=operations_tab";
	});
});

