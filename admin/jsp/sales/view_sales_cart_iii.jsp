<%@page import="com.ecosmosis.mvc.sys.SystemConstant"%>
<%@page import="com.ecosmosis.orca.counter.sales.CounterSalesManager"%>
<% 
	CounterSalesManager counter = new CounterSalesManager();
%>
<table class="listbox">
	<tr class="boxhead" valign="top">
		<td width="5%" nowrap><i18n:label code="GENERAL_NUMBER"/></td>
		<td width="15%" nowrap><i18n:label code="PRODUCT_SKU_CODE"/></td>
		<td nowrap><i18n:label code="PRODUCT_NAME"/></td>
		<!--td width="8%" align="right" width="10%" nowrap><i18n:label code="PRODUCT_UNIT_PV"/></td-->
		<td width="12%" align="right" width="10%" nowrap><i18n:label code="PRODUCT_UNIT_PRICE"/><br>(<%= bean.getLocalCurrencySymbol() %>)</td>
		<td width="8%" align="center" width="10%" nowrap><i18n:label code="GENERAL_QTY"/></td>
		<td width="8%" align="center" width="10%" nowrap><i18n:label code="GENERAL_QTYFOC"/></td>
		<!-- td width="12%" align="right"><i18n:label code="GENERAL_TOTAL"/> PV</td-->
		<td width="12%" align="right"><i18n:label code="GENERAL_TOTAL_AMOUNT"/><br>(<%= bean.getLocalCurrencySymbol() %>)</td>
	</tr>

<%
	int qtyOrder = 0;
	int qtyFoc = 0;
	int count = 0;

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
		
		double unitType = counter.getTypeUnit(product.getSkuCode(), itemSales[i].getUnitPrice(), itemSales[i].getBv1(), 3);
		
		if(unitType == 0)
			continue; 
%>
	
	<tr class="<%= ((++count) % 2 == 0) ? "even" : "odd" %>" valign=top>
		<td align="right"><%= count %>.</td>
		<td><%= skuCode %></td>
		<td><%= product.getProductDescription().getName() %></td>
		<!--td align="right"><std:bvformater value="<%= itemSales[i].getBv1() %>"/></td-->
		<td align="right"><std:currencyformater code="" value="<%= unitType %>"/></td>
		<td align="right"><%= qtyOrder %></td>
		<td align="right"><%= qtyFoc %></td>
		<!--td align="right"><std:bvformater value="<%= qtyOrder * itemSales[i].getBv1() %>"/></td-->
		<td align="right"><std:currencyformater code="" value="<%= qtyOrder * unitType %>"/></td>
	</tr>	
<% 
	} // end for itemSales
%>

	<!--tr>
		<td class="td1 totalhead" colspan="8"><b><i18n:label code="GENERAL_TOTAL"/> PV:</b>
		<td class="td1"><std:bvformater value="<%= bean.getTotalBv1() %>"/></td>
	</tr-->
	<!--tr>
		<td class="td1 totalhead" colspan="8"><b><i18n:label code="GENERAL_GROSS"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getNonBvSalesAmount() + (bean.getBvSalesAmount() * SystemConstant.TYPE_III) %>"/></td>
	</tr>
	<tr>
		<td class="td1 totalhead" colspan="8"><b><i18n:label code="SALES_DELIVERY_AMOUNT"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>"/></td>
	</tr>
	<tr>
		<td class="td1 totalhead" colspan="8"><b><i18n:label code="SALES_DISCOUNT_AMOUNT"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>"/></td>
	</tr>
	
	<%
		if (bean.getMgmtAmount() != 0) {
	%>	
	<tr>
		<td class="td1 totalhead" colspan="8"><b><i18n:label code="SALES_MGMT_FEE"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getMgmtAmount() %>"/></td>
	</tr>
	
	<%
		}
	%>	
	<tr>
		<td class="td1 totalhead" colspan="8"><b><i18n:label code="GENERAL_NET_TOTAL"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getNetSalesAmount() %>"/></td>
	</tr -->
	<tr>
		<td class="td1 totalhead" colspan="6"><b><i18n:label code="GENERAL_NET_TOTAL"/> :</b>
		<td class="td1 totalhead"><b><std:currencyformater code="" value="<%= bean.getCorpSalesAmount() %>"/></b></td>
	</tr>
	<!-- tr>
		<td class="td1 totalhead" colspan="8"><b><i18n:label code="SALES_PAYMENT_RECEIVED"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getPaymentTender() %>"/></td>
	</tr>
	<tr>
		<td class="td1 totalhead" colspan="8"><b><i18n:label code="SALES_CHANGE_DUE"/>:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getPaymentChange() %>"/></td>
	</tr-->
</table>
