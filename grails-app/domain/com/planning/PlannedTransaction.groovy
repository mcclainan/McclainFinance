package com.planning
import com.category.Category

class PlannedTransaction {
	Date plannedTransactionDate
	Double amount
	String cash = "Y"
	String exempt = "N"
	String rolling = "N"
	
	static belongsTo = [budgetItem: BudgetItem]
	static hasOne = [category:Category]
	
    static constraints = {
		plannedTransactionDate blank:false
		amount blank: false
		cash inList : ["Y","N"]
		exempt inList : ["Y","N"]
		rolling nullable:true , inList : ["Y","N"]
		category nullablie:true
    }
	
	String toString(){
		"Planned Transaction, amount ${amount} on day ${plannedTransactionDate.format('dd')} for ${budgetItem}"
	}
}