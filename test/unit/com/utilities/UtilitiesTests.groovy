package com.utilities

import javax.validation.constraints.AssertTrue;

import junit.framework.TestCase;
import junit.framework.Assert;
import org.junit.*

class UtilitiesTests extends TestCase{

	private Utilities utilties = new Utilities()
	
	public void testGetBeginningAndEndOfMonth(){
		Map dates = utilties.getBeginningAndEndOfMonth(2013,1)
		assertEquals(dates["firstOfMonth"].toString(), "Tue Jan 01 00:00:00 CST 2013")
		assertEquals(dates["endOfMonth"].toString(), "Thu Jan 31 00:00:00 CST 2013")
	}
}
