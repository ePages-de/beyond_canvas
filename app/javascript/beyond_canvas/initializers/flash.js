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
    $.closeAlert();
  });

  $(document).on('ready page:load turbolinks:load bc.flash.shown', onDOMReady);
})(jQuery);

$.extend({
  showFlash: function(status, message) {
    const flash = `
        <div class="flash">
          <div class="flash__icon flash__icon--${status}">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M12 2c5.514 0 10 4.486 10 10s-4.486 10-10 10-10-4.486-10-10 4.486-10 10-10zm0-2c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm6 16.538l-4.592-4.548 4.546-4.587-1.416-1.403-4.545 4.589-4.588-4.543-1.405 1.405 4.593 4.552-4.547 4.592 1.405 1.405 4.555-4.596 4.591 4.55 1.403-1.416z"></path></svg>
          </div>
          <div class="flash__message">
            ${message}
          </div>
          <div class="flash__close">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"></path></svg>
          </div>
        </div>`;

    $(document).trigger('bc.flash.show');
    $('#flash').html(flash);
    $(document).trigger('bc.flash.shown');
  },
  closeAlert: function() {
    $(document).trigger('bc.flash.hide');
    $('.flash')
      .removeClass('flash--shown')
      .delay(700)
      .queue(function () {
        $(this).remove();
      });
    $(document).trigger('bc.flash.hidden');
  }
});
