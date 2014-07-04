package com.category
import com.planning.*
import com.tracking.Transaction


class Category {
	
	String name
	String priority
	String cash
	String type
	String active = "Y"
	String displayOnMobile = "N"
	
	
	static belongsTo = [metaCategory : MetaCategory]
	static hasMany = [budgetItems: BudgetItem, transactions: Transaction, plannedTransactions: PlannedTransaction]
	
    static constraints = {
		name(nullable: false, blank: false,  unique: true)
		priority(nullable: true, 
			         size: 1..1, 
			    validator: {value -> value?.isNumber()}
				)
		cash(nullable: false, blank: false, size:1..1, inList:["Y","N"])
		type(nullable: false, blank: false, size:1..1, inList:["I", "E"])
		active blank: false, size:1..1, inList:["Y","N"]
		displayOnMobile nullable: true, blank: true, size:1..1, inList:["Y","N"]
    }
	
	static mapping = {
		budgetItems lazy: false
	}
	
	String toString(){
		"${name}"
	}
}
