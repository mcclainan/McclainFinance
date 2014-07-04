
<%@ page import="com.category.Category" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="recordMaint">
<g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list category">
			
				<g:if test="${categoryInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="category.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${categoryInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.priority}">
				<li class="fieldcontain">
					<span id="priority-label" class="property-label"><g:message code="category.priority.label" default="Priority" /></span>
					
						<span class="property-value" aria-labelledby="priority-label"><g:fieldValue bean="${categoryInstance}" field="priority"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.cash}">
				<li class="fieldcontain">
					<span id="cash-label" class="property-label"><g:message code="category.cash.label" default="Cash" /></span>
					
						<span class="property-value" aria-labelledby="cash-label"><g:fieldValue bean="${categoryInstance}" field="cash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="category.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${categoryInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.active}">
				<li class="fieldcontain">
					<span id="active-label" class="property-label"><g:message code="category.active.label" default="Active" /></span>
					
						<span class="property-value" aria-labelledby="active-label"><g:fieldValue bean="${categoryInstance}" field="active"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.budgetItems}">
				<li class="fieldcontain">
					<span id="budgetItems-label" class="property-label"><g:message code="category.budgetItems.label" default="Budget Items" /></span>
					
						<g:each in="${categoryInstance.budgetItems}" var="b">
						<span class="property-value" aria-labelledby="budgetItems-label"><g:link controller="budgetItem" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.metaCategory}">
				<li class="fieldcontain">
					<span id="metaCategory-label" class="property-label"><g:message code="category.metaCategory.label" default="Meta Category" /></span>
					
						<span class="property-value" aria-labelledby="metaCategory-label"><g:link controller="metaCategory" action="show" id="${categoryInstance?.metaCategory?.id}">${categoryInstance?.metaCategory?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.plannedTransactions}">
				<li class="fieldcontain">
					<span id="plannedTransactions-label" class="property-label"><g:message code="category.plannedTransactions.label" default="Planned Transactions" /></span>
					
						<g:each in="${categoryInstance.plannedTransactions}" var="p">
						<span class="property-value" aria-labelledby="plannedTransactions-label"><g:link controller="plannedTransaction" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.transactions}">
				<li class="fieldcontain">
					<span id="transactions-label" class="property-label"><g:message code="category.transactions.label" default="Transactions" /></span>
					
						<g:each in="${categoryInstance.transactions}" var="t">
						<span class="property-value" aria-labelledby="transactions-label"><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${categoryInstance?.id}" />
					<g:link class="edit" action="edit" id="${categoryInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</div>
</body>
</html>