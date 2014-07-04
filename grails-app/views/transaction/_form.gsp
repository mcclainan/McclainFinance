<%@ page import="com.tracking.Transaction" %>



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

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'budgetItem', 'error')} ">
	<label for="budgetItem">
		<g:message code="transaction.budgetItem.label" default="Budget Item" />
		
	</label>
	<g:select id="budgetItem" name="budgetItem.id" from="${com.planning.BudgetItem.list()}" optionKey="id" value="${transactionInstance?.budgetItem?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'combinationId', 'error')} ">
	<label for="combinationId">
		<g:message code="transaction.combinationId.label" default="Combination Id" />
		
	</label>
	<g:textField name="combinationId" value="${transactionInstance?.combinationId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'active', 'error')} required">
	<label for="active">
		<g:message code="transaction.active.label" default="Active" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="active" required="" value="${transactionInstance?.active}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'verified', 'error')} ">
	<label for="verified">
		<g:message code="transaction.verified.label" default="Verified" />
		
	</label>
	<g:select name="verified" from="${transactionInstance.constraints.verified.inList}" value="${transactionInstance?.verified}" valueMessagePrefix="transaction.verified" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'created', 'error')} required">
	<label for="created">
		<g:message code="transaction.created.label" default="Created" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="created" precision="day"  value="${transactionInstance?.created}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'transactionDate', 'error')} required">
	<label for="transactionDate">
		<g:message code="transaction.transactionDate.label" default="Transaction Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="transactionDate" precision="day"  value="${transactionInstance?.transactionDate}"  />
</div>

