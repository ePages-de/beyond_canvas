(function ($) {
  const onDOMReady = function () {
    $('.flash').each(function () {
      $(this).css('right', -$(this).width() + 'px');
    });

    setTimeout(function () {
      $('.flash').addClass('flash--shown');
    }, 100);
  };

  $(document).on('click', '.flash__close', function () {
    closeAlert();
  });

  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);

function closeAlert() {
  $('.flash')
    .removeClass('flash--shown')
    .delay(700)
    .queue(function () {
      $(this).remove();
    });
}
