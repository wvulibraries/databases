$( document ).on('turbolinks:load', function() {
  var trail_expiration_date = new Pikaday({ 
    field: $('#database_trial_expiration_date')[0], 
    format: 'YYYY-MM-DD'
  });
});
