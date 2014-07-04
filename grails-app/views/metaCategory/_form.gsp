<%@ page import="com.category.MetaCategory" %>



<div class="fieldcontain ${hasErrors(bean: metaCategoryInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="metaCategory.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${metaCategoryInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: metaCategoryInstance, field: 'priority', 'error')} ">
	<label for="priority">
		<g:message code="metaCategory.priority.label" default="Priority" />
		
	</label>
	<g:textField name="priority" maxlength="1" value="${metaCategoryInstance?.priority}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: metaCategoryInstance, field: 'active', 'error')} ">
	<label for="active">
		<g:message code="metaCategory.active.label" default="Active" />
		
	</label>
	<g:select name="active" from="${metaCategoryInstance.constraints.active.inList}" value="${metaCategoryInstance?.active}" valueMessagePrefix="metaCategory.active" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: metaCategoryInstance, field: 'categories', 'error')} ">
	<label for="categories">
		<g:message code="metaCategory.categories.label" default="Categories" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${metaCategoryInstance?.categories?}" var="c">
    <li><g:link controller="category" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="category" action="create" params="['metaCategory.id': metaCategoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'category.label', default: 'Category')])}</g:link>
</li>
</ul>

</div>

