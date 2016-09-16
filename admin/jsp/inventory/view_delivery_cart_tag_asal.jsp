<table class="listbox">
	<tr class=baru valign=top> 
		<td colspan="4" height="15" ></td>
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

	
	<%
		DeliveryProductBean[] dpb = itemDo[i].getProductArray();
		
		for (int j=0; j <dpb.length; j++) {
			
			ProductBean component = dpb[j].getProductBean();
	%>
	
	<tr class=baru valign=top > 
		<td align="center" width="5%"><%= i+1 %></td>
		<td nowrap width="15%"><%= component.getSkuCode()%></td>
		<td width="65%"><%= component.getProductDescription().getName() %></td>
		<td align="right" width="5%" ><%= dpb[j].getQty() %></td>
	</tr>	
	
	<% 		
			} // end for dpb
	%>
	
	<% 
		if ( i != itemDo.length - 1) {
	%> 
	
	<tr class=baru valign=top> 
		<td>&nbsp;</td>
	</tr>
	
	<% 		
		} // end if
	%>
	
	<% 		
		} // end for itemDo
	%>
</table>				
	



