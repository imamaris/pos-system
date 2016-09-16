<table class="listboxbaru">
     
	<tr class="boxheadbaru" valign="top">
		<td align="center" width="5%" nowrap><i18n:label code="GENERAL_NUMBER"/></td>
		<td align="center" nowrap>Item Number</td>
		<td align="center" nowrap>Description</td>    
                <td align="center" nowrap>Series</td>    
                <td align="center" nowrap><i18n:label code="GENERAL_QTY"/></td>
                <td align="center" nowrap>Gross</td>
                <td align="center" nowrap>Disc (%)</td>
                <td align="center" nowrap>Disc (Rp)</td>
		<td align="center" nowrap>Charge (<%= bean.getLocalCurrencySymbol() %>)</td>
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
		<td align="center"><%= i+1 %>.</td>
		<td nowrap ><%= skuCode %>  <br><%= itemSales[i].getProductSKU().equalsIgnoreCase("") ? "" : "SN.".concat(itemSales[i].getProductSKU())%></td>
		<td><%= product.getProductDescription().getName() %> </td>
                <td align="left" nowrap ><%= product.getProductseries() == null ? "" : product.getProductseries() %> </td>
                <td align="right" nowrap><%= qtyOrder %></td>
                <td align="right" nowrap><std:currencyformater code="" value="<%= ((qtyOrder * itemSales[i].getUnitPrice())) * itemSales[i].getBv1()  %>"/></td>
                <td align="center" nowrap><fmt:formatNumber type="number" maxIntegerDigits="2" value="<%= (itemSales[i].getUnitPrice() * itemSales[i].getBv1()) > 0 ? (((qtyOrder * itemSales[i].getUnitDiscount())/(qtyOrder * itemSales[i].getUnitPrice())) * itemSales[i].getBv1() * 100) : 0 %>" /></td>
                <td align="right" nowrap><std:currencyformater code="" value="<%= ((qtyOrder * itemSales[i].getUnitDiscount())) * itemSales[i].getBv1()  %>"/></td>
		<td align="right" nowrap><std:currencyformater code="" value="<%= ((qtyOrder * itemSales[i].getUnitPrice()) - (qtyOrder * itemSales[i].getUnitDiscount())) * itemSales[i].getBv1()  %>"/></td>
	</tr>	
<% 
	} // end for itemSales
%>
      

	<tr class=baru valign=top>
		<td class="td1 totalhead" colspan="8"><b>Total :</b>
		<td class="td1" align="right"><std:currencyformater code="" value="<%= bean.getBvSalesAmount() %>"/></td>
	</tr>

	<%
		if (bean.getDeliveryAmount() != 0) {
	%>   	
        <tr class=baru valign=top>
		<td class="td1 totalhead" colspan="8"><b>Deposit :</b>
		<td class="td1" align="right"><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>"/></td>
	</tr>
        
	<%
		}
	%>
        
	<%
		if (bean.getDiscountAmount() != 0) {
	%>               
        <tr class=baru valign=top>
		<td class="td1 totalhead" colspan="8"><b>Voucher Amount :</b>
		<td class="td1" align="right"><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>"/></td>
	</tr>

	<%
		}
	%>
        
        <%
		if (bean.getMgmtAmount() != 0) {
	%>	
	<tr class=baru valign=top>
		<td class="td1 totalhead" colspan="8"><b><i18n:label code="SALES_MGMT_FEE"/>:</b>
		<td class="td1" align="right"><std:currencyformater code="" value="<%= bean.getMgmtAmount() %>"/></td>
	</tr>
	
	<%
		}
	%>	
        
        
	<tr class=baru valign=top>
		<td class="td1 totalhead" colspan="8"><b>Payment:</b>
		<td class="td1" align="right"><std:currencyformater code="" value="<%= bean.getPaymentTender() %>"/></td>
	</tr>                
        <tr class=baru valign=top>
		<td class="td1 totalhead" colspan="8"><b>Balance :</b>
		<td class="td1" align="right"><std:currencyformater code="" value="<%= bean.getPaymentChange() %>"/></td>
	</tr>        
        
</table>



