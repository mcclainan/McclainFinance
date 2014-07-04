
<%@ page import="com.planning.YearBeginningResources" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'yearBeginningResources.label', default: 'YearBeginningResources')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-yearBeginningResources" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-yearBeginningResources" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list yearBeginningResources">
			
				<g:if test="${yearBeginningResourcesInstance?.year}">
				<li class="fieldcontain">
					<span id="year-label" class="property-label"><g:message code="yearBeginningResources.year.label" default="Year" /></span>
					
						<span class="property-value" aria-labelledby="year-label"><g:fieldValue bean="${yearBeginningResourcesInstance}" field="year"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yearBeginningResourcesInstance?.actualBenifits}">
				<li class="fieldcontain">
					<span id="actualBenifits-label" class="property-label"><g:message code="yearBeginningResources.actualBenifits.label" default="Actual Benifits" /></span>
					
						<span class="property-value" aria-labelledby="actualBenifits-label"><g:fieldValue bean="${yearBeginningResourcesInstance}" field="actualBenifits"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yearBeginningResourcesInstance?.actualCash}">
				<li class="fieldcontain">
					<span id="actualCash-label" class="property-label"><g:message code="yearBeginningResources.actualCash.label" default="Actual Cash" /></span>
					
						<span class="property-value" aria-labelledby="actualCash-label"><g:fieldValue bean="${yearBeginningResourcesInstance}" field="actualCash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yearBeginningResourcesInstance?.actualCreditCard}">
				<li class="fieldcontain">
					<span id="actualCreditCard-label" class="property-label"><g:message code="yearBeginningResources.actualCreditCard.label" default="Actual Credit Card" /></span>
					
						<span class="property-value" aria-labelledby="actualCreditCard-label"><g:fieldValue bean="${yearBeginningResourcesInstance}" field="actualCreditCard"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yearBeginningResourcesInstance?.actualOther}">
				<li class="fieldcontain">
					<span id="actualOther-label" class="property-label"><g:message code="yearBeginningResources.actualOther.label" default="Actual Other" /></span>
					
						<span class="property-value" aria-labelledby="actualOther-label"><g:fieldValue bean="${yearBeginningResourcesInstance}" field="actualOther"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yearBeginningResourcesInstance?.budgetedBenifits}">
				<li class="fieldcontain">
					<span id="budgetedBenifits-label" class="property-label"><g:message code="yearBeginningResources.budgetedBenifits.label" default="Budgeted Benifits" /></span>
					
						<span class="property-value" aria-labelledby="budgetedBenifits-label"><g:fieldValue bean="${yearBeginningResourcesInstance}" field="budgetedBenifits"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yearBeginningResourcesInstance?.budgetedCash}">
				<li class="fieldcontain">
					<span id="budgetedCash-label" class="property-label"><g:message code="yearBeginningResources.budgetedCash.label" default="Budgeted Cash" /></span>
					
						<span class="property-value" aria-labelledby="budgetedCash-label"><g:fieldValue bean="${yearBeginningResourcesInstance}" field="budgetedCash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yearBeginningResourcesInstance?.budgetedCreditCard}">
				<li class="fieldcontain">
					<span id="budgetedCreditCard-label" class="property-label"><g:message code="yearBeginningResources.budgetedCreditCard.label" default="Budgeted Credit Card" /></span>
					
						<span class="property-value" aria-labelledby="budgetedCreditCard-label"><g:fieldValue bean="${yearBeginningResourcesInstance}" field="budgetedCreditCard"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${yearBeginningResourcesInstance?.budgetedOther}">
				<li class="fieldcontain">
					<span id="budgetedOther-label" class="property-label"><g:message code="yearBeginningResources.budgetedOther.label" default="Budgeted Other" /></span>
					
						<span class="property-value" aria-labelledby="budgetedOther-label"><g:fieldValue bean="${yearBeginningResourcesInstance}" field="budgetedOther"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${yearBeginningResourcesInstance?.id}" />
					<g:link class="edit" action="edit" id="${yearBeginningResourcesInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
