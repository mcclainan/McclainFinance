<div class="calendarHead">
	<div class="calendarHeadCell">
		Sunday
	</div>
	<div class="calendarHeadCell">
		Monday
	</div>
	<div class="calendarHeadCell">
		Tuesday
	</div>
	<div class="calendarHeadCell">
		Wednesday
	</div>
	<div class="calendarHeadCell">
		Thursday
	</div>
	<div class="calendarHeadCell">
		Friday
	</div>
	<div class="calendarHeadCell">
		Saturday
	</div>
</div>
<div class="calendarBody">
	<g:each in="calendar" var="calendarRow">
		<div class="calendarRow">
			<g:each in="calendarRow" var="calendarCell">
				<div class="calendarCell">
					<div class="calendarCellHeader">
						${calendarCell.date}
					</div>
					<g:if test="${calendarCell.income}">
					</g:if>
					<g:if test="${calendarCell.expense}">
					</g:if>
					<g:if test="${calendarCell.balance}">
					</g:if>
				</div>
			</g:each>
		</div>
	</g:each>
</div>
