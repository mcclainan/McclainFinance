<!doctype html>
<%@ page import="com.tracking.Account"%>
<%@ page import="com.tracking.Transaction"%>
<html>
<head>
<meta name="layout" content="mainnew">
<title>HHHHHH</title>
<style type="text/css">
	.message{
		width:76.25em;
	}
</style>
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
			<div id="primaryContent">
				<h1>Recent Transactions</h1>
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
									<div class="calendarCell">
										<div class="calendarCellHeader">
											${calendarCell.date}
										</div>
										<g:if test="${calendarCell.income}">
										</g:if>
										<g:if test="${calendarCell.expense}">
										</g:if>
										<g:if test="${calendarCell.balance}">
										</g:if>
									</div>
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
				<li><g:link controller="budgetItem" action="view"
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