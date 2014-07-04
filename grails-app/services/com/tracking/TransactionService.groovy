package com.tracking
import com.assetLiability.AssetLiability
import com.assetLiability.AssetLiabilityClass;
import com.planning.BudgetItem
import com.planning.PlannedTransaction
import com.category.Category

class TransactionService {

    def create(Transaction transaction) {
		addBudgetItem(transaction)
		adjustAmount(transaction,"add")
		adjustAccount(transaction)
		processAssetLiability(transaction,"add")
    }
	
	def delete(Transaction transaction){
		adjustAmount(transaction,"subtract")
		adjustAccount(transaction)
		processAssetLiability(transaction,"delete")
		removeFromAssociations(transaction)
	}
	
	def edit(Transaction newTransaction, Transaction oldTransaction){
		
		adjustAmount(oldTransaction,"subtract")
		adjustAccount(oldTransaction)
		processAssetLiability(oldTransaction,"delete")
		removeFromAssociations(oldTransaction)
		
		if(newTransaction.combinationId){
			if(newTransaction.transactionDate != oldTransaction.transactionDate){
				adjustComboTransactionDates(newTransaction)
			}
		}
		
		adjustAmount(newTransaction,"add")
		adjustAccount(newTransaction)
		processAssetLiability(newTransaction,"edit")
		if(oldTransaction.category != newTransaction.category || 
		   oldTransaction.transactionDate.format("yyyy").toInteger() != Transaction.transactionDate.format("yyyy").toInteger() || 
		   oldTransaction.transactionDate.format("MM").toInteger() != Transaction.transactionDate.format("MM").toInteger()){
			addBudgetItem(newTransaction)
		}
		
		oldTransaction.delete(flush:true)
		
	}

	private adjustAccount(Transaction transaction) {
		if(transaction.account.assetLiability){
			transaction.account.assetLiability.value -= transaction.amount
		}else{
			transaction.account.balance += transaction.amount
		}
	}

	private adjustAmount(Transaction transaction, String action) {
		transaction.amount = Math.abs(transaction.amount)
				
		if(transaction.category.type == "E"){
			transaction.amount *= -1
		}
		if(action == "subtract"){
			transaction.amount *= -1
		}
	}

	private addBudgetItem(Transaction transaction) {
		
		List budgetItemSearchResult = BudgetItem.withCriteria{
			eq("month",transaction.transactionDate.format("MM").toInteger())
			eq("year",transaction.transactionDate.format("yyyy").toInteger())
			category{
				eq("id",transaction.category.id)
			}
		}
		
		BudgetItem budgetItem
		if(budgetItemSearchResult){
			budgetItem = budgetItemSearchResult.get(0)
		}
		BudgetItem previousBudgetItem = transaction.budgetItem
		if(budgetItem){
			transaction.budgetItem = budgetItem
			if(budgetItem.required == "Y"){
				flagPlannnedTransactions(budgetItem)
			}
		}else{
			transaction.budgetItem = null
		}
		
//		if(previousBudgetItem != transaction.budgetItem){
//			previousBudgetItem?.removeFromTransactions(transaction)
//		}
	
	}
	
	private processAssetLiability(Transaction transaction, String task){
		if(transaction.assetLiability){
			Double amount 
			AssetLiability assetLiability = transaction.assetLiability
			AssetLiabilityClass assetLiabilityClass = assetLiability.assetLiabilityClass
			
			switch (task) {
			case "add":
				amount = Math.abs(transaction.amount)
				break;
			case "edit":
				amount = Math.abs(transaction.amount)
				break;
			case "delete":
				amount = Math.abs(transaction.amount) * (-1)
				break;

			default:
				break;
			}
						
			String keyName = transaction.category.name.replace(transaction.assetLiability.name, "")	
			
			switch (keyName) {
			case "-PAYMENT":
				assetLiability.value += amount * assetLiabilityClass.onPayment
				break;
			case "-PROCEEDES":
				assetLiability.value += amount * assetLiabilityClass.onProceedes
				break;
			case "-INTEREST":
				assetLiability.value += amount * assetLiabilityClass.onInterest
				break;
			case "-PURCHASE":
				assetLiability.value += amount * assetLiabilityClass.onPurchase
				break;
			case "-USE":
				assetLiability.value += amount * assetLiabilityClass.onUse
				break;
			case "-SALE":
				assetLiability.value += amount * assetLiabilityClass.onSale
				break;
			case "-APPRECIATION":
				assetLiability.value += amount * assetLiabilityClass.onAppreciation
				break;
			case "-DEPRECIATION":
				assetLiability.value += amount * assetLiabilityClass.onDepreciation
				break;
			default:
				transaction.assetLiability = null
				assetLiability.removeFromTransactions(transaction)
				break;
			}
			
			assetLiability.save(flush:true)
		}
	}
	
	private removeFromAssociations(Transaction transaction){
		Category category = transaction.category
		category.removeFromTransactions(transaction)
		
		BudgetItem budgetItem = transaction.budgetItem
		budgetItem?.removeFromTransactions(transaction)
		if(budgetItem) flagPlannnedTransactions(budgetItem)
		
		AssetLiability assetLiability = transaction.assetLiability
		assetLiability?.removeFromTransactions(transaction)
		
		Account account = transaction.account
		account.removeFromTransactions(transaction)
	}
	
	private adjustComboTransactionDates(Transaction transaction){
		List combotransactions = Transaction.withCriteria{
			eq("combinationId",transaction.combinationId)
		}
		combotransactions.each {
			it.transactionDate = transaction.transactionDate
			it.save(flush:true)
		}
	}
	
	private flagPlannnedTransactions(BudgetItem budgetItemInstance){
		def plannedTransactions = PlannedTransaction.withCriteria {
			budgetItem{
				eq("id",budgetItemInstance.id)
			}
			order("plannedTransactionDate","asc")
		}
		def totalTransactionAmount = Transaction.withCriteria {
			budgetItem{
				eq("id",budgetItemInstance.id)
			}
			projections{
				sum("amount")
			}
		}.get(0)
		
		if(!totalTransactionAmount){
			 totalTransactionAmount = 0;
		}
		println "totalTransactionAmount ${totalTransactionAmount}"
		if (plannedTransactions){
			plannedTransactions.each {plannedTransaction->
			if(totalTransactionAmount>=plannedTransaction.amount){
				plannedTransaction.rolling = "N"
				plannedTransaction.save(flush:true)
			}
			totalTransactionAmount-=plannedTransaction.amount
			}
		}
		
	}
	

}
