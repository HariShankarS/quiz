// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require masonry/jquery.masonry
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require cocoon
//= require ckeditor/init
//= require_tree .

$(document).ready(function(){
  $('[data-toggle="popover"]').popover();
  $.material.init();
  $(".toggle").click(function(){
      $(".text-area").toggle();
  });
  $('.ckeditor').each(function() {
    CKEDITOR.replace($(this).attr('id'));
  });
  $('#results').imagesLoaded(function() {
    $('#results').masonry({
      itemSelector: '.bo',
      isFitWidth: true
    });
  });
  $('.count').each(function () {
    $(this).prop('Counter',0).animate({
        Counter: $(this).text()
    }, {
        duration: 4000,
        easing: 'swing',
        step: function (now) {
            $(this).text(Math.ceil(now));
        }
    });
  });
});
$(document).on('turbolinks:load', function() {
  $('[data-toggle="popover"]').popover();
  $.material.init();
  $('.ckeditor').each(function() {
    CKEDITOR.replace($(this).attr('id'));
  });
  $(".toggle").click(function(){
      $(".text-area").toggle();
  });
  $('#results').imagesLoaded(function() {
    $('#results').masonry({
      itemSelector: '.bo',
      isFitWidth: true
    });
  });
});

