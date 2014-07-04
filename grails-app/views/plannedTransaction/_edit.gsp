<%@ page import="com.planning.PlannedTransaction"%>
<g:javascript library="prototype" />
<g:set var="entityName"
	value="${message(code: 'plannedTransaction.label', default: 'PlannedTransaction')}" />
<div id="dialogBoxHead">
	<h3>
		<g:message code="default.edit.label" args="[entityName]" />
	</h3>
</div>
<div id="dialogBoxBody">
	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<g:hasErrors bean="${plannedTransactionInstance}">
		<ul class="errors" role="alert">
			<g:eachError bean="${plannedTransactionInstance}" var="error">
				<li
					<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
						error="${error}" /></li>
			</g:eachError>
		</ul>
	</g:hasErrors>
	<g:if test="${flash.errors}">
		<ul class="errors" role="alert">
			<g:each in="${flash.errors}" var="error">
				<li>
					${error.value}
				</li>
			</g:each>
		</ul>
	</g:if>
	<g:form method="post">
		<g:hiddenField name="id" value="${plannedTransactionInstance?.id}" />
		<g:hiddenField name="version"
			value="${plannedTransactionInstance?.version}" />
		<fieldset class="form">
			<div
				class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'plannedTransactionDate', 'error')} required">
				<label for="plannedTransactionDate"> <g:message
						code="plannedTransaction.plannedTransactionDate.label"
						default="Planned Transaction Date" /> <span
					class="required-indicator">*</span>
				</label>
				<g:datePicker name="plannedTransactionDate" precision="day"
					value="${plannedTransactionInstance?.plannedTransactionDate}" />
			</div>

			<div
				class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'amount', 'error')} required">
				<label for="amount"> <g:message
						code="plannedTransaction.amount.label" default="Amount" /> <span
					class="required-indicator">*</span>
				</label>
				<g:field type="number" name="amount" step="any" required=""
					value="${plannedTransactionInstance.amount}" />
			</div>
			<div
				class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'exempt', 'error')} ">
				<label for="exempt"> <g:message
						code="plannedTransaction.exempt.label" default="Exempt" />

				</label>
				<g:select name="exempt"
					from="${plannedTransactionInstance.constraints.exempt.inList}"
					value="${plannedTransactionInstance?.exempt}"
					valueMessagePrefix="plannedTransaction.exempt"
					noSelection="['': '']" />
			</div>
			<div
				class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'rolling', 'error')} required">
				<label for="rolling"> <g:message
						code="plannedTransaction.rolling.label" default="Rolling" />
				</label>
				<g:select name="rolling"
					from="${plannedTransactionInstance.constraints.rolling.inList}"
					value="${plannedTransactionInstance?.rolling}"
					valueMessagePrefix="plannedTransaction.rolling"
					noSelection="['': '']" />
			</div>
		</fieldset>
		<fieldset class="buttons">
			<g:submitToRemote url="[action: 'update']" update="dialogBox"
				value="${message(code: 'default.button.update.label', default: 'Update')}"
				onclick="setRefresh('true')" />
			<g:submitToRemote url="[action: 'delete']" update="dialogBox"
				value="${message(code: 'default.button.delete.label', default: 'Delete')}"
				formnovalidate=""
				onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');setRefresh('true');" />
		</fieldset>
		<g:hiddenField name="remote" value="true" />
	</g:form>
</div>
<div id="dialogBoxFooter">
	<input type="button" value="Cancel"
		onclick="toggleDialogBoxVisibility('off');refreshPage();">
</div>

