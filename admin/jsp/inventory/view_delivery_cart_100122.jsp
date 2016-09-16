<table class="listbox">
	<tr class="boxhead" valign="top">
		<td width="5%" nowrap><i18n:label code="GENERAL_NUMBER"/></td>
		<td width="15%" nowrap><i18n:label code="PRODUCT_SKU_CODE"/></td>
		<td nowrap><i18n:label code="PRODUCT_NAME"/></td>
		<td width="12%" align="right"><i18n:label code="DELIVERY_QTY_ISSUE"/></td>
	</tr>

<%
	String skuCode = "";
	
	DeliveryItemBean[] itemDo = doBean.getItemArray();
	
	for (int i = 0; i < itemDo.length; i++) {
		
		ProductBean product = itemDo[i].getProductBean();
		
		skuCode = product.getSkuCode() + " - " + product.getProductDescription().getName();
		
		if (itemDo[i].getProductType() == ProductManager.TYPE_FOCPRODUCT)
			skuCode += " [FOC]";
%>

	<tr class="odd" valign="top">
		<td><%= (i+1) %></td>
	  <td colspan=3><u><%= skuCode %></u></td>
	</tr>
	
	<%
		DeliveryProductBean[] dpb = itemDo[i].getProductArray();
		
		for (int j=0; j <dpb.length; j++) {
			
			ProductBean component = dpb[j].getProductBean();
	%>
	
	<tr class="even" valign=top>
		<td><%= i+1 %>.<%= j %></td>
		<td><%= component.getProductCode() %></td>
		<td><%= component.getProductDescription().getName() %></td>
		<td align="right"><%= dpb[j].getQty() %></td>
	</tr>	
	
	<% 		
			} // end for dpb
	%>
	
	<% 
		if ( i != itemDo.length - 1) {
	%> 
	
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<% 		
		} // end if
	%>
	
	<% 		
		} // end for itemDo
	%>
</table>				
	



