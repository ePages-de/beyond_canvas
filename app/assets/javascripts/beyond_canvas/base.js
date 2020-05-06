/*
 * Warning: This file is auto-generated, do not modify. Instead, make your changes in 'app/javascript/beyond_canvas/' and run `yarn build`
 */
//= require jquery
//= require jquery_ujs
//= require_self

(function(factory) {
  typeof define === "function" && define.amd ? define([ "jquery" ], factory) : factory();
})(function() {
  "use strict";
  var SPINNER_ANIMATION_TIMEOUT = 125;
  (function($) {
    $(document).on("click", '[class^="button"]', function() {
      disableActionElements();
      showSpinner($(this));
    });
    $(document).on("ready page:load turbolinks:load", function() {
      $('button[class^="button"]').each(function() {
        var button = $(this);
        button.width(button.width());
        button.data("oldWidth", button.width());
        button.prepend('\n      <div class="spinner">\n        <div class="bounce1"></div>\n        <div class="bounce2"></div>\n        <div class="bounce3"></div>\n      </div>');
        button.closest("form").on("ajax:success", function() {
          hideSpinner(button);
          enableActionElements();
        }).on("ajax:error", function() {
          hideSpinner(button);
          enableActionElements();
        });
      });
    });
  })(jQuery);
  function showSpinner(button) {
    button.width(button.width() + $(".spinner").outerWidth(true));
    setTimeout(function() {
      button.find(".spinner").css("display", "flex");
    }, SPINNER_ANIMATION_TIMEOUT);
  }
  function hideSpinner(button) {
    setTimeout(function() {
      button.find(".spinner").hide();
      button.width(button.data("oldWidth"));
    }, SPINNER_ANIMATION_TIMEOUT);
  }
  function disableActionElements() {
    $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function() {
      $(this).addClass("actions--disabled");
    });
  }
  function enableActionElements() {
    $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function() {
      $(this).removeClass("actions--disabled");
    });
  }
  (function($) {
    $(document).on("click", ".flash", function() {
      closeAlert();
    });
    $(document).on("ready page:load turbolinks:load", function() {
      $(".flash").each(function() {
        $(this).css("right", -$(this).width() + "px");
      });
      setTimeout(function() {
        $(".flash").addClass("flash--shown");
      }, 100);
    });
  })(jQuery);
  function closeAlert() {
    $(".flash").removeClass("flash--shown").delay(700).queue(function() {
      $(this).remove();
    });
  }
  (function($) {
    $(document).on("ready page:load turbolinks:load", function() {
      $('input[type="file"]').each(function() {
        var $input = $(this), $label = $(".input__file__text." + $input.attr("id")), labelVal = $label.html();
        $input.on("change", function(e) {
          var fileName = "";
          if (this.files && this.files.length > 1) fileName = (this.getAttribute("data-multiple-caption") || "").replace("{count}", this.files.length); else if (e.target.value) fileName = e.target.value.split("\\").pop();
          if (fileName) $label.html('<i class="far fa-file input__file__icon"></i>' + fileName); else $label.html(labelVal);
        });
        $input.on("focus", function() {
          $input.addClass("has-focus");
        }).on("blur", function() {
          $input.removeClass("has-focus");
        });
      });
    });
  })(jQuery);
});
