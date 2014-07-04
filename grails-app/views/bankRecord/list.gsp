<%@ page import="com.tracking.BankRecord" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="tracking">
<g:set var="entityName" value="${message(code: 'bankRecord.label', default: 'BankRecord')}" />
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
					
						<th><g:message code="bankRecord.account.label" default="Account" /></th>
					
						<th>${message(code: 'bankRecord.transactionDate.label', default: 'Transaction Date')}</th>
					
						<th>${message(code: 'bankRecord.description.label', default: 'Description')}</th>
					
						<th>${message(code: 'bankRecord.amount.label', default: 'Amount')}</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${bankRecordInstanceList}" status="i" var="bankRecordInstance">
					<tr class="${(i % 2) == 0 ? 'rowA' : 'rowB'}">
					
						<td><g:link action="show" id="${bankRecordInstance.id}">${fieldValue(bean: bankRecordInstance, field: "account")}</g:link></td>
					
						<td><g:formatDate date="${bankRecordInstance.transactionDate}" /></td>
					
						<td>${fieldValue(bean: bankRecordInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: bankRecordInstance, field: "amount")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${bankRecordInstanceTotal}" />
			</div>
		</div>
	</div>
</body>
</html>