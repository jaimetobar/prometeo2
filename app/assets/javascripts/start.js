//= require jquery
//= require jquery_ujs
//= require bxslider
//= require bootstrap-sprockets
//= require turbolinks


var ready;
ready = function() {
  // slider de paso 3
  $('.bxslider').bxSlider({
    minSlides: 1,
    maxSlides: 3,
    slideWidth: 350,
    slideMargin: 30
  });
};
$(document).ready(ready);
$(document).on("page:load", ready);