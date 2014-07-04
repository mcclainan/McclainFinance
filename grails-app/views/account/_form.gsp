<%@ page import="com.tracking.Account" %>



<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'interestRate', 'error')} ">
	<label for="interestRate">
		<g:message code="account.interestRate.label" default="Interest Rate" />
		
	</label>
	<g:field type="number" name="interestRate" step="any" value="${accountInstance.interestRate}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'active', 'error')} ">
	<label for="active">
		<g:message code="account.active.label" default="Active" />
		
	</label>
	<g:select name="active" from="${accountInstance.constraints.active.inList}" value="${accountInstance?.active}" valueMessagePrefix="account.active" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'cash', 'error')} ">
	<label for="cash">
		<g:message code="account.cash.label" default="Cash" />
		
	</label>
	<g:select name="cash" from="${accountInstance.constraints.cash.inList}" value="${accountInstance?.cash}" valueMessagePrefix="account.cash" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'assetLiability', 'error')} ">
	<label for="assetLiability">
		<g:message code="account.assetLiability.label" default="Asset Liability" />
		
	</label>
	<g:select id="assetLiability" name="assetLiability.id" from="${com.assetLiability.AssetLiability.list()}" optionKey="id" value="${accountInstance?.assetLiability?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'balance', 'error')} required">
	<label for="balance">
		<g:message code="account.balance.label" default="Balance" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="balance" step="any" required="" value="${accountInstance.balance}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="account.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${accountInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'transactions', 'error')} ">
	<label for="transactions">
		<g:message code="account.transactions.label" default="Transactions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${accountInstance?.transactions?}" var="t">
    <li><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="transaction" action="create" params="['account.id': accountInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'transaction.label', default: 'Transaction')])}</g:link>
</li>
</ul>

</div>

