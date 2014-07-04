package com.tracking

import org.grails.datastore.mapping.transactions.TransactionUtils;
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.mobile.device.Device
import org.springframework.mobile.device.LiteDeviceResolver
import com.utilities.Utilities

import com.assetLiability.AssetLiability;
import com.planning.BudgetItem;
import com.category.Category
import com.webservices.TransactionWebService

class TransactionController {
	
	Device device
	LiteDeviceResolver resolver = new LiteDeviceResolver()
	def transactionWebService
	
	static navigation = [
		[group:'trackingTabs', action:'singleTransaction',title:'Single Transactions', order:10],
		[action:'combinationTransaction',title:'Combination Transactions', order:20],
		[action:'accountTransfer',title:'Account Transfer', order:30],
		[action:'reconciliation',title:'Reconciliation', order:40],
		[group:"accountTabs", action:"singleTransaction", title:"Tracking Home", order:20],
		[group:"bankRecordTabs", action:"singleTransaction", title:"Tracking Home", order:30],
		[group:"assetLiabilityTabs", action:"singleTransaction", title:"Tracking Home", order:30]
	]

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def transactionService

    def index() {
        redirect(action: "singleTransaction", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [transactionInstanceList: Transaction.list(params), transactionInstanceTotal: Transaction.count()]
    } 

    def create() {
        [transactionInstance: new Transaction(params)]
    }

    def save() {
		
        def transactionInstance = new Transaction(params)
        if (!transactionInstance.save(flush: true)) {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			params.order = "desc"
			if(params.mobile){
				render("It didn't work")
			}else{
				render(view: "singleTransaction", model: [transactionInstance: transactionInstance,transactionInstanceList: Transaction.listOrderByTransactionDate(params), transactionInstanceTotal: Transaction.count()])
			}
            return
        }
		
		transactionService.create(transactionInstance)
		flash.message = message(code: 'default.created.message', args: [message(code: 'transaction.label', default: 'Transaction'), transactionInstance.id])
		if(params.recon){
			def bankRecord = BankRecord.get(params.bankRecordId)
			bankRecord.transaction = transactionInstance
			bankRecord.save(flush:true)
			transactionInstance.verified = "Y"
			transactionInstance.save(flush:true)
			
			println "bankRecord.transaction = ${bankRecord.transaction}"
			println "transactionInstance.verified = ${transactionInstance.verified}"
			redirect(action: "reconciliation", params:[accountId:transactionInstance.account.id, month:transactionInstance.transactionDate.format("MM"), year:transactionInstance.transactionDate.format("YYYY")])
		}else if(params.mobile){
			render("It worked")
		}else {
			redirect(action: "singleTransaction", id: transactionInstance.id)
		}

    }

    def show() {
        def transactionInstance = Transaction.get(params.id)
        if (!transactionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'transaction.label', default: 'Transaction'), params.id])
            redirect(action: "singleTransaction")
            return
        }   

        [transactionInstance: transactionInstance]
    }

    def edit() {
        def transactionInstance = Transaction.get(params.id)
        if (!transactionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'transaction.label', default: 'Transaction'), params.id])
            redirect(action: "singleTransaction")
            return
        }

        [transactionInstance: transactionInstance]
    }

    def update() {
        def transactionInstance = Transaction.get(params.id)
        if (!transactionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'transaction.label', default: 'Transaction'), params.id])
            redirect(action: "singleTransaction")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (transactionInstance.version > version) {
                transactionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'transaction.label', default: 'Transaction')] as Object[],
                          "Another user has updated this Transaction while you were editing")
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
			params.order = "desc"
            render(view: "singleTransaction", model: [transactionInstance: transactionInstance,transactionInstanceList: Transaction.listOrderByTransactionDate(params), transactionInstanceTotal: Transaction.count()])
            return
            }
        }
		
		Transaction oldTransaction = new Transaction()
		
		bindData(oldTransaction,transactionInstance.properties,['id','verson'])
        transactionInstance.properties = params

        if (!transactionInstance.save(flush: true)) {    
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
			params.order = "desc"
            render(view: "singleTransaction", model: [transactionInstance: transactionInstance,transactionInstanceList: Transaction.listOrderByTransactionDate(params), transactionInstanceTotal: Transaction.count()])
            return
        }
		
		transactionService.edit(transactionInstance,oldTransaction)

		flash.message = message(code: 'default.updated.message', args: [message(code: 'transaction.label', default: 'Transaction'), transactionInstance.id])
        redirect(action: "singleTransaction")
    }

    def delete() {
        def transactionInstance = Transaction.get(params.id)
        if (!transactionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'transaction.label', default: 'Transaction'), params.id])
            redirect(action: "singleTransaction")
            return
        }

        try {
        	transactionService.delete(transactionInstance)
            transactionInstance.delete(flush: true)
			
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'transaction.label', default: 'Transaction'), params.id])
            redirect(action: "singleTransaction")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'transaction.label', default: 'Transaction'), params.id])
            redirect(action: "singleTransaction", id: params.id)
        }
    }  
	
	def singleTransaction(){
		device = resolver.resolveDevice(request)
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.order = "desc" 
		def view = "singleTransaction"
		
		if(device.isMobile()){
			view = "singleTransaction_mobile"
		}
		render(view: view, model: [transactionInstanceList: Transaction.listOrderByTransactionDate(params), transactionInstanceTotal: Transaction.count(), transactionInstance: new Transaction(params)])
	}
	def singleTransaction_mobile(){
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.order = "desc"
		
		[transactionInstanceList: Transaction.listOrderByTransactionDate(params), transactionInstanceTotal: Transaction.count(), transactionInstance: new Transaction(params)]
	}
	
	def search(){
		params.order = "desc"
		params.each{
			println it
		}
		Boolean validSearch = true
		Double amount
		flash.searchErrors = [:]
		if(params.searchAmount){
			try{
				amount = params.searchAmount.toDouble()
			}catch(Exception ex){
				validSearch	= false
				flash.searchErrors.amount = "Amount must be a valid number with no symbols other than one '.'"
			}
		 }
		def transactions = []
		println "params.amount ${params.amount}"
		println "amount ${amount}"
		if(validSearch){  
			println "Valid Search" 
			def searchParams = [:]
			def transactionCriteria = Transaction.createCriteria()
			transactions = transactionCriteria.list(params) {
			
				if(params.dateSearchOption == "By Month"){
					println "Searching By Month"
					def dates = new Utilities().getBeginningAndEndOfMonth(params.searchMonth.format("yyyy").toInteger(), params.searchMonth.format("MM").toInteger())
							def startDate = dates.firstOfMonth
							def endDate = dates.endOfMonth
							searchParams.searchMonth = params.searchMonth
							between("transactionDate", startDate, endDate)
				}else if(params.dateSearchOption == "By Date"){
					println "Searching By Date"
					eq("transactionDate",params.searchDate)
					searchParams.searchDate = params.searchDate
				}else if(params.dateSearchOption == "By Date Range"){
					println "Searching By Date Range"
					between("transactionDate", params.startDate,params.endDate)
					searchParams.startDate = params.startDate
					searchParams.endDate = params.endDate
				}
				
				if(params.searchCategoryId != "null" && params.searchCategoryId != null){
					println "Searching By Category"
					category{
						eq("id",params.searchCategoryId.toLong())
					}
					searchParams.searchCategoryId = params.searchCategoryId
				}
				
				if(params.searchName){
					println "Searching By name"
					ilike("name", "%${params.searchName}%")
					searchParams.searchName = params.searchName
				}
				
				if(amount){
					println "Searching By amount"
					between("amount",amount-10,amount+10)
					searchParams.searchAmount = params.searchAmount
				}
				
				if(params.searchAccountId != "null" && params.searchAccountId != null){
					println "Searching By Account"
					account{
						eq("id",params.searchAccountId.toLong())
					}
					searchParams.searchAccountId = params.searchAccountId
				}			
				
				if(params.searchAssetLiabilityId != "null" && params.searchAssetLiabilityId != null){
					println "Searching By Account Asset Liability"
					assetLiability{
						eq("id",params.searchAssetLiabilityId.toLong())
					}
					searchParams.searchAssetLiabilityId = params.searchAssetLiabilityId
				}
				
				order("transactionDate", "desc")
			}
			
			searchParams.each{
				println "search parameter :${it}"
			}
			
			render(view:"singleTransaction", 
				   model:[transactionInstanceList:transactions, 
					      transactionInstanceTotal:transactions?.getTotalCount()?:0,
						  transactionInstance: new Transaction(), 
						  searchParams:searchParams])
		}else{
			println "InValid Search"
			redirect(action:"singleTransaction")
		}
	}
		
	def accountTransfer(){
		def transaction = new Transaction()
		[transactionInstance:transaction]
	}
	
	def createAccountTransfer(){
		
		def transactionTo = new Transaction()
		bindData(transactionTo,params,["amount"])
		def transactionFrom = new Transaction()
		bindData(transactionFrom,params,["amount"])
		flash.errors = [:]
		
		try{
			def amount = params.amount.toDouble()
			transactionFrom.amount = amount
			transactionTo.amount = amount	
		}catch(NumberFormatException ex){
			flash.errors << ["Invlaid Amount":"Amount Field must be numbers only, with only on demimal (.) allowed"]
		}
		
		
		transactionTo.account = Account.get(params.toAccountId)
		transactionFrom.account = Account.get(params.fromAccountId)
		
		transactionTo.category =  Category.findByName("ACCOUNT TRANSFER IN")
		transactionFrom.category =  Category.findByName("ACCOUNT TRANSFER OUT")
		
		if(params.transferFee){
			try{
			def amount = params.transferFee.toDouble()
				transactionFrom.amount += amount
			}catch(NumberFormatException ex){
				flash.errors << ["Invlaid Transfer Fee":"Transfer Fee Field must be numbers only, with only on demimal (.) allowed"]
			}
		}
		
		if(flash.errors){
			render(view:"accountTransfer", model:[transactionInstance:new Transaction()])
			return
		}
		if(!(transactionFrom.validate() || transactionTo.validate())){ 
			render(view:"accountTransfer", model:[transactionInstance:transactionFrom])
			return
		}
		
		transactionService.create(transactionTo)
		transactionTo.save flush:true
		transactionService.create(transactionFrom)
		transactionFrom.save flush:true
		
		flash.message = "Transfer from ${transactionFrom.account} to ${transactionTo.account} in the amount of ${transactionTo.amount} was successful"
		redirect(action:"singleTransaction")
	}
	
	def combinationTransaction(){
		def amount
		if(!params.totalEntered){ 
			session.newTransactions = null
			session.transactionDate = null
			flash.message = null
			
			render(view:"combinationTransactionTotal", model:[amount:params.amount?:0])
		}else{
			try{
				amount = params.amount.toDouble()
			}catch(NumberFormatException ex){
				flash.errors << ["Invlaid Amount":"Amount Field must be numbers only, with only on demimal (.) allowed"]
				render(view:"combinationTransactionTotal", model:[amount:params.amount])		
			}
			def transaction = new Transaction()
			render(view:"combinationTransaction", model:[transactionInstance:transaction, totalAmount:amount])
//			[transactionInstance:transaction, totalAmount:amount]
		}
	}
	
	def createCombinationTransaction(){ 
		def totalAmount = params.hiddenTotalAmount.toDouble()
		def amount = params.amount.toDouble()
		def dateLock = ""
		
		def transactionInstance = new Transaction()
		bindData(transactionInstance,params,["amount"])
		
		if(!session.transactionDate){
			session.transactionDate = params.transactionDate
		}
		
		if(params.dateLock){
			dateLock = "disabled"
			
			transactionInstance.transactionDate = session.transactionDate
		}
		
		
		if(params.amount){
			try{
				amount = params.amount.toDouble()
				if(amount > totalAmount){
					amount = totalAmount
				} 
			}catch(NumberFormatException ex){
				flash.errors << ["Invlaid Amount":"Amount Field must be numbers only, with only on demimal (.) allowed"]
				transactionInstance.amount = 0
			}
		}
		transactionInstance.amount = amount
		 
		if (!transactionInstance.validate() || flash.errors) {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			params.order = "desc"
			render(view:"combinationTransaction",model:[transactionInstance:transactionInstance, totalAmount:totalAmount, dateLock:dateLock,amount:params.amount])
			return
		}
		 
		if(!session.newTransactions){
			session.newTransactions = [:]
		}
		
		session.newTransactions."Transacton${session.newTransactions.size()}" = transactionInstance
		totalAmount -= Math.abs(amount)
		if(totalAmount <= 0){
			flash.message = "Review the pending transactions list. Click Save when ready"
		}
		 
		render(view:"combinationTransaction",model:[transactionInstance:new Transaction(), totalAmount:totalAmount, dateLock:dateLock])
	}
	
	def saveCombinationTransactions(){
		def comboIdMaxResult = Transaction.withCriteria{
			projections{
				max("combinationId")
			}
		}
		
		def comboId = comboIdMaxResult.get(0)+1
		
		session.newTransactions.each{
			Transaction transaction = it.value
			if(transaction){
				transaction.combinationId = comboId
				transaction.save(flush:true)
				transactionService.create(transaction)
			}
			
		}
		
		def transactionTotal = 0
		session.newTransactions.each{
			transactionTotal += Math.abs(it.value.amount)
		}
		flash.message = "${session.newTransactions.size()} transactions were created totaling ${transactionTotal}"
		session.newTransactions = null
		redirect(action:"singleTransaction")
	}
	
	def removeTransactionFromCombo(){
		def totalAmount = params.amount.toDouble()
		totalAmount += Math.abs(session.newTransactions."${params.transactionKey}".amount)
		session.newTransactions.remove(params.transactionKey)
		render(view:"combinationTransaction",model:[transactionInstance:new Transaction(), totalAmount:totalAmount, dateLock:"disabled"])
		
	}
	
	def reconciliation(){
		
		Account accountInstance
		if(params.accountId && params.accountId != "All"){
			accountInstance = Account.get(params.accountId)
		}
		
		List transactions = []
		List bankRecords = []
		if(accountInstance || params.accountId == "All"){
			def dates = new Utilities().getBeginningAndEndOfMonth(params.year.toInteger(), params.month.toInteger())
			def firstOfMonth = dates.firstOfMonth
			def endOfMonth = dates.endOfMonth
			def combinationId = -1
			def transactionResults = Transaction.withCriteria {
				between("transactionDate",firstOfMonth,endOfMonth+1)
				ne("verified","Y")
				if(params.accountId != "All"){
					account{
						eq("id",accountInstance.id)
					}
				}
				category{
					metaCategory{
						ne("name","UNTRACKED")
					}
				}
				order("transactionDate","desc")
				order("combinationId","desc")
			}
			
			transactionResults.each{
				if(!it.combinationId){
					transactions << ["id":it.id,
									 "transactionDate":it.transactionDate,
						             "category":it.category.name,
									 "name":it.name,
									 "amount":it.amount]
				}else{
					if(it.combinationId == combinationId){
						transactions.get(transactions.size()-1).amount += it.amount	
						transactions.get(transactions.size()-1).name = "Combination Transaction"
					}else{
						transactions << ["id":it.id,
						                 "transactionDate":it.transactionDate,
						                 "category":it.category.name,
						                 "name": it.name,
										 "amount":it.amount,
										 "combinationId":it.combinationId]
						combinationId = it.combinationId
					}	
				}
			}
			
			bankRecords = BankRecord.withCriteria {
				between("transactionDate",firstOfMonth,endOfMonth+1)
				if(params.accountId != "All"){
					account{
						eq("id",accountInstance.id)
					}
				}
				isNull("transaction")
				order("transactionDate","desc")
			}
		}
		
		[month:params.month , year:params.year , accountId:params.accountId, transactionInstanceList:transactions , bankRecordInstanceList:bankRecords]
	}
	
	def getTransactionsForRecon(){
		List transactions = []
		def combinationId = -1
		def bankRecord = BankRecord.get(params.id)
		def transactionResults = Transaction.withCriteria {
			between("transactionDate", bankRecord.transactionDate - 4, bankRecord.transactionDate + 3)
			between("amount", bankRecord.amount - 5, bankRecord.amount + 5 )
			ne("verified","Y")
			if(!session.allAccounts){
				eq("account", bankRecord.account)
			}
			category{
				metaCategory{
					ne("name","UNTRACKED")
				}
			}
			order("transactionDate","desc")
			order("combinationId","desc")
		}
		
		transactionResults.each{
			if(!it.combinationId){
				transactions << ["id":it.id,
								 "transactionDate":it.transactionDate,
								 "category":it.category.name,
								 "name":it.name,
								 "amount":it.amount]
			}else{
				println it
				if(it.combinationId == combinationId){
					transactions.get(transactions.size()-1).amount += it.amount
					transactions.get(transactions.size()-1).name = "Combination Transaction"
				}else{
					transactions << ["id":it.id,
									 "transactionDate":it.transactionDate,
									 "category":it.category.name,
									 "name": it.name,
									 "amount":it.amount,
									 "combinationId":it.combinationId]
					combinationId = it.combinationId
				}
			}
		}
		
		render(view:"_reconTransactionList.gsp", model:[transactionInstanceList:transactions,selectList:true, bankRecord:bankRecord])
	}
	
	def toggleAllAccounts(){
		def message
		println "working with all accounts set to ${session.allAccounts}"
		if(!session.allAccounts){
			session.allAccounts = true
			message = "Look at Transactions that only match Bank Record Accounts"
		}else{
			session.allAccounts = false
			message = "Look at Transactions from all Accounts"
		}
		println "after processing all accounts is set to ${session.allAccounts}"
		render message
	}
	
	def singleTransactionForRecon(){
		def bankRecord = BankRecord.get(params.id)
		Transaction transactionInstance = new Transaction()
		transactionInstance.amount = bankRecord.amount
		transactionInstance.transactionDate = bankRecord.transactionDate
		transactionInstance.name = bankRecord.description
		transactionInstance.account = bankRecord.account
		
		render(view:"_reconTransactionForm", model:[transactionInstance:transactionInstance, bankRecordId:bankRecord.id])
	}
	
	def verify(){
		Transaction transactionInstance = Transaction.get(params.transactionId)
		BankRecord bankRecordInstance = BankRecord.get(params.bankRecordId)
		
		if(transactionInstance.combinationId){
			List transactionList = Transaction.withCriteria{
				eq("combinationId",transactionInstance.combinationId)
				account{
					eq("id",params.accountId.toLong())
				}
			}
			
			Double totalAmount = 0
			transactionList.each {
				totalAmount += it.amount
			}
			
			if(totalAmount != bankRecordInstance.amount){
				def addAmount = (bankRecordInstance.amount - totalAmount)/transactionList.size()
				transactionList.each {
					Transaction oldTransaction = new Transaction()
					bindData(oldTransaction,it.properties,['id','verson'])
					it.amount += addAmount
					it.account = bankRecordInstance.account
					transactionService.edit(it,oldTransaction)
				}
			}
			
			transactionList.each {
				it.verified = "Y"
				it.save(flush:true)
			}
			
		}else{
			Transaction oldTransaction = new Transaction()
			bindData(oldTransaction,transactionInstance.properties,['id','verson'])
			transactionInstance.amount = bankRecordInstance.amount
			transactionInstance.account = bankRecordInstance.account
			transactionService.edit(transactionInstance,oldTransaction)
			transactionInstance.verified = "Y"
			transactionInstance.save(flush:true)
		} 
		bankRecordInstance.transaction = transactionInstance
		bankRecordInstance.save(flush:true)
		redirect(action:"reconciliation",params:params)
	}
}
