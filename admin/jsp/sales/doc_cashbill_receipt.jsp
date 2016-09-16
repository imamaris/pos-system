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
        .printreceiptfooter2 {font-family:Arial; font-size:7pt; TEXT-DECORATION:none; color:white}
        
	@media print {
	 .noprint  { display: none; }
	}
//-->
</style>

<%
	int width = 250;
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
tes
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

<table width="<%=width%>">
     
        <tr class=printreceipt valign=top>
	  <td colspan=3 align=right><hr></td>
	</tr>
        
	<tr class=printreceipt valign=top> 
	  <td >Location Name : </td>
	  <td colspan="2" align=right>FENDI - PRJ</td>
	</tr>
        
	<tr class=printreceipt valign=top> 
	  <td >Location : </td>
	  <td colspan="2" align=right>Pekan Raya Jakarta</td>
	</tr>
        <tr class=printreceipt valign=top> 
	  <td >Sales Invoice : </td>
	  <td colspan="2" align=right><%=(bean.getTrxDocNo().trim())%></td>
	</tr>
	<tr class=printreceipt valign=top>
	  <td >Trx. Date : </td>
	  <td colspan="2" align=right><%=(bean.getTrxDate())%></td>
	</tr>

	<tr class=printreceipt valign=top>
	  <td >No. Cust. : </td>
	  <td colspan="2" align=right><std:text value="<%= bean.getCustomerID().trim() %>" defaultvalue="-"/></td>
	</tr>
	<tr class=printreceipt  valign=top>
	  <td>Cust. Name : </td>
	  <td colspan="2" align=right><%=(bean.getCustomerName())%></td>
	</tr>
	<tr class=printreceipt  valign=top>
	  <td >Sales Name : </td>
	  <td colspan="2" align=right><%=(bean.getBonusEarnerName().trim())%></td>
	</tr>
        <tr class=printreceipt valign=top>
	  <td colspan=3 align=right><hr></td>
	</tr>

<%
	int totalQty = 0;
        int panjang = 0;
	
	CounterSalesItemBean[] itemSales = bean.getItemArray();
	
	for (int i = 0; i < itemSales.length; i++) {
		
		ProductBean product = itemSales[i].getProductBean();
		
		totalQty += itemSales[i].getQtyOrder();
%>
	<tr class=printreceipt>
		<td colspan="2" nowrap><%= String.valueOf(itemSales[i].getQtyOrder()) + " Unit" + tabLine + product.getSkuCode().trim().toString() %>    
		<td align="right"><std:currencyformater code="" value="<%= itemSales[i].getUnitNetPrice()%>"/></td>   
	</tr>  
	<tr class=printreceipt>
		<td colspan=3 valign=top></td>  
	</tr>        
	
        <%         
        panjang = product.getProductDescription().getName().trim().length();
        
        if (panjang > 50  )         
        {
                    System.out.println("masuk IF 50 " + panjang);
                    
                    %>
        
        <tr class=printreceipt>		
            <td colspan=3 valign=top> <%= tabLine + tabLine + tabLine + product.getProductDescription().getName().trim().substring(0,25).toString() %></td>  
	</tr>
	<tr class=printreceipt>		
            <td colspan=3 valign=top> <%= tabLine + tabLine + tabLine + product.getProductDescription().getName().trim().substring(25, 50).toString() %></td>  
	</tr>        
        
        <% } else if (panjang > 25  ) { 
            
            System.out.println("masuk IF 25 " + panjang);
            
            %>
        
        <tr class=printreceipt>		
            <td colspan=3 valign=top> <%= tabLine + tabLine + tabLine + product.getProductDescription().getName().trim().substring(0,25).toString() %></td>  
	</tr>
	<tr class=printreceipt>		
            <td colspan=3 valign=top> <%= tabLine + tabLine + tabLine + product.getProductDescription().getName().trim().substring(25, panjang).toString() %></td>  
	</tr>        
        
        <%  }  else {
            
            System.out.println("masuk IF dibawah 25 " + panjang);            
            %>
        
	<tr class=printreceipt>		
            <td colspan=3 valign=top> <%= tabLine + tabLine + tabLine + product.getProductDescription().getName().trim().toString() %></td>  
	</tr>
        
        
        <% } %>
        
        <% if (itemSales[i].getUnitDiscount() > 0) 
            {
                    %>
	<tr class=printreceipt>		
            <td colspan=3 valign=top> <%= tabLine + tabLine + tabLine + String.valueOf( (itemSales[i].getUnitDiscount() / itemSales[i].getUnitPrice() * itemSales[i].getBv1() ) * 100 ).substring(0,3) + " % " %> ( <std:currencyformater code="" value="<%= itemSales[i].getUnitPrice() * itemSales[i].getBv1()%>"/> )</td>  
	</tr>  
        <%  } %>
        
<%
	} // end for itemSales
%>

        <tr class=printreceipt valign=top>
	  <td colspan=3 align=right><hr></td>
	</tr>
        
   <tr class=printreceipt>
   <td nowrap><i18n:label code="GENERAL_TOTALQTY"/></td>   
   <td >:</td>  
   <td align=right><%= totalQty %></td>   

      
  <%
  	if (bean.getDeliveryAmount() != 0) {
  %>
  
  <tr class=printreceipt>
	  <td width=50%>Deposit</td>
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
	  <td width=50%>Voucher Amount</td>
		<td nowrap>: <%=bean.getLocalCurrencySymbol()%></td>    
	  <td align="right"><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>" /></td>   
  </tr>
  
  <%
		} // end Discount
  %>
  
	<tr class=printreceipt>
		<td width=50%><i18n:label code="SALES_NET"/></td>  
		<td nowrap>: <%=bean.getLocalCurrency()%></td>   
		<td align="right"><std:currencyformater code="" value="<%=(bean.getNetSalesAmount())%>"/></td>   
 	</tr>
	<tr class=printreceipt>
		<td width=50% height="8" colspan="3"></td>  
 	</tr>   
        <tr class=printreceipt>
                <td width=50%><b>Payment Type</b></td>  
		<td nowrap></td>   
		<td align="right"></td>   
 	</tr>        
        

<% 
	CounterSalesPaymentBean[] paymentList = bean.getPaymentArray();
	
	for (int m = 0; m < paymentList.length; m++) { 
		
		CounterSalesPaymentBean payment = paymentList[m];	
%>
        
	<tr class=printreceipt>
  	<td width=50% wrap><%=payment.getPaymodeTime() %></td> 
    <td nowrap>: <%= payment.getCurrency() %></td>     
    <td align="right"><std:currencyformater code="" value="<%=(payment.getAmount())%>"/></td>   
 	</tr>   	
   	
<% 	
	} // end for paymentList
%>
	<tr class=printreceipt>
	  <td width=50%><i18n:label code="SALES_CHANGE_DUE"/></td>
		<td nowrap>: <%=bean.getLocalCurrency()%></td>    
	  <td align="right"><std:currencyformater code="" value="<%= bean.getPaymentChange() %>" /></td>   
  </tr>
        
  <tr class=printreceipt valign=top>
	  <td colspan=3 align=right><hr></td>
  </tr>
        
	<tr class=printreceiptfooter> 
	  <td colspan="3" align="center">Goods/products have been accepted by the customer as being in good condition.</td>   
  </tr>  
	<tr class=printreceiptfooter>
	  <td colspan="3" align="center">Goods/products sold are non-refundable, returnable or exchangeable.</td>   
  </tr>  
  	<tr class=printreceiptfooter>
	  <td colspan="3" align="center">Thank you for your patronage.</td>   
  </tr>  

	<tr class=printreceiptfooter2>
            <td colspan="3" align="center">.</td>   
  </tr>
	<tr class=printreceiptfooter2>
            <td colspan="3" align="center">.</td>   
  </tr>    
  <br>
  <br>
  
</table>

<%
	} else {
%>
	
<% out.println("No Cash Bill info found !!!"); %>	

<%}%>

</body>
</html>