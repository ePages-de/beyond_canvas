(function($) {
  $(document).on('click', '.flash', function() {
    closeAlert();
  });

  $(document).on('ready page:load turbolinks:load', function() {
    $('.flash').each(function() {
      $(this).css('right', -$(this).width() + 'px');
    });

    setTimeout(function() {
      $('.flash').addClass('flash--shown');
    }, 100);
  });
})(jQuery);

function closeAlert() {
  $('.flash')
    .removeClass('flash--shown')
    .delay(700)
    .queue(function() {
      $(this).remove();
    });
}
