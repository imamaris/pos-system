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
 
  // String alamat = bean.getCustomerAddressBean().getMailCity().getName();
  
  
  boolean canView = bean != null;
%>

<html>
<head>
	<title>Cash Bill</title>

	<%@ include file="/lib/header.jsp"%>

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

<table class="tbldata" border="0" width="600">                
        
        <tr valign=top>
	  <td colspan=2 align=right><hr></td>
	</tr>
        <tr valign=top>
            <td colspan=2 align=center> <font size="5" style="bold"> INVOICE </font></td>
	</tr>        
        <tr valign=top>
	  <td colspan=2 align=right><hr></td>
	</tr>
        
        <tr>
		<td valign=top>
			<%@ include file="/admin/jsp/sales/view_sales_document_he.jsp"%>
		</td>
	</tr>
        
        <tr valign=top>
	  <td colspan=2 align=right><hr></td>
	</tr>
        
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_cart_he.jsp"%>                  
		</td>
	</tr>
	<tr valign=top>
		<td colspan="2" width="600">
		  <%@ include file="/admin/jsp/sales/view_sales_payment_he.jsp"%>                  
		</td>
	</tr>
        <tr>
		<td valign=top>
			<%@ include file="/admin/jsp/sales/view_sales_customer_he.jsp"%>
		</td>
	</tr>        
	<tr>
		<td colspan="2" width="600">
			<%@ include file="/admin/jsp/sales/view_sales_remark_he.jsp"%>
		</td>
	</tr>
        
  	<tr class=printreceipt>
	  <td colspan="2"></td>   
  </tr>  
  
	<tr class=printreceipt align="center">
	  <td colspan="2">Goods/products have been accepted by the customer as being in good condition.</td>   
  </tr>  
	<tr class=printreceipt align="center">
	  <td colspan="2">Goods/products sold are non-refundable, returnable or exchangeable.</td>   
  </tr>  
  	<tr class=printreceipt align="center">
	  <td colspan="2">Thank you for your patronage.</td>   
  </tr>  
  
  	<tr class=printreceipt>
	  <td colspan="2"></td>   
  </tr> 
  
        <tr>
		<td  colspan="2" align="left">Validation No. : <%= bean.getTrxDocNo().hashCode()%> </td>
	</tr>    
  
        <tr>
		<td colspan="2" align="left">Printed By : <%= bean.getStd_createBy() %></td>
	</tr> 
        
</table>	

<%
	} // end canView
%>
	