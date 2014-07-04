package com.access

class UserInfo {
	
	def name 
	def password
	static belongsTo = UserGroup
	static hasMany = [groups:UserGroup]
	
    static constraints = {
    }
}
