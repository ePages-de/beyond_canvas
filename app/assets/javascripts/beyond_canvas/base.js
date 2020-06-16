/*!
 * 
 *    Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/beyond_canvas/' and run `yarn build`
 * 
 *    //= require jquery3
 *    //= require_self
 *   
 */
(function(e, a) { for(var i in a) e[i] = a[i]; }(window, /******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 1);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "showSpinner", function() { return showSpinner; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "hideSpinner", function() { return hideSpinner; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "disableActionElements", function() { return disableActionElements; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "enableActionElements", function() { return enableActionElements; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "closeAlert", function() { return closeAlert; });
var SPINNER_ANIMATION_TIMEOUT = 125;
function showSpinner(button) {
  // Adjust the width of the button
  button.width(button.width() + $('.spinner').outerWidth(true)); // Show the spinner

  setTimeout(function () {
    button.find('.spinner').css('display', 'flex');
  }, SPINNER_ANIMATION_TIMEOUT);
}
function hideSpinner() {
  $('button[class^="button"]').each(function (_i, button) {
    setTimeout(function () {
      // Hide the spinner
      $(button).find('.spinner').hide(); // Adjust the width of the button

      $(button).width($(button).data('oldWidth'));
    }, SPINNER_ANIMATION_TIMEOUT);
  });
}
function disableActionElements() {
  $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function (_, button) {
    $(button).addClass('actions--disabled');
  });
}
function enableActionElements() {
  $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function (_, button) {
    $(button).removeClass('actions--disabled');
  });
}
function closeAlert() {
  $('.flash').removeClass('flash--shown').delay(700).queue(function () {
    $(this).remove();
  });
}

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(3);
module.exports = __webpack_require__(0);


/***/ }),
/* 2 */
/***/ (function(module, exports) {

(function ($) {
  var onDOMReady = function onDOMReady() {
    $('input[type="file"]').each(function () {
      var $input = $(this),
          $label = $(".input__file__text." + $input.attr('id')),
          labelVal = $label.html();
      $input.on('change', function (e) {
        var fileName = '';
        if (this.files && this.files.length > 1) fileName = (this.getAttribute('data-multiple-caption') || '').replace('{count}', this.files.length);else if (e.target.value) fileName = e.target.value.split('\\').pop();
        if (fileName) $label.html("<svg class=\"input__file__icon\" xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\"><path d=\"M15 2v5h5v15h-16v-20h11zm1-2h-14v24h20v-18l-6-6z\"/></svg>" + fileName);else $label.html(labelVal);
      }); // Firefox bug fix

      $input.on('focus', function () {
        $input.addClass('has-focus');
      }).on('blur', function () {
        $input.removeClass('has-focus');
      });
    });
  };

  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);

/***/ }),
/* 3 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// EXTERNAL MODULE: ./app/javascript/beyond_canvas/initializers/functions.js
var functions = __webpack_require__(0);

// CONCATENATED MODULE: ./app/javascript/beyond_canvas/initializers/buttons.js


(function ($) {
  var onDOMReady = function onDOMReady() {
    var inputs = $('input, textarea, select').not(':input[type=button], :input[type=submit], :input[type=reset]');
    inputs.each(function () {
      var input = $(this);
      input.bind('invalid', function (e) {
        if ($(input).is(':hidden')) {
          e.preventDefault();
        }

        Object(functions["hideSpinner"])();
        Object(functions["enableActionElements"])();
      });
    });
    $('button[class^="button"]').each(function () {
      var button = $(this); // Add width attribute and save old width

      button.width(button.width());
      button.data('oldWidth', button.width()); // Add the spinner

      button.prepend("\n        <div class=\"spinner\">\n          <div class=\"bounce1\"></div>\n          <div class=\"bounce2\"></div>\n          <div class=\"bounce3\"></div>\n        </div>"); // Bind ajax:success and ajax:error to the form the button belongs to

      button.closest('form').on('ajax:success', function () {
        Object(functions["hideSpinner"])();
        Object(functions["enableActionElements"])();
      }).on('ajax:error', function () {
        Object(functions["hideSpinner"])();
        Object(functions["enableActionElements"])();
      });
    });
  };

  $(document).on('click', '[class^="button"]', function () {
    Object(functions["disableActionElements"])();
    Object(functions["showSpinner"])($(this));
  });
  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);
// CONCATENATED MODULE: ./app/javascript/beyond_canvas/initializers/flash.js


(function ($) {
  var onDOMReady = function onDOMReady() {
    $('.flash').each(function () {
      $(this).css('right', -$(this).width() + 'px');
    });
    setTimeout(function () {
      $('.flash').addClass('flash--shown');
    }, 100);
  };

  $(document).on('click', '.flash', function () {
    Object(functions["closeAlert"])();
  });
  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);
// EXTERNAL MODULE: ./app/javascript/beyond_canvas/initializers/inputs.js
var initializers_inputs = __webpack_require__(2);

// CONCATENATED MODULE: ./app/javascript/beyond_canvas/base.js




/***/ })
/******/ ])));