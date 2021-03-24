function validateDate(isoDate) {
    if (isNaN(Date.parse(isoDate))) {
        return false;
    } else {
        if (isoDate != (new Date(isoDate)).toISOString().substr(0,10)) {
            return false;
        }
    }
    return true;
}

$(document).on('click', '#export', function() {
   var startdate = document.getElementById("start_date").value;
   var enddate = document.getElementById("end_date").value;

   // if valid dates then open tab to download csv
   if (validateDate(startdate) && validateDate(enddate)) {
      window.open("/admin/stats/"+startdate+"/"+enddate, "_blank");
   }
   return true;
});
