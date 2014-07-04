
<%@ page import="com.category.MetaCategory"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="recordMaint">
<g:set var="entityName"
	value="${message(code: 'metaCategory.label', default: 'MetaCategory')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<h1>
				<g:message code="default.show.label" args="[entityName]" />
			</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">
					${flash.message}
				</div>
			</g:if>
			<ol class="property-list metaCategory">

				<g:if test="${metaCategoryInstance?.name}">
					<li class="fieldcontain"><span id="name-label"
						class="property-label"><g:message
								code="metaCategory.name.label" default="Name" /></span> <span
						class="property-value" aria-labelledby="name-label"><g:fieldValue
								bean="${metaCategoryInstance}" field="name" /></span></li>
				</g:if>

				<g:if test="${metaCategoryInstance?.priority}">
					<li class="fieldcontain"><span id="priority-label"
						class="property-label"><g:message
								code="metaCategory.priority.label" default="Priority" /></span> <span
						class="property-value" aria-labelledby="priority-label"><g:fieldValue
								bean="${metaCategoryInstance}" field="priority" /></span></li>
				</g:if>

				<g:if test="${metaCategoryInstance?.active}">
					<li class="fieldcontain"><span id="active-label"
						class="property-label"><g:message
								code="metaCategory.active.label" default="Active" /></span> <span
						class="property-value" aria-labelledby="active-label"><g:fieldValue
								bean="${metaCategoryInstance}" field="active" /></span></li>
				</g:if>

				<g:if test="${metaCategoryInstance?.categories}">
					<li class="fieldcontain"><span id="categories-label"
						class="property-label"><g:message
								code="metaCategory.categories.label" default="Categories" /></span> <g:each
							in="${metaCategoryInstance.categories}" var="c">
							<span class="property-value" aria-labelledby="categories-label"><g:link
									controller="category" action="show" id="${c.id}">
									${c?.encodeAsHTML()}
								</g:link></span>
						</g:each></li>
				</g:if>

			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${metaCategoryInstance?.id}" />
					<g:link class="edit" action="edit" id="${metaCategoryInstance?.id}">
						<g:message code="default.button.edit.label" default="Edit" />
					</g:link>
				</fieldset>
			</g:form>
		</div>
	</div>
</body>
</html>