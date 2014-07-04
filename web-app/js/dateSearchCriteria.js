
function showCriteria(elementId){
	if(elementId == "dateSearchOption"){
		var timeFrame = document.getElementById(elementId);
		if(timeFrame.value == "null"){
			document.getElementById("byMonth").style.visibility = "collapse"
			document.getElementById("byDate").style.visibility = "collapse"
			document.getElementById("byDateRange").style.visibility ="collapse"
		}else if(timeFrame.value == "By Month"){
			document.getElementById("byMonth").style.visibility = "visible"
			document.getElementById("byDate").style.visibility = "collapse"
			document.getElementById("byDateRange").style.visibility ="collapse"
		}
		else if(timeFrame.value == "By Date"){
			document.getElementById("byMonth").style.visibility = "collapse"
			document.getElementById("byDate").style.visibility = "visible"
			document.getElementById("byDateRange").style.visibility ="collapse"
		}
		else if(timeFrame.value == "By Date Range"){
			document.getElementById("byMonth").style.visibility = "collapse"
			document.getElementById("byDate").style.visibility = "collapse"
			document.getElementById("byDateRange").style.visibility ="visible"
		}
	}
}