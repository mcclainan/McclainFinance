<%@ page import="com.planning.BudgetItem" %>
<%@ page import="com.category.Category" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="planning">
<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1>New Budget Items</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr class="rowH">
					
						<th>Year</th>
					
						<th>Month</th>
					
						<th>Category</th>
					
						<th>Amount</th>
					
						<th>Cash</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${budgetItemInstanceList}" status="i" var="budgetItemInstance">
					<tr class="${(i % 2) == 0 ? 'rowA' : 'rowB'}">
					
						<td><g:link action="show" id="${budgetItemInstance.id}">${budgetItemInstance.year}</g:link></td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "month")}</td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "category")}</td>
					
						<td ><g:formatNumber type="currency" currencyCode="USD" number="${budgetItemInstance.amount}"/>  </td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "cash")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>