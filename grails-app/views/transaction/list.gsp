
<%@ page import="com.tracking.Transaction" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'transaction.label', default: 'Transaction')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-transaction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link class="list" action="singleTransactionOld">Single Transactions</g:link></li>
			</ul>
		</div>
		<div id="list-transaction" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="category" title="${message(code: 'transaction.category.label', default: 'Category')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'transaction.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="amount" title="${message(code: 'transaction.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="notes" title="${message(code: 'transaction.notes.label', default: 'Notes')}" />
					
						<th><g:message code="transaction.account.label" default="Account" /></th>
					
						<th><g:message code="transaction.assetLiability.label" default="Asset Liability" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${transactionInstanceList}" status="i" var="transactionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${transactionInstance.id}">${fieldValue(bean: transactionInstance, field: "category")}</g:link></td>
					
						<td>${fieldValue(bean: transactionInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: transactionInstance, field: "amount")}</td>
					
						<td>${fieldValue(bean: transactionInstance, field: "notes")}</td>
					
						<td>${fieldValue(bean: transactionInstance, field: "account")}</td>
					
						<td>${fieldValue(bean: transactionInstance, field: "assetLiability")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${transactionInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
