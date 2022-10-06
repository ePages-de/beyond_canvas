/* exported previewImage  */

export function previewImage(e) {
  const arr = Array.from(e.target.files);
  const elementFather = $(e.target).parents('.relative').find('.js-images');

  const imgAttr = getAtrributesFromElement($(elementFather).find('figure').find('img')[0]);
  const figureAttr = getAtrributesFromElement($(elementFather).find('figure')[0]);
  delete imgAttr.src;
  delete figureAttr.class;

  if($(e.target).attr('multiple')) {
    $(elementFather).children('attachment__placeholder, [preview]').each((_, img) => $(img).remove());
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

      setAttributesToElement(img, imgAttr);
      setAttributesToElement(figure, figureAttr);

      $(figure).append(img);
      $(elementFather).append(figure);
    };
  });
}

export const getAtrributesFromElement = (element) => {
  const attributes = {};
  for (const attr of element.getAttributeNames()) {
    attributes[attr] = element.getAttribute(attr);
  }

  return attributes;
};

export const setAttributesToElement = (element, attributes) => {
  for (const attr in attributes) {
    element.setAttribute(attr, attributes[attr]);
  }
};
