
<%@ page import="com.tracking.Transaction" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'transaction.label', default: 'Transaction')}" />
		<title>Single Transactions</title>
		<style type="text/css">
			body{
				width: 390px;
			}
			
			fieldset{
				margin: 0;
				padding: 0;
			}
			
			.fieldcontain{
				margin-top: 0;
				margin-bottom: 1em;
			}
			
			img {
			    border: 0 none;
			    width:325px;
			}
			
			#name,#amount,#notes{
				width: 217px;
			}
			
			#category\.id,#account,#assetLiability{
				width: 232px;
			}
			
		</style>
		
		<g:javascript src="dateSearchCriteria.js" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
		
		<g:javascript>
			document.getElementById("category.id").focus()
			
			function populateField(id,value){
				document.getElementById(id).value = value;
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
			
			
		</g:javascript>
	</head>
	<body>
		<a href="#list-transaction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="list-transaction" class="content scaffold-list" role="main">
			<h1 >Single Transactions</h1>
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
			
			<div style="padding: 10px;">
					<g:form>
						<fieldset class="form">
							<g:render template="singleForm"/>
						</fieldset>
						<fieldset class="buttons">
							<g:actionSubmit id = "create" action="save" name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="false" />
							<input type = "button" name="refreshForm" class="refresh" value="Reset Form" onclick = "resetForm()"/>
						</fieldset>
					</g:form>

			</div>
		</div>
	</body>
</html>
