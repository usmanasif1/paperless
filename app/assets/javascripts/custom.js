$(document).ready(function(){
  $(".open_modal").click(function(){
    $("#order_id").val($(this).attr('id'));
    $("#note_modal").modal();
  });

  $(".open_modal_upload_file").click(function(){
    $("#folder_id").val($(this).attr('id'));
    $("#folder_modal").modal();
  });

  $(".move-folder-file").click(function(){
    $("#move_file_id").val($(this).attr('id'));
    name_string = $(this).attr('name'); 
    $("#name_of_moving_item").html('');
    $("#name_of_moving_item").html('<strong>'+ name_string +'</strong>');
    str = $(this).attr('id');
    arr = str.split('-');
    $.ajax({
      type: 'get',
      url: '/folders/get_folder_list',
      dataType:'JSON',
      data: {
        'type' : arr[1],
        'id' : arr[0]
      },
      success:function(data){
        //clear the current content of the select
        $select = $("#user_folders_select");
        $select.html('');
        $select.html('<option></option>');
        //iterate over the data and append a select option
        if(arr[1] == 'folder')
        {
          if(data["parent"] != null)
          {
            $select.append('<option value="' + data["parent"].id + '" name="' + data["parent"].id + '" >' + data["parent"].name + '</option>');
          } 
          $.each(data["folders"], function(key, val){
            if(val.id != arr[0])
            {
              $select.append('<option value="' + val.id + '" name="' + val.id + '" >' + val.name + '</option>');
            }
          })
        }else{
          $.each(data["folders"], function(key, val){
            $select.append('<option value="' + val.id + '" name="' + val.id + '" >' + val.name + '</option>');
          })
        }
        $("#move_modal").modal();
      }
    });
  });

  $('.list-table').DataTable();

  $('#tree-my').on('changed.jstree', function (e, data) {
    var parent = "#"+ data.node.id
    arr = parent.split('-');
    arr1 = arr[0].split('#');
    id = arr1[1]
    $.ajax({
      type: 'get',
      url: '/folders/get_html',
      dataType: 'html',
      data: {
        'id' : id
      },
      success: function (data) {                  
        $("#main-div-data").html('');
        $("#main-div-data").html(data);
      }
    });
    // data.instance.toggle_node(data.node);
  });

  $("#tree-my").on("open_node.jstree", function(event, data) {
    // console.log(data.instance);
    var parent = "#"+ data.node.id
    // Call Ajax Here to get children of targeted folder
    $.ajax({
      type: 'get',
      url: '/folders/get_folders',
      dataType: 'json',
      data: {
        'id' : data.node.id
      },
      success: function (data) {                  
        // Apply loop here to create nodes
        for(var i= 0 ; i< data.length; i++)
        {
          child = $('#'+data[i].fdr_id+'-child')
          if(child.length)
          {
          }else{
            createNode(parent, data[i].fdr_id , data[i].name , 'first', data[i].sub_fdr);
          }
        }
        if(data.length > 0 )
        {
          $('#ch-1').remove();
          $(parent+"-child").remove();
        }
      }
    });
  });
  
  function createNode(parent_node, new_node_id, new_node_text, position, sub_fdr) {
    $('#tree-my').jstree('create_node', $(parent_node), { "text":new_node_text, "id":new_node_id+'-child' }, position, false, false); 
    if(sub_fdr == 1 )
    {
      $('#tree-my').jstree('create_node', $("#"+new_node_id+ '-child'), { "text":'', "id":new_node_id+'-child-child' }, position, false, false); 
    }
  }


  $("#tree-my").jstree({
    'core' : {
      'check_callback' : true,
      'data': [{ 'id' : $('#root_folder_id').val()+'-root', 'text' : '', 'state' : {'opened':false}, 'children' : [{'id': 'ch-1', 'text': 'child 1'}]}]
    }
  });
})
