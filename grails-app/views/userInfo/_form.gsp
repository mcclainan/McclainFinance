<%@ page import="com.access.UserInfo" %>



<div class="fieldcontain ${hasErrors(bean: userInfoInstance, field: 'groups', 'error')} ">
	<label for="groups">
		<g:message code="userInfo.groups.label" default="Groups" />
		
	</label>
	
</div>

