<%@ page import="com.category.MetaCategory" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="recordMaint">
<g:set var="entityName" value="${message(code: 'metaCategory.label', default: 'MetaCategory')}" />
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
					
						<g:sortableColumn property="name" title="${message(code: 'metaCategory.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="priority" title="${message(code: 'metaCategory.priority.label', default: 'Priority')}" />
					
						<g:sortableColumn property="active" title="${message(code: 'metaCategory.active.label', default: 'Active')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${metaCategoryInstanceList}" status="i" var="metaCategoryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${metaCategoryInstance.id}">${fieldValue(bean: metaCategoryInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: metaCategoryInstance, field: "priority")}</td>
					
						<td>${fieldValue(bean: metaCategoryInstance, field: "active")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${metaCategoryInstanceTotal}" />
			</div>
		</div>
	</div>
</body>
</html>