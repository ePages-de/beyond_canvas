(function ($) {
  const onDOMReady = function () {
    $('input[type="file"]').each(function () {
      const $input = $(this);
      const $label = $(`.input__file__text.${$input.attr('id')}`);
      const noFileText = $input.attr('data-no-file-text');
      const svgFileIcon = `
        <svg class="input__file__icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
          <path d="M15 2v5h5v15h-16v-20h11zm1-2h-14v24h20v-18l-6-6z"/>
        </svg>`;

      $input.on('change', function (e) {
        let fileName = '';

        if (this.files && this.files.length > 1)
          fileName = (this.getAttribute('data-multiple-caption') || '{count} files selected').replace(
            '{count}',
            this.files.length
          );
        else if (e.target.value) fileName = e.target.value.split('\\').pop();

        if (fileName) {
          // Adds icon + filename to label
          $label.html(`${svgFileIcon}${fileName}`);
        } else {
          // Adds default no-file text
          $label.html(noFileText);
        }
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

  // Clear previous files on click to upload a new file. This applies to the files
  // inputs inside a form that has the data-clear-on-click="true" setted
  const initializeClearOnClickInputs = function () {
    $('form').on('click', 'input[type="file"][data-clear-on-click="true"]', function () {
      // Clear previous selected files
      const dt = new DataTransfer();

      this.files = dt.files;
      // Trigger change
      this.dispatchEvent(new Event('change', { bubbles: true, composed: true }));
    });
  };

  $(document).on('ready page:load turbolinks:load', () => {
    const observer = new MutationObserver(() => onDOMReady());

    onDOMReady();
    initializeClearOnClickInputs();

    observer.observe(document.body, { childList: true, subtree: true });
  });
})(jQuery);

