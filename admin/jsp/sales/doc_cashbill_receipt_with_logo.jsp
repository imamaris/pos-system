<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>

<html>
<head>
<%@ include file="/lib/header_without_css.jsp"%>

<style type="text/css">
<!--
	.printreceipt {font-family:Arial; font-size:8pt; TEXT-DECORATION:none; color:black}
	.printreceiptfooter {font-family:Arial; font-size:7pt; TEXT-DECORATION:none; color:black}
	@media print {
	 	.noprint  { display: none; }
	}
//-->
</style>

<%
	int width = 220;
	int maxChar = 60;
	String tabLine = "&nbsp;&nbsp;&nbsp;&nbsp;";	
	//response.setContentType("text/plain; charset=utf-8");
	
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  	CounterSalesOrderBean bean = (CounterSalesOrderBean) returnBean.getReturnObject("CounterSalesOrderBean");

  	boolean canView = bean != null;
%>

</head>

<%
	if (canView) {
%>

<body onLoad = "window.print();">

<table width="100">
	<tr>
		<td>
			<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
		</td>
		<td>
			<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick="window.close();">
		</td>
	</tr>	
</table>

<br>

<table width="<%=width%>">

	<tr class=printreceipt valign=top>
	  <td colspan=2 align=center>
<c:if test="true">
          <img border=0 src="<%= request.getContextPath() %>/img/receipt_logo.jpg">
</c:if>		
          <hr noshade>
          </td>
	</tr>
	<tr class=printreceipt valign=top> 
	  <td>Location : </td>
	  <td align=right><%=(bean.getSellerID())%></td>
	</tr>
        <tr class=printreceipt valign=top> 
	  <td>Sales Invoice : </td>
	  <td align=right><%=(bean.getTrxDocNo())%></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td >Trx. Date : </td>
	  <td align=right><%=(bean.getTrxDate())%></td>
	</tr>

	<tr class=printreceipt valign=top>
	  <td >No. Cust. : </td>
	  <td align=right><std:text value="<%= bean.getCustomerID().trim() %>" defaultvalue="-"/></td>
	</tr>
	<tr class=printreceipt  valign=top>
	  <td >Cust. Name : </td>
	  <td align=right><%=(bean.getCustomerName())%></td>
	</tr>
	<tr class=printreceipt  valign=top>
	  <td >Sales Name : </td>
	  <td align=right><%=(bean.getBonusEarnerName().trim())%></td>
	</tr>
        <tr class=printreceipt valign=top>
	  <td colspan=2 align=right><hr noshade></td>
	</tr>
</table>

<table width="<%=width%>">
<%
	int totalQty = 0;
	
	CounterSalesItemBean[] itemSales = bean.getItemArray();
	
	for (int i = 0; i < itemSales.length; i++) {
		
		ProductBean product = itemSales[i].getProductBean();
		
		totalQty += itemSales[i].getQtyOrder();
%>
	<tr class=printreceipt>
		<td width=40% nowrap><%= String.valueOf(itemSales[i].getQtyOrder()) + " Unit " + tabLine + product.getSkuCode() %>    
		<td align="right"><std:currencyformater code="" value="<%= itemSales[i].getUnitNetPrice()%>"/></td>   
	</tr>  
	<tr class=printreceipt>
		<td colspan=2 valign=top></td>  
	</tr>        
	<tr class=printreceipt>
		<td colspan=2 valign=top><%= product.getProductDescription().getName().trim().substring(0,50) %></td>  
	</tr>
        <br>
	 
<%
	} // end for itemSales
%>

</table>

<br>

<table width="<%=width%>">
	<tr class=printreceipt>
   <td width=20% nowrap><i18n:label code="GENERAL_TOTALQTY"/></td>   
   <td width=15% nowrap>:</td>  
   <td align=left><%= totalQty %></td>   

      
  <%
  	if (bean.getDeliveryAmount() != 0) {
  %>
  
  <tr class=printreceipt>
	  <td width=40%>Deposit</td>
		<td nowrap>: <%=bean.getLocalCurrencySymbol()%></td>    
	  <td align="right"><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>" /></td>   
  </tr>
  
  <%
		} // Delivery
  %>
  
  <%
  	if (bean.getDiscountAmount() != 0) {
  %>   
  
  <tr class=printreceipt>
	  <td width=40%>Voucher Amount</td>
		<td nowrap>: <%=bean.getLocalCurrencySymbol()%></td>    
	  <td align="right"><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>" /></td>   
  </tr>
  
  <%
		} // end Discount
  %>
  
	<tr class=printreceipt>
		<td width=40%><i18n:label code="SALES_NET"/></td>  
		<td nowrap>: <%=bean.getLocalCurrencySymbol()%></td>   
		<td align="right"><std:currencyformater code="" value="<%=(bean.getNetSalesAmount())%>"/></td>   
 	</tr>

<% 
	CounterSalesPaymentBean[] paymentList = bean.getPaymentArray();
	
	for (int m = 0; m < paymentList.length; m++) { 
		
		CounterSalesPaymentBean payment = paymentList[m];	
%>

	<tr class=printreceipt>
  	<td width=40%><%=payment.getPaymodeDesc() %></td> 
    <td nowrap>: <%=bean.getLocalCurrencySymbol()%></td>     
    <td align="right"><std:currencyformater code="" value="<%=(payment.getAmount())%>"/></td>   
 	</tr>   	
   	
<% 	
	} // end for paymentList
%>
	<tr class=printreceipt>
	  <td width=40%><i18n:label code="SALES_CHANGE_DUE"/></td>
		<td nowrap>: <%=bean.getLocalCurrencySymbol()%></td>    
	  <td align="right"><std:currencyformater code="" value="<%= bean.getPaymentChange() %>" /></td>   
  </tr>

  	<tr class=printreceipt>
	  <td colspan="3"></td>   
  </tr>  
  <br>
	<tr class=printreceiptfooter> 
	  <td colspan="3" align="center">Goods/products have been accepted by the customer as being in good condition.</td>   
  </tr>  
	<tr class=printreceiptfooter>
	  <td colspan="3" align="center">Goods/products sold are non-refundable, returnable or exchangeable.</td>   
  </tr>  
  	<tr class=printreceiptfooter>
	  <td colspan="3" align="center">Thank you for your patronage.</td>   
  </tr>  

</table>

<br>
<br>
<br>
<br>

<%
	} else {
%>
	
<% out.println("No Cash Bill info found !!!"); %>	

<%}%>

</body>
</html>