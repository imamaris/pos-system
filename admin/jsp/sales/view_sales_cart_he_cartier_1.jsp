<table width="650" border="0" cellpadding="0" cellspacing="0">

<%
	int qtyOrder = 0;
	int qtyFoc = 0;
	String skuCode = "";
        String productCode = "";
	
	CounterSalesItemBean[] itemSales = bean.getItemArray();
	
	for (int i = 0; i < itemSales.length; i++) {
		
                /* diremark, ambil semua dari sales item ..
		ProductBean product = itemSales[i].getSkucode();
		
		if (itemSales[i].getProductType() == ProductManager.TYPE_SALESPRODUCT) {
			qtyFoc = 0;
			qtyOrder = itemSales[i].getQtyOrder();
			skuCode = product.getSkuCode();
                        productCode = product.getSkuCode();
			
		} else if (itemSales[i].getProductType() == ProductManager.TYPE_FOCPRODUCT) { 
			qtyFoc = itemSales[i].getQtyOrder();
			qtyOrder = 0;
			skuCode = product.getSkuCode() + " [FOC]";
		}
                
                */
%>
	
	  <tr class="baru" valign=top> 
		<td width="5%" nowrap align="center"><%= itemSales[i].getQtyOrder()%> </td>
		<td width="15%" nowrap ><%= itemSales[i].getProductCode()%></td>
                <td width="15%" nowrap ><%= itemSales[i].getProductCode().equalsIgnoreCase(itemSales[i].getProductSKU()) ? " - " : itemSales[i].getProductSKU() %></td>       
                <td width="20%"><%= itemSales[i].getProductDesc() %></td>
		<td width="16%" align="right" nowrap><std:currencyformater code="" value="<%= itemSales[i].getUnitNetPrice() %>"/></td>
	</tr>	
<% 
	} // end for itemSales
%>
       
   <tr>
      <td width="650" height="30" colspan="5"></td>
   </tr> 
        
	  <tr class="baru" valign=top> 
		<td align="right" colspan="4"><b>TOTAL </b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getBvSalesAmount() %>"/></td>
	</tr>

	<%
		if (bean.getDeliveryAmount() != 0) {
	%>   	
          <tr class="baru" valign=top> 
		<td align="right" colspan="4"><b>DEPOSIT </b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>"/></td>
	</tr>
        
	<%
		}
	%>
        
	<%
		if (bean.getDiscountAmount() != 0) {
	%>               
          <tr class="baru" valign=top> 
		<td align="right" colspan="4"><b>VOUCHER </b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>"/></td>
	</tr>

	<%
		}
	%>
        
        <%
		if (bean.getMgmtAmount() != 0) {
	%>	
	  <tr class="baru" valign=top> 
		<td align="right"  colspan="4"><b><i18n:label code="SALES_MGMT_FEE"/> :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getMgmtAmount() %>"/></td>
	</tr>
	
	<%
		}
	%>	
                     
        
</table>


