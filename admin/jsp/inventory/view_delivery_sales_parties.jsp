<!-- Parties related -->

<table>
	<tr>
		<td class="td1" width="80"><i18n:label code="SALES_COUNTER"/>:</td>
		<td><%= bean.getSellerID() %></td>
	</tr>
	
	<%
		if (doBean.getCustomerID() != null && doBean.getCustomerID().length() > 0) {
	%>
	
	<tr>
		<td class="td1"><i18n:label code="GENERAL_ID"/>:</td>
		<td><std:text value="<%= doBean.getCustomerID() %>"/></td>
	</tr>
	
	<%
		}
	%>
	
	<tr>
		<td class="td1"><i18n:label code="GENERAL_TYPE"/>:</td>
		<td><std:text value="<%= doBean.getCustomerType() %>"/></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="GENERAL_NAME"/>:</td>
		<td><std:text value="<%= bean.getCustomerName() %>"/></td>
	</tr>
	<tr>
		<td class="td1" valign="top"><i18n:label code="GENERAL_CONTACTS"/>:</td>
		<td><%= doBean.getCustomerContact() != null ? doBean.getCustomerContact().replaceAll("\n", "<br>") : "-" %></td>
	</tr>
</table>	