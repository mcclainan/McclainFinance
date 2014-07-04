<%@ page import="com.tracking.Account" %>
<html>
<head>
<meta name="layout" content="tracking">
<title>Single Transaction</title>
<g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr class="rowH">
						
						<g:sortableColumn property="name" title="${message(code: 'account.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="balance" title="${message(code: 'account.balance.label', default: 'Balance')}" />

						<g:sortableColumn property="cash" title="${message(code: 'account.cash.label', default: 'Cash')}" />
					
						<th><g:message code="account.assetLiability.label" default="Asset Liability" /></th>
					
						
						<g:sortableColumn property="interestRate" title="${message(code: 'account.interestRate.label', default: 'Interest Rate')}" />
					
						
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${accountInstanceList}" status="i" var="accountInstance">
					<tr class="${(i % 2) == 0 ? 'rowA' : 'rowB'}">
					
						<td><g:link action="show" id="${accountInstance.id}">${fieldValue(bean: accountInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: accountInstance, field: "balance")}</td>

						<td>${fieldValue(bean: accountInstance, field: "cash")}</td>
					
						<td>${fieldValue(bean: accountInstance, field: "assetLiability")}</td>
						
						<td>${fieldValue(bean: accountInstance, field: "interestRate")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${accountInstanceTotal}" />
			</div>
		</div>
	</div>
</body>
</html>