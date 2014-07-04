<%@ page import="com.tracking.Transaction" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="tracking">
<g:set var="entityName" value="${message(code: 'transaction.label', default: 'Transaction')}" />
<title>Combination Total</title>
</head>
<body>
		
		<div id="primaryContentContainer">
			<div id="primaryContent">
			<h1>Enter the Total amount of the transactions</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${flash.errors}">
				<ul class="errors" role="alert">
					<g:each in="${flash.errors}" var="error">
						<li>${error.value}</li>
					</g:each>
				</ul>
			</g:if>
			<g:form action="combinationTransaction" >
				<fieldset class="form">
					<g:textField style="margin-top:1em;" name="amount" value="${amount}"/>
					<g:hiddenField name="totalEntered" value="true"/>
				</fieldset>
				<fieldset  style="margin-top:1em;" class="buttons">
					<g:submitButton name="create" class="save" value="Submit" />
				</fieldset>
			</g:form>
			</div>
		</div>
		
</body>
</html>