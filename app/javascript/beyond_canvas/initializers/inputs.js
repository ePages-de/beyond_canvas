(function ($) {
  const onDOMReady = function () {
    $('input[type="file"]').each(function () {
      var $input = $(this),
        $label = $(`.input__file__text.${$input.attr('id')}`),
        labelVal = $label.html();

      $input.on('change', function (e) {
        var fileName = '';

        if (this.files && this.files.length > 1)
          fileName = (this.getAttribute('data-multiple-caption') || '').replace(
            '{count}',
            this.files.length
          );
        else if (e.target.value) fileName = e.target.value.split('\\').pop();

        if (fileName)
          $label.html(
            `<svg class="input__file__icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M15 2v5h5v15h-16v-20h11zm1-2h-14v24h20v-18l-6-6z"/></svg>${fileName}`
          );
        else $label.html(labelVal);
      });

      // Firefox bug fix
      $input
        .on('focus', function () {
          $input.addClass('has-focus');
        })
        .on('blur', function () {
          $input.removeClass('has-focus');
        });
    });
  };

  $(document).on('ready page:load turbolinks:load', onDOMReady);
})(jQuery);
