$( document ).on('turbolinks:load', function() {
  if($('#search_filter').length){
    $('#search_filter').keyup(function(e) { 
      var searchTerm = $(this).val().toLowerCase(); 
      $('.filter-list').each(function(){
        var searchText = $(this).find('.keywords').text().replace(/\s/g,'').toLowerCase();
        if(searchText.indexOf(searchTerm) === -1){
          $(this).hide(); 
        } else { 
          $(this).show(); 
        }
      });
    });
  } 
});

// function search(elm, search_terms, search_text) {

//   for (var i = 0; i < search_text.length; i++) {
//     var text =  search_text[i];
//     for(var f = 0; f < search_terms.length; f++) {
//       console.log("search result:" + text.indexOf(search_terms[f]))
//       if (text.indexOf(search_terms[f]) > -1 ) {    
//         elm.show(); 
//       } else {
//         elm.hide();  
//       }
//     }
//   }
// }

// function search(elm, search_terms, search_text){ 
//   $('.employee-list').each(function(){
//     var searchText = $(this).find('.keywords').text().toLowerCase();
//     if(searchText.indexOf(searchTerm) === -1){
//       $(this).hide(); 
//     } else { 
//       $(this).show(); 
//     }
//   });
// }