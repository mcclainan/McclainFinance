<%@ page import="com.planning.PlannedTransaction" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="planning">
<g:set var="entityName" value="${message(code: 'plannedTransaction.label', default: 'PlannedTransaction')}" />
<link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
<title><g:message code="default.list.label" args="[entityName]" /></title>
<g:javascript src="dateSearchCriteria.js" />
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<div class = "searchDiv">
				<h3>Search Planned Transactions</h3>
				<g:if test="${flash.searchErrors}">
				<ul class="errors" role="alert">
					<g:each in="${flash.searchErrors}" var="error">
						<li>${error.value}</li>
					</g:each>
				</ul>
				</g:if>
				<g:form action="search">
					<table>
						<tbody>
							<tr>
								<td>
									Amount <g:textField name="amount"/>
								</td>
								<td>
									Cash <g:select name="cash" from="${['Y','N']}" noSelection="${['null':'Select One...']}"/>
								</td>
								<td>
									Exempt <g:select name="exempt" from="${['Y','N']}" noSelection="${['null':'Select One...']}"/>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									Budget Item <g:select name="budgetItemId" from="${com.planning.BudgetItem.list()}" optionKey="id" noSelection="${['null':'Select One...']}"/>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									Date Search Options <g:select name="dateSearchOption" from="${['By Month','By Date','By Date Range']}" noSelection="${['null':'Select One...']}" onchange = "showCriteria(this.id)"/>
								</td> 
							</tr>
							<tr id = "byMonth" class = "invisible">
								<td colspan="2" >
									Month <g:datePicker name="month" precision="month"/>
								</td> 
							</tr>
							<tr id = "byDate" class = "invisible">
								<td colspan="2">
									Date <g:datePicker name="date" precision="day"/>
								</td> 
							</tr>
							<tr id = "byDateRange" class = "invisible">
								<td colspan="3">
									Start Date <g:datePicker name="startDate" precision="day"/> &nbsp;&nbsp; End Date <g:datePicker name="endDate" precision="day"/>
								</td> 
							</tr>
							<tr>
								<td>
									<g:submitButton name="search"/> <g:link action="list"><input type="button" value = "reset"/></g:link> 
								</td>
							</tr>
						</tbody>
					</table>
				</g:form>
			</div>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="plannedTransactionDate" title="${message(code: 'plannedTransaction.plannedTransactionDate.label', default: 'Planned Transaction Date')}" />
					
						<g:sortableColumn property="amount" title="${message(code: 'plannedTransaction.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="cash" title="${message(code: 'plannedTransaction.cash.label', default: 'Cash')}" />
					
						<g:sortableColumn property="exempt" title="${message(code: 'plannedTransaction.exempt.label', default: 'Exempt')}" />
					
						<th><g:message code="plannedTransaction.budgetItem.label" default="Budget Item" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${plannedTransactionInstanceList}" status="i" var="plannedTransactionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${plannedTransactionInstance.id}">${plannedTransactionInstance.plannedTransactionDate.format("MMM/DD/yyyy")}</g:link></td>
					
						<td>${fieldValue(bean: plannedTransactionInstance, field: "amount")}</td>
					
						<td>${fieldValue(bean: plannedTransactionInstance, field: "cash")}</td>
					
						<td>${fieldValue(bean: plannedTransactionInstance, field: "exempt")}</td>
					
						<td>${fieldValue(bean: plannedTransactionInstance, field: "budgetItem")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${plannedTransactionInstanceTotal}" />
			</div>
		</div>
	</div>
</body>
</html>