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

$.fn.extend({
  showModal: function () {
    const modal = $(this);

    modal.trigger('bc.modal.show');

    $.restoreActionElements();
    modal.css('display', 'flex');

    modal.trigger('bc.modal.shown');
  },
  hideModal: function () {
    const modal = $(this);

    modal.trigger('bc.modal.hide');

    $.restoreActionElements();
    modal.hide();

    modal.trigger('bc.modal.hidden');
  },
});
