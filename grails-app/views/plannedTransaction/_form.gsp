<%@ page import="com.planning.PlannedTransaction" %>



<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'plannedTransactionDate', 'error')} required">
	<label for="plannedTransactionDate">
		<g:message code="plannedTransaction.plannedTransactionDate.label" default="Planned Transaction Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="plannedTransactionDate" precision="day"  value="${plannedTransactionInstance?.plannedTransactionDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="plannedTransaction.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="amount" step="any" required="" value="${plannedTransactionInstance.amount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'cash', 'error')} ">
	<label for="cash">
		<g:message code="plannedTransaction.cash.label" default="Cash" />
		
	</label>
	<g:select name="cash" from="${plannedTransactionInstance.constraints.cash.inList}" value="${plannedTransactionInstance?.cash}" valueMessagePrefix="plannedTransaction.cash" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'exempt', 'error')} ">
	<label for="exempt">
		<g:message code="plannedTransaction.exempt.label" default="Exempt" />
		
	</label>
	<g:select name="exempt" from="${plannedTransactionInstance.constraints.exempt.inList}" value="${plannedTransactionInstance?.exempt}" valueMessagePrefix="plannedTransaction.exempt" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'budgetItem', 'error')} required">
	<label for="budgetItem">
		<g:message code="plannedTransaction.budgetItem.label" default="Budget Item" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="budgetItem" name="budgetItem.id" from="${com.planning.BudgetItem.list()}" optionKey="id" required="" value="${plannedTransactionInstance?.budgetItem?.id}" class="many-to-one"/>
</div>

