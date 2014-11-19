$(document).ready(function(){

	$('.has-tooltip').each(function() { // Notice the .each() loop, discussed below
	    $(this).qtip({
	        content: {
	            text: $(this).data('tooltip') // Use the "div" element next to this for the content
	        },
	        position: {
		        my: 'bottom center',  // Position my top left...
		        at: 'top center' // at the bottom right of...
		    },
		    style: {
		        classes: 'qtip-dark'
		    }
	    });
	});

});