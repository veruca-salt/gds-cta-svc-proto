$( document ).on('turbolinks:load', function() { 

	jQuery(function() {

		// Hide the extra divs when entering the page
		$('#program_text_div').hide();
		$('#agency_text_div').hide();

		// Switch to div to add a new programme
		$( '#toggle_new_program' ).click(function() {
			$('#program_text_div').show();
			$('#program_select_div').hide();
		});

		// Switch to div to select an existing programme
		$( '#toggle_existing_program' ).click(function() {
			$('#program_text_div').hide();
			$('#program_select_div').show();
		});

		// Switch to div to add a new programme
		$( '#toggle_new_agency' ).click(function() {
			$('#agency_text_div').show();
			$('#agency_select_div').hide();
		});

		// Switch to div to select an existing programme
		$( '#toggle_existing_agency' ).click(function() {
			$('#agency_text_div').hide();
			$('#agency_select_div').show();
		});

		$('form').submit(function(e) {
		  e.preventDefault();		// prevent default submit behaviour to update program and agency ids

		  // if 'Select a program' then do not add a program and skip
		  if ($('#service_program_name').html() != 'Select a program' && $('#service_program_name').html() == '') {
			  // only run the functions if it is the 'new' option otherwise use the existing value
			  if($("#program_select_div").css('display') == 'none') {
			  	// a new program is being added
			  	var newProgramIdAdded = addNewProgramSubmit();
	          }
	      }
	      if ($('#service_agency_name').html() != 'Select an agency' && $('#service_agency_name').html() == '') {
	          if($("#agency_select_div").css('display') == 'none') {
			  	// a new agency is being added
			  	var newAgencyIdAdded = addNewAgencySubmit();
	          }
	      }
		  
		 $('form').trigger('submit.rails');		// submit the rails form
		});

	});
})

		// CHANGE TO USE PROMISE eg currently async: false
		function addNewProgramSubmit() {
		  var progName = $('#service_program_name').val();	// get the program name

		  // execute logic to add new program id
		  $.ajax({
		      dataType: "json",
		      cache: false,
		      url: '/programs/add/' + progName,
		      timeout: 5000,
		      async: false,	
		      error: function(XMLHttpRequest, errorTextStatus, error) {
		       console.log("Failed to submit : " + errorTextStatus + " ;" + error);
		      },
		       success: function(data) {
		       	$.each(data, function(i, j) {
	       			$("#service_program_id :selected").val(j.id);	// set the value
			     });
		      }
	       }) 
		}


		// CHANGE TO USE PROMISE eg currently async: false
		function addNewAgencySubmit() {
		  var agencyName = $('#service_agency_name').val();		// get the agency name

		  // execute logic to add new agency id
		  $.ajax({
		      dataType: "json",
		      cache: false,
		      url: '/agencies/add/' + agencyName,
		      timeout: 5000,
		      async: false,	
		      error: function(XMLHttpRequest, errorTextStatus, error) {
		       console.log("Failed to submit : " + errorTextStatus + " ;" + error);
		      },
		       success: function(data) {
		       	$.each(data, function(i, j) {
	       			$("#service_agency_id :selected").val(j.id);	// set the value
			     });
		      }
	       }) 
		}

