<%@ page import="com.tracking.BankRecord" %>



<div class="fieldcontain ${hasErrors(bean: bankRecordInstance, field: 'account', 'error')} required">
	<label for="account">
		<g:message code="bankRecord.account.label" default="Account" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="account" name="account.id" from="${com.tracking.Account.list()}" optionKey="id" required="" value="${bankRecordInstance?.account?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bankRecordInstance, field: 'transactionDate', 'error')} required">
	<label for="transactionDate">
		<g:message code="bankRecord.transactionDate.label" default="Transaction Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="transactionDate" precision="day"  value="${bankRecordInstance?.transactionDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: bankRecordInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="bankRecord.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${bankRecordInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bankRecordInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="bankRecord.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="amount" step="any" required="" value="${bankRecordInstance.amount}"/>
</div>

