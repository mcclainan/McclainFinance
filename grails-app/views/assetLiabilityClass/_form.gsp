<%@ page import="com.assetLiability.AssetLiabilityClass" %>



<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="assetLiabilityClass.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${assetLiabilityClassInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onSale', 'error')} required">
	<label for="onSale">
		<g:message code="assetLiabilityClass.onSale.label" default="On Sale" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="onSale" required="" value="${assetLiabilityClassInstance.onSale}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onPurchase', 'error')} required">
	<label for="onPurchase">
		<g:message code="assetLiabilityClass.onPurchase.label" default="On Purchase" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="onPurchase" required="" value="${assetLiabilityClassInstance.onPurchase}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onProceedes', 'error')} required">
	<label for="onProceedes">
		<g:message code="assetLiabilityClass.onProceedes.label" default="On Proceedes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="onProceedes" required="" value="${assetLiabilityClassInstance.onProceedes}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onPayment', 'error')} required">
	<label for="onPayment">
		<g:message code="assetLiabilityClass.onPayment.label" default="On Payment" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="onPayment" required="" value="${assetLiabilityClassInstance.onPayment}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onInterest', 'error')} required">
	<label for="onInterest">
		<g:message code="assetLiabilityClass.onInterest.label" default="On Interest" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="onInterest" required="" value="${assetLiabilityClassInstance.onInterest}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onAppreciation', 'error')} required">
	<label for="onAppreciation">
		<g:message code="assetLiabilityClass.onAppreciation.label" default="On Appreciation" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="onAppreciation" required="" value="${assetLiabilityClassInstance.onAppreciation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onDepreciation', 'error')} required">
	<label for="onDepreciation">
		<g:message code="assetLiabilityClass.onDepreciation.label" default="On Depreciation" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="onDepreciation" required="" value="${assetLiabilityClassInstance.onDepreciation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onUse', 'error')} required">
	<label for="onUse">
		<g:message code="assetLiabilityClass.onUse.label" default="On Use" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="onUse" required="" value="${assetLiabilityClassInstance.onUse}"/>
</div>

