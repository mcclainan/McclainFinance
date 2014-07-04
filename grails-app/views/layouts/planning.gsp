<%@ page import="com.tracking.Account"%>
<!doctype html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:layoutTitle default="Grails" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon"
	href="${resource(dir: 'images', file: 'favicon.png')}"
	type="image/x-icon">
<link rel="apple-touch-icon"
	href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114"
	href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'macfin.css')}" type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
<nav:resources />
<g:layoutHead />
<r:layoutResources />
</head>
<body>
	<div id="outer">
		<div id="header">
			<a class="home" href="${createLink(uri: '/')}"><img
				src="${resource(dir: 'images', file: 'grails_logo.png')}"
				alt="Grails" class="logo" /></a>
		</div>
		<div id="menu">
			<ul>
				<li class="first"><a class="home"
					href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link controller="transaction">Tracking</g:link></li>
				<li><g:link controller="budgetItem">Planning</g:link></li>
				<li><g:link controller="report">Reports</g:link></li>
				<li><g:link controller="category">Records Maintenance</g:link></li>
			</ul>
		</div>
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
			<g:layoutBody />
			<div id="secondaryContent">
				<h3>Budget</h3>
				<ul>
					<li><g:link controller="budgetItem" action="view">View</g:link></li>
					<li><g:link controller="budgetItem" action="create">Create</g:link></li>
					<li><g:link controller="budgetItem" action="list">List</g:link></li>
					<li><g:link controller="budgetItem" action="budgetItemChoose">Choose For Editing</g:link></li>
				</ul>
				<h3>Planned Transaction</h3>
				<ul>
					<li><g:link controller="plannedTransaction" action="list">List</g:link></li>
					<li><g:link controller="plannedTransaction" action="cashFlowCalendar">Cash Flow Calendar</g:link></li>
				</ul>
				<div class="xbg"></div>
			</div>
		<div class="clear"></div>
		</div>
		<g:javascript library="application" />
		<r:layoutResources />
		<div id="footer">
			<p>
				<a href="http://www.freecsstemplates.org">Free CSS Templates</a>
			</p>
		</div>
	</div>
</body>
</html>
