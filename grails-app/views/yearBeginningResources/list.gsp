
<%@ page import="com.planning.YearBeginningResources" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'yearBeginningResources.label', default: 'YearBeginningResources')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-yearBeginningResources" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-yearBeginningResources" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="year" title="${message(code: 'yearBeginningResources.year.label', default: 'Year')}" />
					
						<g:sortableColumn property="actualBenifits" title="${message(code: 'yearBeginningResources.actualBenifits.label', default: 'Actual Benifits')}" />
					
						<g:sortableColumn property="actualCash" title="${message(code: 'yearBeginningResources.actualCash.label', default: 'Actual Cash')}" />
					
						<g:sortableColumn property="actualCreditCard" title="${message(code: 'yearBeginningResources.actualCreditCard.label', default: 'Actual Credit Card')}" />
					
						<g:sortableColumn property="actualOther" title="${message(code: 'yearBeginningResources.actualOther.label', default: 'Actual Other')}" />
					
						<g:sortableColumn property="budgetedBenifits" title="${message(code: 'yearBeginningResources.budgetedBenifits.label', default: 'Budgeted Benifits')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${yearBeginningResourcesInstanceList}" status="i" var="yearBeginningResourcesInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${yearBeginningResourcesInstance.id}">${fieldValue(bean: yearBeginningResourcesInstance, field: "year")}</g:link></td>
					
						<td>${fieldValue(bean: yearBeginningResourcesInstance, field: "actualBenifits")}</td>
					
						<td>${fieldValue(bean: yearBeginningResourcesInstance, field: "actualCash")}</td>
					
						<td>${fieldValue(bean: yearBeginningResourcesInstance, field: "actualCreditCard")}</td>
					
						<td>${fieldValue(bean: yearBeginningResourcesInstance, field: "actualOther")}</td>
					
						<td>${fieldValue(bean: yearBeginningResourcesInstance, field: "budgetedBenifits")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${yearBeginningResourcesInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
