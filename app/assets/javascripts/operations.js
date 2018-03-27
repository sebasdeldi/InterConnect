// CLICKEABLE TABLE ROWS


var ready = () => {
	$('.row').on('click', (e) => {
		window.location = e.target.dataset.link;
	});
}

$(document).ready(ready);
$(document).on("page:load", ready);
