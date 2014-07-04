<!doctype html>
<html>
<head>
<meta name="layout" content="reports">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
<title>Financial Report</title>
<style>
	h1{
		font-size: 25px;
	}
	h2{
		font-size: 20px;
		border-bottom: solid;
		border-width: 2px;
		padding: 2px;
		border-color: gray;
	}
	td,th{
		line-height: 0px
	}
	table{
		margin-bottom: 0px;
	}
	#primaryContent {
    	margin: 1.5em 17em 0 10.25em;
    }	
</style>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<div style = "width:100%;height:60px;">
			<h1 style = "margin-left: 10px; width:50%; float:left;">${application.monthNames[month.toInteger()]} ${year} Financial Report</h1>
			<div style="float:right;margin:15px">
				<g:form action="financial">
					Year <g:select name="year" from="${[2011,2012,2013,2014,2015]}" value = "${year}"/> 
					Month <g:select name="month" from="${application.monthNames}" optionKey="key" optionValue="value" value = "${month}"/>
					<g:submitButton name="Refresh"/>
				</g:form>
			</div>
			
		</div>		
		<div style = "height:600px; width:36%; padding: 2%; float:left;">
			<div style="width:97%; height:40%; border:solid; border-style:outset; border-width: 10px; margin-bottom: 20px;">
				<h2>Summary</h2>
				<div style="padding: 5px;">
					<span style="font-weight: bold; font-size: 17px;">Beginning Resources</span><br/>
					<table>
						<tr>
							<td>
								Cash
							</td>
							<td>
								<g:formatNumber number="${summary.beginningCash}" type="currency" currencyCode="USD"/> <br/>
							</td>
						</tr>
						<tr>
							<td>
								Benefits 
							</td>
							<td>
								<g:formatNumber number="${summary.beginningBenifit}" type="currency" currencyCode="USD"/><br/>
							</td>
						</tr>
						<tr>
							<td>
								Credit Cards 
							</td>
							<td>
						    	<g:formatNumber number="${summary.beginningCreditCard}" type="currency" currencyCode="USD"/><br/>							
							</td>
						</tr>
						<tr>
							<td>
								Other 							
							</td>
							<td>
								<g:formatNumber number="${summary.beginningOther}" type="currency" currencyCode="USD"/><br/>
							</td>
						</tr>
					</table>
					
				</div>
				<div style=" padding: 5px; font-size: 17px;">
					<span style="font-weight: bold">
						<g:if test="${month == new Date().format('MM').toInteger() && year == new Date().format('yyyy').toInteger()}">
							Current Resources
						</g:if>
						<g:else>
							Ending Resources
						</g:else>
						
					</span><br/>
					<table>
						<tr>
							<td>
								Cash
							</td>
							<td>
								<g:formatNumber number="${summary.enddingCash}" type="currency" currencyCode="USD"/> <br/>
							</td>
						</tr>
						<tr>
							<td>
								Benefits 
							</td>
							<td>
								<g:formatNumber number="${summary.enddingBenifit}" type="currency" currencyCode="USD"/><br/>
							</td>
						</tr>
						<tr>
							<td>
								Credit Cards 
							</td>
							<td>
						    	<g:formatNumber number="${summary.enddingCreditCard}" type="currency" currencyCode="USD"/><br/>							
							</td>
						</tr>
						<tr>
							<td>
								Other 							
							</td>
							<td>
								<g:formatNumber number="${summary.enddingOther}" type="currency" currencyCode="USD"/><br/>
							</td>
						</tr>
					</table>
				</div>
				
			</div>
			<div  style="width:97%; height:51%; border:solid; border-style:outset;  border-width: 10px; margin-bottom: 20px;">
				<h2>Year Overview</h2>
				<table style = "width : 90%">
					<tr>
						<td>
						</td>
						<td>
							Income
						</td>
						<td>
							Expense
						</td>
					</tr>
					<g:each in = "${yearOverview}" var="yo">
						<tr>
							<td>${application.monthNames[yo.get(0)]}</td>
							<td><g:formatNumber number="${yo.get(1)}" type="currency" currencyCode="USD"/></td>
							<td><g:formatNumber number="${yo.get(2)}" type="currency" currencyCode="USD"/></td>
							<td></td>
						</tr>
					</g:each>
				</table>
			</div>
		</div>
		<div style = "height:600px; width:56%; padding: 2%; float:right;">
			<div style="width:97%; height:30%; border:solid; border-style:outset; border-width: 10px; margin-bottom: 20px;">
				<h2>Income</h2>
				<div style = "width:97%;height:78.7% ;overflow:scroll; padding-left:15px; padding-top:10px ">
					<g:each in="${incomeBreakdown}" var="metaCategory">
						<span style="font-weight: bold; font-size: 17px;">${metaCategory.key}</span><br/>
						<g:each in="${metaCategory.value}" var="category">
							<div style="width:50%; margin-left: 15px; float:left">${category.get(0)}</div>
							<div style="width:30%; margin-left: 15px; float:right">
							   <g:formatNumber number="${category.get(1)}" type="currency" currencyCode="USD"/>
							</div>
							<br/>
						</g:each>
						<br/>
					</g:each>
				</div>
			</div>
			<div  style="width:97%; height:61%; border:solid; border-style:outset;  border-width: 10px; margin-bottom: 20px;">
				<h2>Expense</h2>
				<div style = "width:97%;height:89.5% ;overflow:scroll; padding-left:15px; padding-top: 10px">
					<g:each in="${expenseBreakdown}" var="metaCategory">
						<span style="font-weight: bold; font-size: 17px;">${metaCategory.key}</span><br/>
						<g:each in="${metaCategory.value}" var="category">
							<div style="width:50%; margin-left: 15px; float:left">${category.get(0)}</div>
							<div style="width:30%; margin-left: 15px; float:right">
							   <g:formatNumber number="${category.get(1)}" type="currency" currencyCode="USD"/>
							</div>
							<br/>
						</g:each>
						<br/>
					</g:each>
				</div>
			</div>
		</div>
		</div>
	</div>
</body>
</html>