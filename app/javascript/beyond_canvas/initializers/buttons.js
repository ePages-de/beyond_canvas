const SPINNER_ANIMATION_TIMEOUT = 125;

(function($) {
  const onDOMReady = function () {
    const inputs = $('input, textarea, select').not(':input[type=button], :input[type=submit], :input[type=reset]');

    inputs.each(function () {
      var input = $(this);

      input.bind('invalid', function (e) {
        if ($(input).is(':hidden')) {
          e.preventDefault();
        }
        $('button[class^="button"]').each(function () {
          hideSpinner($(this));
        });
        enableActionElements();
      });
    });

    $('button[class^="button"]').each(function () {
      var button = $(this);

      // Add width attribute and save old width
      button.width(button.width());
      button.data('oldWidth', button.width());

      // Add the spinner
      button.prepend(`
        <div class="spinner">
          <div class="bounce1"></div>
          <div class="bounce2"></div>
          <div class="bounce3"></div>
        </div>`
      );

      // Bind ajax:success and ajax:error to the form the button belongs to
      button
        .closest('form')
        .on('ajax:success', function () {
          hideSpinner(button);
          enableActionElements();
        })
        .on('ajax:error', function () {
          hideSpinner(button);
          enableActionElements();
        });
    });
  };

  $(document).on('click', '[class^="button"]', function () {
    disableActionElements();
    showSpinner($(this));
  });

  $(document)
    .on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);

function showSpinner(button) {
  // Adjust the width of the button
  button.width(button.width() + $('.spinner').outerWidth(true));
  // Show the spinner
  setTimeout(function() {
    button.find('.spinner').css('display', 'flex');
  }, SPINNER_ANIMATION_TIMEOUT);
}

function hideSpinner(button) {
  setTimeout(function () {
    // Hide the spinner
    button.find('.spinner').hide();
    // Adjust the width of the button
    button.width(button.data('oldWidth'));
  }, SPINNER_ANIMATION_TIMEOUT);
}

function disableActionElements() {
  $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function() {
    $(this).addClass('actions--disabled');
  });
}
function enableActionElements() {
  $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function() {
    $(this).removeClass('actions--disabled');
  });
}
