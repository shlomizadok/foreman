$(function() {
  $('#review_before_build').on('change', "#build_reboot", function(e) {
    if (this.checked) {
      $("#build_form input").val(__("Reboot and build"));
    } else {
      $("#build_form input").val(__("Build"));
    }
  });
});

