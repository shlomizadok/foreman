$(function () {
  $("#build-review").click(function() {
    $("#review_before_build .modal-body #build_status").html('');
    $('.large-spinner-placeholder').addClass('visible');
    $.ajax({
      type:'get',
      url: $(this).attr('data-url'),
      success: function(result){
       $("#review_before_build .modal-body #build_status").html(result);
      },
      complete: function(){
        $('.large-spinner-placeholder').removeClass('visible');
      }
    })
  });
  $('#review_before_build').on('change', "#host_build", function () {
    $('#build_form').find('input.submit').val((this.checked) ? (__("Reboot and build")) : (__("Build")));
  });

  $('#review_before_build').on('click', "#recheck_review", function () {
    $("#build-review").click();
  });
});
