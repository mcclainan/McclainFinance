package com.tracking

class BankRecord {
	Date transactionDate
	Account account
	String description
	Double amount
	Transaction transaction
	
    static constraints = {
		account blank:false
		transactionDate blank:false
		description blank:false,  unique : ["transactionDate", "amount"]
		amount blank:false
		transaction nullable:true
    }
}
