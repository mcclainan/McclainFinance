package com.assetLiability
import com.tracking.*
class AssetLiability {
	String name
	String type
	Double value
	Double interestRate
	Double creditLimit
	String active = "Y"
	AssetLiabilityClass assetLiabilityClass
	Account account
	
	static hasMany = [transactions: Transaction]
	
    static constraints = {
		name blank: false, unique: true
		type  blank: false, size : 1..1, inList:['A','L','X']
		assetLiabilityClass  blank: false
		value  blank: false
		active  blank: false, size: 1..1, inList: ['Y','N']
		account nullable: true
		interestRate nullable: true
		creditLimit nullable: true
    }
	
	String toString(){
		"${name}"
	}
}
