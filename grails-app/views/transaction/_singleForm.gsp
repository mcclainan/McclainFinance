<%@ page import="com.tracking.Transaction" %>

<g:hiddenField name="id" value="${transactionInstance.id}"/>
<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'transactionDate', 'error')} required">
	<label for="transactionDate">
		Date
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="transactionDate" precision="day"  value="${transactionInstance?.transactionDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="transaction.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="category.id" from="${com.category.Category.listOrderByName()}" optionKey="id" optionValue="name"/>
	
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="transaction.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${transactionInstance?.name}"/>
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

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'account', 'error')} required">
	<label for="account">
		<g:message code="transaction.account.label" default="Account" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="account" name="account.id" from="${com.tracking.Account.list()}" optionKey="id" required="" value="${transactionInstance?.account?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'assetLiability', 'error')} ">
	<label for="assetLiability">
		<g:message code="transaction.assetLiability.label" default="Asset Liability" />
		
	</label>
	<g:select id="assetLiability" name="assetLiability.id" from="${com.assetLiability.AssetLiability.list()}" optionKey="id" value="${transactionInstance?.assetLiability?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>





