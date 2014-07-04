<%@ page import="com.planning.BudgetItem" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="planning">
<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list budgetItem">
			
				<g:if test="${budgetItemInstance?.year}">
				<li class="fieldcontain">
					<span id="year-label" class="property-label"><g:message code="budgetItem.year.label" default="Year" /></span>
					
						<span class="property-value" aria-labelledby="year-label"><g:fieldValue bean="${budgetItemInstance}" field="year"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.month}">
				<li class="fieldcontain">
					<span id="month-label" class="property-label"><g:message code="budgetItem.month.label" default="Month" /></span>
					
						<span class="property-value" aria-labelledby="month-label"><g:fieldValue bean="${budgetItemInstance}" field="month"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="budgetItem.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:link controller="category" action="show" id="${budgetItemInstance?.category?.id}">${budgetItemInstance?.category?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="budgetItem.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${budgetItemInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.cash}">
				<li class="fieldcontain">
					<span id="cash-label" class="property-label"><g:message code="budgetItem.cash.label" default="Cash" /></span>
					
						<span class="property-value" aria-labelledby="cash-label"><g:fieldValue bean="${budgetItemInstance}" field="cash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.plannedTransactions}">
				<li class="fieldcontain">
					<span id="plannedTransactions-label" class="property-label"><g:message code="budgetItem.plannedTransactions.label" default="Planned Transactions" /></span>
					
						<g:each in="${budgetItemInstance.plannedTransactions}" var="p">
						<span class="property-value" aria-labelledby="plannedTransactions-label"><g:link controller="plannedTransaction" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span><br/>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.transactions}">
				<li class="fieldcontain">
					<span id="transactions-label" class="property-label"><g:message code="budgetItem.transactions.label" default="Transactions" /></span>
					
						<g:each in="${budgetItemInstance.transactions}" var="t">
						<span class="property-value" aria-labelledby="transactions-label"><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${budgetItemInstance?.id}" />
					<g:link class="edit" action="edit" id="${budgetItemInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</div>
</body>
</html>