$(document).ready(function(){
	$('.sections-link').click(function(){
		$('#main').css('display','none');
		$('#projects').css('display','none');
		$('#contacts').css('display','none');
		var dest = $(this).attr('dest');    
		$('#' + dest).fadeIn(2000);
	})
});
