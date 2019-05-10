$( document ).on('turbolinks:load', function() {     // have to include turbolinks event so it fires every visit

jQuery(function() {

	// remove dropdown options of the same system name
	$('#linked_sys_tbl tbody tr').each(function(i) {	
		var acronymn = $('#system_acronymn').val();
		if (acronymn != '') $(this).find('select').eq(0).find('option:contains('+ acronymn +')').remove();
    });

	// add a new linked system row
	$('#add_new_system').click(function() {
	    // clone existing row and copy it, blank out the value of the id and set default values
	    var newRow = $('#linked_sys_tbl tbody tr:last').clone();
	    $(newRow).find('.this_id').attr('value', '');  //blank out the system link id
	    if ($(newRow).find('select').eq(0).find('option:first').html() == 'Select a system') $(newRow).find('select').eq(0).find('option:first').remove();
	    if ($(newRow).find('select').eq(1).find('option:first').html() == 'Select a protocol') $(newRow).find('select').eq(1).find('option:first').remove();
	    $(newRow).find('select').eq(0).prepend("<option value='Select a system' selected='selected'>Select a system</option>");
	    $(newRow).find('select').eq(1).prepend("<option value='Select a protocol' selected='selected'>Select a protocol</option>");
		$('#linked_sys_tbl tbody').append(newRow);	// add the row to the table
		
		var total = $('#linked_sys_tbl tbody tr').length;  // get total
		$('#linked_sys_tbl tbody tr').each(function(i) {	// reorder the el ids
	        if (i === 0)
	            return;

	        // Linked system IDs
	        // hidden id
	        var textinput = $(this).find('.this_id');
    		textinput.attr('id', 'system_system_links_attributes_' + i + '_id');
	        textinput.attr('name', 'system[system_links_attributes][' + i + '][id]');

	        var selectinput = $(this).find('select');
	        // system b id
	        selectinput.eq(0).attr('id', 'system_system_links_attributes_' + i + '_system_b_id');
	        selectinput.eq(0).attr('name', 'system[system_links_attributes][' + i + '][system_b_id]');
	        
	        // Protocol
	        selectinput.eq(1).attr('id', 'system_system_links_attributes_' + i + '_protocol');
	        selectinput.eq(1).attr('name', 'system[system_links_attributes][' + i + '][protocol]');
    	});

	}); 

	// remove a row from linked systems
	$('#linked_sys_tbl').on('click', '.remove_link', function() {
		// clone existing row as if all rows removed we should always insert a blank one
		var newRow = $('#linked_sys_tbl tbody tr:last').clone();
		$(newRow).find('.this_id').attr('value', '');  //blank out the system link id
	    if ($(newRow).find('select').eq(0).find('option:first').html() == 'Select a system') $(newRow).find('select').eq(0).find('option:first').remove();
	    if ($(newRow).find('select').eq(1).find('option:first').html() == 'Select a protocol') $(newRow).find('select').eq(1).find('option:first').remove();
	    $(newRow).find('select').eq(0).prepend("<option value='Select a system' selected='selected'>Select a system</option>");
	    $(newRow).find('select').eq(1).prepend("<option value='Select a protocol' selected='selected'>Select a protocol</option>");

		// if this row already exists on the db then remove it there as well
		var sysLinkId = $(this).closest('tr').find('.this_id').val();	// get system link id
		if (sysLinkId != '') {
		  	$.ajax({
			      dataType: "json",
			      cache: false,
			      url: '/system_links/remove/' + sysLinkId,
			      timeout: 5000,
			      //async: false,	
			      error: function(XMLHttpRequest, errorTextStatus, error) {
			       console.log("Failed to submit : " + errorTextStatus + " ;" + error);
			      },
			       success: function(data) {
			       	$('#linked_sys_tbl tbody :input[value=' + sysLinkId + ']').remove();  // remove the hidden input which is the system link id
			      }
		       }) 
	  	}
	 
	  	$(this).closest('tr').remove();		// remove the row
	  	
	  	// get total rows remaining, if 0 then add blanked cloned row
	  	var count = $('#linked_sys_tbl tbody tr').length;
	  	if (count == 0) $('#linked_sys_tbl tbody').append(newRow);

	});

	// Validation for selected linked system - can't select 2 of the same
	$(document).delegate('.selectValid', 'input', function() { 
		var value = $(this).find(':selected').html();  // get the value
		var obj = $(this);  // get the current selected dropdown oject

		//check other values and if one already exists that matches reset this one
		$('.selectValid').not(this).each(function() {
			var curRow = $(this).find(':selected').html();
			if (value == curRow) { 
				obj.val('Select a system');
			}
		});


	});
	


});

})