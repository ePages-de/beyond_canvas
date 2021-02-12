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
    $(dataTarget).showModal();
  });

  $(document).on('click', '[data-dismiss="modal"]', function (e) {
    e.preventDefault();

    const dataTarget = $(this).closest('.modal');

    $.restoreActionElements();
    $(dataTarget).hideModal();
  });

  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);

$.extend({
  showModal: function () {
    $.restoreActionElements();
    $(this).css('display', 'flex');
  },
  hideModal: function () {
    $.restoreActionElements();
    $(this).hide();
  },
});
