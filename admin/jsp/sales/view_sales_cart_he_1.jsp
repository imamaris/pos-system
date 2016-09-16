<table class="listbox">
	<tr class="boxhead" valign="top">
		<td width="5%" nowrap><i18n:label code="GENERAL_NUMBER"/></td>
		<td width="15%" nowrap>Item Number</td>
		<td nowrap>Description</td>
		<td width="16%" align="right">Charge (<%= bean.getLocalCurrencySymbol() %>)</td>
	</tr>

<%
	int qtyOrder = 0;
	int qtyFoc = 0;
	String skuCode = "";
	
	CounterSalesItemBean[] itemSales = bean.getItemArray();
	
	for (int i = 0; i < itemSales.length; i++) {
		
		ProductBean product = itemSales[i].getProductBean();
		
		if (itemSales[i].getProductType() == ProductManager.TYPE_SALESPRODUCT) {
			qtyFoc = 0;
			qtyOrder = itemSales[i].getQtyOrder();
			skuCode = product.getSkuCode();
			
		} else if (itemSales[i].getProductType() == ProductManager.TYPE_FOCPRODUCT) { 
			qtyFoc = itemSales[i].getQtyOrder();
			qtyOrder = 0;
			skuCode = product.getSkuCode() + " [FOC]";
		}
%>
	
	<tr class="<%= ((i+1) % 2 == 0) ? "even" : "odd" %>" valign=top>
		<td align="right"><%= i+1 %>.</td>
		<td nowrap ><%= product.getProductCode()%> <br>SN : <%= skuCode %></td>
		<td><%= product.getProductDescription().getName() %></td>
		<td align="right"><std:currencyformater code="" value="<%= qtyOrder * itemSales[i].getUnitPrice() * itemSales[i].getBv1() - itemSales[i].getUnitDiscount() %>"/></td>
	</tr>	
<% 
	} // end for itemSales
%>
       
<br><br>
        
	<tr>
		<td align="right" colspan="3"><b>Total :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getBvSalesAmount() %>"/></td>
	</tr>

	<%
		if (bean.getDeliveryAmount() != 0) {
	%>   	
        <tr>
		<td align="right" colspan="3"><b>Deposit :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>"/></td>
	</tr>
        
	<%
		}
	%>
        
	<%
		if (bean.getDiscountAmount() != 0) {
	%>               
        <tr>
		<td align="right" colspan="3"><b>Voucher Amount :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>"/></td>
	</tr>

	<%
		}
	%>
        
        <%
		if (bean.getMgmtAmount() != 0) {
	%>	
	<tr>
		<td align="right"  colspan="3"><b><i18n:label code="SALES_MGMT_FEE"/> :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getMgmtAmount() %>"/></td>
	</tr>
	
	<%
		}
	%>	
        
        
	<tr>
		<td align="right"  colspan="3"><b>Payment :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getPaymentTender() %>"/></td>
	</tr>                
        <tr>
		<td align="right"  colspan="3"><b>Balance :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getPaymentChange() %>"/></td>
	</tr>        
        
</table>



