const SPINNER_ANIMATION_TIMEOUT = 125;
const BUTTON_SELECTORS = '[class^="button"]';

(function ($) {
  const onDOMReady = function () {
    const inputs = $('input, textarea, select').not(
      ':input[type=button], :input[type=submit], :input[type=reset]'
    );

    inputs.each(function () {
      var input = $(this);

      input.bind('invalid', function (e) {
        if ($(input).is(':hidden')) {
          e.preventDefault();
        }
        $.restoreActionElements();
      });
    });

    $(BUTTON_SELECTORS).each(function () {
      $(this).buildButton();
    });
  };

  $(document).on('confirm:complete', function ()  {
    $.restoreActionElements();
  });

  $(document).on('click', BUTTON_SELECTORS, function () {
    var button = $(this);

    $.disableActionElements();

    if (!button.hasClass('button--no-spinner')) {
      $(this).showSpinner();
    }
  });

  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);

$.extend({
  restoreActionElements: function () {
    // Hide spinners
    $(BUTTON_SELECTORS).each(function (_, button) {
      setTimeout(function () {
        // Hide the spinner
        $(button).find('.spinner').hide();
        // Adjust the width of the button
        $(button).width($(button).data('oldWidth'));
      }, SPINNER_ANIMATION_TIMEOUT);
    });

    // Enable action elements
    $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function () {
      $(this).removeClass('actions--disabled');
    });
  },
  disableActionElements: function () {
    $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function () {
      $(this).addClass('actions--disabled');
    });
  }
});

$.fn.extend({
  buildButton: function() {
    var button = $(this);

    if (button.is('[class^=button]')) {
      if (!button.hasClass('button--no-spinner')) {
        // Add width attribute and save old width
        button.width(button.width());
        button.data('oldWidth', button.width());

        // Add the spinner
        if (button.find('.spinner').length == 0) {
          button.prepend(`
          <div class="spinner">
            <div class="bounce1"></div>
            <div class="bounce2"></div>
            <div class="bounce3"></div>
          </div>`);
        }
      }

      // Bind ajax:success and ajax:error to the form the button belongs to
      button
        .closest('form')
        .on('ajax:success', function () {
          $.restoreActionElements();
        })
        .on('ajax:error', function () {
          $.restoreActionElements();
        });
    }
  },
  showSpinner: function () {
    var button = $(this);

    // Adjust the width of the button
    button.width(
      button.width() + $('.spinner').outerWidth(true)
    );

    // Show the spinner
    setTimeout(function () {
      button.find('.spinner').css('display', 'inline-flex');
    }, SPINNER_ANIMATION_TIMEOUT);
  }
});
