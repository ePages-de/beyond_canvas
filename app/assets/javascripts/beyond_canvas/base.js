/*
 * Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/beyond_canvas/' and run `yarn build`
 */
//= require jquery3
//= require rails-ujs
//= require beyond_canvas/common_functions
//= require_self

(function(factory) {
  typeof define === "function" && define.amd ? define([ "jquery" ], factory) : factory();
})(function() {
  "use strict";
  var SPINNER_ANIMATION_TIMEOUT = 125;
  var BUTTON_SELECTORS = '[class^="button"]';
  (function($) {
    var onDOMReady = function onDOMReady() {
      var inputs = $("input, textarea, select").not(":input[type=button], :input[type=submit], :input[type=reset]");
      inputs.each(function() {
        var input = $(this);
        input.bind("invalid", function(e) {
          if ($(input).is(":hidden")) {
            e.preventDefault();
          }
          $.restoreActionElements();
        });
      });
      $(BUTTON_SELECTORS).each(function() {
        $(this).buildButton();
      });
    };
    $(document).on("confirm:complete", function() {
      $.restoreActionElements();
    });
    $(document).on("click", BUTTON_SELECTORS, function(e) {
      var _e$target$attributes$;
      var button = $(this);
      if (((_e$target$attributes$ = e.target.attributes.getNamedItem("target")) == null ? void 0 : _e$target$attributes$.value) === "_blank") return;
      $.disableActionElements();
      if (!button.hasClass("button--no-spinner")) {
        $(this).showSpinner();
      }
    });
    $(document).on("ready page:load turbolinks:load", onDOMReady);
    $(document).on("beforeunload turbolinks:before-visit", function() {
      $.restoreActionElements();
    });
  })(jQuery);
  $.extend({
    restoreActionElements: function restoreActionElements() {
      setTimeout(function() {
        $(BUTTON_SELECTORS).each(function(_, button) {
          setTimeout(function() {
            $(button).find(".spinner").hide();
            $(button).width($(button).data("oldWidth"));
          }, SPINNER_ANIMATION_TIMEOUT);
        });
        $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function() {
          $(this).removeClass("actions--disabled");
        });
      }, 100);
    },
    disableActionElements: function disableActionElements() {
      $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function() {
        $(this).addClass("actions--disabled");
      });
    }
  });
  $.fn.extend({
    buildButton: function buildButton() {
      var button = $(this);
      if (button.is("[class^=button]")) {
        if (!button.hasClass("button--no-spinner")) {
          button.width(button.width());
          button.data("oldWidth", button.width());
          if (button.find(".spinner").length == 0) {
            button.prepend('\n          <div class="spinner">\n            <div class="bounce1"></div>\n            <div class="bounce2"></div>\n            <div class="bounce3"></div>\n          </div>');
          }
        }
        button.closest("form").on("ajax:success", function() {
          $.restoreActionElements();
        }).on("ajax:error", function() {
          $.restoreActionElements();
        });
      }
    },
    showSpinner: function showSpinner() {
      var button = $(this);
      button.width(button.width() + $(".spinner").outerWidth(true));
      setTimeout(function() {
        button.find(".spinner").css("display", "inline-flex");
      }, SPINNER_ANIMATION_TIMEOUT);
    }
  });
  (function($) {
    $(document).on("click", '[data-toggle="collapse"]', function(e) {
      e.preventDefault();
      var target = $(this).attr("data-target");
      if ($(target).is(":hidden")) {
        $(this).openCollapse();
      } else {
        $(this).closeCollapse();
      }
    });
  })(jQuery);
  $.fn.extend({
    openCollapse: function openCollapse() {
      var target = $(this).attr("data-target");
      $(this).trigger("bc.collapse.open");
      $(this).attr("data-visible", true);
      $(this).find(".collapse__icon").addClass("collapse__icon--open");
      $(target).slideDown();
      $(this).trigger("bc.collapse.opened");
    },
    closeCollapse: function closeCollapse() {
      var target = $(this).attr("data-target");
      $(this).trigger("bc.collapse.close");
      $(this).attr("data-visible", false);
      $(this).find(".collapse__icon").removeClass("collapse__icon--open");
      $(target).slideUp();
      $(this).trigger("bc.collapse.closed");
    }
  });
  (function($) {
    var onDOMReady = function onDOMReady() {
      $(".flash").each(function() {
        $(this).css("right", -$(this).width() + "px");
      });
      setTimeout(function() {
        $(".flash").addClass("flash--shown");
      }, 100);
    };
    $(document).on("click", ".flash__close", function() {
      $.closeAlert();
    });
    $(document).on("ready page:load turbolinks:load bc.flash.shown", onDOMReady);
  })(jQuery);
  $.extend({
    showFlash: function showFlash(status, message) {
      var flash = '\n        <div class="flash">\n          <div class="flash__icon flash__icon--' + status + '">\n            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M12 2c5.514 0 10 4.486 10 10s-4.486 10-10 10-10-4.486-10-10 4.486-10 10-10zm0-2c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm6 16.538l-4.592-4.548 4.546-4.587-1.416-1.403-4.545 4.589-4.588-4.543-1.405 1.405 4.593 4.552-4.547 4.592 1.405 1.405 4.555-4.596 4.591 4.55 1.403-1.416z"></path></svg>\n          </div>\n          <div class="flash__message">\n            ' + message + '\n          </div>\n          <div class="flash__close">\n            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"></path></svg>\n          </div>\n        </div>';
      $(document).trigger("bc.flash.show");
      $("#flash").html(flash);
      $(document).trigger("bc.flash.shown");
    },
    closeAlert: function closeAlert() {
      $(document).trigger("bc.flash.hide");
      $(".flash").removeClass("flash--shown").delay(700).queue(function() {
        $(this).remove();
      });
      $(document).trigger("bc.flash.hidden");
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
      $("form").on("change", 'input[type="file"]', function(_ref) {
        var _input$files, _input$getAttribute, _input$value;
        var input = _ref.currentTarget;
        var label = $(".input__file__text." + input.getAttribute("id"));
        if (!label) return;
        var noFileText = input.getAttribute("data-no-file-text");
        var svgFileIcon = '\n        <svg class="input__file__icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">\n          <path d="M15 2v5h5v15h-16v-20h11zm1-2h-14v24h20v-18l-6-6z"/>\n        </svg>';
        var fileName = ((_input$files = input.files) == null ? void 0 : _input$files.length) > 1 ? (_input$getAttribute = input.getAttribute("data-multiple-selection-text")) == null ? void 0 : _input$getAttribute.replace("{count}", input.files.length) : ((_input$value = input.value) == null ? void 0 : _input$value.split("\\").pop()) || "";
        fileName ? label.html("" + svgFileIcon + fileName) : label.html(noFileText);
      });
    };
    var addInputFocusClass = function addInputFocusClass() {
      $("form").on("focus", 'input[type="file"]', function(_ref2) {
        var input = _ref2.currentTarget;
        input.addClass("has-focus");
      });
    };
    var removeInputFocusClass = function removeInputFocusClass() {
      $("form").on("blur", 'input[type="file"]', function(_ref3) {
        var input = _ref3.currentTarget;
        input.removeClass("has-focus");
      });
    };
    var initializeClearOnClickInputs = function initializeClearOnClickInputs() {
      $("form").on("click", 'input[type="file"][data-clear-on-click="true"]', function() {
        var dt = new DataTransfer();
        this.files = dt.files;
        this.dispatchEvent(new Event("change", {
          bubbles: true,
          composed: true
        }));
      });
    };
    $(document).on("ready page:load turbolinks:load", function() {
      return onDOMReady();
    });
  })(jQuery);
  (function($) {
    var onDOMReady = function onDOMReady() {
      $(".modal").each(function() {
        $(this).hide().css("visibility", "visible");
      });
    };
    $(document).on("click", '[data-toggle="modal"]', function(e) {
      e.preventDefault();
      var dataTarget = $(this).attr("data-target");
      $.restoreActionElements();
      $(dataTarget).showModal();
    });
    $(document).on("click", '[data-dismiss="modal"]', function(e) {
      e.preventDefault();
      var dataTarget = $(this).closest(".modal");
      $.restoreActionElements();
      $(dataTarget).hideModal();
    });
    $(document).on("ready page:load turbolinks:load", onDOMReady);
  })(jQuery);
  $.fn.extend({
    showModal: function showModal() {
      var modal = $(this);
      modal.trigger("bc.modal.show");
      $.restoreActionElements();
      modal.css("display", "flex");
      modal.trigger("bc.modal.shown");
    },
    hideModal: function hideModal() {
      var modal = $(this);
      modal.trigger("bc.modal.hide");
      $.restoreActionElements();
      modal.hide();
      modal.trigger("bc.modal.hidden");
    }
  });
  const template = `<style>:host{display:inline-block;position:relative}:host([hidden]){display:none}s{position:absolute;top:0;bottom:0;left:0;right:0;pointer-events:none;background:var(--scroll-shadow-top,radial-gradient(farthest-side at 50% 0,#0003,#0000)) top/100% var(--top),var(--scroll-shadow-bottom,radial-gradient(farthest-side at 50% 100%,#0003,#0000)) bottom/100% var(--bottom),var(--scroll-shadow-left,radial-gradient(farthest-side at 0,#0003,#0000)) left/var(--left) 100%,var(--scroll-shadow-right,radial-gradient(farthest-side at 100%,#0003,#0000)) right/var(--right) 100%;background-repeat:no-repeat}</style><slot></slot><s></s>`;
  const updaters = new WeakMap();
  class ScrollShadowElement extends HTMLElement {
    constructor() {
      super();
      this.attachShadow({
        mode: "open"
      }).innerHTML = template;
      updaters.set(this, new Updater(this.shadowRoot.lastElementChild));
    }
    static get observedAttributes() {
      return [ "el" ];
    }
    get el() {
      return this.getAttribute("el");
    }
    set el(value) {
      this.setAttribute("el", value);
    }
    connectedCallback() {
      this.shadowRoot.querySelector("slot").addEventListener("slotchange", () => this.start());
      this.start();
    }
    disconnectedCallback() {
      updaters.get(this).stop();
    }
    attributeChangedCallback(_name, oldValue, newValue) {
      if (oldValue !== newValue) {
        this.scrollEl = newValue ? this.querySelector(newValue) : null;
        this.start();
      }
    }
    start() {
      updaters.get(this).start(this.scrollEl || this.firstElementChild, this.scrollEl ? this.firstElementChild : null);
    }
  }
  class Updater {
    constructor(targetElement) {
      const update = this.update.bind(this, targetElement, getComputedStyle(targetElement));
      this.handleScroll = throttle(update);
      this.rO = new ResizeObserver(update);
      this.mO = new MutationObserver(() => this.start(this.el, this.rootEl));
    }
    start(element, rootElement) {
      if (this.el) this.stop();
      if (element) {
        element.addEventListener("scroll", this.handleScroll);
        [ element, ...element.children ].forEach(el => this.rO.observe(el));
        this.mO.observe(element, {
          childList: true
        });
        this.el = element;
      }
      if (rootElement) {
        this.rO.observe(rootElement);
        this.rootEl = rootElement;
      }
    }
    stop() {
      this.el.removeEventListener("scroll", this.handleScroll);
      this.mO.disconnect();
      this.rO.disconnect();
      this.el = this.rootEl = null;
    }
    update(targetElement, computedStyle) {
      const {
        el,
        rootEl
      } = this;
      if (!el) return;
      const maxSize = Number(computedStyle.getPropertyValue("--scroll-shadow-size")) || 14;
      const style = {
        "--top": clamp(el.scrollTop, 0, maxSize),
        "--bottom": clamp(el.scrollHeight - el.offsetHeight - el.scrollTop, 0, maxSize),
        "--left": clamp(el.scrollLeft, 0, maxSize),
        "--right": clamp(el.scrollWidth - el.offsetWidth - el.scrollLeft, 0, maxSize)
      };
      if (rootEl) {
        const clientRect = el.getBoundingClientRect();
        const rootClientRect = rootEl.getBoundingClientRect();
        Object.assign(style, {
          top: clamp(clientRect.top - rootClientRect.top),
          bottom: clamp(rootClientRect.bottom - clientRect.bottom),
          left: clamp(clientRect.left - rootClientRect.left),
          right: clamp(rootClientRect.right - clientRect.right)
        });
      }
      for (const key in style) {
        targetElement.style.setProperty(key, `${style[key]}px`);
      }
    }
  }
  function clamp(num, min = 0, max) {
    if (num < min) return min;
    if (num > max) return max;
    return num;
  }
  function throttle(callback) {
    let id = null;
    return () => {
      if (id) return;
      id = requestAnimationFrame(() => {
        callback();
        id = null;
      });
    };
  }
  if ("customElements" in window && "ResizeObserver" in window) {
    customElements.define("scroll-shadow", ScrollShadowElement);
  }
});
