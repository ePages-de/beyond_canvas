var bc = (function (exports) {
  'use strict';

  /* exported previewImage  */
  function previewImage(e) {
    var arr = Array.from(e.target.files);
    var elementFather = $(e.target).parents('.relative').find('.js-images');

    if ($(e.target).attr('multiple')) {
      $(elementFather).children('.attachment__placeholder, [preview]').each(function (_, img) {
        return $(img).remove();
      });
    } else {
      $(elementFather).find('figure').remove();
    }

    arr.forEach(function (file) {
      var reader = new FileReader();
      reader.readAsDataURL(file);

      reader.onload = function () {
        var figure = document.createElement('figure');
        var img = document.createElement('img');
        figure.classList.add('attachment', 'attachment--preview');
        figure.setAttribute('preview', true);
        img.setAttribute('src', reader.result);
        $(figure).append(img);
        $(elementFather).append(figure);
      };
    });

    $(e.target).parent().find('label').text($(e.target).attr('data-button-change-text'));
  }

  exports.previewImage = previewImage;

  return exports;

}({}));
