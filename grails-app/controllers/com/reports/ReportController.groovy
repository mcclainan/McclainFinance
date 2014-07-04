package com.reports

class ReportController {
	def reportService
	static navigation = [
	                     [group:"reportsTab",action:"financial", title:"Financial Report"],	
	                     [group:"reportsTab",action:"incomeAndExpense", title:"Income And Expense Report"]	
	                	]

	def index() { 
		redirect(action:"menu")
	}
	
	def menu(){}
	
	
	
	def financial(){
		params.month = params.month?: new Date().format("MM").toInteger()
		params.year = params.year?: new Date().format("yyyy").toInteger()
		def monthBreakdowns = reportService.getMonthBreakdown(params)
		def summary = reportService.getSummary(params)
		def yearOverview = reportService.getYearOverview(params)
		def month = params.month
		def year = params.year 
		
		[incomeBreakdown:monthBreakdowns.incomeBreakdown, 
		 expenseBreakdown:monthBreakdowns.expenseBreakdown , 
		 yearOverview:yearOverview , 
		 summary:summary , 
		 month:month , 
		 year:year] 
	}
	
	def incomeAndExpense(){
		params.month = params.month?: new Date().format("MM").toInteger()
		params.year = params.year?: new Date().format("yyyy").toInteger()
		
		def incomeAndExpense = reportService.getIncomeAndExpenseReoprt(params)
		def month = params.month
		def year = params.year
		
		[incomeBreakdown:incomeAndExpense.incomeBreakdown,
		 expenseBreakdown:incomeAndExpense.expenseBreakdown,
		 month:month ,
		 year:year]
	}
}
       