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
//= require autocomplete
//= require_tree .


document.addEventListener("turbolinks:load", function() {
  FontAwesome.dom.i2svg();

  var options = {

    url: "/ports.json",

    getValue: "full_name",

    list: { 
      match: {
        enabled: true
      }
    },

    theme: "square"
  };

  $("#port-discharge").easyAutocomplete(options);
  $("#port-loading").easyAutocomplete(options);



  $(".show-modal").click(function() {
  	var modal_type = this.classList[this.classList.length-1]
    $(".modal." + modal_type).addClass("is-active");  
  });

  $(".close-modal").click(function() {
  	var modal_type = this.classList[this.classList.length-1]
    $(".modal." + modal_type).removeClass("is-active");
  });

  $(document).on('page:fetch', function() {
    return $('#content').fadeOut('slow');
  });

  $(document).on('page:restore', function() {
    return $('#content').fadeIn('slow');
  });

  $('.panel-block').hover(
    function(){ $(this).addClass('is-active') },
    function(){ $(this).removeClass('is-active') }
  )

  $('select.sli').val("DOCUMENTS");

  $('select.sli').on('change', function() {
    if(this.value.includes("request_sli") === true){
      $.post(
        "http://" + window.location.host + "/" + this.value,
        { secure_id: this.value, link: "http://" + window.location.host + "/slis/new/" + this.value.split('/').pop() }
      );
    }else if(this.value.includes("request_invoice") === true){
      $.post(
        "http://" + window.location.host + "/" + this.value,
        { secure_id: this.value, link: "http://" + window.location.host + "/invoices/new/" + this.value.split('/').pop() }
      );
    }else{
      window.open("http://" + window.location.host + "/" + this.value, '_blank');
    }
    $('select.sli').val("DOCUMENTS");
  });  
});

