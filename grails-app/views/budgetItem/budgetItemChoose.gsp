<%@ page import="com.planning.BudgetItem" %>
<%@ page import="com.category.Category" %>
<!doctype html>
<html>
<head>
	<meta name="layout" content="planning">
	<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
	<title>Choose Budget Item</title>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1>Choose a Budget Item</h1>
			
			<div class = "searchDiv">
				<h3>Search Budget Items</h3>
				<g:if test="${flash.searchErrors}">
				<ul class="errors" role="alert">
					<g:each in="${flash.searchErrors}" var="error">
						<li>${error.value}</li>
					</g:each>
				</ul>
				</g:if>
				<g:form controller="budgetItem" action="search">
					<table>
						<tbody>
							<tr>
								
								<td>
									Year
								</td>
								<td>
									 <g:select name="year" from="[2011,2012,2013,2014,2015,2016]" noSelection="${['null':'Select One...']}"/> 
								</td>
								<td>
									Month
								</td>
								<td>
									 <g:select name="month" from="${application.monthNames}" optionKey="key" optionValue="value" noSelection="${['null':'Select One...']}"/> 
								</td>
							</tr>
							<tr>
								<td>
									Amount
								</td>
								<g:if test="${flash.searchErrors?.amount}">
									<g:set var="amountError" value = "${'invalidField'}"/>
								</g:if>
								<td >
									 <g:field class = "${amountError}" type="number" name = "amount"/> 
								</td>
								<td>
									Category
								</td>
								<td>
									 <g:select name="category.id" from="${Category.list()}" optionKey="id" noSelection="${['null':'Select One...']}"/>
								</td>
							</tr>
							<tr>
								<td>
									<g:hiddenField name="returnAction" value = "choose" />
									<g:submitButton name="search"/>
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
					<tr class="rowH">
						<td></td>
						
						<g:sortableColumn property="year" title="${message(code: 'budgetItem.year.label', default: 'Year')}" />
					
						<g:sortableColumn property="month" title="${message(code: 'budgetItem.month.label', default: 'Month')}" />
					
						<th><g:message code="budgetItem.category.label" default="Category" /></th>
					
						<g:sortableColumn property="amount" title="${message(code: 'budgetItem.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="cash" title="${message(code: 'budgetItem.cash.label', default: 'Cash')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${budgetItemInstanceList}" status="i" var="budgetItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
						<td><g:link controller = "plannedTransaction" action="create" id="${budgetItemInstance.id}" params="[createSet:'createSet']">Choose</g:link></td>
					
						<td>${budgetItemInstance.year}</td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "month")}</td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "category")}</td>
					
						<td ><g:formatNumber type="currency" currencyCode="USD" number="${budgetItemInstance.amount}"/>  </td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "cash")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${budgetItemInstanceTotal}" params="[returnAction:'choose']"/>
			</div>
		</div>
	</div>
</body>
</html>