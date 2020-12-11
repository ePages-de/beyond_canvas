(function ($) {
  $(document).on('click', "[data-toggle='collapse']", function (e) {
    e.preventDefault();

    $($(this).attr('data-target')).slideToggle();
    $(this).find('.collapse__icon').toggleClass('collapse__icon--open');
  });
})(jQuery);
