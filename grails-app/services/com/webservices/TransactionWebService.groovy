package com.webservices
import com.category.CategoryService
import com.assetLiability.AssetLiabilityService
import com.tracking.AccountService

class TransactionWebService {
	def categoryService
	def assetLiabilityService
	def accountService
	
    def getSingleTransactionXML() {
		StringBuffer singleTransactionXML = new StringBuffer()
		singleTransactionXML.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
		singleTransactionXML.append("<lists>\n")
		singleTransactionXML.append(categoryService.getCategoryList(false))
		singleTransactionXML.append(accountService.getAccountList(false))
		singleTransactionXML.append(/<\/lists>/)
    }
}
