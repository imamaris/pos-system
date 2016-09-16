<!-- Parties related -->

<%
	String fullShippingAddress = null;
	
	AddressBean shippingAddBean = doBean.getShippingAddressBean();
	
	if (shippingAddBean != null)
		fullShippingAddress = shippingAddBean.getFullMailAddress();
%>

<table>
	<tr>
		<td class="td1" width="110"><i18n:label code="DELIVERY_BY"/>:</td>
		<td><%= doBean.getShipByStoreCode() %></td>
	</tr>
	
	<%
		if (doBean.getShipOption() == CounterSalesManager.SHIP_TO_RECEIVER) {
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
		<td><%= CounterSalesManager.defineShippingOptionName(doBean.getShipOption()) %></td>
	</tr>	
	
	<%
		}
	%>
</table>	