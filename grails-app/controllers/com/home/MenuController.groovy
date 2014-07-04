package com.home
import com.tracking.Account
import com.tracking.Transaction
import com.planning.PlannedTransactionService

class MenuController {
	def plannedTransactionService
	static navigation = [
		[group:"home",action:"index", title:"Mac Fin Home"]	
	]
    def index() { 
		def calendar = plannedTransactionService.getCashFlowCalendar()
		[calendar:calendar] 
	}
	def blank(){
	}
}
