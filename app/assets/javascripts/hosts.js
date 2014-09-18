$(function () {
  $('#review_before_build').on('change', "#build_reboot", function () {
    var submit = $("#build_form").find("input");
    submit.value = (this.checked) ? (__("Reboot and build")) : (__("Build"));
  });
});
