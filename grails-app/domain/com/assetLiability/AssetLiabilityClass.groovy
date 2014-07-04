package com.assetLiability

class AssetLiabilityClass {
	
	String  name
	Integer onProceedes = 0
	Integer onSale = 0
	Integer onPurchase = 0
	Integer onPayment = 0
	Integer onInterest = 0
	Integer onAppreciation = 0
	Integer onDepreciation  = 0
	Integer onUse = 0
	
    static constraints = {
		name           blank : false
		onSale  	   blank : false, inlist: [-1, 0, 1]
		onPurchase     blank : false, inlist: [-1, 0, 1]
		onProceedes    blank : false, inlist: [-1, 0, 1]
		onPayment      blank : false, inlist: [-1, 0, 1]
		onInterest     blank : false, inlist: [-1, 0, 1]
		onAppreciation blank : false, inlist: [-1, 0, 1]
		onDepreciation blank : false, inlist: [-1, 0, 1]
		onUse		   blank : false, inlist: [-1, 0, 1]
    }
	
	String toString(){
		"${name}"
	} 
}
