<%@ page import="com.planning.BudgetItem" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="planning">
<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
<title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${errors}">
				<ul class="errors" role="alert">
					<g:each in = "${errors}" var = "error">
					<li>${error.value}</li>
					</g:each>
				</ul>
			</g:if>
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</div>
</body>
</html>