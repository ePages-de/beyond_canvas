/*
 * Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/beyond_canvas/' and run `yarn build`
 */
//= require jquery3
//= require rails-ujs
//= require beyond_canvas/common_functions
//= require_self

(function(factory) {
  typeof define === 'function' && define.amd ? define([ 'jquery' ], factory) : factory();
})(function() {
  'use strict';
  var SPINNER_ANIMATION_TIMEOUT = 125;
  var BUTTON_SELECTORS = "[class^='button']";
  (function($) {
    var onDOMReady = function onDOMReady() {
      var inputs = $('input, textarea, select').not(':input[type=button], :input[type=submit], :input[type=reset]');
      inputs.each(function() {
        var input = $(this);
        input.bind('invalid', function(e) {
          if ($(input).is(':hidden')) {
            e.preventDefault();
          }
          $.restoreActionElements();
        });
      });
      $(BUTTON_SELECTORS).each(function() {
        $(this).buildButton();
      });
    };
    $(document).on('confirm:complete', function() {
      $.restoreActionElements();
    });
    $(document).on('click', BUTTON_SELECTORS, function(e) {
      var _e$target$attributes$;
      var button = $(this);
      if (((_e$target$attributes$ = e.target.attributes.getNamedItem('target')) == null ? void 0 : _e$target$attributes$.value) === '_blank') return;
      $.disableActionElements();
      if (!button.hasClass('button--no-spinner')) {
        $(this).showSpinner();
      }
    });
    $(document).on('ready page:load turbolinks:load', onDOMReady);
    $(document).on('beforeunload turbolinks:before-visit', function() {
      $.restoreActionElements();
    });
  })(jQuery);
  $.extend({
    restoreActionElements: function restoreActionElements() {
      setTimeout(function() {
        $(BUTTON_SELECTORS).each(function(_, button) {
          setTimeout(function() {
            $(button).find('.spinner').hide();
            $(button).width($(button).data('oldWidth'));
          }, SPINNER_ANIMATION_TIMEOUT);
        });
        $("a, input[type='submit'], input[type='button'], input[type='reset'], button").each(function() {
          $(this).removeClass('actions--disabled');
        });
      }, 100);
    },
    disableActionElements: function disableActionElements() {
      $("a, input[type='submit'], input[type='button'], input[type='reset'], button").each(function() {
        $(this).addClass('actions--disabled');
      });
    }
  });
  (function($) {
    var onDOMReady = function onDOMReady() {
      updateInputLabel();
      initializeClearOnClickInputs();
      addInputFocusClass();
      removeInputFocusClass();
    };
    var updateInputLabel = function updateInputLabel() {
      $('form').on('change', 'input[type="file"]', function(_ref) {
        var _input$files, _input$getAttribute, _input$value;
        var input = _ref.currentTarget;
        var label = $('.input__file__text.' + input.getAttribute('id'));
        if (!label) return;
        var noFileText = input.getAttribute('data-no-file-text');
        var svgFileIcon = "\n        <svg class='input__file__icon' xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24'>\n          <path d='M15 2v5h5v15h-16v-20h11zm1-2h-14v24h20v-18l-6-6z'/>\n        </svg>";
        var fileName = ((_input$files = input.files) == null ? void 0 : _input$files.length) > 1 ? (_input$getAttribute = input.getAttribute('data-multiple-selection-text')) == null ? void 0 : _input$getAttribute.replace('{count}', input.files.length) : ((_input$value = input.value) == null ? void 0 : _input$value.split('\\').pop()) || '';
        fileName ? label.html('' + svgFileIcon + fileName) : label.html(noFileText);
      });
    };
    var addInputFocusClass = function addInputFocusClass() {
      $('form').on('focus', 'input[type="file"]', function(_ref2) {
        var input = _ref2.currentTarget;
        input.addClass('has-focus');
      });
    };
    var removeInputFocusClass = function removeInputFocusClass() {
      $('form').on('blur', 'input[type="file"]', function(_ref3) {
        var input = _ref3.currentTarget;
        input.removeClass('has-focus');
      });
    };
    var initializeClearOnClickInputs = function initializeClearOnClickInputs() {
      $('form').on('click', 'input[type="file"][data-clear-on-click="true"]', function() {
        var dt = new DataTransfer();
        this.files = dt.files;
        this.dispatchEvent(new Event('change', {
          bubbles: true,
          composed: true
        }));
      });
    };
    $(document).on('ready page:load turbolinks:load', function() {
      return onDOMReady();
    });
  })(jQuery);
  (function($) {
    var onDOMReady = function onDOMReady() {
      $('.modal').each(function() {
        $(this).hide().css('visibility', 'visible');
      });
    };
    $(document).on('click', '[data-toggle="modal"]', function(e) {
      e.preventDefault();
      var dataTarget = $(this).attr('data-target');
      $.restoreActionElements();
      $(dataTarget).showModal();
    });
    $(document).on('click', '[data-dismiss="modal"]', function(e) {
      e.preventDefault();
      var dataTarget = $(this).closest('.modal');
      $.restoreActionElements();
      $(dataTarget).hideModal();
    });
    $(document).on('ready page:load turbolinks:load', onDOMReady);
  })(jQuery);
  $.fn.extend({
    showModal: function showModal() {
      var modal = $(this);
      modal.trigger('bc.modal.show');
      $.restoreActionElements();
      modal.css('display', 'flex');
      modal.trigger('bc.modal.shown');
    },
    hideModal: function hideModal() {
      var modal = $(this);
      modal.trigger('bc.modal.hide');
      $.restoreActionElements();
      modal.hide();
      modal.trigger('bc.modal.hidden');
    }
  });
  const template = `<style>:host{display:inline-block;position:relative}:host([hidden]){display:none}s{position:absolute;top:0;bottom:0;left:0;right:0;pointer-events:none;background:var(--scroll-shadow-top,radial-gradient(farthest-side at 50% 0,#0003,#0000)) top/100% var(--top),var(--scroll-shadow-bottom,radial-gradient(farthest-side at 50% 100%,#0003,#0000)) bottom/100% var(--bottom),var(--scroll-shadow-left,radial-gradient(farthest-side at 0,#0003,#0000)) left/var(--left) 100%,var(--scroll-shadow-right,radial-gradient(farthest-side at 100%,#0003,#0000)) right/var(--right) 100%;background-repeat:no-repeat}</style><slot></slot><s></s>`;
});
