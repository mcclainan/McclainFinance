<%@ page import="com.assetLiability.AssetLiability" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="tracking">
<g:set var="entityName" value="${message(code: 'assetLiability.label', default: 'AssetLiability')}" />
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
					<tr class:"rowH">
					
						<g:sortableColumn property="name" title="${message(code: 'assetLiability.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'assetLiability.type.label', default: 'Type')}" />
					
						<th><g:message code="assetLiability.assetLiabilityClass.label" default="Asset Liability Class" /></th>
					
						<g:sortableColumn property="value" title="${message(code: 'assetLiability.value.label', default: 'Value')}" />
					
						<g:sortableColumn property="active" title="${message(code: 'assetLiability.active.label', default: 'Active')}" />
					
						<th><g:message code="assetLiability.account.label" default="Account" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${assetLiabilityInstanceList}" status="i" var="assetLiabilityInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${assetLiabilityInstance.id}">${fieldValue(bean: assetLiabilityInstance, field: "name")}</g:link></td>
					
						<td>
							<g:if test="${assetLiabilityInstance.type == 'L'}">
								Liability
							</g:if>
							<g:else>
								Asset
							</g:else>
						</td>
					
						<td>${fieldValue(bean: assetLiabilityInstance, field: "assetLiabilityClass")}</td>
					
						<td>${fieldValue(bean: assetLiabilityInstance, field: "value")}</td>
					
						<td>${fieldValue(bean: assetLiabilityInstance, field: "active")}</td>
					
						<td>${fieldValue(bean: assetLiabilityInstance, field: "account")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${assetLiabilityInstanceTotal}" />
			</div>
		</div>
	</div>
</body>
</html>