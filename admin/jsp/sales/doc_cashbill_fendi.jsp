<%@ page import="com.ecosmosis.mvc.manager.*"%>

<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  CounterSalesOrderBean bean = (CounterSalesOrderBean) returnBean.getReturnObject("CounterSalesOrderBean");
  
  boolean canView = bean != null;
 
  // MemberBean product = bean.getCustomerID();
  // System.out.println("product :"+product);
  
%>

<html>
<head>
	<title>Cash Bill</title>

	<%@ include file="/lib/header_without_css.jsp"%>
        
<style type="text/css">

	.baru {
         font-family: Arial; 
         font-size: 6pt; 
         TEXT-DECORATION: none; 
         color: black
         }
         
.boxheadbaru {
	font-size: 6pt; 
	font-weight: bold;
	text-align: center;
	background-color: #E7E7E7;
        color: black;
}

.listboxbaru { 
	font-family: verdana, arial, sans-serif;
	font-size: 6pt;
	border: 1px solid #c0bab6;
	border-collapse: collapse;

}

.listboxbaru td {
	font-family: verdana, arial, sans-serif;
	font-size: 6pt;
	border: 1px solid #c0bab6;
	padding: 3px 3px 3px 3px
}
	.barufooter {font-family: Arial; font-size: 7pt; TEXT-DECORATION: none; color: black}
        .barufooter2 {font-family: Arial; font-size: 7pt; TEXT-DECORATION: none; color: white}        
	@media print {
	 .noprint  { display: none; }
	}
        
</style>        

</head>

<body>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<table width="100">
	<tr>
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
		</td>
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick="window.close();">
		</td>
	</tr>
</table>
		
<br>

<table class="tbldatabaru" border="0" width="600">                
        
        <tr valign=top>
            <td colspan=2 align=center> <font size="4" style="bold"> INVOICE </font></td>
	</tr>        
        
        
        <tr class=baru valign=top>
		<td valign=top>
                    
			<%@ include file="/admin/jsp/sales/view_sales_document_fendi.jsp"%>
		</td>
	</tr>

        
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_cart_he_3.jsp"%>                    
		</td>
	</tr>
        
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_payment_fendi.jsp"%>                  
		</td>
	</tr>
        <tr>
		<td valign=top>
		   <%@ include file="/admin/jsp/sales/view_sales_customer_fendi.jsp"%>
		</td>
	</tr>        
        
  	<tr class=baru>
	  <td colspan="2"></td>   
  </tr>  
  
	<tr class=baru align="center">
	  <td colspan="2">Goods/products have been accepted by the customer as being in good condition.</td>   
  </tr>  
	<tr class=baru align="center">
	  <td colspan="2">Goods/products sold are non-refundable, returnable or exchangeable.</td>   
  </tr>  
  	<tr class=baru align="center">
	  <td colspan="2">Thank you for your patronage.</td>   
  </tr>  
  
  	<tr class=baru>
	  <td colspan="2"></td>   
  </tr> 
  
        <tr class=baru>
		<td  colspan="2" align="left">Validation No. : <%= bean.getTrxDocNo().hashCode()%> </td>
	</tr>    
  
        <tr class=baru>
		<td colspan="2" align="left">Printed By : <%= bean.getStd_createBy() %></td>
	</tr> 
        
</table>	

<%
	} // end canView
%>
	