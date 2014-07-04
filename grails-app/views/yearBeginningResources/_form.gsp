<%@ page import="com.planning.YearBeginningResources" %>



<div class="fieldcontain ${hasErrors(bean: yearBeginningResourcesInstance, field: 'year', 'error')} required">
	<label for="year">
		<g:message code="yearBeginningResources.year.label" default="Year" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="year" required="" value="${yearBeginningResourcesInstance.year}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: yearBeginningResourcesInstance, field: 'actualBenifits', 'error')} required">
	<label for="actualBenifits">
		<g:message code="yearBeginningResources.actualBenifits.label" default="Actual Benifits" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="actualBenifits" step="any" required="" value="${yearBeginningResourcesInstance.actualBenifits}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: yearBeginningResourcesInstance, field: 'actualCash', 'error')} required">
	<label for="actualCash">
		<g:message code="yearBeginningResources.actualCash.label" default="Actual Cash" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="actualCash" step="any" required="" value="${yearBeginningResourcesInstance.actualCash}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: yearBeginningResourcesInstance, field: 'actualCreditCard', 'error')} required">
	<label for="actualCreditCard">
		<g:message code="yearBeginningResources.actualCreditCard.label" default="Actual Credit Card" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="actualCreditCard" step="any" required="" value="${yearBeginningResourcesInstance.actualCreditCard}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: yearBeginningResourcesInstance, field: 'actualOther', 'error')} required">
	<label for="actualOther">
		<g:message code="yearBeginningResources.actualOther.label" default="Actual Other" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="actualOther" step="any" required="" value="${yearBeginningResourcesInstance.actualOther}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: yearBeginningResourcesInstance, field: 'budgetedBenifits', 'error')} required">
	<label for="budgetedBenifits">
		<g:message code="yearBeginningResources.budgetedBenifits.label" default="Budgeted Benifits" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="budgetedBenifits" step="any" required="" value="${yearBeginningResourcesInstance.budgetedBenifits}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: yearBeginningResourcesInstance, field: 'budgetedCash', 'error')} required">
	<label for="budgetedCash">
		<g:message code="yearBeginningResources.budgetedCash.label" default="Budgeted Cash" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="budgetedCash" step="any" required="" value="${yearBeginningResourcesInstance.budgetedCash}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: yearBeginningResourcesInstance, field: 'budgetedCreditCard', 'error')} required">
	<label for="budgetedCreditCard">
		<g:message code="yearBeginningResources.budgetedCreditCard.label" default="Budgeted Credit Card" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="budgetedCreditCard" step="any" required="" value="${yearBeginningResourcesInstance.budgetedCreditCard}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: yearBeginningResourcesInstance, field: 'budgetedOther', 'error')} required">
	<label for="budgetedOther">
		<g:message code="yearBeginningResources.budgetedOther.label" default="Budgeted Other" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="budgetedOther" step="any" required="" value="${yearBeginningResourcesInstance.budgetedOther}"/>
</div>

