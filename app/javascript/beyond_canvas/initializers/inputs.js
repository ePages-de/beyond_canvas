(function ($) {
  const onDOMReady = function () {
    updateInputLabel();
    initializeClearOnClickInputs();
    addInputFocusClass();
    removeInputFocusClass();
  };

  const updateInputLabel = () => {
    $('form').on('change', 'input[type="file"]', function ({ currentTarget: input }) {
      const label = $(`.input__file__text.${input.getAttribute('id')}`);

      if(!label) return;

      const noFileText = input.getAttribute('data-no-file-text');
      const svgFileIcon = `
        <svg class="input__file__icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
          <path d="M15 2v5h5v15h-16v-20h11zm1-2h-14v24h20v-18l-6-6z"/>
        </svg>`;
      let fileName = '';

      if (input.files && input.files.length > 1) {
        fileName = (input.getAttribute('data-multiple-caption') || '{count} files selected').replace(
          '{count}',
          input.files.length
        );
      } else if (input.value) {
        fileName = input.value.split('\\').pop();
      }

      if (fileName) {
        // Adds icon + filename to label
        label.html(`${svgFileIcon}${fileName}`);
      } else {
        // Adds default no-file text
        label.html(noFileText);
      }
    });
  };

  const addInputFocusClass = () => {
    $('form').on('focus', 'input[type="file"]', function ({ currentTarget: input }) {
        input.addClass('has-focus');
    });
  };

  const removeInputFocusClass = () => {
    $('form').on('blur', 'input[type="file"]', function ({ currentTarget: input }) {
      input.removeClass('has-focus');
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

  $(document).on('ready page:load turbolinks:load', () => onDOMReady());
})(jQuery);
