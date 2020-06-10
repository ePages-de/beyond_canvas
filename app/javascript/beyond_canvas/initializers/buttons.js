import {
  disableActionElements,
  enableActionElements,
  hideSpinner,
  showSpinner,
} from './functions';

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
        </div>`);

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

  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);
