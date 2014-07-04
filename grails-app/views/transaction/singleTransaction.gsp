<!doctype html>
<%@ page import="com.tracking.Account"%>
<%@ page import="com.tracking.Transaction"%>
<html>
<head>
<meta name="layout" content="tracking">
<g:set var="entityName" value="${message(code: 'transaction.label', default: 'Transaction')}" />
		<title>Single Transactions</title>
		<style type="text/css">
		 	.pagination {
		 		width:40em;
		 	}
			fieldset{
				margin: 0;
				padding: 0;
			}
			
			.fieldcontain{
				margin-top: 0;
				margin-bottom: 1em;
			}
			
			.searchCriteria{
				width: 40em; 
				border: solid; 
				position:absolute; 
				z-index: 1; 
				top:15em;
				left:27em; 
				opacity:100; 
				background-color: #EFEFEF; 
				padding: 1em; 
				visibility: hidden;
			}
			
			.searchButtons{
				margin-left:1em;
			}
			
			select {
    			max-width: 270px;
    		}
    		
			#primaryContent {
			    margin: 1.5em 2em 0 11em;
			    padding: 1.5em 3em;
			}
			
			
		</style>
		
		<g:javascript src="dateSearchCriteria.js" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
		
		<g:javascript>
			document.getElementById("transactionDate_day").focus()
		
			function populateForm(transactionId){
				populateField("transactionDate_day",document.getElementById("date_day" + transactionId).value)
				populateField("transactionDate_month",document.getElementById("date_month" + transactionId).value)
				populateField("transactionDate_year",document.getElementById("date_year" + transactionId).value)
                populateField("name",document.getElementById("name" + transactionId).value)
                populateField("amount",document.getElementById("amount" + transactionId).value)
                populateField("notes","")
                populateField("notes",document.getElementById("notes" + transactionId).value)
                populateField("category.id",document.getElementById("category.id" + transactionId).value)
                populateField("account",document.getElementById("account.id" + transactionId).value)
                populateField("assetLiability","null")
                populateField("assetLiability",document.getElementById("assetLiability.id" + transactionId).value)
                populateField("id",transactionId)
			}
			function populateField(id,value){
				document.getElementById(id).value = value;
			}
			function disableElement(id){
				var element = document.getElementById(id)
				element.disabled = "disabled"
			}
			function enableElement(id){
				var element = document.getElementById(id)
				element.disabled = false
			}
			
			function resetForm(){
				var date = ${new Date().format("dd").toInteger()}
				var month = ${new Date().format("MM").toInteger()}
				var year = ${new Date().format("yyyy").toInteger()}
				
				populateField("transactionDate_day", date)
				populateField("transactionDate_month",month)
				populateField("transactionDate_year",year)
                populateField("name","")
                populateField("amount","")
                populateField("notes","")
                populateField("category.id",1)
                populateField("account",1)
                populateField("assetLiability","null")
                populateField("id","")
                
                enableElement("create")
                enableElement("update")
                enableElement("delete")
                document.getElementById("transactionDate_day").focus()
			}
			
			function resetSearch(){
				populateField("dateSearchOption", "null")
				populateField("searchCategoryId","null")
				populateField("searchName","")
				populateField("searchAmount","")
                populateField("searchAccountId","null")
                populateField("searchAssetLiabilityId","null")
			}
			
			function toggleSearch(action){
				if(action == "on"){
					document.getElementById("searchForm").style.visibility = "visible"
				}else{
					document.getElementById("searchForm").style.visibility = "hidden"
				}
			}
			
			function centerSearch(){
				var width = window.innerWidth
				var height = document.body.clientHeight
				var top = (height/2) - 150
				var left = (width/2) - 350
				document.getElementById("searchForm").style.top = top + "px"
				document.getElementById("searchForm").style.left = left + "px"
			} 
			
			function collapseAllDates(){
				document.getElementById("byMonth").style.visibility = "collapse"
				document.getElementById("byDate").style.visibility = "collapse"
				document.getElementById("byDateRange").style.visibility ="collapse"
			}
			
		</g:javascript>
<title>Single Transaction</title>
</head>
<body>
		<div id="primaryContentContainer">
		
			<div id="primaryContent">
				<h1>Single Transactions</h1>
				<div id="searchForm" 
				 class="searchCriteria">
					<g:render template="search"/>
				</div>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${transactionInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${transactionInstance}" var="error">
							<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</g:eachError>
					</ul>
				</g:hasErrors>
				<div style = "width:32%;float:left">
					<g:form>
						<fieldset class="form">
							<g:render template="singleForm"/>
						</fieldset>
						<fieldset class="buttons">
							<g:actionSubmit id = "create" action="save" name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="false" />
							<g:actionSubmit id = "update" action="update" name="update" class="edit" value="Update" disabled = "disabled"/>
							<g:actionSubmit id = "delete" action="delete" name="delete" class="delete" value="Delete" disabled = "disabled"/>
							<input type="button" value="Search" onclick="toggleSearch('on')"/>
							<input type = "button" name="refreshForm" class="refresh" value="Reset Form" onclick = "resetForm()"/>
							<br/>
						</fieldset>
					</g:form>
				</div>
				<div style = "width:67.5%;float:right<g:if test="${params.action == 'search'}">;height: 525px; overflow: scroll</g:if>">
				 
					<table>
						<thead>
							<tr class="rowH">
								
								<g:sortableColumn property="transactionDate" title="${message(code: 'transaction.transactionDate.label', default: 'Transaction Date')}" />
								
								<g:sortableColumn property="category" title="${message(code: 'transaction.category.label', default: 'Category')}" />
							
								<g:sortableColumn style="width:10em;" property="name" title="${message(code: 'transaction.name.label', default: 'Name')}" />
							
								<g:sortableColumn property="amount" title="${message(code: 'transaction.amount.label', default: 'Amount')}" />
							
<%--								<th><g:message code="transaction.account.label" default="Account" /></th>--%>
							
							</tr>
						</thead>
						
						<tbody>
						<g:each in="${transactionInstanceList}" status="i" var="transactionInstance">
							<tr class="${(i % 2) == 0 ? 'rowA' : 'rowB'}" style=" max-height: 2em;" onclick="populateForm('${transactionInstance.id}'); disableElement('create'); enableElement('delete'); enableElement('update'); ">
							
								<td><g:formatDate date="${transactionInstance.transactionDate}" format="MM/dd/yyyy"/> </td>
							
								<td>${fieldValue(bean: transactionInstance, field: "category")}</td>
								
								<td style="width:10em; overflow:hidden;">${fieldValue(bean: transactionInstance, field: "name")}</td>
							
								<td>${fieldValue(bean: transactionInstance, field: "amount")}</td>
							
<%--								<td>${fieldValue(bean: transactionInstance, field: "account")}</td>--%>
							
							</tr>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "date_day${transactionInstance.id}" value = "${transactionInstance.transactionDate.format('dd').toInteger()}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "date_month${transactionInstance.id}" value = "${transactionInstance.transactionDate.format('MM').toInteger()}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "date_year${transactionInstance.id}" value = "${transactionInstance.transactionDate.format('yyyy').toInteger()}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "name${transactionInstance.id}" value = "${ transactionInstance.name}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "amount${transactionInstance.id}" value = "${transactionInstance.amount}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "notes${transactionInstance.id}" value = "${ transactionInstance.notes}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "category.id${transactionInstance.id}" value = "${transactionInstance.category?.id}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "account.id${transactionInstance.id}" value = "${transactionInstance.account?.id}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "assetLiability.id${transactionInstance.id}" value = "${transactionInstance.assetLiability?.id}"/>
						</g:each>
						</tbody>
					</table>
<%--					<g:if test="${params.action != 'search' }">--%>
						<div class="pagination">
							<g:paginate total="${transactionInstanceTotal}" params="${searchParams}"/>
						</div>
<%--					</g:if>--%>
				</div>
				
			</div>	
		</div>
		
</body>
</html>