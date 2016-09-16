<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>

<html>
<head>
<%@ include file="/lib/header_without_css.jsp"%>

<style type="text/css">
<!--
	.printreceipt {font-family:Arial; font-size:10pt; TEXT-DECORATION:none; color:black}
	
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
	  <td><i18n:label code="SALES_BILLNO"/> : </td>
	  <td align=right><%=(bean.getTrxDocNo())%></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td ><i18n:label code="GENERAL_DATE"/> : </td>
	  <td align=right><%=(bean.getTrxDate())%></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td ><i18n:label code="BONUS_PERIOD"/> : </td>
	  <td align=right><std:text value="<%= bean.getBonusPeriodID() %>" defaultvalue="-"/></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td ><i18n:label code="MEMBER_NUMBER"/> : </td>
	  <td align=right><std:text value="<%= bean.getCustomerID() %>" defaultvalue="-"/></td>
	</tr>
	<tr class=printreceipt  valign=top>
	  <td ><i18n:label code="GENERAL_NAME"/> : </td>
	  <td align=right><%=(bean.getCustomerName())%></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td colspan=2 align=right><hr noshade></td>
	</tr>
</table>

<br>

<table width="<%=width%>">
<%
	int totalQty = 0;
	
	CounterSalesItemBean[] itemSales = bean.getItemArray();
	
	for (int i = 0; i < itemSales.length; i++) {
		
		ProductBean product = itemSales[i].getProductBean();
		
		totalQty += itemSales[i].getQtyOrder();
%>

	<tr class=printreceipt>
		<td colspan=2 valign=top><%= product.getSkuCode() + tabLine + product.getProductDescription().getName() %></td>  
	</tr>
	<tr class=printreceipt>
		<td width=40% nowrap><%= String.valueOf(itemSales[i].getQtyOrder()) + " x "%><std:currencyformater code="" value="<%= itemSales[i].getUnitPrice() %>"/></td>   
		<td align="right"><std:currencyformater code="" value="<%= itemSales[i].getQtyOrder() * itemSales[i].getUnitPrice() %>"/></td>   
	</tr>  
	 
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
  </tr>
	<tr class=printreceipt>
	  <td width=40%><i18n:label code="GENERAL_TOTAL"/> </td>
		<td nowrap>: <%=bean.getLocalCurrencySymbol()%></td>    
	  <td align="right"><std:currencyformater code="" value="<%= ((bean.getNonBvSalesAmount() + bean.getBvSalesAmount()))  %>" /></td>   
  </tr>
      
  <%
  	if (bean.getDeliveryAmount() != 0) {
  %>
  
  <tr class=printreceipt>
	  <td width=40%><i18n:label code="SALES_DELIVERY_CHARGES"/></td>
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
	  <td width=40%><i18n:label code="SALES_DISCOUNT"/></td>
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
    <td width=40%>PV</td>
    <td>: </td>
    <td colspan="1" align="right"><std:bvformater value="<%=(bean.getTotalBv1())%>"/></td>  
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