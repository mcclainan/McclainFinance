<%@ page import="com.planning.PlannedTransaction" %>
<g:javascript library="prototype" />
<div id="dialogBoxHead">
	<h3><g:formatDate date="${date}" format="MMM-dd-yyyy"/> Planned Transactions</h3>
</div>
<div id="dialogBoxBody">
	<table>
		<thead>
			<tr class="rowH">
				
				<th></th>
				
				<th>amount</th>
			
				<th>Category</th>
				
				<th>Income/Expense</th>
			
			</tr>
		</thead>
		<tbody>
		<g:each in="${plannedTransactionInstanceList}" status="i" var="plannedTransactionInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				
				<td>
					<g:remoteLink controller="plannedTransaction" action="edit"  params="[remote:'true',id:plannedTransactionInstance.id]" update="dialogBox">edit</g:remoteLink>
				</td>
			
				<td>${fieldValue(bean: plannedTransactionInstance, field: "amount")}</td>
	
				<td>${plannedTransactionInstance.category.name}</td>
			
				<td>${plannedTransactionInstance.category.type}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
</div>
<div id="dialogBoxFooter">
	<input type="button" value="Done" onclick="toggleDialogBoxVisibility('off');refreshPage();">
</div>
			