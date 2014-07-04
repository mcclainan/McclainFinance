<%@ page import="com.planning.BudgetItem" %>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'year', 'error')} required">
	<label for="year">
		<g:message code="budgetItem.year.label" default="Year" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="year" from="[2011,2012,2013,2014,2015,2016]" value="${budgetItemInstance.year?:new Date().format('yyyy').toInteger()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'month', 'error')} required">
	<label for="month">
		<g:message code="budgetItem.month.label" default="Month" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="month" from="${application.monthNames}" optionKey="key" optionValue="value" value="${budgetItemInstance.month}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="budgetItem.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="category" name="category.id" from="${com.category.Category.list()}" optionKey="id" required="" value="${budgetItemInstance?.category?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="budgetItem.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="amount" step="any" required="" value="${budgetItemInstance.amount}"/>
</div>

<div class="fieldcontain">
	<label for="nuberOfMonths">
		Number of Months
	</label>
	<g:select name="numberOfMonths" from="${[1,2,3,4,5,6,7,8,9,10,11,12]}" value="${numberOfMonths}"/>
</div>
<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'cash', 'error')} ">
	<label for="cash">
		<g:message code="budgetItem.cash.label" default="Cash" />
		
	</label>
	<g:select name="cash" from="${budgetItemInstance.constraints.cash.inList}" value="${budgetItemInstance?.cash}" valueMessagePrefix="budgetItem.cash" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'plannedTransactions', 'error')} ">
	<label for="plannedTransactions">
		Add Planned Transactions
		
	</label>
	
<ul class="one-to-many">

<li class="add">
<g:checkBox name="addPlannedTransactions"/>
</li>
</ul>

</div>



