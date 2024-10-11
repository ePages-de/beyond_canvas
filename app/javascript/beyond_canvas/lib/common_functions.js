/* exported previewImage  */

export function previewImage(e) {
  const arr = Array.from(e.target.files);
  const elementFather = $(e.target).parents('.relative').find('.js-images');
  const figureElement = $(elementFather).find('figure');
  const figurePlaceholderElement = $(e.target).parents('.relative').find('.js-placeholder').find('figure');

  const imgAttr = getImagesAttributes(figureElement, figurePlaceholderElement);
  const figureAttr = getAttributesFromFigureElements(figureElement, figurePlaceholderElement);

  delete imgAttr.src;
  delete figureAttr.class;
  delete figureAttr.style;

  if($(e.target).attr('multiple')) {
    $(elementFather).children('attachment__placeholder, [preview]').each((_, img) => $(img).remove());
  } else {
    $(elementFather).find('figure').remove();
  }

  $(e.target).parents('.relative').find('.js-placeholder').hide();

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

const getImagesAttributes = (figureImageElement, figurePlaceholderElement) => {
  return {
    ...getImageAttributes($(figurePlaceholderElement)),
    ...getImageAttributes($(figureImageElement))
  };
};

const getAttributesFromFigureElements = (figureImageElement, figurePlaceholderElement) => {
  return {
    ...getAttributesFromElement($(figurePlaceholderElement)[0]),
    ...getAttributesFromElement($(figureImageElement)[0])
  };
};

export const getImageAttributes = (figureElement) => {
  const svgElement = $(figureElement).find('svg')[0];
  const imageElement = $(figureElement).find('img')[0];

  if(imageElement) {
    return getAttributesFromElement(imageElement);
  }

  return getAttributesFromSVG(svgElement);
};

export const getAttributesFromElement = (element) => {
  const attributes = {};

  if(!element) return attributes;

  for (const attr of element.getAttributeNames()) {
    attributes[attr] = element.getAttribute(attr);
  }

  return attributes;
};

export const getAttributesFromSVG = (element) => {
  const svgAttrToExclude = ['xmlns', 'xmlns:xlink', 'version', 'id', 'x', 'y', 'viewBox', 'style', 'xml:space'];
  const attributes = {};

  if(!element) return attributes;

  const svgAttr = element.getAttributeNames().filter(attr=> !svgAttrToExclude.includes(attr));

  for (const attr of svgAttr) {
    attributes[attr] = element.getAttribute(attr);
  }

  return attributes;
};

export const setAttributesToElement = (element, attributes) => {
  for (const attr in attributes) {
    element.setAttribute(attr, attributes[attr]);
  }
};
