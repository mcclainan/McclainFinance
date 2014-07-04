<%@ page import="com.assetLiability.AssetLiability" %>



<div class="fieldcontain ${hasErrors(bean: assetLiabilityInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="assetLiability.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${assetLiabilityInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="assetLiability.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${assetLiabilityInstance.constraints.type.inList}" required="" value="${assetLiabilityInstance?.type}" valueMessagePrefix="assetLiability.type"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityInstance, field: 'assetLiabilityClass', 'error')} required">
	<label for="assetLiabilityClass">
		<g:message code="assetLiability.assetLiabilityClass.label" default="Asset Liability Class" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="assetLiabilityClass" name="assetLiabilityClass.id" from="${com.assetLiability.AssetLiabilityClass.list()}" optionKey="id" required="" value="${assetLiabilityInstance?.assetLiabilityClass?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityInstance, field: 'value', 'error')} required">
	<label for="value">
		<g:message code="assetLiability.value.label" default="Value" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="value" step="any" required="" value="${assetLiabilityInstance.value}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityInstance, field: 'active', 'error')} required">
	<label for="active">
		<g:message code="assetLiability.active.label" default="Active" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="active" from="${assetLiabilityInstance.constraints.active.inList}" required="" value="${assetLiabilityInstance?.active}" valueMessagePrefix="assetLiability.active"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityInstance, field: 'account', 'error')} ">
	<label for="account">
		<g:message code="assetLiability.account.label" default="Account" />
		
	</label>
	<g:select id="account" name="account.id" from="${com.tracking.Account.list()}" optionKey="id" value="${assetLiabilityInstance?.account?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityInstance, field: 'interestRate', 'error')} ">
	<label for="interestRate">
		<g:message code="assetLiability.interestRate.label" default="Interest Rate" />
		
	</label>
	<g:field type="number" name="interestRate" step="any" value="${assetLiabilityInstance.interestRate}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityInstance, field: 'creditLimit', 'error')} ">
	<label for="creditLimit">
		<g:message code="assetLiability.creditLimit.label" default="Credit Limit" />
		
	</label>
	<g:field type="number" name="creditLimit" step="any" value="${assetLiabilityInstance.creditLimit}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityInstance, field: 'transactions', 'error')} ">
	<label for="transactions">
		<g:message code="assetLiability.transactions.label" default="Transactions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${assetLiabilityInstance?.transactions?}" var="t">
    <li><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="transaction" action="create" params="['assetLiability.id': assetLiabilityInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'transaction.label', default: 'Transaction')])}</g:link>
</li>
</ul>

</div>

