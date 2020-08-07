(function ($) {
  $(document).on('click', function (e) {
    var target = $(e.target);

    if (target.is('.modal__background')) {
      $.closeModal();
    }
  });
})(jQuery);

$.extend({
  displayModal: function (modalContent) {
    $('#modal').find('.modal__content').html(modalContent);
    $('#modal').css('display', 'flex');
  },
  closeModal: function () {
    $('#modal').find('.modal__content').empty();
    $('#modal').css('display', 'none');
  }
});
