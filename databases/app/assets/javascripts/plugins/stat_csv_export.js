function validateDateRegex(dateStr) {
    var regex = /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/; 
    return dateStr.match(regex);
}

$(document).on('click', '#export', function() {
   var startdate = document.getElementById("start_date").value;
   var enddate = document.getElementById("end_date").value;

   // if valid dates then open tab to download csv
   if (validateDateRegex(startdate) && validateDateRegex(enddate)) {
      window.open("/admin/stats/"+startdate+"/"+enddate, "_blank");
   }
   return true;
});
