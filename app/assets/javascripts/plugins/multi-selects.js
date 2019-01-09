$( document ).on('turbolinks:load', function() {
  $('#database_subject_ids').multiSelect(); // subjects
  $('#database_curated_ids').multiSelect(); // curated
  $('#database_resource_ids').multiSelect(); // rss
});

// Subject Form Select All
$(document).on('click', '#subject_select_all', function(event) {
  event.preventDefault();
  $('#database_subject_ids').multiSelect('select_all');
  return true;
});

// Subject Form Deselect All
$(document).on('click', '#subject_deselect_all', function(event) {
  event.preventDefault();
  $('#database_subject_ids').multiSelect('deselect_all');
  return true;
});


// curated Form Select All
$(document).on('click', '#curated_select_all', function(event) {
  event.preventDefault();
  $('#database_curated_ids').multiSelect('select_all');
  return true;
});

// curated Form Deselect All
$(document).on('click', '#curated_deselect_all', function(event) {
  event.preventDefault();
  $('#database_curated_ids').multiSelect('deselect_all');
  return true;
});


// resource Form Select All
$(document).on('click', '#resource_select_all', function(event) {
  event.preventDefault();
  $('#database_resource_ids').multiSelect('select_all');
  return true;
});

// resource Form Deselect All
$(document).on('click', '#resource_deselect_all', function(event) {
  event.preventDefault();
  $('#database_resource_ids').multiSelect('deselect_all');
  return true;
});