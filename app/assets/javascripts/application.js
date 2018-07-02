// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require jquery.ui.all
//= require toastr
//= require Chart.bundle
//= require chartkick
//= require_tree .


document.addEventListener("turbolinks:load", function() {
  FontAwesome.dom.i2svg();

  $(".show-modal").click(function() {
  	var modal_type = this.classList[this.classList.length-1]
    $(".modal." + modal_type).addClass("is-active");  
  });

  $(".close-modal").click(function() {
  	var modal_type = this.classList[this.classList.length-1]
    $(".modal." + modal_type).removeClass("is-active");
  });
});

