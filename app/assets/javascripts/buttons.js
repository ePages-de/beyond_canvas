$(document).ready(function() {
  ('use strict');

  $('[class^="button"][type=submit]').each(function() {
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
      .on('ajax:success', function() {
        hideSpinner(button);
        enableActionElements();
      })
      .on('ajax:error', function() {
        hideSpinner(button);
        enableActionElements();
      });
  });

  // Bind click event to buttons
  $('[class^="button"][type=submit]').click(function() {
    disableActionElements();
    showSpinner($(this));
  });
});

function showSpinner(button) {
  // Adjust the width of the button
  button.width(button.width() + $('.spinner').outerWidth(true));
  // Show the spinner
  setTimeout(function() {
    button.find('.spinner').css('display', 'flex');
  }, 125);
}

function hideSpinner(button) {
  // Hide the spinner
  button.find('.spinner').hide();
  // Adjust the width of the button
  button.width(button.data('oldWidth'));
}

function disableActionElements() {
  $('a, input[type="submit"], button').each(function() {
    $(this).addClass('actions--disabled')
  });
}
function enableActionElements() {
  $('a, input[type="submit"], button').each(function() {
    $(this).removeClass("actions--disabled");
  });
}
