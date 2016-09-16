<!-- Trx related -->

<table>
	<tr>
		<td class="td1" width="80"><i18n:label code="PRICE_CODE"/>:</td>
		<td><std:text value="<%= bean.getPriceCode() %>"/></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="SALES_TRX_TYPE"/>:</td>
		<td><%= CounterSalesManager.defineTrxTypeName(bean.getTrxType()) %></td>
	</tr>
</table>
