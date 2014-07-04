package com.planning
import com.category.Category
import com.tracking.Account
import com.tracking.Transaction

class PlannedTransactionService {

	Date currentDate 
   
	def createSet(Map params) {
/*Create Local Variables*/
		//Retrieve initial budget item
		BudgetItem budgetItem = BudgetItem.get(params.id)
		//Create map to hold errors
		Map errors = [:]
		//Create variable to count the errors to make unique error keys on the error map
		Integer errorIterator = 1
		//Create map to hold messages
		Map messages = [:]
		//Create variable to count the messages to make unique message keys on the message map
		Integer messageIterator = 1
		//Create a lists for planned transactions
		List plannedTransactions = []
		List newPlannedTransactions = []
		//????
		Double amount = 0
		//Category that all planned transactions will have
		Category categoryInstance = budgetItem.category
		//Initiate current date global variable
		currentDate = new Date()
/*End Variable Creation*/
		
/*Validate Fields*/
		//Validate Amount
		if(params.amountOption == "addAmount" || params.createMode == "single"){
			try{
				amount = params.amount.toDouble()
				if(amount < 0) throw new NumberFormatException()
			}catch(Exception ex){
				errors.inValidAmount = "Invalid Amount"
			}
		}
		//Validate start date is not in the past
		if(params.startDate.clearTime() < currentDate.clearTime()){
			errors.inValidStartDateType1 = "Start Date must be current or future date"
		}
		//Validate start date is before end date
		if((params.startDate > params.endDate)&& !params.createMode == "single"){
			errors.inValidStartDateType2 = "Start Date must be before end date"
		}
		//Validate the start date is in the same month as the budget item
		if(params.startDate.format("MM").toInteger()!= budgetItem.month &&
			params.startDate.format("YYYY").toInteger()!= budgetItem.year){
			errors.inValidStartDateType3 = "Start Date must be within the month of the chosen budget item"
		}
		//if errors exist halt process and return the errors
		if(errors){
			return [errors:errors]
		}
/*End Validation*/
		
		//If the user chooses to replace current set the delete all planned transactions in the date range
		if(params.replaceCurrentSet){
			List currentSet = PlannedTransaction.withCriteria {
				between("plannedTransactionDate",params.startDate-1,params.endDate+1)
				category{
					eq("id",categoryInstance.id)
				}
			}		
			currentSet.each{ plannedTransaction ->
				plannedTransaction.delete(flush:true)
			}
		}
		
		
		currentDate = params.startDate
		
		if(params.createMode == "single"){
			PlannedTransaction plannedTransaction = new PlannedTransaction(plannedTransactionDate:currentDate.clearTime(),category:categoryInstance, budgetItem:budgetItem, amount:params.amount)
			plannedTransaction.save(flush:true)
			budgetItem.calculateAmount()
			messages."message${messageIterator++}" = "1 planned transaction created for ${budgetItem}"
		}else{
			int i = 1
			println "_______________________________________________________________"
			while(currentDate <= params.endDate && !errors.inValidStartDate){
				Integer year = currentDate.format("yyyy").toInteger()
				Integer month = currentDate.format("MM").toInteger() 
				if(budgetItem.year != year || budgetItem.month != month){
					List budgetItems = BudgetItem.withCriteria {
						eq("year",year)
						eq("month",month)
						category{
							eq("id",categoryInstance.id)
						}
					}
					
					if(budgetItems){
						budgetItem = budgetItems.get(0)
					}else{
						errors."missingBudgetItem${errorIterator++}" = "No ${categoryInstance} Budget Item exists for ${month}/${year}<br/>"
								while(currentDate.format("yyyy").toInteger() == year && currentDate.format("MM").toInteger() == month){
									getNextDate(params.frequencyOption)
								}
						continue
					}
				}
				
				PlannedTransaction plannedTransaction = new PlannedTransaction(plannedTransactionDate:currentDate.clearTime(),category:categoryInstance, budgetItem:budgetItem)
				plannedTransaction.save(flush:true)
				
				plannedTransactions << plannedTransaction
				
				getNextDate(params.frequencyOption)
				
				if(budgetItem.year != currentDate.format("yyyy").toInteger() || budgetItem.month != currentDate.format("MM").toInteger()){
					messages."message${messageIterator++}" = "${plannedTransactions.size()} planned transaction created for ${budgetItem}"
							if(params.amountOption == "deriveAmount"){
								amount = budgetItem.amount/plannedTransactions.size()
							}
					
					plannedTransactions.each{
						it.amount = amount
						it.save(flush:true)
//						newPlannedTransactions << it
					}
					
					if(params.amountOption == "addAmount"){
						budgetItem.calculateAmount()
					}
					
					plannedTransactions = []
				}
			}
		}
		
		return [errors : errors, messages:messages]
	}

	def getNextDate(String frequencyOption){
		if(frequencyOption == "daily"){
			currentDate = currentDate + 1
		}else if(frequencyOption == "biDaily"){
			currentDate = currentDate + 2
		}else if(frequencyOption == "weekly"){
			currentDate = currentDate + 7
		}else if(frequencyOption == "biWeekly"){
			currentDate = currentDate + 14
		}else if(frequencyOption == "monthly"){
			Calendar calendar = new GregorianCalendar(currentDate.format("YYYY").toInteger(), currentDate.format("MM").toInteger()-1, currentDate.format("dd").toInteger())
			calendar.add(Calendar.MONTH, 1)
			int month = calendar.get(Calendar.MONTH)
			if(month == 0){
				currentDate.set(year:currentDate.format("YYYY").toInteger()+1)
			}
			currentDate.set(month:month)
		}//else if(frequencyOption == "semiMonthly"){
		//		}
	}
	
	def getSearchDateRange(Map params){
		Date startDate
		Date endDate
		
		def month = params.month.format("MM").toInteger()
		def year = params.month.format("yyyy").toInteger()
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month, 1);
		int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		def firstOfTheMonth = new Date()
		firstOfTheMonth.set(year: year, month: month-1, date:1)
		def endOfTheMonth = new Date()
		endOfTheMonth.set(year: year, month: month-1, date:days)
		
		[startDate:firstOfTheMonth.clearTime(),endDate:endOfTheMonth.clearTime()]
	}
	
	def editAmount(PlannedTransaction plannedTransaction, Map params){
		def errors = [:]
		def amount
		try{
			amount = params.amount.toDouble()
			if(amount < 0) throw new NumberFormatException()
			plannedTransaction.amount = amount
			plannedTransaction.budgetItem.calculateAmount()
		}catch(Exception ex){
			errors.inValidAmount = "Invalid Amount"
		}
		
		[errors:errors]
	}

	def getCashFlowCalendar(Map params){
		rollPlannedTransactions()
		Calendar cal = Calendar.getInstance()
		def startDate = new Date()
		def endDate = new Date()
		def i = cal.get(Calendar.DAY_OF_WEEK)
		def dateday = cal.get(Calendar.DATE)
		def tempCalendar = [:]
		def totalOnHand = Account.withCriteria {
			eq("active","Y")
			eq("cash","Y")
			projections{
				sum("balance")
			}
		}.get(0)
		
		//create a map with 35 elements to hold five weeks of data
		int numberOfWeeks = 5
		
		if(params){
			numberOfWeeks =  params.weeks?.toInteger() ?: 5
		}
		
		int elements = numberOfWeeks * 7
		for (int j = 0; j < elements; j++) {
			def key
			def date
			def fullDate = new Date()
			
			if((j+1)<i){
				key = j
				date = " "  
			}else{
				key = "${cal.get(Calendar.MONTH)}/${cal.get(Calendar.DATE)}"
				date = cal.get(Calendar.DATE)
				fullDate.set(year:cal.get(Calendar.YEAR),month:cal.get(Calendar.MONTH),date:cal.get(Calendar.DATE))
				fullDate.clearTime()
				fullDate = fullDate.format("MM-dd-yyyy")
				cal.add(Calendar.DATE, 1)
			}
			tempCalendar.put(key,[fullDate: fullDate,date:date,income:0,expense:0,balance:0])
		}
		
		
		/*Deduct Transaction made today from on hand balance so that they don't double count with 
		the planned transaction of the day*/
		def todaysIncome = Transaction.withCriteria {
			category{
				eq("type","I")
			}
			account{
				eq("active","Y")
				eq("cash","Y")
			}
			eq("transactionDate",new Date().clearTime())
			projections{
				sum("amount")
			}
		}.get(0)
		def todaysExpense = Transaction.withCriteria {
			category{
				eq("type","E")
			}
			account{
				eq("active","Y")
				eq("cash","Y")
			}
			eq("transactionDate",new Date().clearTime())
			projections{
				sum("amount")
			}
		}.get(0)
				
		if(!todaysIncome)todaysIncome=0
		if(!todaysExpense)todaysExpense=0
		def total = todaysIncome + (todaysExpense/2)
		totalOnHand -= total

		//Set end date for queary
		cal = Calendar.getInstance();
		cal.add(Calendar.DATE, elements)
		endDate.set(year: cal.get(Calendar.YEAR), month: cal.get(Calendar.MONTH), date:cal.get(Calendar.DATE))
		
		/*Get Income and Expense sets for appropriate dates and 
		 * place them in the map at appropriate location*/ 
		def incomeSet = PlannedTransaction.withCriteria {
			between("plannedTransactionDate",startDate-1,endDate)
			category{
				eq("type","I")
			}
			projections{
				groupProperty("plannedTransactionDate")
				sum("amount")
			}
		}
		incomeSet.each {
			Date date = (Date)it.getAt(0)
			def key = "${date.format("MM").toInteger()-1}/${date.format("dd").toInteger()}"
			if(tempCalendar.get(key)){
				tempCalendar.get(key).putAt("income", it.getAt(1))
			}
		}
		def expenseSet = PlannedTransaction.withCriteria {
			between("plannedTransactionDate",startDate-1,endDate)
			category{
				eq("type","E")
			}
			projections{
				groupProperty("plannedTransactionDate")
				sum("amount")
			}
		}
		expenseSet.each {
			Date date = (Date)it.getAt(0)
			def key = "${date.getAt(Calendar.MONTH)}/${date.getAt(Calendar.DATE)}"
			if(tempCalendar.get(key)){
				tempCalendar.get(key).putAt("expense", it.getAt(1))
			}
		}
		
		/*Create the map that will hold the data that is sent to the view*/
		def calendar = []
		def calendarRow = []
		int sent = 0
		def j = 0
		for (def map : tempCalendar) {
			
			totalOnHand += map.value.income - map.value.expense
			if(((j++)+1)<i){
				map.value.balance = 0
			}else{
				map.value.balance = totalOnHand
			}
			calendarRow.add(map.value)
			if(++sent >= 7){
				calendar.add(calendarRow)
				calendarRow = []
				sent=0
			}
		}
		return calendar
	}
	
	def rollPlannedTransactions(){
		println "geting rolling list"
		def rollingList = PlannedTransaction.withCriteria {
			eq("rolling","Y")
			lt("plannedTransactionDate",new Date().clearTime())
		}	
		if(rollingList){
			println "rolling list found"
			rollingList.each{plannedTransactionInstance ->
				println "rollint ${plannedTransactionInstance}"
				plannedTransactionInstance.plannedTransactionDate = plannedTransactionInstance.plannedTransactionDate + 1
			}
		}
		
	}
}
