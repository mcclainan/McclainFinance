<%@ page import="com.access.UserGroup" %>



<div class="fieldcontain ${hasErrors(bean: userGroupInstance, field: 'users', 'error')} ">
	<label for="users">
		<g:message code="userGroup.users.label" default="Users" />
		
	</label>
	<g:select name="users" from="${com.access.UserInfo.list()}" multiple="multiple" optionKey="id" size="5" value="${userGroupInstance?.users*.id}" class="many-to-many"/>
</div>

