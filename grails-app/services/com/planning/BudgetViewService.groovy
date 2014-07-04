package com.planning
import com.category.*
import com.tracking.Transaction
import com.utilities.Utilities
class BudgetViewService {
    def budgetView(params){
		def year = (params.year?:new Date().format("yyyy")).toInteger()
		def month = (params.month?:new Date().format("MM")).toInteger()
		//Get Year Overview
		List yearOverView = []
		YearBeginningResources yBR = YearBeginningResources.findByYear(year.toInteger())
		double totalResorces = yBR.actualCash + yBR.actualCreditCard + yBR.actualBenifits + yBR.actualOther 
		for(int i = 1; i <= 12; i++){
			if(i < new Date().format("MM").toInteger() && params.staticBudget != true ){
				Map monthTotals = getActualMonthTotals(i,year)
				totalResorces = totalResorces + monthTotals.incomeTotal - monthTotals.expenseTotal
				yearOverView << [i,monthTotals.incomeTotal,monthTotals.expenseTotal, totalResorces]
			}else{
				Map monthTotals = getBudgetedMonthTotals(i,year)
				totalResorces = totalResorces + monthTotals.incomeTotal - monthTotals.expenseTotal
				yearOverView << [i,monthTotals.incomeTotal,monthTotals.expenseTotal, totalResorces]
			}		
					
		}
		
//		//Get Month Summary
//		Map monthSummary = []
//		if(month >= new Date().format("MM").toInteger() && session.staticBudget != true ){
//			monthSummary = getActualMonthTotals(month,year)
//		}else{
//			monthSummary = getBudgetedMonthTotals(month,year)
//		}
		
		//Get Month Expense and Income
		Map monthBreakDown = [:]
		
		if(month < new Date().format("MM").toInteger() && params.staticBudget != true ){
			monthBreakDown = getActualMonthBreakDown(year, month)
		}else{
			monthBreakDown = getBudgetedMonthBreakDown(year, month)
		}
		Map monthIncome = monthBreakDown.incomeBreakDown
		Map	monthExpense = monthBreakDown.expenseBreakDown
		
		return [yearOverView:yearOverView,monthIncome:monthIncome,monthExpense:monthExpense]
	}
	
	Map getActualMonthTotals(int month, int year){
		Map dates = new Utilities().getBeginningAndEndOfMonth(year, month)
		Date firstOfMonth = dates.firstOfMonth
		Date endOfMonth = dates.endOfMonth
		
		def incomeTotal = Transaction.withCriteria {
			between("transactionDate",firstOfMonth,endOfMonth)
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
		
		def expenseTotal = Transaction.withCriteria {
			between("transactionDate",firstOfMonth,endOfMonth)
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
		
		def untrackedTotal = Transaction.withCriteria {
			between("transactionDate",firstOfMonth,endOfMonth)
			category{
				metaCategory{
					eq("name","UNTRACKED")
				}
			}
			projections{
				sum("amount")
			}
		}
		
		incomeTotal = incomeTotal.get(0) ?:0
		expenseTotal = expenseTotal.get(0) ?:0
		untrackedTotal =  untrackedTotal.get(0)?:0
		if(untrackedTotal > 0){
			incomeTotal += untrackedTotal
		}else{
			expenseTotal += untrackedTotal
		}
		
		[incomeTotal: Math.abs(incomeTotal), expenseTotal: Math.abs(expenseTotal)]
	}
	
	Map getBudgetedMonthTotals(int month, int year){
		def incomeTotal = BudgetItem.withCriteria{
			eq("year",year)
			eq("month", month)
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
		def expenseTotal = BudgetItem.withCriteria{
			eq("year",year)
			eq("month", month)
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
		
		def untrackedTotal = BudgetItem.withCriteria{
			eq("year",year)
			eq("month", month)
			category{
				metaCategory{
					eq("name","UNTRACKED")
				}
			}
			projections{
				sum("amount")
			}
		}
		
		incomeTotal = incomeTotal.get(0) ?:0
		expenseTotal = expenseTotal.get(0) ?:0
		untrackedTotal =  untrackedTotal.get(0)?:0
		if(untrackedTotal > 0){
			incomeTotal += untrackedTotal
		}else{
			expenseTotal += untrackedTotal
		}
		[incomeTotal: Math.abs(incomeTotal), expenseTotal: Math.abs(expenseTotal)]
	}
	

	Map getActualMonthBreakDown(int year, int month){
		Map dates = new Utilities().getBeginningAndEndOfMonth(year, month)
				
		Date firstOfMonth = dates.firstOfMonth
		Date endOfMonth = dates.endOfMonth
		Map incomeBreakDown = [:]
		Map expenseBreakDown  = [:]
		
		MetaCategory.list().each{ metaCategoryInstance ->
			Map tempBreakDown = [:]
				
			Category.findAllByMetaCategory(metaCategoryInstance).each{categoryInstance ->
				
				List total = Transaction.withCriteria{
					between("transactionDate", firstOfMonth,endOfMonth)
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
				
				if(total.get(0)) tempBreakDown << ["${categoryInstance.name}" : total.get(0)]
			}
			
			if(tempBreakDown) incomeBreakDown << ["${metaCategoryInstance.name}" : tempBreakDown]
		}
		
		MetaCategory.list().each{ metaCategoryInstance ->
			Map tempBreakDown = [:]
			
			Category.findAllByMetaCategory(metaCategoryInstance).each{categoryInstance ->
				
				List total = Transaction.withCriteria{
					between("transactionDate", firstOfMonth,endOfMonth)
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
				if(total.get(0))tempBreakDown << ["${categoryInstance.name}" : total.get(0)]
			}
			
			if(tempBreakDown) expenseBreakDown << ["${metaCategoryInstance.name}" : tempBreakDown]
		}
		
		def untrackedTotal = Transaction.withCriteria{
			between("transactionDate", firstOfMonth,endOfMonth)
			category{
				metaCategory{
					eq("name","UNTRACKED")
				}
			}
			projections{
				sum("amount")
			}
		}
		
		def untrackedBreakdown = []
		untrackedTotal = untrackedTotal.get(0)?:0
		
		if(untrackedTotal > 0){
			untrackedBreakdown << ["Untracked Income" : untrackedTotal]
			incomeBreakDown << ["UNTRACKED" : untrackedBreakdown]	
		}else if(untrackedTotal < 0){
			untrackedBreakdown << ["Untracked Expense" : untrackedTotal]
			expenseBreakDown << ["UNTRACKED" : untrackedBreakdown]
		}
			

		
		return[incomeBreakDown:incomeBreakDown, expenseBreakDown:expenseBreakDown]
	}
	
	Map getBudgetedMonthBreakDown(int year, int month){
		Map incomeBreakDown = [:]
		Map expenseBreakDown  = [:]
		
		MetaCategory.list().each{ metaCategoryInstance ->
			Map tempBreakDown = [:]
			Category.findAllByMetaCategory(metaCategoryInstance).each{categoryInstance ->
				List budgetItems = BudgetItem.withCriteria{
					eq("month",month)
					eq("year",year)
					category{
						eq("type","I")
						eq("id",categoryInstance.id)
					}
				}
				if(budgetItems) tempBreakDown << ["${categoryInstance.name}":budgetItems.get(0).amount]
			}
			if(tempBreakDown) incomeBreakDown << ["${metaCategoryInstance.name}":tempBreakDown]
		}
		
		MetaCategory.list().each{ metaCategoryInstance ->
			Map tempBreakDown = [:]
			Category.findAllByMetaCategory(metaCategoryInstance).each{categoryInstance ->
				List budgetItems = BudgetItem.withCriteria{
					eq("month",month)
					eq("year",year)
					category{
						eq("type","E")
						eq("id",categoryInstance.id)
					}
				}
				if(budgetItems) tempBreakDown << ["${categoryInstance.name}" : budgetItems.get(0).amount]
			}
			if(tempBreakDown) expenseBreakDown << ["${metaCategoryInstance.name}" : tempBreakDown]
		}
		return[incomeBreakDown:incomeBreakDown, expenseBreakDown:expenseBreakDown]
	}
}
