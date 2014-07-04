package com.errors;

import java.util.Calendar;
import java.util.GregorianCalendar;

public class Main {
	
	public static void main(String[] args) {
		
		Calendar calendar = new GregorianCalendar();
		calendar.set(2012, 11, 2);
		System.out.println("Month " + calendar.get(Calendar.MONTH));
		System.out.println("Day " + calendar.get(Calendar.DATE));
		System.out.println("Year " + calendar.get(Calendar.YEAR));
		System.out.println("Day of week " + calendar.get(Calendar.DAY_OF_WEEK));

	}

}
