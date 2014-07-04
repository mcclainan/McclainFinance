import grails.util.Environment;
import com.category.*
import com.planning.*
import com.tracking.*
import com.assetLiability.*

class BootStrap {
	MetaCategory metaCategory
	Category category
	BudgetItem budgetItem
	PlannedTransaction plannedTransaction 
	Account account
	AssetLiabilityClass assetLiabilityClass
	AssetLiability assetLiability
	YearBeginningResources yearBeginningResources
	Transaction transaction
	BankRecord bankRecord
	def month
	def year
	def date = new Date()
    def init = { servletContext ->
		println "Initializing"
		switch(Environment.current){
			case Environment.DEVELOPMENT:
				createTestData()
				break;
//			case Environment.TEST:
//				createTestData()
//				break;
		}
		
		def monthNames = [(1):"January", (2):"February",(3):"March",(4): "April", (5):"May", (6):"June", (7):"July", (8):"August", (9):"September", (10):"October", (11):"November",(12):"December"]
		def monthNumbers = [("January"):1, ("February"):2,("March"):3,("April"): 4 , ("May"): 5, ("June"): 6, ("July"):7, ("August"):8, ("September"):9, ("October"):10, ("November"):11,("December"):12]
		servletContext.setAttribute("monthNames", monthNames)
		servletContext.setAttribute("monthNumbers", monthNumbers)
    }
    def destroy = {
    }
	
	void createTestData(){
		createMetaCategoryIfRequired()
		createCategoryIfRequired()
		createBudgetItemIfRequied()
		createPlannedTransactionIfRequired()
		createAccountIfNeeded()
		createAssetLiabilityClassIfNeeded()
		createAssetLiabilityIfNeeded()
		createYearBeginningResourcessIfNeeded()
		createTransactionsIfNeeded()
	}
	
	void createMetaCategoryIfRequired(){
		if(!MetaCategory.findAllByPriority("Z")){
			println "Creating Meta Category Test Data."
			metaCategory = new MetaCategory(name:"JOB", priority: "Z", active: "Y").save(flush: true)
			metaCategory = new MetaCategory(name:"HOUSING", priority: "Z", active: "Y").save(flush: true)
			metaCategory = new MetaCategory(name:"FOOD", priority: "Z", active: "Y").save(flush: true)
			metaCategory = new MetaCategory(name:"TRANSPORTATION", priority: "Z", active: "Y").save(flush: true)
			metaCategory = new MetaCategory(name:"CLOTHING", priority: "Z", active: "Y").save(flush: true)
			metaCategory = new MetaCategory(name:"FINANCING", priority: "Z", active: "Y").save(flush: true)
			metaCategory = new MetaCategory(name:"ADJUSTMENTS", priority: "Z", active: "Y").save(flush: true)
			metaCategory = new MetaCategory(name:"UNTRACKED", priority: "Z", active: "Y").save(flush: true)
		}
	}
	
	void createCategoryIfRequired(){
		if(!Category.findAllByPriority("0")){
			println "Creating Category Test Data."
			
			metaCategory = MetaCategory.findByName("JOB")
			metaCategory.addToCategories(new Category(name: "PAPA JOHNS", priority: "0", cash: "Y", type: "I", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.addToCategories(new Category(name: "EXPEDIA", priority: "0", cash: "Y", type: "I", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.save(flush: true)
			
			metaCategory = MetaCategory.findByName("HOUSING")
			metaCategory.addToCategories(new Category(name: "RENT", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.addToCategories(new Category(name: "UTILITIES", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.save(flush: true)
			
			metaCategory = MetaCategory.findByName("FOOD")
			metaCategory.addToCategories(new Category(name: "GROCERIES", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory, displayOnMobile: "Y").save(flush: true))
			metaCategory.addToCategories(new Category(name: "OUT OF HOME FOOD", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory, displayOnMobile: "Y").save(flush: true))
			metaCategory.save(flush: true)
			
			metaCategory = MetaCategory.findByName("TRANSPORTATION")
			metaCategory.addToCategories(new Category(name: "FUEL", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory, displayOnMobile: "Y").save(flush: true))
			metaCategory.addToCategories(new Category(name: "VEHICLE MAINTAINENCE", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory, displayOnMobile: "Y").save(flush: true))
			metaCategory.save(flush: true)
			
			metaCategory = MetaCategory.findByName("CLOTHING")
			metaCategory.addToCategories(new Category(name: "KIDS CLOTHES", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory, displayOnMobile: "Y").save(flush: true))
			metaCategory.save(flush: true)
			
			metaCategory = MetaCategory.findByName("FINANCING")
			metaCategory.addToCategories(new Category(name: "TITLE MAX LOAN-PROCEEDES", priority: "0", cash: "Y", type: "I", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.addToCategories(new Category(name: "TITLE MAX LOAN-PAYMENT", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.addToCategories(new Category(name: "TITLE MAX LOAN-INTEREST", priority: "0", cash: "N", type: "E", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.addToCategories(new Category(name: "Bank Credit Card-PROCEEDES", priority: "0", cash: "Y", type: "I", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.addToCategories(new Category(name: "Bank Credit Card-PAYMENT", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.addToCategories(new Category(name: "Bank Credit Card-INTEREST", priority: "0", cash: "N", type: "E", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.save(flush: true)
			
			metaCategory = MetaCategory.findByName("ADJUSTMENTS")
			metaCategory.addToCategories(new Category(name: "ACCOUNT TRANSFER OUT", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.addToCategories(new Category(name: "ACCOUNT TRANSFER IN", priority: "0", cash: "Y", type: "I", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.save(flush: true)

			metaCategory = MetaCategory.findByName("UNTRACKED")
			metaCategory.addToCategories(new Category(name: "Untracked Expense", priority: "0", cash: "Y", type: "E", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.addToCategories(new Category(name: "Untracked Income", priority: "0", cash: "Y", type: "I", active: "Y", metaCategory: metaCategory).save(flush: true))
			metaCategory.save(flush: true)
		}
	}
	
	void createBudgetItemIfRequied(){
		month =  new Date().format("MM").toInteger()
		year = new Date().format("yyyy").toInteger()
		if(!BudgetItem.findAllByYearAndMonth(year,month)){
			println "Creating Budget Item test data."
			
			category = Category.findByName("PAPA JOHNS")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 400, category : category, active: "Y").save(flush: true))
			category.save(flush: true)
			
			category = Category.findByName("EXPEDIA")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 1000, category : category, active: "Y").save(flush: true))
			category.save(flush: true)
			
			category = Category.findByName("RENT")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 600, category : category, active: "Y",required:"Y").save(flush: true))
			category.save(flush: true)
			
			category = Category.findByName("UTILITIES")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 200, category : category, active: "Y",required:"Y").save(flush: true))
			category.save(flush: true)
			
			category = Category.findByName("GROCERIES")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 200, category : category, active: "Y").save(flush: true))
			category.save(flush: true)

			category = Category.findByName("OUT OF HOME FOOD")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 0, category : category, active: "Y").save(flush: true))
			category.save(flush: true)
			
			category = Category.findByName("FUEL")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 200, category : category, active: "Y").save(flush: true))
			category.save(flush: true)
			
			category = Category.findByName("VEHICLE MAINTAINENCE")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 40, category : category, active: "Y").save(flush: true))
			category.save(flush: true)
			
			category = Category.findByName("KIDS CLOTHES")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 50, category : category, active: "Y").save(flush: true))
			category.save(flush: true)

			category = Category.findByName("TITLE MAX LOAN-PAYMENT")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 120, category : category, active: "Y",required:"Y").save(flush: true))
			category.save(flush: true)
			
			category = Category.findByName("TITLE MAX LOAN-INTEREST")
			category.addToBudgetItems(new BudgetItem(year:year, month:month, amount: 100, category : category, active: "Y").save(flush: true))
			category.save(flush: true)
			
		}
	}
	
	void createPlannedTransactionIfRequired(){
		month =  new Date().format("MM").toInteger()
		year = new Date().format("yyyy").toInteger()
		if(true){
			println "Creating Planned Transaction Test Data"
			
			category = Category.findByName("PAPA JOHNS")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			
			date.set(date:1)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 200, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)

			category = Category.findByName("EXPEDIA")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:7)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 500, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)

			category = Category.findByName("PAPA JOHNS")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:14)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 200, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("EXPEDIA")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:21)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 500, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("RENT")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:1)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 600, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("UTILITIES")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:7)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 200, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("GROCERIES")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:1)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 112.5, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("GROCERIES")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:7)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 112.5, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("GROCERIES")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:14)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 112.5, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("GROCERIES")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:21)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 112.5, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)

			category = Category.findByName("FUEL")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:1)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 50, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			
			category = Category.findByName("FUEL")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:7)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 50, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("FUEL")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:14)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 50, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("FUEL")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:21)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 50, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)

			category = Category.findByName("VEHICLE MAINTAINENCE")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:8)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 40, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
			
			category = Category.findByName("KIDS CLOTHES")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:15)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 50, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)

			category = Category.findByName("TITLE MAX LOAN-PAYMENT")
			budgetItem =  category.budgetItems.find{[year:year, month: month]}
			date.set(date:23)
			budgetItem.addToPlannedTransactions(new PlannedTransaction(plannedTransactionDate: date.clearTime(), amount: 120, category : budgetItem.category, budgetItem : budgetItem).save(flush: true))
			budgetItem.save(flush: true)
		}
		
	}
	
	void createAccountIfNeeded(){
						
		if(!Account.findByName("Cash")){
			println "Creating Cash Account"
			account = new Account(name: "Cash", balance: 0, active: "Y", cash: "Y").save(flush: true)
			def bankRecord = new BankRecord(transactionDate:new Date(),account:account,amount:100)
			bankRecord.save flush:true
		}
		if(!Account.findByName("EBT")){
			println "Creating EBT Account"
			account = new Account(name: "EBT", balance: 0, active: "Y", cash: "N").save(flush: true)
		}
		if(!Account.findByName("Bank Credit Card")){
			println "Creating Bank Credit Card Account"
			account = new Account(name: "Bank Credit Card", balance: 0, active: "Y", cash: "N").save(flush: true)
		}
	}
	
	void createAssetLiabilityClassIfNeeded(){
		println "Creating AssetLiabilityClass Test Data"
		if(!AssetLiabilityClass.findByName("LOAN")){
			assetLiabilityClass = new AssetLiabilityClass(name: "LOAN", onProceedes : 1, onPayment : -1, onInterest : 1).save(flush: true)
		}
		if(!AssetLiabilityClass.findByName("Credit Card")){
			assetLiabilityClass = new AssetLiabilityClass(name: "CREDIT CARD", onProceedes : 1, onPayment : -1, onInterest : 1, onUse : 1).save(flush: true)
		}
	}
	
	void createAssetLiabilityIfNeeded(){
		println "Creating Asset/Liability Test Data"
		assetLiability
		if(!AssetLiability.findByName("TITLE MAX LOAN")){
			assetLiability = new AssetLiability(name: "TITLE MAX LOAN", assetLiabilityClass: AssetLiabilityClass.findByName("LOAN"), type:"L", active: "Y", value: 900).save(flush: true)
		}
		if(!AssetLiability.findByName("Bank Credit Card")){
			assetLiability = new AssetLiability(name: "Bank Credit Card", assetLiabilityClass: AssetLiabilityClass.findByName("CREDIT CARD"), type:"L", active: "Y", value: 0, creditLimit: 500).save(flush: true)
		}
		account = Account.findByName("Bank Credit Card")
		account.assetLiability = assetLiability
		account.save(flush:true)
	}
	
	void createYearBeginningResourcessIfNeeded(){
		if(!YearBeginningResources.findByYear(2012)){
			println "Creating Year Beginning Cash Test Data"
			yearBeginningResources = new YearBeginningResources(year: 2012, budgetedAmount: 0, actualAmount: 0)
			if (yearBeginningResources.validate()){
				yearBeginningResources.save(flush: true)
			}else{
				yearBeginningResources.errors.each{
					println it
				}
			}

			yearBeginningResources = new YearBeginningResources(year: 2013, budgetedAmount: 0, actualCash: 1000)
			if (yearBeginningResources.validate()){
				yearBeginningResources.save(flush: true)
			}else{
				yearBeginningResources.errors.each{
					println it
				}
			}
			yearBeginningResources = new YearBeginningResources(year: 2014, budgetedAmount: 0, actualAmount: 0)
			if (yearBeginningResources.validate()){
				yearBeginningResources.save(flush: true)
			}else{
				yearBeginningResources.errors.each{
					println it
				}
			}
		}
	}
	
	void createTransactionsIfNeeded(){
		println "Creating Transaction Test Data"
		
		category = Category.findByName("EXPEDIA")
		account = Account.findByName("Cash")
		transaction = new Transaction(name: "Kia Pay 3000000000000",amount: 800, category: category, account: account, transactionDate: new Date()-5, combinationId : 0)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		category = Category.findByName("RENT")
		account = Account.findByName("Cash")
		transaction = new Transaction(name: "Rent",amount: -600, active: "Y", category: category, account: account, transactionDate: new Date()-6)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		category = Category.findByName("PAPA JOHNS")
		account = Account.findByName("Cash")
		transaction = new Transaction(name: "PayCheck",amount: 200, active: "Y", category: category, account: account,  transactionDate: new Date()-2)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		category = Category.findByName("GROCERIES")
		account = Account.findByName("EBT")
		transaction = new Transaction(name: "Food",amount: -80, active: "Y", category: category, account: account,  transactionDate: new Date()- 1)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()

		category = Category.findByName("GROCERIES")
		account = Account.findByName("EBT")
		transaction = new Transaction(name: "Food",amount: -80, active: "Y", category: category, account: account,  transactionDate: new Date()- 8)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		category = Category.findByName("TITLE MAX LOAN-PAYMENT")
		assetLiability = AssetLiability.findByName("TITLE MAX LOAN")
		account = Account.findByName("Cash")
		transaction = new Transaction(name: "Loan Payment",amount: -120, active: "Y", category: category, account: account, assetLiability: assetLiability,  transactionDate: new Date()-2)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		assetLiability.addToTransactions(transaction)
		category = Category.findByName("EXPEDIA")
		account = Account.findByName("Cash")
		transaction = new Transaction(name: "Kia Pay",amount: 800, category: category, account: account, transactionDate: new Date()-5)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		category = Category.findByName("RENT")
		account = Account.findByName("Cash")
		transaction = new Transaction(name: "Rent",amount: -600, active: "Y", category: category, account: account, transactionDate: new Date()-36)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		category = Category.findByName("PAPA JOHNS")
		account = Account.findByName("Cash")
		transaction = new Transaction(name: "PayCheck",amount: 200, active: "Y", category: category, account: account,  transactionDate: new Date()-32)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		category = Category.findByName("GROCERIES")
		account = Account.findByName("EBT")
		transaction = new Transaction(name: "Food",amount: -80, active: "Y", category: category, account: account,  transactionDate: new Date()- 31)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		category = Category.findByName("GROCERIES")
		
		account = Account.findByName("EBT")
		transaction = new Transaction(name: "Food",amount: -80, active: "Y", category: category, account: account,  transactionDate: new Date()- 38)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		category = Category.findByName("TITLE MAX LOAN-PAYMENT")
		assetLiability = AssetLiability.findByName("TITLE MAX LOAN")
		account = Account.findByName("Cash")
		transaction = new Transaction(name: "Loan Payment",amount: -120, active: "Y", category: category, account: account, assetLiability: assetLiability,  transactionDate: new Date()-32)
		budgetItem = category.budgetItems.find{[year: year, month: month]}
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		budgetItem.addToTransactions(transaction)
		assetLiability.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		account = Account.findByName("Cash")
		category = Category.findByName("Untracked Expense")
		transaction = new Transaction(name: "???",amount: -100, active: "Y", category: category, account: account,  transactionDate: new Date()- 10)
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		account = Account.findByName("Cash")
		category = Category.findByName("Untracked Income")
		transaction = new Transaction(name: "???",amount: 80, active: "Y", category: category, account: account,  transactionDate: new Date()- 6)
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
				
		account = Account.findByName("EBT")
		category = Category.findByName("GROCERIES")
		transaction = new Transaction(name: "Walmart Food",amount: -218, active: "Y", category: category, account: account,  transactionDate: new Date()- 6, combinationId: 1)
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
		
		account = Account.findByName("Cash")
		category = Category.findByName("KIDS CLOTHES")
		transaction = new Transaction(name: "Clothes",amount: -124, active: "Y", category: category, account: account,  transactionDate: new Date()- 6,  combinationId: 1)
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()

		account = Account.findByName("Cash")
		category = Category.findByName("OUT OF HOME FOOD")
		transaction = new Transaction(name: "Walmart Hot Food",amount: -8.25, active: "Y", category: category, account: account,  transactionDate: new Date()- 6,  combinationId: 1)
		category.addToTransactions(transaction)
		account.addToTransactions(transaction)
		bankRecord = new BankRecord(account:transaction.account, amount:transaction.amount, transactionDate:transaction.transactionDate, description:transaction.name)
		bankRecord.save()
	}
	
}
