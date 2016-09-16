<table class="listbox">
	<tr class="boxhead" valign="top">
		<td width="5%">No.</td>
		<td width="15%" nowrap>SKU Code</td>
		<td nowrap>Product Name</td>
		<td width="8%" align="right" width="10%" nowrap>Unit PV</td>
		<td width="12%" align="right" width="10%" nowrap>Unit Price <br> (<%= bean.getLocalCurrencySymbol() %>)</td>
		<td width="8%" align="center" width="10%" nowrap>Qty</td>
		<td width="8%" align="center" width="10%" nowrap>Qty FOC</td>
		<td width="12%" align="right">Total PV</td>
		<td width="12%" align="right">Total Price <br> (<%= bean.getLocalCurrencySymbol() %>)</td>
		<td width="8%" align="center" width="10%" nowrap>Qty Issue</td>
		<td width="8%" align="center" width="10%" nowrap>Qty KIV</td>
	</tr>

<%
	int qtyOrder = 0;
	int qtyFoc = 0;
	String skuCode = "";
	
	CounterSalesItemBean[] itemSales = bean.getItemArray();
	
	for (int i = 0; i < itemSales.length; i++) {
		
		boolean isItemSales = itemSales[i].getProductType() == ProductManager.TYPE_SALESPRODUCT;
		
		ProductBean salesPd = itemSales[i].getProductBean();
		
		if (isItemSales) {
			qtyFoc = 0;
			qtyOrder = itemSales[i].getQtyOrder();
			skuCode = salesPd.getSkuCode();
			
		} else { 
			qtyFoc = itemSales[i].getQtyOrder();
			qtyOrder = 0;
			skuCode = salesPd.getSkuCode() + " [FOC]";
		}
%>

	<tr class="odd" valign=top>
		<td><%= i+1 %>.</td>
		<td><%= skuCode %></td>
		<td><%= salesPd.getProductDescription().getName() %></td>
		<td align="right"><std:bvformater value="<%= itemSales[i].getBv1() %>"/></td>
		<td align="right"><std:currencyformater code="" value="<%= itemSales[i].getUnitPrice() %>"/></td>
		<td align="right"><%= qtyOrder %></td>
		<td align="right"><%= qtyFoc %></td>
		<td align="right"><std:bvformater value="<%= qtyOrder * itemSales[i].getBv1() %>"/></td>
		<td align="right"><std:currencyformater code="" value="<%= qtyOrder * itemSales[i].getUnitPrice() %>"/></td>
		<td align="right" colspan="2">&nbsp</td>
	</tr>	
	
<%
 		CounterSalesProductBean[] cpd = itemSales[i].getProductArray();
	
		for (int j=0; j <cpd.length; j++) {

			int qtyIssued = 0;
			int qtyKiv = cpd[j].getQtyOrder();
			
			int qtyPOrder = isItemSales ? cpd[j].getQtyOrder() : 0;
			int qtyPFoc = !isItemSales ? cpd[j].getQtyOrder() : 0;
			
			ProductBean salesCpd = cpd[j].getProductBean();
			
			if (canViewDelivery) {
				
				DeliveryItemBean[] itemDo = doBean.getItemArray();
				
				for (int m=0; m<itemDo.length; m++) {
					
					ProductBean doPd = itemDo[m].getProductBean();
					
					if (doPd.getProductID() == salesPd.getProductID()) {
						
						DeliveryProductBean[] dpb = itemDo[i].getProductArray();
						
						for (int n=0; n<dpb.length; n++) {
							
							ProductBean doCpd = dpb[n].getProductBean();
							
							if (doCpd.getProductID() == salesCpd.getProductID()) {
								qtyIssued = dpb[n].getQty();
								qtyKiv = dpb[n].getQtyKiv();
									
								break;
							}
							
						} // end productDo
						
						break;
					}
					
				}
			} // end canViewDelivery
%>
	
	<tr class="even" valign=top>
		<td><%= i+1 %>.<%= j %></td>
		<td><%= salesCpd.getProductCode() %></td>
		<td colspan="7"><%= salesCpd.getProductDescription().getName() %></td>
		<td align="right"><%= qtyIssued %></td>
		<td align="right"><%= qtyKiv %></td>
	</tr>	
	
<% 		
		} // end for cpd
%>

<% 
	if ( i != itemSales.length - 1) {
%> 

<tr>
	<td>&nbsp;</td>
</tr>

<% 		
	} // end if
%>
	
<% 
	} // end for itemSales
%>

	<tr>
		<td class="td1 totalhead" colspan="8"><b>Total PV:</b>
		<td class="td1"><std:bvformater value="<%= bean.getTotalBv1() %>"/></td>
	</tr>
	<tr>
		<td class="td1 totalhead" colspan="8"><b>Gross Total:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getNonBvSalesAmount() + bean.getBvSalesAmount() %>"/></td>
	</tr>
	<tr>
		<td class="td1 totalhead" colspan="8"><b>Delivery Amount:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>"/></td>
	</tr>
	<tr>
		<td class="td1 totalhead" colspan="8"><b>Discount Amount:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>"/></td>
	</tr>
	
	<%
		if (bean.getMgmtAmount() != 0) {
	%>
	
	<tr>
		<td class="td1 totalhead" colspan="8"><b>Management Fee:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getMgmtAmount() %>"/></td>
	</tr>
	
	<%
		}
	%>
	
	<tr>
		<td class="td1 totalhead" colspan="8"><b>Net Total:</b>
		<td class="td1"><std:currencyformater code="" value="<%= bean.getNetSalesAmount() %>"/></td>
	</tr>
</table>



