<table class="listbox">
	<tr class="boxhead" valign="top">
		<td width="5%" nowrap align="center"><i18n:label code="GENERAL_NUMBER"/></td>
		<td nowrap align="center"><i18n:label code="PRODUCT_SKU_CODE"/></td>
		<td nowrap align="center"><i18n:label code="PRODUCT_NAME"/></td>
		<td width="12%" align="center">Qty</td>
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
                        
                    if(component.getProductSelling().equalsIgnoreCase("Y"))    
                       { 
	%>
	
        <tr class="<%= ((i+1) % 2 == 0) ? "even" : "odd" %>" valign=top>
		<td align="center" ><%= i+1 %></td>
		<td nowrap><%= component.getProductCode() %></td>
		<td><%= component.getProductDescription().getName() %></td>
		<td align="center"><%= dpb[j].getQty() %></td>
	</tr>	
	
	<% 		
                        } // end getProductSelling                                                
			} // end for dpb            
	%>
        
	<% 		
		} // end for itemDo
	%>
        
        <tr class="boxhead" valign="top">
		<td align="left" colspan="4" >KIT Detail</td>
	</tr>
        
<%
	String skuCode1 = "";
        int nomor = 0;
	
	DeliveryItemBean[] itemDo1 = doBean.getItemArray();
	
	for (int i = 0; i < itemDo1.length; i++) {
		
		ProductBean product1 = itemDo1[i].getProductBean();
		
		skuCode1 = product1.getSkuCode() + " - " + product1.getProductDescription().getName();
		
		if (itemDo1[i].getProductType() == ProductManager.TYPE_FOCPRODUCT)
			skuCode1 += " [FOC]";
%>        
        
	<%
		DeliveryProductBean[] dpb_k = itemDo1[i].getProductArray();
		
		for (int m=0; m <dpb_k.length; m++) {
			
			ProductBean component_k = dpb_k[m].getProductBean();
                                             
                    if(component_k.getProductSelling().equalsIgnoreCase("N"))    
                       {
                       nomor ++;     
	%>
	
        <tr class="<%= ((i+1) % 2 == 0) ? "even" : "odd" %>" valign=top>
		<td align="center" ><%= nomor %></td>
		<td nowrap><%= component_k.getProductCode() %></td>
		<td><%= component_k.getProductDescription().getName() %></td>
		<td align="center"><%= dpb_k[m].getQty() %></td>
	</tr>	
	
	<% 		
                        } // end getProductSelling
			} // end for dpb_k            
	%>        
                
        
	<% 		
		} // end for itemDo
	%>
        
        
        
        
        
        
</table>				
	



