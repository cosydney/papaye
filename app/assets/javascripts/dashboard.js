$(function(){
  $(function () {
    $('.invoice-wrapper .fa').tooltip()
  });

$('#see-activities').click(function(){
    $('#activities').removeClass("hidden")
    $(this).addClass('hidden')
  });
  $('#hide-activities').click(function(){
    $('#activities').addClass("hidden")
    $('#see-activities').removeClass('hidden')

  });
})