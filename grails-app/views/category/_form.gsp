<%@ page import="com.category.Category" %>



<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="category.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${categoryInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'priority', 'error')} ">
	<label for="priority">
		<g:message code="category.priority.label" default="Priority" />
		
	</label>
	<g:textField name="priority" maxlength="1" value="${categoryInstance?.priority}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'cash', 'error')} required">
	<label for="cash">
		<g:message code="category.cash.label" default="Cash" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="cash" from="${categoryInstance.constraints.cash.inList}" required="" value="${categoryInstance?.cash}" valueMessagePrefix="category.cash"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="category.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${categoryInstance.constraints.type.inList}" required="" value="${categoryInstance?.type}" valueMessagePrefix="category.type"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'active', 'error')} required">
	<label for="active">
		<g:message code="category.active.label" default="Active" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="active" from="${categoryInstance.constraints.active.inList}" required="" value="${categoryInstance?.active}" valueMessagePrefix="category.active"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'budgetItems', 'error')} ">
	<label for="budgetItems">
		<g:message code="category.budgetItems.label" default="Budget Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${categoryInstance?.budgetItems?}" var="b">
    <li><g:link controller="budgetItem" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="budgetItem" action="create" params="['category.id': categoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'budgetItem.label', default: 'BudgetItem')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'metaCategory', 'error')} required">
	<label for="metaCategory">
		<g:message code="category.metaCategory.label" default="Meta Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="metaCategory" name="metaCategory.id" from="${com.category.MetaCategory.list()}" optionKey="id" required="" value="${categoryInstance?.metaCategory?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'plannedTransactions', 'error')} ">
	<label for="plannedTransactions">
		<g:message code="category.plannedTransactions.label" default="Planned Transactions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${categoryInstance?.plannedTransactions?}" var="p">
    <li><g:link controller="plannedTransaction" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="plannedTransaction" action="create" params="['category.id': categoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'plannedTransaction.label', default: 'PlannedTransaction')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'transactions', 'error')} ">
	<label for="transactions">
		<g:message code="category.transactions.label" default="Transactions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${categoryInstance?.transactions?}" var="t">
    <li><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="transaction" action="create" params="['category.id': categoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'transaction.label', default: 'Transaction')])}</g:link>
</li>
</ul>

</div>

