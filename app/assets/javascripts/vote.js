$(document).ready(function(){
	$(".vote")

		//on send
		.on('ajax:send', function(e, data){ 
			var $currentTarget = $(e.currentTarget);
			var $currentCount = $currentTarget.find(".count");
			var currentValue = parseInt($currentCount.text());

			if($currentTarget.hasClass("voted")){
				$currentCount.text(currentValue-1);
				$currentTarget.removeClass("voted");
			}else{
				$currentCount.text(currentValue+1);
				$currentTarget.addClass("voted");
			}
			console.log("Send Data: ", e, data);
		})

		//on complete
		.on('ajax:complete', function(e, data){ 
			console.log("Complete Data: ", e, data);
		})

		//on error
		.on('ajax:error', function(e, data){ 
			console.log("Error Data: ", e, data);
		})

		//on success
		.on('ajax:success', function(e, data){ 
			console.log("Success Data: ", e, data);
		})

});