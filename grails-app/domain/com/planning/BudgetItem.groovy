package com.planning
import com.category.Category
import com.tracking.Transaction

class BudgetItem {
	Integer year
	Integer month
	Double  amount
	String cash = "Y" 
	String required = "N"
	static belongsTo = [category: Category]
	static hasMany = [plannedTransactions: PlannedTransaction, transactions: Transaction]
	
	static constraints = {
		year blank : false, min : 2011, max : 2020
		month blank : false, min : 1, max : 12
		category unique : ["month", "year"]
		amount blank : false
		cash inList : ["Y","N"]
		required blank:true ,  inList : ["Y","N"]
	}
	
	static mapping = {
	}
	
	String toString(){
		"${category} budget ${year}/${month}"
	}
	
	public void calculateAmount(){
		Double newAmount = 0
		plannedTransactions.each{
			newAmount += it.amount
		}
		amount=newAmount
		this.save(flush:true)
	}
	
	
}

