package practice

class calendarPractice {
	public static void main(String[] args){
		Date date = new Date()
		String firstDayString = date.toString().substring(0, 3)
		Integer firstDay
		switch (firstDayString) {
			case "Sun":
				firstDay = 1
				break;
			case "Mon":
				firstDay = 2
				break;
			case "Tue":
				firstDay = 3
				break;
			case "Wed":
				firstDay = 4
				break;
			case "Thu":
				firstDay = 5
				break;
			case "Fri":
				firstDay = 6
				break;
			case "Sat":
				firstDay = 7
				break;
		}
		
		println firstDay
	}
}
