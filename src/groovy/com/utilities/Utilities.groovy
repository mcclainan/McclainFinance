package com.utilities

import java.util.Map;

class Utilities {
	Map getBeginningAndEndOfMonth(int year, int month){
		Calendar calendar = Calendar.getInstance()
		calendar.set(year, month-1, 1)
		int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH)
		def firstOfMonth = new Date()
		firstOfMonth.set(year: year, month: month-1, date:1)
		def endOfMonth = new Date()
		endOfMonth.set(year: year, month: month-1, date:days)
		
		
		[firstOfMonth:firstOfMonth.clearTime(),endOfMonth:endOfMonth.clearTime()]
	}
}
