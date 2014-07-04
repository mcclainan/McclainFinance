<%@ page import="com.assetLiability.AssetLiability" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="tracking">
<g:set var="entityName" value="${message(code: 'assetLiability.label', default: 'AssetLiability')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list assetLiability">
			
				<g:if test="${assetLiabilityInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="assetLiability.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${assetLiabilityInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="assetLiability.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${assetLiabilityInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.assetLiabilityClass}">
				<li class="fieldcontain">
					<span id="assetLiabilityClass-label" class="property-label"><g:message code="assetLiability.assetLiabilityClass.label" default="Asset Liability Class" /></span>
					
						<span class="property-value" aria-labelledby="assetLiabilityClass-label"><g:link controller="assetLiabilityClass" action="show" id="${assetLiabilityInstance?.assetLiabilityClass?.id}">${assetLiabilityInstance?.assetLiabilityClass?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.value}">
				<li class="fieldcontain">
					<span id="value-label" class="property-label"><g:message code="assetLiability.value.label" default="Value" /></span>
					
						<span class="property-value" aria-labelledby="value-label"><g:fieldValue bean="${assetLiabilityInstance}" field="value"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.active}">
				<li class="fieldcontain">
					<span id="active-label" class="property-label"><g:message code="assetLiability.active.label" default="Active" /></span>
					
						<span class="property-value" aria-labelledby="active-label"><g:fieldValue bean="${assetLiabilityInstance}" field="active"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.account}">
				<li class="fieldcontain">
					<span id="account-label" class="property-label"><g:message code="assetLiability.account.label" default="Account" /></span>
					
						<span class="property-value" aria-labelledby="account-label"><g:link controller="account" action="show" id="${assetLiabilityInstance?.account?.id}">${assetLiabilityInstance?.account?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.interestRate}">
				<li class="fieldcontain">
					<span id="interestRate-label" class="property-label"><g:message code="assetLiability.interestRate.label" default="Interest Rate" /></span>
					
						<span class="property-value" aria-labelledby="interestRate-label"><g:fieldValue bean="${assetLiabilityInstance}" field="interestRate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.creditLimit}">
				<li class="fieldcontain">
					<span id="creditLimit-label" class="property-label"><g:message code="assetLiability.creditLimit.label" default="Credit Limit" /></span>
					
						<span class="property-value" aria-labelledby="creditLimit-label"><g:fieldValue bean="${assetLiabilityInstance}" field="creditLimit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.transactions}">
				<li class="fieldcontain">
					<span id="transactions-label" class="property-label"><g:message code="assetLiability.transactions.label" default="Transactions" /></span>
					
						<g:each in="${assetLiabilityInstance.transactions}" var="t">
						<br/><span class="property-value" aria-labelledby="transactions-label"><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${assetLiabilityInstance?.id}" />
					<g:link class="edit" action="edit" id="${assetLiabilityInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</div>
</body>
</html>