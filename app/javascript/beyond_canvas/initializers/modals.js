(function ($) {
  $(document).on('click', '.modal__close', function (e) {
    $.closeModal();
  });
})(jQuery);

$.extend({
  displayModal: function (modalContent) {
    $('#modal').find('#modal__content').html(modalContent);
    $('#modal').css('display', 'flex');
  },
  closeModal: function () {
    $('#modal').find('#modal__content').empty();
    $('#modal').css('display', 'none');
    $.restoreActionElements();
  }
});
