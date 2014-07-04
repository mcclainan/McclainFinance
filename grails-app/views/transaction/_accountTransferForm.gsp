<%@ page import="com.tracking.Transaction" %>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'transactionDate', 'error')} required">
	<label for="transactionDate">
		<g:message code="transaction.transactionDate.label" default="Transaction Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="transactionDate" precision="day"  value="${transactionInstance?.transactionDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="transaction.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${transactionInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'account', 'error')} required">
	<label for="account">
		From
		<span class="required-indicator">*</span>
	</label>
	<g:select id="fromAccountId" name="fromAccountId" from="${com.tracking.Account.list()}" optionKey="id" required="" value="${transactionInstance?.account?.id}" class="many-to-one"/>
</div>
<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'account', 'error')} required">
	<label for="account">
		To
		<span class="required-indicator">*</span>
	</label>
	<g:select id="toAccountId" name="toAccountId" from="${com.tracking.Account.list()}" optionKey="id" required="" value="${transactionInstance?.account?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="transaction.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="amount" step="any" required="" value="${transactionInstance.amount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'notes', 'error')} ">
	<label for="notes">
		<g:message code="transaction.notes.label" default="Notes" />
		
	</label>
	<g:textArea name="notes" cols="40" rows="5" maxlength="255" value="${transactionInstance?.notes}"/>
</div>
<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'notes', 'error')} ">
	<label>
		Transfer Fee
	</label>
	<g:textField name="transferFee" cols="40" rows="5" maxlength="255" value="${transferFee}"/>
</div>










