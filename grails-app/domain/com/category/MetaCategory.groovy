package com.category

class MetaCategory {
	String name
	String priority
	String active = "Y"
	
	
	static hasMany = [categories: Category]
	
    static constraints = {
		name unique: true
		priority(nullable:true, size: 1..1)
		active size:1..1, inList: ["Y","N"]
    }
	
	String toString(){
		"${name}"
	}
}

