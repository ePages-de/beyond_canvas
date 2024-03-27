(function ($) {
  $(document).on('click', '[data-toggle="collapse"]', function (e) {
    e.preventDefault();

    const target = $(this).attr('data-target');

    if ($(target).is(':hidden')) {
      $(this).openCollapse();
    } else {
      $(this).closeCollapse();
    }
  });
})(jQuery);

$.fn.extend({
  openCollapse: function () {
    const target = $(this).attr('data-target');

    $(this).trigger('bc.collapse.open');

    $(this).attr('data-visible', true);
    $(this).find('.collapse__icon').addClass('collapse__icon--open');
    $(target).slideDown();

    $(this).trigger('bc.collapse.opened');
  },
  closeCollapse: function () {
    const target = $(this).attr('data-target');

    $(this).trigger('bc.collapse.close');

    $(this).attr('data-visible', false);
    $(this).find('.collapse__icon').removeClass('collapse__icon--open');
    $(target).slideUp();

    $(this).trigger('bc.collapse.closed');
  },
});
