<h3>Transactions</h3>
<table>
	<thead>
		<tr>

			<th>Date</th>

			<th>Category</th>

			<th>Amount</th>

			<th>Name</th>

		</tr>
	</thead>
	<tbody>
		<g:each in="${transactionInstanceList}" status="i"
			var="transactionInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}"
				onclick="showTransaction('${transactionInstance.transactionDate.format("MM-dd-yyyy")}','${transactionInstance.category.toString().replace("\'", "")}','${transactionInstance.amount}','${transactionInstance.name.replace("\'", "")}','${transactionInstance.id}')">

				<td><g:formatDate date="${transactionInstance.transactionDate}"
						format="MM-dd-yyyy" />
				<td>
					${transactionInstance.category}
				</td>

				<td><g:formatNumber number="${transactionInstance.amount}"
						type="currency" currencyCode="USD" />
				<td>
					<g:link action="edit" id="${transactionInstance.id}">
						${transactionInstance.name}
					</g:link>
				</td>
			</tr>
		</g:each>
		<g:if test="${selectList}">
			<tr>
				<td colspan="3">
					<g:javascript library="prototype" />
					<a action="singleTransactionForRecon" onclick="new Ajax.Updater('transactions','/MacFinance/transaction/singleTransactionForRecon/${bankRecord.id}',{asynchronous:true,evalScripts:true});return false;" href="/MacFinance/transaction/singleTransactionForRecon/${bankRecord.id}">
						Create Transaction for ${bankRecord.description}
					</a>
				</td>
			</tr>
		</g:if>
	</tbody>
</table>
<%----%>
