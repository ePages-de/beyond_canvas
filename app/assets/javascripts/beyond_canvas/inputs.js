(function($) {
  $(document).on('ready page:load turbolinks:load', function() {
    $('input[type="file"]').each(function() {
      var $input = $(this),
				$label = $(`.input__file__text.${$input.attr('id')}`),
				labelVal = $label.html();

      $input.on('change', function(e) {
        var fileName = '';

        if (this.files && this.files.length > 1)
          fileName = (this.getAttribute('data-multiple-caption') || '').replace('{count}', this.files.length);
        else if (e.target.value)
          fileName = e.target.value.split('\\').pop();

        if (fileName)
          $label.html(`<i class="far fa-file input__file__icon"></i>${fileName}`);
        else
          $label.html(labelVal);
      });

      // Firefox bug fix
      $input
        .on('focus', function() { $input.addClass('has-focus'); })
        .on('blur', function() { $input.removeClass('has-focus'); });
    });
  });
})(jQuery);
