<%@ page import="com.planning.BudgetItem" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="planning">
<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
<title>Budget View</title>
<style type="text/css">
	td{line-height: .5em;}
	
	#primaryContent {
	    margin: 1.5em 20em 0 12.25em;
	}
</style>
<SCRIPT TYPE="text/javascript">
	<!--
	function popup(mylink, windowname)
	{
	if (! window.focus)return true;
	var href;
	if (typeof(mylink) == 'string')
	   href=mylink;
	else
	   href=mylink.href;
	   window.open(href, windowname, 'width=400,height=200,scrollbars=yes');
	return false;
	}
	//-->
</SCRIPT>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<g:form action = "view">
			<div style = "width:100%;height:60px;">
			<h1 style = "margin-left: 10px; width:50%; float:left;">${application.monthNames[month.toInteger()]} ${year} Budget</h1>
				<div style="float:right;margin:15px">
					Year <g:select name="year" from="${[2011,2012,2013,2014,2015]}" value = "${year}"/> 
					Month <g:select name="month" from="${application.monthNames}" optionKey="key" optionValue="value" value = "${month}"/>
					<g:submitButton name="Refresh"/>
				</div>
				
			</div>
			<g:if test="${year != new Date().format("yyyy") && month  != new Date().format("MM")}">
				<div style = "width:100%; height: 25px; margin:10px">
					<g:if test="${session.staticBudget}">
						This budget view is shows all planned Budget Items. Check this box to view dynamic budget. <g:checkBox name="dynamicBudget"/>
					</g:if>
					<g:else>
						This budget view shows actual amounts for previous months. Check this box to view static budget. <g:checkBox name="staticBudget"/>
					</g:else>
				</div>
			</g:if>
			</g:form>
			<div style = "margin : 10px; width:97.25% ;">
				<div style="width: 40%; float:left;border: solid;border-width: 10px; border-style: outset; padding:5px; margin-bottom: 10px">
					<h3 style="text-align: center;">Year Overview</h3><br/>
					<table>
						<thead>
							<tr>
								<td style = "font-weight: bold;">
									Month								
								</td>
								<td style="text-align: right;font-weight: bold;">
									Income
								</td>
								<td style="text-align: right;font-weight: bold;">
									Expense
								</td>
								<td style="text-align: right;font-weight: bold;">
									Ending<br/><br/>Resources
								</td>
							</tr>
						</thead>
						<tbody>
							<g:each var="monthOverView"	in="${yearOverView}">
								<tr>
									<td style="line-height: .5em;">
										${application.monthNames[monthOverView.get(0)]}
									</td>
									<td style="line-height: .5em; text-align: right;">
										<g:formatNumber number="${Math.abs(monthOverView.get(1)?:0)}" type="currency" currencyCode="USD"/>
									</td>
									<td style="line-height: .5em; text-align: right;">
										<g:formatNumber number="${Math.abs(monthOverView.get(2)?:0)}" type="currency" currencyCode="USD"/>
									</td>
									<td style="line-height: .5em; text-align: right;">
										<g:formatNumber number="${monthOverView.get(3)}" type="currency" currencyCode="USD"/>
									</td>
								<tr/>
							</g:each>
						</tbody>
					</table>
				</div>
				<div style="width: 55%; float:right; margin-bottom: 10px">
					<div style="width: 95%; border: solid; border-width: 10px; border-style: outset; padding:5px;  margin-bottom: 10px; ">
						<h3 style = "margin-bottom: 10px; text-align: center;">Income</h3>
						<g:each in="${monthIncome}" var = "metaCategory">
							<h4>${metaCategory.key}</h4>
							<table>
								<g:each in="${metaCategory.value}" var = "category">
									<tr>
										<td style = "width: 20em">
											<g:link controller="budgetItem" action="showByCategoryMonthAndYear" params="[month:month,year:year,name:category.key]" target="_blank">
												${category.key}
											</g:link>
										</td>
										<td style = "text-align: right; width:8em;">
											<g:formatNumber number="${Math.abs(category.value?:0)}" type="currency" currencyCode="USD"/>
										</td>
									</tr>									
								</g:each>
							</table>
						</g:each>
					</div>
					<div style="width: 95%; border: solid; border-width: 10px; border-style: outset; padding:5px;  margin-bottom: 10px; ">
						<h3 style = "margin-bottom: 10px; text-align: center;">Expense</h3>
						<g:each in="${monthExpense}" var = "metaCategory">
							<h4>${metaCategory.key}</h4>
							<table>
								<g:each in="${metaCategory.value}" var = "category">
									<tr>
										<td style = "width: 20em">
											<g:link controller="budgetItem" action="showByCategoryMonthAndYear" params="[month:month,year:year,name:category.key]" target="_blank">
												${category.key}
											</g:link>
										</td>
										<td style = "text-align: right;  width:8em;">
											<g:formatNumber number="${Math.abs(category.value?:0)}" type="currency" currencyCode="USD"/>
										</td>
									</tr>									
								</g:each>
							</table>
						</g:each>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>