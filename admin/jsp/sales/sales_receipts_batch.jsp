<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>

<html>
<head>
<%@ include file="/lib/header_without_css.jsp"%>
<%
CounterSalesManager counter = new CounterSalesManager();
%>
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
	CounterSalesOrderBean[] beans = (CounterSalesOrderBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SALESLIST_CODE);
	
	boolean isCorp = ((request.getParameter("print")!=null && request.getParameter("print").equalsIgnoreCase("corp"))?true:false);
	boolean canView = (beans != null && beans.length > 0);
%>
<title>Cash Bill Receipt for <%=((isCorp)?"Corporate":"Chi Network")%></title>
</head>



<body <%=(canView)?"onLoad = \"window.print();\"":""%>>

<table width="100">
	<tr>
	<c:if test="<%(canView)%>">
		<td>
			<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
		</td>
	</c:if>
		<td>
			<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick="window.close();">
		</td>
	</tr>	
</table>

<%
	if (canView) {
%>

<br>

<%
		for (int i=0; i<beans.length; i++) { 
		if( (!isCorp && beans[i].getChiSalesAmount() <= 0d) || 
		(isCorp && beans[i].getCorpSalesAmount() <= 0d))
	continue;
%>
<table width="<%=width%>">

	<tr class=printreceipt valign=top>
	  <td colspan=2 align=center>
<c:if test="true">
          <img border=0 src="<%= request.getContextPath() %>/img/receipt_logo.jpg">
</c:if>	
		<div align=left><%=(isCorp)?"Corporate":"Chi Network"%></div>
          <hr noshade>
          </td>
	</tr>
	<tr class=printreceipt valign=top> 
	  <td><i18n:label code="SALES_BILLNO"/> : </td>
	  <td align=right><%=(beans[i].getTrxDocNo())%></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td ><i18n:label code="GENERAL_DATE"/> : </td>
	  <td align=right><%=(beans[i].getTrxDate())%></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td ><i18n:label code="BONUS_PERIOD"/> : </td>
	  <td align=right><std:text value="<%= beans[i].getBonusPeriodID() %>" defaultvalue="-"/></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td ><i18n:label code="MEMBER_NUMBER"/> : </td>
	  <td align=right><std:text value="<%= beans[i].getCustomerID() %>" defaultvalue="-"/></td>
	</tr>
	<tr class=printreceipt  valign=top>
	  <td ><i18n:label code="GENERAL_NAME"/> : </td>
	  <td align=right><%=(beans[i].getCustomerName())%></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td colspan=2 align=right><hr noshade></td>
	</tr>
</table>

<br>

<table width="<%=width%>">
<%
	int totalQty = 0;
	double gross = 0d;
	
	CounterSalesItemBean[] itemSales = beans[i].getItemArray();
	
	for (int j = 0; j < itemSales.length; j++) {
		
		ProductBean product = itemSales[j].getProductBean();
		
		totalQty += itemSales[j].getQtyOrder();
		
		double unitType = counter.getTypeUnit(product.getSkuCode(), itemSales[j].getUnitPrice(), itemSales[j].getBv1(), ((isCorp)?3:2));
		gross += (itemSales[j].getQtyOrder() * unitType);
%>

	<tr class=printreceipt>
		<td colspan=2 valign=top><%=product.getSkuCode() + tabLine + product.getProductDescription().getName()%></td>  
	</tr>
	<tr class=printreceipt>
		<td width=40% nowrap><%=String.valueOf(itemSales[j].getQtyOrder()) + " x "%><std:currencyformater code="" value="<%= unitType %>"/></td>   
		<td align="right"><std:currencyformater code="" value="<%= itemSales[j].getQtyOrder() * unitType %>"/></td>   
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
   <td align=left><%=totalQty%></td>   
  </tr>
  
  <c:if test="<%=!isCorp%>">
  <tr class=printreceipt>
	  <td width=40%><i18n:label code="GENERAL_TOTAL"/> </td>
		<td nowrap>: <%=beans[i].getLocalCurrencySymbol()%></td>    
	  <td align="right"><std:currencyformater code="" value="<%= (gross)  %>" /></td>   
  </tr>
  </c:if>    
  <%
      if (!isCorp && beans[i].getDeliveryAmount() != 0) {
      %>
  
  <tr class=printreceipt>
	  <td width=40%><i18n:label code="SALES_DELIVERY_CHARGES"/></td>
		<td nowrap>: <%=beans[i].getLocalCurrencySymbol()%></td>    
	  <td align="right"><std:currencyformater code="" value="<%= beans[i].getDeliveryAmount() %>" /></td>   
  </tr>
  
  <%
    } // Delivery
    %>
  
  <%
    if (!isCorp && beans[i].getDiscountAmount() != 0) {
    %>   
  
  <tr class=printreceipt>
	  <td width=40%><i18n:label code="SALES_DISCOUNT"/></td>
		<td nowrap>: <%=beans[i].getLocalCurrencySymbol()%></td>    
	  <td align="right"><std:currencyformater code="" value="<%= beans[i].getDiscountAmount() %>" /></td>   
  </tr>
  
  <%
    } // end Discount
    %>

	<tr class=printreceipt>
		<td width=40%><i18n:label code="SALES_NET"/></td>  
		<td nowrap>: <%=beans[i].getLocalCurrencySymbol()%></td>   
		<td align="right"><std:currencyformater code="" value="<%=((isCorp)?beans[i].getCorpSalesAmount():beans[i].getChiSalesAmount())%>"/></td>   
		
		
 	</tr>

</table>

<br>
<br>
<br>
<br>
<% 			}//end for %>
<%
	} else {
%>

<p>	
<div align=center><font type="Arial"><b>No record found.</b></div>	

<%}%>

</body>
</html>