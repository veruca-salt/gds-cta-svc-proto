$( document ).on('turbolinks:load', function() {     // have to include turbolinks event so it fires every visit

jQuery(function() {

	// on initial entry remove system options
	$('#system_id option').remove();
	row = "<option value=\"" + "" + "\">" + "No Systems Available" + "</option>";
    $(row).appendTo("#system_id");


  $('#department_id').change(function() {
  	var row, deptId;

    if ($('#department_id :selected').html() == 'Select a department' || $('#department_id :selected').html() == '') {
    	$('#system_id option').remove();
    	row = "<option value=\"" + "" + "\">" + "No Systems Available" + "</option>";
    	$(row).appendTo("#system_id");
    } else {
    	deptId = $('#department_id :selected').val();
    	$('#system_id option').remove();     // remove options

	   	$.ajax({
		      dataType: "json",
		      cache: false,
		      url: '/get_systems_by_dept/' + deptId,
		      timeout: 5000,
		      error: function(XMLHttpRequest, errorTextStatus, error) {
		       console.log("Failed to submit : " + errorTextStatus + " ;" + error);
		      },
		       success: function(data) {
		       	// create options
		      	if (! data || data.length == 0) {
			       row = "<option value=\"" + "" + "\">" + "No Systems Available" + "</option>";
		    	   $(row).appendTo("#system_id");
		      	} else {
			       row = "<option value=\"" + "" + "\">" + "Select a system" + "</option>";
		    	   $(row).appendTo("#system_id");
			       // populate select
			       $.each(data, function(i, j) {
				        row = "<option value=\"" + j.id + "\">" + j.sys_name + "</option>";
				        $(row).appendTo("#system_id");
			       });
		   		}
		      }
	    }) 
	}
    	
  });

});

})