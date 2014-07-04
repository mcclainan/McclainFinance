package com.reports
import org.apache.log4j.lf5.viewer.categoryexplorer.CategoryImmediateEditor;

import com.category.*
import com.planning.* 
import com.tracking.*
import com.utilities.Utilities

class ReportService {

    def getMonthBreakdown(Map params) {
		println "Processing Month Breakdown"
    	Map incomeBreakdown = [:]
		Map expenseBreakdown = [:]
		
		List metaCategories = MetaCategory.list()
		
		Map dates = new Utilities().getBeginningAndEndOfMonth(params.year.toInteger(), params.month.toInteger())
		Date startDate = dates.firstOfMonth
		Date endDate = dates.endOfMonth
		
		println "getting income"
		metaCategories.each{metaCategoryInstance->
			metaCategoryInstance.categories.each{categoryInstance->
				def incomeResult = Transaction.withCriteria {  
					between("transactionDate",startDate, endDate)
					category{
						eq("id",categoryInstance.id)
						eq("type","I")
						metaCategory{
							not{'in'("name",["ADJUSTMENTS","UNTRACKED"])}
						}
					}
					
					projections{
						sum("amount")
					}
				}	
				
				if(incomeResult.get(0)){
						if(!incomeBreakdown["${metaCategoryInstance.name}"]){ 
							incomeBreakdown."${metaCategoryInstance.name}" = []
						}
						incomeBreakdown."${metaCategoryInstance.name}" << ["${categoryInstance.name}",incomeResult.get(0),categoryInstance.id]
				}
			}			
		}
		
		println "getting Expense"
    	metaCategories.each{metaCategoryInstance->
	    	metaCategoryInstance.categories.each{categoryInstance->
		    	def expenseResult = Transaction.withCriteria {  
		    		between("transactionDate",startDate, endDate)
		    		category{
		    			eq("id",categoryInstance.id)
		    			eq("type","E")
		    			metaCategory{
							not{'in'("name",["ADJUSTMENTS","UNTRACKED"])}
						}
		    		}
		    		
		    		projections{
		    			sum("amount")
		    		}
		    	}	
		    	
		    	if(expenseResult.get(0)){
		    		if(!expenseBreakdown["${metaCategoryInstance.name}"]){
		    			expenseBreakdown."${metaCategoryInstance.name}" = []
		    		}
		    		expenseBreakdown."${metaCategoryInstance.name}" << ["${categoryInstance.name}",expenseResult.get(0),categoryInstance.id]
		    	}
	    	}			
    	}
		
		println "getting untracked"
		List untrackedTransactionResult = Transaction.withCriteria {
			between("transactionDate",startDate, endDate)
			category{
				metaCategory{
					eq("name","UNTRACKED")
				}
			}
			projections{
				sum("amount")
			}
		}
		
		if(untrackedTransactionResult.get(0)){
			Double amount = untrackedTransactionResult.get(0)
			
			
			
			if(amount<0){
				expenseBreakdown."UNTRACKED" = []
				expenseBreakdown."UNTRACKED" << ["Untracked Expense", amount,Category.findByName("Untracked Expense").id]
				
			}else if(amount>0){
				incomeBreakdown."UNTRACKED" = []
				incomeBreakdown."UNTRACKED" << ["Untracked Income", amount,Category.findByName("Untracked Income").id]
			} 
		}
		
		println "returning month break down"
		return [incomeBreakdown:incomeBreakdown,expenseBreakdown:expenseBreakdown]
    }
	
	def getSummary(Map params){
		println "Processing Summary"
		Map summary = [:]
		Date startDate = new Date().clearTime()
		startDate.set(year:params.year.toInteger())
		startDate.set(month:0)
		startDate.set(date:1)
		
		Map dates = new Utilities().getBeginningAndEndOfMonth(params.year.toInteger(), params.month.toInteger() - 1)
		Date endDate = dates.endOfMonth
		println "Start Date: ${startDate}\nEnd Date ${endDate}"
		
		YearBeginningResources yearBeginningResources = YearBeginningResources.findByYear(params.year.toInteger())
		println "getting cash"
		def cashActivity = Transaction.withCriteria {
			between("transactionDate",startDate,endDate)
			account{
				eq("cash","Y")
			}
			projections{
				sum("amount")
			}
		}
		
		if(cashActivity.get(0)){
			println "activity found "
			summary << ["beginningCash": yearBeginningResources.actualCash + cashActivity.get(0)]
		}else{
			println "No activity found"
			summary << ["beginningCash": yearBeginningResources.actualCash]
		}
		println "getting credit card"
		def creditCardActivity = Transaction.withCriteria {
			between("transactionDate",startDate,endDate)
			account{
				eq("cash","N")
				assetLiability{
					assetLiabilityClass{
						eq("name","CREDIT CARD")
					}
				}
			}
			projections{
				sum("amount")
			}
		}
		
		if(creditCardActivity.get(0)){
			summary << ["beginningCreditCard": yearBeginningResources.actualCreditCard + creditCardActivity.get(0)]
		}else{
			summary << ["beginningCreditCard": yearBeginningResources.actualCreditCard]
		}
		println "getting benefits"
		def benifitActivity = Transaction.withCriteria {
			between("transactionDate",startDate,endDate)
			account{
				eq("name","EBT")
			}
			projections{
				sum("amount")
			}
		}
		
		if(benifitActivity.get(0)){
			summary << ["beginningBenifit": yearBeginningResources.actualBenifits + benifitActivity.get(0)]
		}else{
			summary << ["beginningBenifit": yearBeginningResources.actualBenifits]
		}
		println"getting other activity"
		def otherActivity = Transaction.withCriteria {
			between("transactionDate",startDate,endDate)
			account{
				eq("cash","N")
				ne("name","EBT")
				isNull("assetLiability")
			}
			projections{
				sum("amount")
			}
		}
		
		if(otherActivity.get(0)){
			summary << ["beginningOther": yearBeginningResources.actualOther + otherActivity.get(0)]
		}else{
			summary << ["beginningOther": yearBeginningResources.actualOther]
		}
		
		dates = new Utilities().getBeginningAndEndOfMonth(params.year.toInteger(), params.month.toInteger())
		startDate = dates.firstOfMonth
		endDate = dates.endOfMonth
				
		cashActivity = Transaction.withCriteria {
			between("transactionDate",startDate,endDate)
			account{
				eq("cash","Y")
			}
			projections{
				sum("amount")
			}
		}
		
		if(cashActivity.get(0)){
			summary << ["enddingCash": summary.beginningCash + cashActivity.get(0)]
		}else{
			summary << ["enddingCash": summary.beginningCash]
		}
		
		creditCardActivity = Transaction.withCriteria {
			between("transactionDate",startDate,endDate)
			account{
				eq("cash","N")
				assetLiability{
					assetLiabilityClass{
						eq("name","CREDIT CARD")
					}
				}
			}
			projections{
				sum("amount")   
			}
		}
		
		if(creditCardActivity.get(0)){
			summary << ["enddingCreditCard": summary.beginningCreditCard + creditCardActivity.get(0)]
		}else{
			summary << ["enddingCreditCard": summary.beginningCreditCard ]
		}
		
		benifitActivity = Transaction.withCriteria {
			between("transactionDate",startDate,endDate)
			account{
				eq("name","EBT")
			}
			projections{
				sum("amount")
			}
		}
		
		if(benifitActivity.get(0)){
			summary << ["enddingBenifit": summary.beginningBenifit + benifitActivity.get(0)]
		}else{
			summary << ["enddingBenifit": summary.beginningBenifit]
		}
		
		otherActivity = Transaction.withCriteria {
			between("transactionDate",startDate,endDate)
			account{
				eq("cash","N")
				ne("name","EBT")
				isNull("assetLiability")
			}
			projections{
				sum("amount")
			}
		}
		
		if(otherActivity.get(0)){
			summary << ["enddingOther": summary.beginningOther + otherActivity.get(0)]
		}else{
			summary << ["enddingOther": summary.beginningOther]
		}
		
		return summary		
	}
	
	def getYearOverview(Map params){
		List yearOverview = []
		for(int i=1;i<=12;i++){
			Map dates = new Utilities().getBeginningAndEndOfMonth(params.year.toInteger(), i)
			Date startDate = dates.firstOfMonth
			Date endDate = dates.endOfMonth
			Double income = 0
			Double expense = 0
			
			def incomeResult = Transaction.withCriteria {
				between("transactionDate",startDate,endDate)
				category{
					eq("type","I")
					metaCategory{
						not{'in'("name",["ADJUSTMENTS","UNTRACKED"])}
					}
				}
				projections{
					sum("amount")
				}
			}

			if(incomeResult.get(0)){
				income = incomeResult.get(0)
			}
			def expenseResult = Transaction.withCriteria {
				between("transactionDate",startDate,endDate)
				category{
					eq("type","E")  
					metaCategory{
						not{'in'("name",["ADJUSTMENTS","UNTRACKED"])}
					}
				}
				projections{
					sum("amount")
				}
			}
			
			if(expenseResult.get(0)){
				expense = expenseResult.get(0)
			}
			
			def untrackedTransactionResult = Transaction.withCriteria {
				between("transactionDate",startDate,endDate)
				category{
					metaCategory{
						eq("name","UNTRACKED")
					}
				}
				projections{
					sum("amount")
				}
			}
			
			if(untrackedTransactionResult.get(0)){
				Double amount = untrackedTransactionResult.get(0)
				
				if(amount<0){
					expense += amount						
				}else{
					income += amount
				}
			}
			
			yearOverview << [i,income,expense]
		}
		
		return yearOverview
	}

	def getIncomeAndExpenseReoprt(Map params){
		Map dates = new Utilities().getBeginningAndEndOfMonth(params.year.toInteger(), params.month.toInteger())
		Date startDate = dates.firstOfMonth
		Date endDate = dates.endOfMonth
		def monthBreakDown = this.getMonthBreakdown(params)
		def incomeBreakdown = monthBreakDown.incomeBreakdown
		def expenseBreakdown = monthBreakDown.expenseBreakdown
		
		
		
		incomeBreakdown.each {metaCategry->
			metaCategry.value.each{categoryInstance->
				def id = categoryInstance.get(2)
				
				def transactionList = Transaction.withCriteria {
					between("transactionDate",startDate, endDate)
					category{
						eq("id", id)
					}
				}
				
				categoryInstance << transactionList
			}
		}
		
		expenseBreakdown.each {metaCategry->
			metaCategry.value.each{categoryInstance->
			def id = categoryInstance.get(2)
			
			def transactionList = Transaction.withCriteria {
				between("transactionDate",startDate, endDate)
				category{
					eq("id", id)
				}
			}
			
			categoryInstance << transactionList
			}
		}
		
		return [incomeBreakdown:incomeBreakdown,expenseBreakdown:expenseBreakdown]
	}
}
