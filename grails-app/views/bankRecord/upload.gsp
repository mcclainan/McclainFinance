<%@ page import="com.tracking.BankRecord" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="tracking">
<g:set var="entityName" value="${message(code: 'bankRecord.label', default: 'BankRecord')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<style type="text/css">
			th{
				text-align: center;
			}
			
			.oddTableData{
				background-color: #EFEFEF;
			}
			
			#primaryContent {
			    margin: 1.5em 16em 0 9.25em;
			}
		</style>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1>Match Columns</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${bankRecordInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${bankRecordInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
				
			</ul>
			</g:hasErrors>
			<div style = "width:48%; height: 400px; overflow: scroll; float:left; margin-left: 1%;">
				<h3>Added Bank Records</h3>
				<table>
					<thead>
						<tr class="rowH">
						
							<th><g:message code="bankRecord.account.label" default="Account" /></th>
						
							<g:sortableColumn property="transactionDate" title="Date" />
						
							<g:sortableColumn property="description" title="${message(code: 'bankRecord.description.label', default: 'Description')}" />
						
							<g:sortableColumn property="amount" title="${message(code: 'bankRecord.amount.label', default: 'Amount')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${bankRecordsList}" status="i" var="bankRecordInstance">
						<tr class="${(i % 2) == 0 ? 'rowA' : 'rowB'}">
						
							<td>${fieldValue(bean: bankRecordInstance, field: "account")}</td>
						
							<td><g:formatDate date="${bankRecordInstance.transactionDate}" format="MM-dd-yyyy"/></td>
						
							<td>${fieldValue(bean: bankRecordInstance, field: "description")}</td>
						
							<td>${fieldValue(bean: bankRecordInstance, field: "amount")}</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
			</div>
			
			<div style = "width:48%; height: 400px; overflow: scroll; float:right; margin-right:1%;">
				<h3>Duplicate Bank Records</h3>
				<table>
					<thead>
						<tr class="rowH">
						
							<th><g:message code="bankRecord.account.label" default="Account" /></th>
						
							<g:sortableColumn property="transactionDate" title="Date" />
						
							<g:sortableColumn property="description" title="${message(code: 'bankRecord.description.label', default: 'Description')}" />
						
							<g:sortableColumn property="amount" title="${message(code: 'bankRecord.amount.label', default: 'Amount')}" />
						
						</tr>
					</thead>
					<tbody>
						<g:each in="${duplicateBankRecordsList}" status="i" var="bankRecordInstance">
							<tr class="${(i % 2) == 0 ? 'rowA' : 'rowB'}">
							
								<td>${fieldValue(bean: bankRecordInstance, field: "account")}</td>
							
								<td><g:formatDate date="${bankRecordInstance.transactionDate}" /></td>
							
								<td>${fieldValue(bean: bankRecordInstance, field: "description")}</td>
							
								<td>${fieldValue(bean: bankRecordInstance, field: "amount")}</td>
							
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>