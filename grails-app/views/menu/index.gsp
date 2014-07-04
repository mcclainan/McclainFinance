<!doctype html>
<%@ page import="com.tracking.Account"%>
<%@ page import="com.tracking.Transaction"%>
<html>
<head>
<meta name="layout" content="mainnew">
<title>Home</title>
<style type="text/css">
	.message{
		width:76.25em;
	}
	#dialogBox {
	    background: none repeat scroll 0 0 #EFEFEF;
	    border-color: #006192;
	    border-style: outset;
	    border-width: 0.5em;
	    height: 20em;
	    margin: 6em 1em 1em 24em;
	    position: fixed;
	    visibility: hidden;
	    width: 40em;
	    padding:1em;
	    z-index: 1;
	}
	#dialogBoxHead{
		height: 11%;
	}
	#dialogBoxBody{
	    overflow:scroll;
		height: 77%;
	}
	#dialogBoxFooter{
		height: 11%;
		text-align: center;
	}
	
</style>
<g:javascript library="prototype" />
<script type="text/javascript">
	var refresh = "false"
	function toggleDialogBoxVisibility(on){
		if(on=="on"){
			document.getElementById("dialogBox").style.visibility = "visible"
		}else{
			document.getElementById("dialogBox").style.visibility = "hidden"
		}	
	}	

	function setRefresh(value){
		refresh = value
	}

	function refreshPage(){
		if(refresh == "true"){
			location.reload() 
		}
	}
	
</script>
</head>
<body>
	
	<div id="content">
		<div id="tertiaryContent">
			<h3>Current Resources</h3>
			<ul>
				<g:each in="${Account.findAllByActive("Y")}" var="accountInstance">
					<li>
						${accountInstance.name} <g:formatNumber
							number="${accountInstance.balance}" type="currency"
							currencyCode="USD" />
					</li>
				</g:each>
			</ul>
			<div class="xbg"></div>
		</div>
		<div id="primaryContentContainer">
			<div id="dialogBox">
				
			</div>
			<div id="primaryContent">
				<h2>Recent Transactions</h2>
				<table>
					<tr class="rowH">
						<th>Date</th>
						<th>Category</th>
						<th>Description</th>
						<th>Amount</th>
						<th>Account</th>
					</tr>
					<g:each
						in="${Transaction.list(max: 5, sort: "transactionDate", order: "desc")}"
						status="i" var="transactionInstance">
						<tr class="${(i % 2) == 0 ? 'rowA' : 'rowB'}">

							<td><g:formatDate
									date="${transactionInstance.transactionDate}"
									format="MM/dd/yyyy" /></td>

							<td>
								${fieldValue(bean: transactionInstance, field: "name")}
							</td>

							<td>
								${fieldValue(bean: transactionInstance, field: "category")}
							</td>

							<td>
								${fieldValue(bean: transactionInstance, field: "amount")}
							</td>

							<td>
								${fieldValue(bean: transactionInstance, field: "account")}
							</td>

						</tr>
					</g:each>
				</table>
				<br/><br/>
				<h2>Cash Flow Calendar</h2> <g:link controller="plannedTransaction" action="cashFlowCalendar">(view full calendar)</g:link> 
				<div class="calendar">
					<div class="calendarHead">
						<div class="calendarHeadCell">
							Sunday
						</div>
						<div class="calendarHeadCell">
							Monday
						</div>
						<div class="calendarHeadCell">
							Tuesday
						</div>
						<div class="calendarHeadCell">
							Wednesday
						</div>
						<div class="calendarHeadCell">
							Thursday
						</div>
						<div class="calendarHeadCell">
							Friday
						</div>
						<div class="calendarHeadCell">
							Saturday
						</div>
					</div>
					<div class="calendarBody">
						<g:each in="${calendar}" var="calendarRow">
							<div class="calendarRow">
								<g:each in="${calendarRow}" var="calendarCell">
									<g:remoteLink controller="plannedTransaction" action="remoteList" params="[date: calendarCell.fullDate]" update="dialogBox" after="toggleDialogBoxVisibility('on')">
										<div class="calendarCell">
											<div class="calendarCellHeader">
												${calendarCell.date}
											</div>
											<g:if test="${calendarCell.income}">
												+ ${calendarCell.income}<br/>
											</g:if>
											<g:if test="${calendarCell.expense}">
												- ${calendarCell.expense}<br/>
											</g:if>
											<g:if test="${calendarCell.balance}">
												bal <g:formatNumber number="${calendarCell.balance}" type="currency" currencyCode="USD" /><br/>
											</g:if>
										</div>
									</g:remoteLink>
								</g:each>
							</div>
						</g:each>
					</div>
				</div>
			</div>
		</div>
		<div id="secondaryContent">
			<h3>Tracking</h3>
			<ul>
				<li><g:link controller="transaction" action="singleTransaction">Transactions</g:link></li>
				<li><g:link controller="account" action="list">Accounts</g:link></li>
				<li><g:link controller="assetLiability" action="list">Assets/Liabilities</g:link>
				</li>
			</ul>
			<h3>Planning</h3>
			<ul>
				<li><g:link controller="budgetItem" action="budgetView"
						params="[staticBudget:'on']">Budget View</g:link></li>
				<li><g:link controller="budgetItem" action="create">New Budget</g:link>
				</li>
			</ul>
			<h3>Reports</h3>
			<ul>
				<li><g:link controller="report" action="financial">Financial</g:link>
				</li>
				<li><g:link controller="report" action="incomeAndExpense">Income and Expense</g:link>
				</li>
			</ul>
			<h3>Records Maintenance</h3>
			<ul>
				<li><g:link controller="metaCategory" action="list">Meta Category</g:link>
				</li>
				<li><g:link controller="category" action="list">Category</g:link>
				</li>
			</ul>
			<div class="xbg"></div>
		</div>
		<div class="clear"></div>
	</div>
</body>
</html>