const SPINNER_ANIMATION_TIMEOUT = 125;

export function showSpinner(button) {
  // Adjust the width of the button
  button.width(button.width() + $('.spinner').outerWidth(true));
  // Show the spinner
  setTimeout(function () {
    button.find('.spinner').css('display', 'flex');
  }, SPINNER_ANIMATION_TIMEOUT);
}

export function hideSpinner() {
  $('button[class^="button"]').each(function (_, button) {
    setTimeout(function () {
      // Hide the spinner
      $(button).find('.spinner').hide();
      // Adjust the width of the button
      $(button).width($(button).data('oldWidth'));
    }, SPINNER_ANIMATION_TIMEOUT);
  });
}

export function disableActionElements() {
  $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function (_, button) {
    $(button).addClass('actions--disabled');
  });
}
export function enableActionElements() {
  $('a, input[type="submit"], input[type="button"], input[type="reset"], button').each(function (_, button) {
    $(button).removeClass('actions--disabled');
  });
}

export function closeAlert() {
  $('.flash')
    .removeClass('flash--shown')
    .delay(700)
    .queue(function () {
      $(this).remove();
    });
}
