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
  DeliveryOrderBean[] doBeans = (DeliveryOrderBean[]) returnBean.getReturnObject("DeliveryList");
  
  boolean canView = bean != null && doBeans != null;
%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>

</head>

<body>

<div class="functionhead">View Sales Delivery History</div>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<table>
	<tr>
		<td>
			<%@ include file="/admin/jsp/sales/view_sales_order_trx.jsp"%>
		<td/>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td>
		  <%@ include file="/admin/jsp/sales/view_sales_parties.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2"><b><u>Delivery Summary</u></b></td>
	</tr>
	<tr class="listbox">
		<td class="totalhead" width="50"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TOTAL%>"/></td>
		<td width="50"><%= doBeans.length %></td>
	</tr>

	<% 
		for (int g = 0; g < doBeans.length; g++) {
			
			DeliveryOrderBean doBean = doBeans[g];
			
			String colCss = (doBean.getStatus() != CounterSalesManager.STATUS_ACTIVE) ? "wordalert" : "";
	%>
	
	<tr>
		<td>
			<%= doBean.getTrxDocNo() %> on <fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= doBean.getTrxDate() %>" />
			<%= CounterSalesManager.getTrxStatusName(doBean.getStatus()) %>
		</td>
		<td>
			<%@ include file="/admin/jsp/inventory/view_delivery_cart.jsp"%>
		</td>
	</tr>
	
	<%
		}
	%>

</table>	

<%
	} // end canView
%>
	