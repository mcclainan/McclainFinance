package com.tracking
import com.assetLiability.AssetLiability
import com.planning.BudgetItem
import com.category.Category

class Transaction {
	
	Date created = new Date()
	Date transactionDate = new Date()
	String name
	Double amount
	String notes
	String active = "Y"
	Integer combinationId
	String verified = "N"
	
	static hasOne = [category: Category, 
		              account: Account, 
			   assetLiability: AssetLiability, 
			       budgetItem: BudgetItem]
	
    static constraints = {
		category nullable:false
		name nullable: false, blank: false
		amount nullable: false, blank: false
		notes nullable: true, size: 1..255
		account nullable: false
		assetLiability nullable: true
		budgetItem nullable: true
		combinationId nullable: true
		active blank: false
		verified nullable: true, inList:["Y","N"]
	}
	
	static mapping = {
		table name:'TRANSACTION'
		version false
	 }
	
	String toString(){
		"Amount: ${amount}    Name:${name}     Transaction Date:${transactionDate.format('MMM,dd,yyyy')}    "
	}
}
 