/*
 * Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/beyond_canvas/' and run `yarn build`
 */
//= require jquery3
//= require_self

(function(factory) {
  typeof define === "function" && define.amd ? define([ "jquery" ], factory) : factory();
})(function() {
  "use strict";
  var SPINNER_ANIMATION_TIMEOUT = 125;
  var BUTTON_SELECTORS = 'button[class^="button__"], a[class^="button__"]';
  (function($) {
    var onDOMReady = function onDOMReady(e) {
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
        var button = $(this);
        button.width(button.width());
        button.data("oldWidth", button.width());
        if (button.find(".spinner").length == 0) {
          button.prepend('\n          <div class="spinner">\n            <div class="bounce1"></div>\n            <div class="bounce2"></div>\n            <div class="bounce3"></div>\n          </div>');
        }
        button.closest("form").on("ajax:success", function() {
          $.restoreActionElements();
        }).on("ajax:error", function() {
          $.restoreActionElements();
        });
      });
    };
    $(document).on("confirm:complete", function() {
      $.restoreActionElements();
    });
    $(document).on("click", '[class^="button"]', function() {
      $.disableActionElements();
      $(this).showSpinner();
    });
    $(document).on("ready page:load turbolinks:load", onDOMReady);
  })(jQuery);
  $.extend({
    restoreActionElements: function restoreActionElements() {
      $(BUTTON_SELECTORS).each(function(_, button) {
        setTimeout(function() {
          $(button).find(".spinner").hide();
          $(button).width($(button).data("oldWidth"));
        }, SPINNER_ANIMATION_TIMEOUT);
      });
      $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function() {
        $(this).removeClass("actions--disabled");
      });
    },
    disableActionElements: function disableActionElements() {
      $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function() {
        $(this).addClass("actions--disabled");
      });
    }
  });
  $.fn.extend({
    showSpinner: function showSpinner() {
      var button = $(this);
      button.width(button.width() + $(".spinner").outerWidth(true));
      setTimeout(function() {
        button.find(".spinner").css("display", "flex");
      }, SPINNER_ANIMATION_TIMEOUT);
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
    $(document).on("click", ".flash", function() {
      closeAlert();
    });
    $(document).on("ready page:load turbolinks:load", onDOMReady);
  })(jQuery);
  function closeAlert() {
    $(".flash").removeClass("flash--shown").delay(700).queue(function() {
      $(this).remove();
    });
  }
  (function($) {
    var onDOMReady = function onDOMReady() {
      $('input[type="file"]').each(function() {
        var $input = $(this), $label = $(".input__file__text." + $input.attr("id")), labelVal = $label.html();
        $input.on("change", function(e) {
          var fileName = "";
          if (this.files && this.files.length > 1) fileName = (this.getAttribute("data-multiple-caption") || "").replace("{count}", this.files.length); else if (e.target.value) fileName = e.target.value.split("\\").pop();
          if (fileName) $label.html('<svg class="input__file__icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M15 2v5h5v15h-16v-20h11zm1-2h-14v24h20v-18l-6-6z"/></svg>' + fileName); else $label.html(labelVal);
        });
        $input.on("focus", function() {
          $input.addClass("has-focus");
        }).on("blur", function() {
          $input.removeClass("has-focus");
        });
      });
    };
    $(document).on("ready page:load turbolinks:load", onDOMReady);
  })(jQuery);
  (function($) {
    $(document).on("click", ".modal__close", function(e) {
      $.closeModal();
    });
  })(jQuery);
  $.extend({
    displayModal: function displayModal(modalContent) {
      $("#modal").find("#modal__content").html(modalContent);
      $("#modal").css("display", "flex");
    },
    closeModal: function closeModal() {
      $("#modal").find("#modal__content").empty();
      $("#modal").css("display", "none");
      $.restoreActionElements();
    }
  });
});
