
<%@ page import="com.assetLiability.AssetLiabilityClass" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-assetLiabilityClass" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<nav:render group="assetLiabilityClassTabs"/>
		</div>
		<div id="show-assetLiabilityClass" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list assetLiabilityClass">
			
				<g:if test="${assetLiabilityClassInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="assetLiabilityClass.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${assetLiabilityClassInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityClassInstance?.onSale}">
				<li class="fieldcontain">
					<span id="onSale-label" class="property-label"><g:message code="assetLiabilityClass.onSale.label" default="On Sale" /></span>
					
						<span class="property-value" aria-labelledby="onSale-label"><g:fieldValue bean="${assetLiabilityClassInstance}" field="onSale"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityClassInstance?.onPurchase}">
				<li class="fieldcontain">
					<span id="onPurchase-label" class="property-label"><g:message code="assetLiabilityClass.onPurchase.label" default="On Purchase" /></span>
					
						<span class="property-value" aria-labelledby="onPurchase-label"><g:fieldValue bean="${assetLiabilityClassInstance}" field="onPurchase"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityClassInstance?.onProceedes}">
				<li class="fieldcontain">
					<span id="onProceedes-label" class="property-label"><g:message code="assetLiabilityClass.onProceedes.label" default="On Proceedes" /></span>
					
						<span class="property-value" aria-labelledby="onProceedes-label"><g:fieldValue bean="${assetLiabilityClassInstance}" field="onProceedes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityClassInstance?.onPayment}">
				<li class="fieldcontain">
					<span id="onPayment-label" class="property-label"><g:message code="assetLiabilityClass.onPayment.label" default="On Payment" /></span>
					
						<span class="property-value" aria-labelledby="onPayment-label"><g:fieldValue bean="${assetLiabilityClassInstance}" field="onPayment"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityClassInstance?.onInterest}">
				<li class="fieldcontain">
					<span id="onInterest-label" class="property-label"><g:message code="assetLiabilityClass.onInterest.label" default="On Interest" /></span>
					
						<span class="property-value" aria-labelledby="onInterest-label"><g:fieldValue bean="${assetLiabilityClassInstance}" field="onInterest"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityClassInstance?.onAppreciation}">
				<li class="fieldcontain">
					<span id="onAppreciation-label" class="property-label"><g:message code="assetLiabilityClass.onAppreciation.label" default="On Appreciation" /></span>
					
						<span class="property-value" aria-labelledby="onAppreciation-label"><g:fieldValue bean="${assetLiabilityClassInstance}" field="onAppreciation"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityClassInstance?.onDepreciation}">
				<li class="fieldcontain">
					<span id="onDepreciation-label" class="property-label"><g:message code="assetLiabilityClass.onDepreciation.label" default="On Depreciation" /></span>
					
						<span class="property-value" aria-labelledby="onDepreciation-label"><g:fieldValue bean="${assetLiabilityClassInstance}" field="onDepreciation"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityClassInstance?.onUse}">
				<li class="fieldcontain">
					<span id="onUse-label" class="property-label"><g:message code="assetLiabilityClass.onUse.label" default="On Use" /></span>
					
						<span class="property-value" aria-labelledby="onUse-label"><g:fieldValue bean="${assetLiabilityClassInstance}" field="onUse"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${assetLiabilityClassInstance?.id}" />
					<g:link class="edit" action="edit" id="${assetLiabilityClassInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
