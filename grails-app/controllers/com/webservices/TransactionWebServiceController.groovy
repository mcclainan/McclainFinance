package com.webservices

import com.category.CategoryService
import com.tracking.AccountService
import com.tracking.Transaction
import com.tracking.TransactionService
class TransactionWebServiceController {
	def accountService
	def categoryService
	def transactionWebService
	def transactionService
	
	def categoryList(){
		render(categoryService.getCategoryList())
	}
	
	def accountList(){
		render(accountService.getAccountList())
	}
	
	def getCategoryAndAccountList(){
		render(transactionWebService.getSingleTransactionXML())
	}
	
	def save() {
		
		def transactionInstance = new Transaction(params)
		if (!transactionInstance.save(flush: true)) {
			render("It didn't work")
			return
		}
		
		transactionService.create(transactionInstance)
		flash.message = message(code: 'default.created.message', args: [message(code: 'transaction.label', default: 'Transaction'), transactionInstance.id])
		render("Transaction Saved")
	
	}
}
