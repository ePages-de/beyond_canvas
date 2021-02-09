(function ($) {
  const onDOMReady = function () {
    $('.modal').each(function () {
      $(this).hide().css('visibility', 'visible');
    });
  };

  $(document).on('click', '[data-toggle="modal"]', function (e) {
    e.preventDefault();

    const dataTarget = $(this).attr('data-target');

    $.restoreActionElements();
    $(dataTarget).css('display', 'flex');
  });

  $(document).on('click', '[data-dismiss="modal"]', function (e) {
    e.preventDefault();

    const dataTarget = $(this).closest('.modal');

    $.restoreActionElements();
    $(dataTarget).hide();
  });

  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);
