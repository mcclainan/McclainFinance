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
		</style>
		
		<g:javascript>
			function toggleElements(){
				var amountValue = document.getElementById("amount").value
								
				if(amountValue == "multiple"){
					document.getElementById("debitRow").style.visibility = "visible"	
					document.getElementById("creditRow").style.visibility = "visible"	
				}else{
					document.getElementById("debitRow").style.visibility = "collapse"	
					document.getElementById("creditRow").style.visibility = "collapse"	
				}
			}
		</g:javascript>
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
			<g:if test="${flash.errors}">
				<ul class="errors" role="alert">
					<g:each in="${flash.errors}" var = "error">
						<li>${error.value}</li>
					</g:each>
				</ul>
			</g:if>
			<g:form action="upload" >
				<fieldset class="form">
					<table>
						<tr>
							<td style="width:130px">
								Account
							</td>
							<td>
								<g:select id="account" name="account.id" from="${com.tracking.Account.list()}" optionKey="id" value="" />
							</td>
						</tr>	
						<tr>
							<td>
								Transaction Date
							</td>
							<td>
								<g:select name="transactionDate" from="${elementNumbers}" noSelection="['': 'Choose']"/>
							</td>
						</tr>	
						<tr>
							<td>
								Description
							</td>
							<td>
								<g:select name="description" from="${elementNumbers}" noSelection="['': 'Choose']"/>
							</td>
						</tr>	
						<tr>
							<td>
								Amount
							</td>
							<td>
								<g:select name="amount" from="${amountElements}" noSelection="['': 'Choose']" onchange = "toggleElements()"/>
							</td>
						</tr>	
						<tr id = "debitRow" style="visibility: collapse">
							<td></td>
							<td>
								Debits &nbsp;<g:select name="debits" from="${elementNumbers}" noSelection="['': 'Choose']"/>
							</td>
						</tr>
						<tr id = "creditRow" style="visibility: collapse">
							<td></td>
							<td>
								Credits <g:select name="credits" from="${elementNumbers}" noSelection="['': 'Choose']"/>
							</td>
						</tr>
						<tr>
							<td>
								Date Format
							</td>
							<td>
								<g:textField name="dateFormat"/>
							</td>
						</tr>	
						<tr>
							<td>
								Has Heading
							</td>
							<td>
								<g:select name="hasHeading" from="${['no','yes']}"/>
							</td>
						</tr>	
					</table>
					<div style = "width:100%; height: 200px; overflow: hidden;">
						<table>
							<thead>
								<tr>
									<g:each in="${elementNumbers}" var = "number">
										<th>${number}</th>
									</g:each>
								</tr>
							</thead>
							<tbody>
								<g:each in="${session.newFile}" var="row">
									<tr>
									
										<g:set var="i" value="${1}"/>
										
										<g:each in="${row}" var="element">
											<td class ="<g:if test="${i++%2 !=0}">oddTableData</g:if>">
												${element}
											</td>
										</g:each>
									</tr>
								</g:each>
							</tbody>
						</table>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="upload" value="Upload"/>
				</fieldset>
			</g:form>
		</div>
	</div>
</body>
</html>