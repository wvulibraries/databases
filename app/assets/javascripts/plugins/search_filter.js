$( document ).on('turbolinks:load', function() {
  if($('#search_filter').length){
    $('#search_filter').keyup(function(e) { 
      var search_terms = $(this).val().toLowerCase().split(' '); 
      $('.filter-list').each(function(){
        var keywords = $(this).find('.keywords').text().toLowerCase().split(' '); 
        if(search(search_terms, keywords)){ 
          $(this).show(); 
        } else {
          $(this).hide(); 
        }
      }); 
    });
  } 
});

function search(search_terms, search_text) {
  for (var i = 0; i < search_text.length; i++) {
    var text =  search_text[i].innerHTML.toLowerCase();
    for(var f = 0; f < search_terms.length; f++) {
      if (text.indexOf(search_terms[f]) > -1 ) {    
        return true;
      } else {
        return false; 
      }
    }
  }
}