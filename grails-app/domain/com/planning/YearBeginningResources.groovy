package com.planning

class YearBeginningResources {

	Integer year
	Double budgetedCash = 0
	Double actualCash = 0
	Double budgetedCreditCard = 0
	Double actualCreditCard = 0
	Double budgetedBenifits = 0
	Double actualBenifits = 0
	Double budgetedOther = 0
	Double actualOther = 0
	
    static constraints = {
		year blank: false, unique: true
    }
}
