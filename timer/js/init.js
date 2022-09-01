//Hook up the tweet display

$(document).ready(function() {
						   
	$(".countdown").countdown({
				date: "30 sep 2022 0:00:00",
				format: "on"
			},
			
			function() {
				// callback function
			});

});	