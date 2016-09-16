<!-- Parties related -->

<table>
	<tr>
		<td class="td1" width="80">Boutique:</td>
		<td><std:text value="<%= bean.getSellerID() %>"/></td>
	</tr>
	
	<%
		if (bean.getCustomerID() != null && bean.getCustomerID().length() > 0) {
	%>
	
	<tr>
		<td class="td1"><i18n:label code="GENERAL_ID"/>:</td>
		<td><std:text value="<%= bean.getCustomerID() %>"/></td>
	</tr>
	
	<%
		}
	%>

	<tr>
		<td class="td1"><i18n:label code="GENERAL_NAME"/>:</td>
		<td><std:text value="<%= bean.getCustomerName() %>"/></td>
	</tr>
	<tr>
		<td class="td1" valign="top"><i18n:label code="GENERAL_CONTACTS"/>:</td>
		<td><%= bean.getCustomerContact() != null ? bean.getCustomerContact().replaceAll("\n", "<br>") : "-" %></td>
	</tr>
         
    
</table>	