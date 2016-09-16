<table class="listbox">
	<tr class="boxhead" valign="top">
		<td width="5%" nowrap><i18n:label code="GENERAL_NUMBER"/></td>
		<td width="15%" nowrap>Item Code</td>
		<td nowrap><i18n:label code="PRODUCT_NAME"/></td>
		<td nowrap>Serial Number</td>
                <td width="8%" align="center" width="10%" nowrap><i18n:label code="GENERAL_QTY"/></td>
		<td width="16%" align="right"><i18n:label code="GENERAL_TOTAL_AMOUNT"/><br>(<%= bean.getLocalCurrencySymbol() %>)</td>
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
		<td><%= skuCode %></td>
		<td><%= product.getProductDescription().getName() %></td>
                <td><%= product.getProductCode() %></td>
		<td align="right"><%= qtyOrder %></td>
		<td align="right"><std:currencyformater code="" value="<%= qtyOrder * itemSales[i].getUnitPrice() * itemSales[i].getBv1() - itemSales[i].getUnitDiscount() %>"/></td>
	</tr>	
<% 
	} // end for itemSales
%>
       
<br>
        
	<tr>
		<td class="td1 totalhead" colspan="5"><b>Net Sales :</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getBvSalesAmount() %>"/></td>
	</tr>

	<%
		if (bean.getDeliveryAmount() != 0) {
	%>   	
        <tr>
		<td class="td1 totalhead" colspan="5"><b>Deposit :</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>"/></td>
	</tr>
        
	<%
		}
	%>
        
	<%
		if (bean.getDiscountAmount() != 0) {
	%>               
        <tr>
		<td class="td1 totalhead" colspan="5"><b>Voucher Amount :</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>"/></td>
	</tr>
        
        <tr>
		<td class="td1 totalhead" colspan="5"><b><i18n:label code="GENERAL_NET_TOTAL"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getNetSalesAmount() %>"/></td>
	</tr>        
	
	<%
		}
	%>
        
        <%
		if (bean.getMgmtAmount() != 0) {
	%>	
	<tr>
		<td class="td1 totalhead" colspan="5"><b><i18n:label code="SALES_MGMT_FEE"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getMgmtAmount() %>"/></td>
	</tr>
	
	<%
		}
	%>	
        

        <%
		if (bean.getPaymentChange() != 0) {
	%>        
        
        
	<tr>
		<td class="td1 totalhead" colspan="5"><b><i18n:label code="SALES_PAYMENT_RECEIVED"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getPaymentTender() %>"/></td>
	</tr>        
        
        <tr>
		<td class="td1 totalhead" colspan="5"><b>Balance :</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getPaymentChange() %>"/></td>
	</tr>
        
	<%
		}
	%>        
        
</table>



