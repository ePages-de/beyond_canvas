$.extend({
  displayModal: function (content, options = {}) {
    $('#modal').find('#modal__content').html(content);
    $('#modal').css('display', 'flex');
    $.restoreActionElements();
    $(document).trigger('modal:opened', options['extraEventParameters']);
  },
  closeModal: function () {
    $('#modal').find('#modal__content').empty();
    $('#modal').css('display', 'none');
    $.restoreActionElements();
    $(document).trigger('modal:closed');
  }
});
