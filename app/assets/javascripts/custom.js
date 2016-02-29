$(document).ready(function(){
  $(".open_modal").click(function(){
    $("#order_id").val($(this).attr('id'));
    $("#note_modal").modal();
  })

  $('.list-table').DataTable();
})
