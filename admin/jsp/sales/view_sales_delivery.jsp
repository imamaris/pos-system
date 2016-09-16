<!-- Trx related -->

<%
	String fullShippingAddress = null;
	
	AddressBean shippingAddBean = bean.getShippingAddressBean();
	
	if (shippingAddBean != null)
		fullShippingAddress = shippingAddBean.getFullMailAddress();
%>

<table>
	<tr>
		<td class="td1" width="110"><i18n:label code="DELIVERY_BY"/>:</td>
		<td><std:text value="<%= bean.getShipByStoreCode() %>"/></td>
	</tr>
	
	<%
		if (bean.getShipOption() == CounterSalesManager.SHIP_TO_RECEIVER) {
	%>
	
	<tr>
		<td class="td1"><i18n:label code="DELIVERY_SHIP_TO"/>:</td>
		<td valign="top"><%= fullShippingAddress != null ? fullShippingAddress.replaceAll("\n","<br>") : "-" %></td>
	</tr>
	
	<%
		} else {
	%>
	
	<tr>
		<td class="td1"><i18n:label code="DELIVERY_METHOD"/>:</td>
		<td><%= CounterSalesManager.defineShippingOptionName(bean.getShipOption()) %></td>
	</tr>	
	
	<%
		}
	%>
</table>
