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
  DeliveryOrderBean doBean = (DeliveryOrderBean) returnBean.getReturnObject("DeliveryOrderBean");
  
  boolean canView = bean != null;
  boolean canViewDelivery = doBean != null;
%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>

</head>

<body>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<br>

<table width="100">
	<tr>
		<td>
			<input class="noprint textbutton" type="button" value="Print" onClick="window.print();">
		</td>
		<td>
			<input class="noprint textbutton" type="button" value="Close" onClick="window.close();">
		</td>
	</tr>
</table>

<br>

<table class="tbldata" border="0" width="700">
	<tr>
		<td width="400" valign=top>
			 <%@ include file="/admin/jsp/sales/view_sales_parties.jsp"%>
		</td>
		<td width="300" valign=top>
			<%@ include file="/admin/jsp/sales/view_sales_document.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign=top>
		<td colspan="2" width="700">
			<% 
				if (bean.isImmediateDelivery() && bean.isDisplayDelivery()) {
			%>
			
			<%@ include file="/admin/jsp/sales/view_sales_delivery_cart.jsp"%>
		  
		  <%
				} else {
		  %>
		  
		  <%@ include file="/admin/jsp/sales/view_sales_cart.jsp"%>
		  
		  <% 
				}
		  %>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign=top>
		<td colspan="2" width="500">
		  <%@ include file="/admin/jsp/sales/view_sales_payment.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" width="500">
			<%@ include file="/admin/jsp/sales/view_sales_remark.jsp"%>
		</td>
	</tr>
</table>	

<%
	} // end canView
%>
	