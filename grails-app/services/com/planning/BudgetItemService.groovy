package com.planning
import javax.servlet.ServletContext;
import com.tracking.Transaction
import com.utilities.Utilities

import com.category.Category

class BudgetItemService {

	def create(Map params) {
		Map errors = [:]
		Boolean valid = true
		List budgetItems = []
		Double amount
		int year = params.year.toInteger()
		int month = params.month.toInteger()
		Long categoryId = params.category.id.toLong()
		String cash = params.cash
		Boolean previousYear = year < new Date().format("yyyy").toInteger()
		Boolean previousMonth = year ==  new Date().format("yyyy").toInteger() && month < new Date().format("MM").toInteger()

		if(params.amount){
			try{
				amount = params.amount.toDouble()
			}catch(Exception ex){
				errors.amount = "Amount must be a valid number with no symbols other than one decimal point '.' "				
			}
		}else{
			errors.amount = "An amount must be entered"
		}
		
		if(previousYear || previousMonth){
			errors.timeFrame = "New Budget Items should be for future months, ${month}/${year} is invalid"
		}

		for(int i = 0; i < params.numberOfMonths.toInteger(); i++){
			def budgetItem = new BudgetItem(year:year,month:month,category:Category.get(categoryId),amount:amount)
			if(!budgetItem.validate()){
				budgetItem.errors.each{
					if(it.fieldError.code == "unique"){
						errors.unique = "A Budget Item for ${budgetItem.category} already exist for ${month}/${year}"
					}
				}
			}
			budgetItem.save(flush:true)
			budgetItems << budgetItem
			month ++
			if(month > 12){
				month = 1
				year++
			}
		}
		
		if(errors) valid = false
		
		[errors:errors,valid:valid,budgetItems:budgetItems]
	}
	
	
	public void editAmount(BudgetItem budgetItemInstance, Map params){
		Map errors = [:]
		try {
			Double exemptTotal = 0
			Double amount = params.amount.toDouble()
			if(amount < 0) throw new NumberFormatException()
			List exemptPlannedTransactions = PlannedTransaction.withCriteria {
				eq("exempt", "Y")
				budgetItem{
					eq("id",budgetItemInstance.id)
				}
			}
			
			exemptPlannedTransactions.each{
				exemptTotal += it.amount
			}
			
			List currentPlannedTransactions  = PlannedTransaction.withCriteria {
				eq("exempt", "N")
				budgetItem{
					eq("id",budgetItemInstance.id)
				}
			}
			
			
			Double newAmount = 0
					Double adjustedAmount = amount - exemptTotal
					if(currentPlannedTransactions){
						newAmount = adjustedAmount/currentPlannedTransactions.size()
								currentPlannedTransactions.each{
							if(newAmount < 0){
								it.amount = 0
							}else{
								it.amount = newAmount
							}
							it.save(flush:true)
						}
					}
			
			if(amount != adjustedAmount && (!currentPlannedTransactions || adjustedAmount < 0)){
				Double adjustedExemptTotal = adjustedAmount/exemptPlannedTransactions.size()
						exemptPlannedTransactions.each{
					it.amount += adjustedExemptTotal
							it.save(flush:true)
				}
			}
			
			budgetItemInstance.calculateAmount()
		} catch (NumberFormatException e) {
			errors.invalidAmount = "InvalidAmount"
		}
		
		[errors:errors]
	}
	
	public void addTransactions(BudgetItem budgetItem){
		def dates = new Utilities().getBeginningAndEndOfMonth(budgetItem.year, budgetItem.month)
		def transactions = Transaction.withCriteria{
			between("transactionDate",dates.firstOfMonth,dates.endOfMonth)
			category{
				eq("id",budgetItem.category.id)
			}
		}
		transactions.each{
			it.budgetItem = budgetItem
			budgetItem.addToTransactions(it)
		}
	}	
	
}
