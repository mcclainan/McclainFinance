
<%@ page import="com.tracking.Transaction" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'transaction.label', default: 'Transaction')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-transaction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-transaction" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list transaction">
			
				<g:if test="${transactionInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="transaction.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:fieldValue bean="${transactionInstance}" field="category"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="transaction.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${transactionInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="transaction.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${transactionInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.notes}">
				<li class="fieldcontain">
					<span id="notes-label" class="property-label"><g:message code="transaction.notes.label" default="Notes" /></span>
					
						<span class="property-value" aria-labelledby="notes-label"><g:fieldValue bean="${transactionInstance}" field="notes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.account}">
				<li class="fieldcontain">
					<span id="account-label" class="property-label"><g:message code="transaction.account.label" default="Account" /></span>
					
						<span class="property-value" aria-labelledby="account-label"><g:link controller="account" action="show" id="${transactionInstance?.account?.id}">${transactionInstance?.account?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.assetLiability}">
				<li class="fieldcontain">
					<span id="assetLiability-label" class="property-label"><g:message code="transaction.assetLiability.label" default="Asset Liability" /></span>
					
						<span class="property-value" aria-labelledby="assetLiability-label"><g:link controller="assetLiability" action="show" id="${transactionInstance?.assetLiability?.id}">${transactionInstance?.assetLiability?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.budgetItem}">
				<li class="fieldcontain">
					<span id="budgetItem-label" class="property-label"><g:message code="transaction.budgetItem.label" default="Budget Item" /></span>
					
						<span class="property-value" aria-labelledby="budgetItem-label"><g:link controller="budgetItem" action="show" id="${transactionInstance?.budgetItem?.id}">${transactionInstance?.budgetItem?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.combinationId}">
				<li class="fieldcontain">
					<span id="combinationId-label" class="property-label"><g:message code="transaction.combinationId.label" default="Combination Id" /></span>
					
						<span class="property-value" aria-labelledby="combinationId-label"><g:fieldValue bean="${transactionInstance}" field="combinationId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.active}">
				<li class="fieldcontain">
					<span id="active-label" class="property-label"><g:message code="transaction.active.label" default="Active" /></span>
					
						<span class="property-value" aria-labelledby="active-label"><g:fieldValue bean="${transactionInstance}" field="active"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.verified}">
				<li class="fieldcontain">
					<span id="verified-label" class="property-label"><g:message code="transaction.verified.label" default="Verified" /></span>
					
						<span class="property-value" aria-labelledby="verified-label"><g:fieldValue bean="${transactionInstance}" field="verified"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.created}">
				<li class="fieldcontain">
					<span id="created-label" class="property-label"><g:message code="transaction.created.label" default="Created" /></span>
					
						<span class="property-value" aria-labelledby="created-label"><g:formatDate date="${transactionInstance?.created}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionInstance?.transactionDate}">
				<li class="fieldcontain">
					<span id="transactionDate-label" class="property-label"><g:message code="transaction.transactionDate.label" default="Transaction Date" /></span>
					
						<span class="property-value" aria-labelledby="transactionDate-label"><g:formatDate date="${transactionInstance?.transactionDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${transactionInstance?.id}" />
					<g:link class="edit" action="edit" id="${transactionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
