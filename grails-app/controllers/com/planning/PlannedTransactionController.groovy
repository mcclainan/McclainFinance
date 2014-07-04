package com.planning

import org.springframework.dao.DataIntegrityViolationException

class PlannedTransactionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	def plannedTransactionService
	static navigation=[
		[group:"planningTabs", action:"list", title:"Planned Transaction List", order:3]	
	]

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [plannedTransactionInstanceList: PlannedTransaction.list(params), plannedTransactionInstanceTotal: PlannedTransaction.count()]
    }
	
	def remoteList(){
		def dateFields  = params.date.toString().replace('[', "").split(",")[0].split("-")
		def month = dateFields[0].toInteger()-1
		def day  = dateFields[1].toInteger()
		def year  = dateFields[2].toInteger()
		def date = new Date()
		date.set(month:month,date:day,year:year)
		def plannedTransactionList = PlannedTransaction.withCriteria {
			eq("plannedTransactionDate",date.clearTime())
		}
		
		render(template:"list",model:[plannedTransactionInstanceList:plannedTransactionList,date:date])
	}

    def create() {
		def budgetItem = BudgetItem.get(params.id)
		def date = new Date()
		date.set(year:budgetItem.year,month:budgetItem.month-1)
		render(view: "createSet", model: [plannedTransactionInstance: new PlannedTransaction(params), 
			                                              budgetItem:budgetItem,
		                                                   date:date])
    }

    def save() {
		
		def createResult = plannedTransactionService.createSet(params)
		
		flash.messages = createResult.messages
		flash.errors = createResult.errors
		
		render(view: "createSet", model: [plannedTransactionInstance: new PlannedTransaction(), budgetItem:BudgetItem.get(params.id)])

    }

    def show() {
        def plannedTransactionInstance = PlannedTransaction.get(params.id)
        if (!plannedTransactionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'plannedTransaction.label', default: 'PlannedTransaction'), params.id])
            redirect(action: "list")
            return
        }

        [plannedTransactionInstance: plannedTransactionInstance]
    }

    def edit() {
        def plannedTransactionInstance = PlannedTransaction.get(params.id)
		
        if (!plannedTransactionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'plannedTransaction.label', default: 'PlannedTransaction'), params.id])
            redirect(action: "list")
            return
        }
		if(params.remote){
			render(template:"edit",model:[plannedTransactionInstance: plannedTransactionInstance])
		}else{
			render(view:"edit",model:[plannedTransactionInstance: plannedTransactionInstance])
		}
        
    }

    def update() {
        def plannedTransactionInstance = PlannedTransaction.get(params.id)
        if (!plannedTransactionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'plannedTransaction.label', default: 'PlannedTransaction'), params.id])
			if(params.remote){
				render("No Planned Transaction found with id of ${params.id}")
			}else{
				redirect(action: "list")
			}
            return
        }
        def date = plannedTransactionInstance.plannedTransactionDate 

        if (params.version) {
            def version = params.version.toLong()
            if (plannedTransactionInstance.version > version) {
                plannedTransactionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'plannedTransaction.label', default: 'PlannedTransaction')] as Object[],
                          "Another user has updated this PlannedTransaction while you were editing")
				if(params.remote){
					render(template: "edit", model: [plannedTransactionInstance: plannedTransactionInstance])
				}else{
					render(view: "edit", model: [plannedTransactionInstance: plannedTransactionInstance])
				}
                return
            }
        }

		bindData(plannedTransactionInstance ,params,['amount'])
		def editResult = plannedTransactionService.editAmount(plannedTransactionInstance, params)
		if(editResult.errors) flash.errors = editResult.errors

        if (flash.errors || !plannedTransactionInstance.save(flush: true)) {
            if(params.remote){
				render(template: "edit", model: [plannedTransactionInstance: plannedTransactionInstance])
			}else{
				render(view: "edit", model: [plannedTransactionInstance: plannedTransactionInstance])
			}
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'plannedTransaction.label', default: 'PlannedTransaction'), plannedTransactionInstance.id])
		if(params.remote){
			redirect(action: "remoteList", params:[date:date.format("MM-dd-yyyy")])
		}else{
			redirect(action: "show", id: plannedTransactionInstance.id)
		}
    }

    def delete() {
        def plannedTransactionInstance = PlannedTransaction.get(params.id)
        if (!plannedTransactionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'plannedTransaction.label', default: 'PlannedTransaction'), params.id])
            if(params.remote){
				render("No Planned Transaction found with id of ${params.id}")
			}else{
				redirect(action: "list")
			}
            return
        }
		
		def date = plannedTransactionInstance.plannedTransactionDate
		BudgetItem budgetItem = plannedTransactionInstance.budgetItem

        try {
            plannedTransactionInstance.delete(flush: true)
			budgetItem.calculateAmount()
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'plannedTransaction.label', default: 'PlannedTransaction'), params.id])
			if(params.remote){
				redirect(action: "remoteList", params:[date:date.format("MM-dd-yyyy")])
			}else{
				redirect(action: "list")
			}
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'plannedTransaction.label', default: 'PlannedTransaction'), params.id])
			redirect(action: "show", id: params.id)
        }
    }
	
	def search(){
		Boolean validSearch = true
		Double amount
		flash.searchErrors = [:]
		if(params.amount){
			try{
				amount = params.amount.toDouble()
			}catch(Exception ex){
				validSearch	
				flash.searchErrors.amount = "Amount must be a valid number with no symbols other than one '.'"
			}
 		}
		
		if(validSearch){
			params.each{
				println it
			}
			
			def c = PlannedTransaction.createCriteria()
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			
			List plannedTransactions = c.list (params){
				if(params.amount){
					println "Searching Amount"
					between("amount",amount - 10, amount + 10)
				}
				if(params.cash != 'null'){
					println "Searching Cash "
					eq("cash", params.cash)
				}
				if(params.exempt != 'null'){
					println "Searching exempt "
					eq("exempt", params.exempt)
				}
				if(params.budgetItemId != 'null'){
					budgetItem{
						eq("id",params.budgetItemId.toLong())
					}
				}
				if(params.dateSearchOption != 'null'){
					println "Searching Date "
					if(params.dateSearchOption == "By Month"){
						Map dateRange = plannedTransactionService.getSearchDateRange(params)
						between("plannedTransactionDate",dateRange.startDate,dateRange.endDate)
					}else if(params.dateSearchOption == "By Date"){
						println "finding ${params.date}"
						eq("plannedTransactionDate", params.date)
					}else if(params.dateSearchOption == "By Date Range"){
						between("plannedTransactionDate",params.startDate,params.endDate)
					}
				}
			}
			
			println "Planned Transactions Count ${plannedTransactions.size()}"
			render(view:"list" , model :  [plannedTransactionInstanceList: plannedTransactions, plannedTransactionInstanceTotal: plannedTransactions.getTotalCount()])
		}
		else{
			redirect(action:"list")
		}
	}
	
	def cashFlowCalendar(){
		if(!params){
			params.weeks = 15
		}    	
		def calendar = plannedTransactionService.getCashFlowCalendar(params)
		[calendar:calendar]
	}
	
}
