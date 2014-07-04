package com.tracking
import com.assetLiability.AssetLiability

class Account {
	String name
	Double balance
	Double interestRate
	String active = "Y"
	String cash
	AssetLiability assetLiability
	
	static hasMany = [transactions: Transaction]
	
    static constraints = {
		interestRate nullable : true
		active size : 1..1, inList : ["Y","N"]
		cash  size : 1..1, inList : ["Y","N"]
		assetLiability nullable: true
    }
	
	String toString(){
		"${name}"
	} 
	
}
