/* exported previewImage  */

export function previewImage(e) {
  const arr = Array.from(e.target.files);
  const elementFather = $(e.target).parents('.relative').find('.js-images');

  if($(e.target).attr('multiple')) {
    $(elementFather).children('.placeholder, [preview]').each((_, img) => $(img).remove());
  } else {
    $(elementFather).find('figure').remove();
  }

  arr.forEach(file => {
    const reader = new FileReader();

    reader.readAsDataURL(file);
    reader.onload = function () {
      const figure = document.createElement('figure');
      const img = document.createElement('img');

      figure.classList.add('attachment', 'attachment--preview');
      figure.setAttribute('preview', true);
      img.setAttribute('src', reader.result);

      $(figure).append(img);
      $(elementFather).append(figure);
    };
  });
}
