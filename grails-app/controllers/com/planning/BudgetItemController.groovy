package com.planning
import com.errors.LockedPlanningExecption
import com.category.Category


import org.springframework.dao.DataIntegrityViolationException

class BudgetItemController {
	def budgetItemService
	def budgetViewService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	static navigation = [
		[group:'planningTabs', action:'view',title:'Budget View', order:0],
		[action:'create',title:'Create Budget', order:1],
		[action:'list',title:'Budget Item List', order:2]
		
	]

    def index() {
        redirect(action: "view", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [budgetItemInstanceList: BudgetItem.list(params), budgetItemInstanceTotal: BudgetItem.count()]
    }
	
    def listNew() {
    	[budgetItemInstanceList: BudgetItem.list(params)]
    }

    def create() {
        [budgetItemInstance: new BudgetItem(params)]
    }

    def save() {
        def budgetItemInstance = new BudgetItem()
		bindData(budgetItemInstance,params,['amount'])
		
		def createResults = budgetItemService.create(params)
		
        if (!createResults.valid) {
            render(view: "create", model: [budgetItemInstance: budgetItemInstance, errors:createResults.errors])
            return
        }else{
			
        	createResults.budgetItems.each{
				budgetItemService.addTransactions(it)
        		it.save(flush:true)	
        	}
			
			if(params.addPlannedTransactions == "on"){
				flash.message = "Select criteria for planned transactions."
				redirect(controller:"PlannedTransaction", action:"create", id : createResults.budgetItems.get(0).id)
			}else{
				flash.message = "The following Budget Items were created"
				render(view:"listNew", model : [budgetItemInstanceList:createResults.budgetItems])
			}
        }

    }

    def show() {
        def budgetItemInstance
		if(params.fromView){
//			= BudgetItem.get(params.id)
			println params
			
			redirect(action:"view")
			return
		}else{
			budgetItemInstance = BudgetItem.get(params.id)
		
		}
        if (!budgetItemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'budgetItem.label', default: 'BudgetItem'), params.id])
            redirect(action: "list")
            return
        }

        [budgetItemInstance: budgetItemInstance]
    }
	
    def showByCategoryMonthAndYear() {
    	def budgetItemInstance
		def categoryInstance = Category.findByName(params.name);
    	if(params.fromView){
//			= BudgetItem.get(params.id)
    		println params
    		
    		redirect(action:"view")
    		return
    	}else{
    		budgetItemInstance = BudgetItem.withCriteria {
				eq("year",params.year.toInteger())
				eq("month",params.month.toInteger())
				category{
					eq("id",categoryInstance.id)
				}
			}.get(0)
    				
    	}
    	if (!budgetItemInstance) {
    		flash.message = message(code: 'default.not.found.message', args: [message(code: 'budgetItem.label', default: 'BudgetItem'), params.id])
    				redirect(action: "list")
    				return
    	}
    	
    	render(view:"show", model:[budgetItemInstance: budgetItemInstance])
    }
	
	def view(){
		def year = params.year?:new Date().format("yyyy").toInteger()
		def month = params.month?:new Date().format("MM").toInteger()
		if(params.staticBudget == "on"){
			session.staticBudget = true
		}else if(params.dynamicBudget == "on"){
			session.staticBudget = false
		}
		params.staticBudget = session.staticBudget
		def budgetView = budgetViewService.budgetView(params)
		
		[yearOverView : budgetView.yearOverView, monthIncome:budgetView.monthIncome, monthExpense:budgetView.monthExpense ,year:year,month:month]
	}

    def edit() {
        def budgetItemInstance = BudgetItem.get(params.id)
        if (!budgetItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'budgetItem.label', default: 'BudgetItem'), params.id])
            redirect(action: "list")
            return
        }

        [budgetItemInstance: budgetItemInstance]
    }
	
	def remoteEdit

    def update() {
        def budgetItemInstance = BudgetItem.get(params.id)
        if (!budgetItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'budgetItem.label', default: 'BudgetItem'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (budgetItemInstance.version > version) {
                budgetItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'budgetItem.label', default: 'BudgetItem')] as Object[],
                          "Another user has updated this BudgetItem while you were editing")
                render(view: "edit", model: [budgetItemInstance: budgetItemInstance])
                return
            }
        }
		
		flash.errors = [:]

        bindData(budgetItemInstance,params,["amount"])
		def editResults = budgetItemService.editAmount(budgetItemInstance, params)
		
		if(editResults.errors){
			flash.errors = editResults.errors
		}
		Boolean previousYear = new Date().format("yyyy").toInteger() > budgetItemInstance.year
		Boolean previousMonth = new Date().format("yyyy").toInteger() == budgetItemInstance.year && new Date().format("mm").toInteger() >= budgetItemInstance.month
		
		if(previousMonth || previousYear){
			flash.errors.lockedPlaning = "Can not edit a Budget Item from a current or previous month"
		}

        if (flash.errors || !budgetItemInstance.save(flush: true)) {
            render(view: "edit", model: [budgetItemInstance: budgetItemInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'budgetItem.label', default: 'BudgetItem'), budgetItemInstance.id])
        redirect(action: "show", id: budgetItemInstance.id)
    }

    def delete() {
        def budgetItemInstance = BudgetItem.get(params.id)
        if (!budgetItemInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'budgetItem.label', default: 'BudgetItem'), params.id])
            redirect(action: "list")
            return
        }

        try {
      		Boolean previousYear = new Date().format("yyyy").toInteger() > budgetItemInstance.year
			Boolean previousMonth = new Date().format("yyyy").toInteger() == budgetItemInstance.year && new Date().format("mm").toInteger() >= budgetItemInstance.month
			
			if(previousMonth || previousYear) throw new LockedPlanningExecption()
			
            budgetItemInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'budgetItem.label', default: 'BudgetItem'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'budgetItem.label', default: 'BudgetItem'), params.id])
            redirect(action: "show", id: params.id)
        }
        catch (LockedPlanningExecption e) {
        	flash.message = "Can not delete a Budget Item from a current or previous month" 
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
				validSearch	= false
				flash.searchErrors.amount = "Amount must be a valid number with no symbols other than one '.'"
			}
 		}
		
		if(validSearch){
			
			def c = BudgetItem.createCriteria()
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			List budgetItems = c.list (params){
				if(params.year != 'null'){
					eq("year", params.year.toInteger())
				}
				if(params.month != 'null'){
					eq("month", params.month.toInteger())
				}
				if(params.category.id != 'null'){
					category{
						eq("id",params.category.id.toLong())
					}
				}
				if(amount){
					between("amount", amount - 10, amount + 10)
				}
			}
			
			String view
			if(params.returnAction == "choose"){
				view = "budgetItemChoose"
			}else{
				view = "list"
			}
			
			render(view:view , model :  [budgetItemInstanceList: budgetItems, budgetItemInstanceTotal: budgetItems.getTotalCount()])
		}
		else{
			redirect(action:"list")
		}
	}
	
	def budgetItemChoose() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[budgetItemInstanceList: BudgetItem.list(params), budgetItemInstanceTotal: BudgetItem.count()]
	}
}
