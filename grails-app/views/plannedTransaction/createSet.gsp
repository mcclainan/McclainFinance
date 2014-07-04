<%@ page import="com.planning.PlannedTransaction" %>
<%@ page import="com.planning.BudgetItem" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="planning">
<g:set var="entityName" value="${message(code: 'plannedTransaction.label', default: 'PlannedTransaction')}" />
<title><g:message code="default.create.label" args="[entityName]" /></title>
<script type="text/javascript">
	function displayMessage(message,element){
		var messageBox = document.getElementById("messageBox")
		messageBox.innerHTML = message
		if(element == "amountOption"){
			amounHiglight("on")
		}
	}

	function createModeMessage(){
		var value = document.getElementById("createMode").checked
		if(value == false||value == "false"){
			messageBox.innerHTML = "Specify an amount<br/>Specify a date in the \"Start Date\" field"
		}else{
			messageBox.innerHTML = ""
		}
	}
</script>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1>Create Planned Transactions</h1>
			<g:form action="save" >
				<div style="height: 430px">
					<div style = "width : 30%; margin-top: 25px; margin-left: 30px; float: left;">
						<h3>Budget Item</h3>
						<g:link controller="budgetItem" action = "show" id = "${budgetItem.id}" target = "_blank">View</g:link> <br/>
						Year: ${budgetItem.year}<br/>
						Month: ${application.monthNames[budgetItem.month]}<br/>
						Category: ${budgetItem.category}<br/>
						Current Amount: <g:formatNumber type="currency" number="${budgetItem.amount }" currencyCode="USD"/> <br/>
						<g:link controller="budgetItem" action="budgetItemChoose">Change Budget Item</g:link>
						<g:hiddenField name="id" value="${budgetItem.id}"/><br/><br/>
						Create Mode:<br/> 
						<g:radio name="createMode" value="set" checked="true" onchange="createModeMessage()"/> Set &nbsp;&nbsp;
						<g:radio name="createMode" value="single" onchange="createModeMessage()"/> Single<br/><br/>
						Start Date<br/>
						<g:datePicker name="startDate" precision="day" value="${date}"  relativeYears="[0..5]"/><br/><br/>
						End Date<br/>
						<g:datePicker name="endDate" precision="day" value="${date}"  relativeYears="[0..5]"/><br/><br/>
						
						<g:checkBox name="replaceCurrentSet"/> Replace Current Set<br/><br/>
						
						<fieldset class="buttons">
							<g:submitButton name="create" class="save" value="Create Set" />
						</fieldset>
					</div>
					<div style = "float: right; width: 60%; height:95%; margin:2%; border: outset; border-width: 5px">
						<div style = "float: left; width: 45%; margin : 10px;">
							Amount Options<br/>
							<table>
								<tr>
									<td><g:radio name = "amountOption" value="deriveAmount" checked="checked" /> Derive from Budget Amount</td>
								</tr>
								<tr>
									<td><g:radio name = "amountOption" value="addAmount" onchange = "displayMessage('Specify an Amount in the amount field',this.id)"/> Add to get budget amount</td>
								</tr>
								<tr>
									<td>Amount <g:field name = "amount" id = "amount" type="number" size = "10" /> </td>
								</tr>
							</table>
						</div>
						
						<div style = "width: 45%; margin : 10px; float:right;" >
							Frequency Options
							<table>
								<tr>
									<td><g:radio name="frequencyOption" value="daily"  checked="checked"/> Daily</td>
									<td><g:radio name="frequencyOption" value="biDaily"/> Bi-Daily</td>
								</tr>
								<tr>
									<td><g:radio name="frequencyOption" value="weekly"/> Weekly</td>
									<td><g:radio name="frequencyOption" value="biWeekly"/> Bi Weekly</td>
								</tr>
								<tr>
									<td><g:radio name="frequencyOption" value="monthly"/> Monthly</td>
									<!-- <td><g:radio name="frequencyOption" value="semiMonthly"/> Semi Monthly </td>  -->
								</tr>
							</table>
						</div>
						<div style = "width: 93%; height:189px ;margin : 10px;  border: outset; border-width: 5px; padding:5px; float: left">
							<h5>Message Area</h5>
							<div id="messageBox" style="width: 100%; height: 85%; margin-top: 10px; font-size: 14px; overflow: scroll">
								<g:if test="${flash.message}">
									<div class="message" role="status">${flash.message}</div>
								</g:if>
								<g:each in = "${flash.messages}" var = "message">
									<div class="message" role="status">${message.value}</div>
								</g:each>
								<g:if test="${flash.errors}">
									<ul class="errors" role="alert">
										<g:each in="${flash.errors}" var="error">
											<li>${error.value}</li>
										</g:each>
									</ul>	
								</g:if>
							</div>						
						</div>
					</div>
				</div>
			</g:form>
		</div>
	</div>
</body>
</html>