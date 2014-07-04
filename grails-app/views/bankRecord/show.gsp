
<%@ page import="com.tracking.BankRecord" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bankRecord.label', default: 'BankRecord')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-bankRecord" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<nav:render group="bankRecordTabs"/>
		</div>
		<div id="show-bankRecord" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list bankRecord">
			
				<g:if test="${bankRecordInstance?.account}">
				<li class="fieldcontain">
					<span id="account-label" class="property-label"><g:message code="bankRecord.account.label" default="Account" /></span>
					
						<span class="property-value" aria-labelledby="account-label"><g:link controller="account" action="show" id="${bankRecordInstance?.account?.id}">${bankRecordInstance?.account?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankRecordInstance?.transactionDate}">
				<li class="fieldcontain">
					<span id="transactionDate-label" class="property-label"><g:message code="bankRecord.transactionDate.label" default="Transaction Date" /></span>
					
						<span class="property-value" aria-labelledby="transactionDate-label"><g:formatDate date="${bankRecordInstance?.transactionDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankRecordInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="bankRecord.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${bankRecordInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankRecordInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="bankRecord.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${bankRecordInstance}" field="amount"/></span>
					
				</li>
				</g:if>
				<g:if test="${bankRecordInstance?.transaction}">
				<li class="fieldcontain">
					<span id="transaction-label" class="property-label"><g:message code="bankRecord.transaction.label" default="transaction" /></span>
					
						<span class="property-value" aria-labelledby="transaction-label"><g:fieldValue bean="${bankRecordInstance}" field="transaction"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${bankRecordInstance?.id}" />
					<g:link class="edit" action="edit" id="${bankRecordInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
