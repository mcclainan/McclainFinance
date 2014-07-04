package com.tracking

import java.text.ParseException;
import java.text.SimpleDateFormat

import org.apache.jasper.compiler.Node.ParamsAction;
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.transaction.annotation.Transactional;

import com.sun.java.util.jar.pack.Attribute.FormatException;

class BankRecordController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	static navigation = [
		[group:'trackingTabs', action:'list',title:'Bank Records', order:60],
		[group:'bankRecordTabs', action:'list', title: 'Bank Records Home', order:0],
		[group:'bankRecordTabs', action:'loadFile', title: 'Load From File', order:10]
	]
    def index() {   
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [bankRecordInstanceList: BankRecord.list(params), bankRecordInstanceTotal: BankRecord.count()]
    }

    def create() {
        [bankRecordInstance: new BankRecord(params)]
    }

    def save() {
        def bankRecordInstance = new BankRecord(params)
        if (!bankRecordInstance.save(flush: true)) {
            render(view: "create", model: [bankRecordInstance: bankRecordInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'bankRecord.label', default: 'BankRecord'), bankRecordInstance.id])
        redirect(action: "show", id: bankRecordInstance.id)
    }

    def show() {
        def bankRecordInstance = BankRecord.get(params.id)
        if (!bankRecordInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankRecord.label', default: 'BankRecord'), params.id])
            redirect(action: "list")
            return
        }

        [bankRecordInstance: bankRecordInstance]
    }

    def edit() {
        def bankRecordInstance = BankRecord.get(params.id)
        if (!bankRecordInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankRecord.label', default: 'BankRecord'), params.id])
            redirect(action: "list")
            return
        }

        [bankRecordInstance: bankRecordInstance]
    }

    def update() {
        def bankRecordInstance = BankRecord.get(params.id)
        if (!bankRecordInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankRecord.label', default: 'BankRecord'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (bankRecordInstance.version > version) {
                bankRecordInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'bankRecord.label', default: 'BankRecord')] as Object[],
                          "Another user has updated this BankRecord while you were editing")
                render(view: "edit", model: [bankRecordInstance: bankRecordInstance])
                return
            }
        }

        bankRecordInstance.properties = params

        if (!bankRecordInstance.save(flush: true)) {
            render(view: "edit", model: [bankRecordInstance: bankRecordInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'bankRecord.label', default: 'BankRecord'), bankRecordInstance.id])
        redirect(action: "show", id: bankRecordInstance.id)
    }

    def delete() {
        def bankRecordInstance = BankRecord.get(params.id)
        if (!bankRecordInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankRecord.label', default: 'BankRecord'), params.id])
            redirect(action: "list")
            return
        }

        try {
            bankRecordInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'bankRecord.label', default: 'BankRecord'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'bankRecord.label', default: 'BankRecord'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def loadFile(){
		//Pass through to view
		session.newFile = null
	}
	
	def configureUpload(){
		//Create a session variable called new file to hold the contents of a file.
		session.newFile = []
		//Get the input stream of a file that is taken from the request
		request.getFile("file").inputStream.eachLine{
			List row = it.split(",")//Split each line into elements delimited by comma
			session.newFile << row //Add the list as an element in the new file 
		}
		int elementNumber = 0 //Holds the current element numbers 
		List amountElements = [] //Holds a list of element numbers that will populate amount drop downs in the view
		List elementNumbers = [] //Holds a list of element numbers that will populate all other drop downs in the view.
		//This loop populates these lists according to the number of elements in each row of the file
		session.newFile.get(0).each{
			elementNumbers << elementNumber
			amountElements << elementNumber++
			
		}
		
		//Adds a line that says "multiple" for amount elements that have two different columns for debits and credits
		amountElements << "multiple"
		
		[elementNumbers:elementNumbers,amountElements:amountElements]		
	}
	
	@Transactional
	def upload(){
		
		Account account = Account.get(params.account.id)
		flash.errors = [:]
		Integer dateColumn 
		Integer descriptionColumn 
		Integer amountColumn 
		Integer debitColumn
		Integer creditColumn
		try {
			dateColumn = params.transactionDate.toInteger()
			descriptionColumn = params.description.toInteger()
			
			if(params.amount == "multiple"){
				debitColumn = params.debits.toInteger()
				creditColumn = params.credits.toInteger()
			}else{
				amountColumn = params.amount.toInteger()
			}
			
		} catch (NumberFormatException e) { 
			flash.errors.blankColumn = "One or more of the properties was not given a column number ${e.message}"
			redirect(action:"errorAction")
		}
		
		List bankRecordsList = []
		List duplicateBankRecordsList = []
		
		if(!flash.errors){
			int i = 0
			println params.hasHeading
			if(params.hasHeading.toString() == "yes"){
				i=1
			}
			for(i; i < session.newFile.size(); i++){
				List row = session.newFile.get(i)
						BankRecord bankRecord = new BankRecord()
				try {
					bankRecord.description = row.get(descriptionColumn)
					if(bankRecord.description == ''){
						println "bankRecord.description == null: ${bankRecord.description == ''}"
						throw new Exception()
					}
				} catch (IndexOutOfBoundsException e) {
				} catch (Exception e){
					flash.errors.descriptionError = "Description should not be assigned to a blank column"
				}
				
				try {
					bankRecord.transactionDate = new SimpleDateFormat(params.dateFormat).parse(row.get(dateColumn))
					if(bankRecord.transactionDate.format("MM/dd/yyyy")=="01/01/1970"){
						throw new Exception()
					}
				} catch (IndexOutOfBoundsException e) {
					println e.message
				} catch (ParseException e){
					flash.errors.dateError = "The column assign to Transaction Date has the wrong data type [${e.message}]"
				} catch (Exception e){
					flash.errors.dateError = "The Date Format was invalid."
				}
				
				try {
					
					if(params.amount == "multiple"){
						if(row.get(debitColumn)){
							bankRecord.amount = Math.abs(row.get(debitColumn).replace("\"", "").toDouble()) * (-1)
						}else{
							bankRecord.amount = Math.abs(row.get(creditColumn).replace("\"", "").toDouble())
						}
					}else{
						bankRecord.amount = row.get(amountColumn).replace("\"", "").toDouble()
					}
				} catch (IndexOutOfBoundsException e) {
					println e.message
				} catch(NumberFormatException e){
					flash.errors.numberError = "The amount property was not to a compatible Column. There was a problem recognizing the data as a number. [${e.message}]"
				}
				
				bankRecord.account = account
				
				
				
				if(flash.errors){
					redirect(action:"errorAction")
					break
				}
				
				if(bankRecord.save(flush:true)){
					bankRecordsList << bankRecord
				}else{
					duplicateBankRecordsList << bankRecord
				}
			}
		}
		
		if(!flash.errors){
			flash.message = "${bankRecordsList.size()} Bank Records where added. The file contained ${duplicateBankRecordsList.size()} duplicate records."
			[bankRecordsList:bankRecordsList,duplicateBankRecordsList:duplicateBankRecordsList]
		}
	}
	
	def errorAction(){
		def elementNumbers = []
		def amountElements = []
		def elementNumber = 0
		flash.errors.each{
			println it
		}
		session.newFile.get(0).each{
			elementNumbers << elementNumber
			amountElements << elementNumber++
		}
		amountElements<<"multiple"
		render(view:"configureUpload", model:[elementNumbers:elementNumbers,amountElements:amountElements])
	}
}
