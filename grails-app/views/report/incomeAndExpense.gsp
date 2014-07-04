<!doctype html>
<html>
<head>
<meta name="layout" content="reports">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
		<title>Income and Expense Report</title>
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
    			margin: 1.5em 16em 0 10.25em;
    		}
		</style>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<div style = "width:100%;height:60px;">
			<h1 style = "margin-left: 10px; width:50%; float:left;">${application.monthNames[month.toInteger()]} ${year} Income/Expense Report</h1>
			<div style="float:right;margin:15px">
				<g:form action="incomeAndExpense">
					Year <g:select name="year" from="${[2011,2012,2013,2014,2015]}" value = "${year}"/> 
					Month <g:select name="month" from="${application.monthNames}" optionKey="key" optionValue="value" value = "${month}"/>
					<g:submitButton name="Refresh"/>
				</g:form>
			</div>
			
		</div>		
		
			<div style="width:47%; height:500px; border:solid; border-style:outset; border-width: 10px; margin-bottom: 20px; float:left">
				<h2>Income</h2>
				<div style = "width:96%;height:91.7% ;overflow:scroll; padding-left:15px; padding-top:10px ">
					<g:each in="${incomeBreakdown}" var="metaCategory">
						<span style="font-weight: bold; font-size: 17px; text-decoration: underline;">${metaCategory.key}</span><br/>
						<g:each in="${metaCategory.value}" var="category">
							<span style="font-weight: bold; font-size: 15px; margin-left: 15px;">${category.get(0)}</span><br/>
							<g:if test = "${category.get(3).size() > 5 }">
								<div style = "width:99%; height:115px; overflow:scroll;">
							</g:if>
							<g:each in="${category.get(3)}" var="transaction">
								<span style="width:15%; height:20px; margin-left: 35px; float:left; overflow: hidden;">${transaction.transactionDate.format("MM/dd")}</span>
								<span style="width:50%; height:20px; margin-left: 20px; float:left; overflow: hidden;">${transaction.name}</span>
								<span style="width:20%; float:rihgt; text-align: right; margin-right: 15px;">
								   <g:formatNumber number="${transaction.amount}" type="currency" currencyCode="USD"/>
								</span>
								<br/>
							</g:each> 
							<g:if test = "${category.get(3).size() > 5 }">
								</div>
							</g:if>
						</g:each>
						<br/>
					</g:each>
				</div>
			</div>
			<div  style="width:47%; height:500px; border:solid; border-style:outset;  border-width: 10px; margin-bottom: 20px; float:right; 	">
				<h2>Expense</h2>
				<div style = "width:96%;height:91.7% ;overflow:scroll; padding-left:15px; padding-top: 10px">
					<g:each in="${expenseBreakdown}" var="metaCategory">
						<span style="font-weight: bold; font-size: 17px; text-decoration: underline;">${metaCategory.key}</span><br/>
						<g:each in="${metaCategory.value}" var="category">
							<span style="font-weight: bold; font-size: 15px; margin-left: 15px;">${category.get(0)}</span><br/>
							<g:if test = "${category.get(3).size() > 5 }">
								<div style = "width:99%; height:115px; overflow:scroll;">
							</g:if>
							<g:each in="${category.get(3)}" var="transaction">
								<span style="width:15%; height:20px; margin-left: 35px; float:left; overflow: hidden;">${transaction.transactionDate.format("MM/dd")}</span>
								<span style="width:50%; height:20px; margin-left: 20px; float:left; overflow: hidden;">${transaction.name}</span>
								<span style="width:20%; float:rihgt; text-align: right; margin-right: 15px;">
								   <g:formatNumber number="${transaction.amount * (-1)}" type="currency" currencyCode="USD"/>
								</span>
								<br/>
							</g:each> 
							<g:if test = "${category.get(3).size() > 5 }">
								</div>
							</g:if>
						</g:each>
						<br/>
					</g:each>
				</div>
			</div>
		</div>
	</div>
</body>
</html>