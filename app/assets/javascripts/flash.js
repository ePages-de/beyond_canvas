$(document).ready(function() {
  ("use strict");

  $(".flash").each(function() {
    $(this).css("right", -$(this).width() + "px");
  });

  setTimeout(function() {
    $(".flash").addClass("flash--shown");
  }, 100);

  $(".flash").click(function() {
    closeAlert();
  });

  function closeAlert() {
    $(".flash")
      .removeClass("flash--shown")
      .delay(700)
      .queue(function() {
        $(this).remove();
      });
  }
});
