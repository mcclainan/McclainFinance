<%@ page import="com.category.Category" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="recordMaint">
<g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
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
					
						<g:sortableColumn property="name" title="${message(code: 'category.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="priority" title="${message(code: 'category.priority.label', default: 'Priority')}" />
					
						<g:sortableColumn property="cash" title="${message(code: 'category.cash.label', default: 'Cash')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'category.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="active" title="${message(code: 'category.active.label', default: 'Active')}" />
					
						<th><g:message code="category.metaCategory.label" default="Meta Category" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${categoryInstanceList}" status="i" var="categoryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${categoryInstance.id}">${fieldValue(bean: categoryInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: categoryInstance, field: "priority")}</td>
					
						<td>${fieldValue(bean: categoryInstance, field: "cash")}</td>
					
						<td>${fieldValue(bean: categoryInstance, field: "type")}</td>
					
						<td>${fieldValue(bean: categoryInstance, field: "active")}</td>
					
						<td>${fieldValue(bean: categoryInstance, field: "metaCategory")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${categoryInstanceTotal}" />
			</div>
		</div>
	</div>
</body>
</html>