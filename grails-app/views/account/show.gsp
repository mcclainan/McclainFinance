<%@ page import="com.tracking.Account" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="tracking">
<g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list account">
			
				<g:if test="${accountInstance?.interestRate}">
				<li class="fieldcontain">
					<span id="interestRate-label" class="property-label"><g:message code="account.interestRate.label" default="Interest Rate" /></span>
					
						<span class="property-value" aria-labelledby="interestRate-label"><g:fieldValue bean="${accountInstance}" field="interestRate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${accountInstance?.active}">
				<li class="fieldcontain">
					<span id="active-label" class="property-label"><g:message code="account.active.label" default="Active" /></span>
					
						<span class="property-value" aria-labelledby="active-label"><g:fieldValue bean="${accountInstance}" field="active"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${accountInstance?.cash}">
				<li class="fieldcontain">
					<span id="cash-label" class="property-label"><g:message code="account.cash.label" default="Cash" /></span>
					
						<span class="property-value" aria-labelledby="cash-label"><g:fieldValue bean="${accountInstance}" field="cash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${accountInstance?.assetLiability}">
				<li class="fieldcontain">
					<span id="assetLiability-label" class="property-label"><g:message code="account.assetLiability.label" default="Asset Liability" /></span>
					
						<span class="property-value" aria-labelledby="assetLiability-label"><g:link controller="assetLiability" action="show" id="${accountInstance?.assetLiability?.id}">${accountInstance?.assetLiability?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${accountInstance?.balance}">
				<li class="fieldcontain">
					<span id="balance-label" class="property-label"><g:message code="account.balance.label" default="Balance" /></span>
					
						<span class="property-value" aria-labelledby="balance-label"><g:fieldValue bean="${accountInstance}" field="balance"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${accountInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="account.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${accountInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${accountInstance?.transactions}">
				<li class="fieldcontain">
					<span id="transactions-label" class="property-label"><g:message code="account.transactions.label" default="Transactions" /></span>
					
						<g:each in="${accountInstance.transactions}" var="t">
						<span class="property-value" aria-labelledby="transactions-label"><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${accountInstance?.id}" />
					<g:link class="edit" action="edit" id="${accountInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</div>
</body>
</html>