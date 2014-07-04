package com.access

class UserGroup {
	
	def groupName
	static hasMany = [users:UserInfo]
    static constraints = {
    }
}
