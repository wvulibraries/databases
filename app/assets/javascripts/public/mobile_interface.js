// Subject Form Select All
$(document).on('click', '.search-toggle', function(event) {
  event.preventDefault();

  var $popup = $('.search-popup');
  var $help_pop = $('.help-popup'); 
  
  $popup.toggleClass('hidden');

  if(!$help_pop.hasClass('hidden')){
    $help_pop.addClass('hidden'); 
  } 

  if($popup.hasClass('hidden')){ 
    $(this).attr('aria-pressed', false);
    $popup.attr('aria-expanded', false).attr('aria-hidden', true);
  } else { 
    $(this).attr('aria-pressed', true);
    $popup.attr('aria-expanded', true).attr('aria-hidden', false);
    console.log('remove hidden aria stuff')
  }

  return true;
});

$(document).on('click', '.help-toggle', function(event) {
  event.preventDefault();

  var $popup = $('.help-popup');
  var $search_pop = $('.search-popup'); 

  $popup.toggleClass('hidden');

  if(!$search_pop.hasClass('hidden')){
    $search_pop.addClass('hidden'); 
  } 
  
  if($popup.hasClass('hidden')){ 
    $(this).attr('aria-pressed', false);
    $popup.attr('aria-expanded', false).attr('aria-hidden', true);
  } else { 
    $(this).attr('aria-pressed', true);
    $popup.attr('aria-expanded', true).attr('aria-hidden', false);
    console.log('remove hidden aria stuff')
  }
  
  return true;
});