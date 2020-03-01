
function formatDate(date) {
	
  var day = date.getDate();
  var monthIndex = date.getMonth();
  var year = date.getFullYear();

  return day + '/' + (monthIndex +1) + '/' + year;
}

