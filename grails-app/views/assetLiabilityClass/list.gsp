
<%@ page import="com.assetLiability.AssetLiabilityClass" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-assetLiabilityClass" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<nav:render group="assetLiabilityClassTabs"/>
		</div>
		<div id="list-assetLiabilityClass" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'assetLiabilityClass.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="onSale" title="${message(code: 'assetLiabilityClass.onSale.label', default: 'On Sale')}" />
					
						<g:sortableColumn property="onPurchase" title="${message(code: 'assetLiabilityClass.onPurchase.label', default: 'On Purchase')}" />
					
						<g:sortableColumn property="onProceedes" title="${message(code: 'assetLiabilityClass.onProceedes.label', default: 'On Proceedes')}" />
					
						<g:sortableColumn property="onPayment" title="${message(code: 'assetLiabilityClass.onPayment.label', default: 'On Payment')}" />
					
						<g:sortableColumn property="onInterest" title="${message(code: 'assetLiabilityClass.onInterest.label', default: 'On Interest')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${assetLiabilityClassInstanceList}" status="i" var="assetLiabilityClassInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${assetLiabilityClassInstance.id}">${fieldValue(bean: assetLiabilityClassInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: assetLiabilityClassInstance, field: "onSale")}</td>
					
						<td>${fieldValue(bean: assetLiabilityClassInstance, field: "onPurchase")}</td>
					
						<td>${fieldValue(bean: assetLiabilityClassInstance, field: "onProceedes")}</td>
					
						<td>${fieldValue(bean: assetLiabilityClassInstance, field: "onPayment")}</td>
					
						<td>${fieldValue(bean: assetLiabilityClassInstance, field: "onInterest")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${assetLiabilityClassInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
