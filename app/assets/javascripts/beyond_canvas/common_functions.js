var bc = (function (exports) {
  'use strict';

  function _unsupportedIterableToArray(o, minLen) {
    if (!o) return;
    if (typeof o === "string") return _arrayLikeToArray(o, minLen);
    var n = Object.prototype.toString.call(o).slice(8, -1);
    if (n === "Object" && o.constructor) n = o.constructor.name;
    if (n === "Map" || n === "Set") return Array.from(o);
    if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen);
  }

  function _arrayLikeToArray(arr, len) {
    if (len == null || len > arr.length) len = arr.length;

    for (var i = 0, arr2 = new Array(len); i < len; i++) arr2[i] = arr[i];

    return arr2;
  }

  function _createForOfIteratorHelperLoose(o, allowArrayLike) {
    var it = typeof Symbol !== "undefined" && o[Symbol.iterator] || o["@@iterator"];
    if (it) return (it = it.call(o)).next.bind(it);

    if (Array.isArray(o) || (it = _unsupportedIterableToArray(o)) || allowArrayLike && o && typeof o.length === "number") {
      if (it) o = it;
      var i = 0;
      return function () {
        if (i >= o.length) return {
          done: true
        };
        return {
          done: false,
          value: o[i++]
        };
      };
    }

    throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
  }

  /* exported previewImage  */
  function previewImage(e) {
    var arr = Array.from(e.target.files);
    var elementFather = $(e.target).parents('.relative').find('.js-images');
    var figureElement = $(elementFather).find('figure');
    var imgAttr = getImagesAttributes($(figureElement));
    var figureAttr = getAtrributesFromElement($(figureElement)[0]);
    delete imgAttr.src;
    delete figureAttr["class"];

    if ($(e.target).attr('multiple')) {
      $(elementFather).children('attachment__placeholder').each(function (_, img) {
        return $(img).remove();
      });
    } else {
      $(elementFather).find('figure').remove();
    }

    $(e.target).parents('.relative').find('.js-placeholder').hide();
    arr.forEach(function (file) {
      var reader = new FileReader();
      reader.readAsDataURL(file);

      reader.onload = function () {
        var figure = document.createElement('figure');
        var img = document.createElement('img');
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
  var getImagesAttributes = function getImagesAttributes(figureElement) {
    var svgElement = $(figureElement).find('svg')[0];
    var imageElement = $(figureElement).find('img')[0];

    if (imageElement) {
      return getAtrributesFromElement(imageElement);
    }

    return getAtrributesFromSVG(svgElement);
  };
  var getAtrributesFromElement = function getAtrributesFromElement(element) {
    var attributes = {};
    if (!element) return attributes;

    for (var _iterator = _createForOfIteratorHelperLoose(element.getAttributeNames()), _step; !(_step = _iterator()).done;) {
      var attr = _step.value;
      attributes[attr] = element.getAttribute(attr);
    }

    return attributes;
  };
  var getAtrributesFromSVG = function getAtrributesFromSVG(element) {
    var svgAttrToExclude = ['xmlns', 'xmlns:xlink', 'version', 'id', 'x', 'y', 'viewBox', 'style', 'xml:space'];
    var attributes = {};
    if (!element) return attributes;
    var svgAttr = element.getAttributeNames().filter(function (attr) {
      return !svgAttrToExclude.includes(attr);
    });

    for (var _iterator2 = _createForOfIteratorHelperLoose(svgAttr), _step2; !(_step2 = _iterator2()).done;) {
      var attr = _step2.value;
      attributes[attr] = element.getAttribute(attr);
    }

    return attributes;
  };
  var setAttributesToElement = function setAttributesToElement(element, attributes) {
    for (var attr in attributes) {
      element.setAttribute(attr, attributes[attr]);
    }
  };

  exports.getAtrributesFromElement = getAtrributesFromElement;
  exports.getAtrributesFromSVG = getAtrributesFromSVG;
  exports.getImagesAttributes = getImagesAttributes;
  exports.previewImage = previewImage;
  exports.setAttributesToElement = setAttributesToElement;

  return exports;

}({}));
