import { closeAlert } from './functions';

(function ($) {
  const onDOMReady = function () {
    $('.flash').each(function () {
      $(this).css('right', -$(this).width() + 'px');
    });

    setTimeout(function () {
      $('.flash').addClass('flash--shown');
    }, 100);
  };

  $(document).on('click', '.flash', function () {
    closeAlert();
  });

  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);
