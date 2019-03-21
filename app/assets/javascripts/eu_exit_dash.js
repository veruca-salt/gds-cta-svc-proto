$( document ).on('turbolinks:load', function() {     // have to include turbolinks event so it fires every visit

jQuery(function() {

	// on initial entry remove system options
	$('#system_id option').remove();
	row = "<option value=\"" + "" + "\">" + "No Systems Available" + "</option>";
    $(row).appendTo("#system_id");


  $('#department_id').change(function() {
  	var row, deptId;

  	$('#linked_sys_tbl tbody').empty();		// department has changed, removed linked systems

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
				        row = "<option value=\"" + j.system_id + "\">" + j.sys_name + "</option>";
				        $(row).appendTo("#system_id");
			       });
		   		}
		      }
	    }) 
	}
    	
  });

$('#system_id').change(function() {
  	var row, sysId;

  	if ($('#system_id :selected').html() == 'Select a system' || $('#department_id :selected').html() == 'Select a system') {
    	$('#linked_sys_tbl tbody').empty();		// delete any rows that exist
    } else {
    	$('#linked_sys_tbl tbody').empty();		// delete any rows that exist

    	sysId = $('#system_id :selected').val();	// get data based on system id
	   	$.ajax({
		      dataType: "json",
		      cache: false,
		      url: '/impact/' + sysId,
		      timeout: 5000,
		      error: function(XMLHttpRequest, errorTextStatus, error) {
		       console.log("Failed to submit : " + errorTextStatus + " ;" + error);
		      },
		       success: function(data) {
		       // append to table body
		       var tblRows = '';
		       $.each(data, function (i, sys) {

		       //	console.log('systems......................... ' + JSON.stringify(data));

			       tblRows += "<tr class=\"govuk-table__row\"><td class=\"govuk-table__header\">" + sys.sys_ac + " (" + sys.sys_nm + ")</td>";
			       if (sys.children) tblRows += "<td class=\"govuk-table__header\">" + sys.children[0].sys_ac + " (" + sys.children[0].sys_nm + ")</td>";
			       tblRows += "</tr>";

          		});
          		$('#linked_sys_tbl tbody').append(tblRows);
		      }
	    }) 
	}
});  	


});

})