//= require jquery-3.5.1.min
//= require jquery_ujs
//= require jquery.tokeninput
//= require handlebars-v4.7.7
//= require selectize
//= require uswds

function humanize(string)
{
    return string.charAt(0).toUpperCase() + string.slice(1);
}

$(document).ready(function(){
	$('.usa-banner__header-action').on('click',function(){
		alert('testing2');
		$('.usa-banner__content').toggle();
	});

	$('.btn-learn-more ').on('click',function(){
		$('#org-details').toggle();
	});

	$('#archive-button').on('click',function(){
		    alert('testing1');
			$('#archive_confirm').show();
		});

});
