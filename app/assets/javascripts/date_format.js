$(document).ready(function(){
  $('.datepicker').datepicker({
	   format: "mm/dd/yyyy",
	   autoclose: true,
	});


  $('#month_year').datepicker({
		format: "mm-yyyy",
	    viewMode: "months",
	    minViewMode: "months",
	    autoclose: true,
	});
})