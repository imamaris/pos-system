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
  DeliveryOrderBean adjstBean = (DeliveryOrderBean) returnBean.getReturnObject("AdjstDeliveryBean");
%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	<!--
		function validateForm(thisform) {
			thisform.action = "<%= Sys.getControllerURL(CounterSalesManager.TASKID_VOID_DELIVERY,request) %>";
			thisform.submit();
		}
		
	//-->
	</script>

</head>

<body>

<div class="functionhead"><i18n:label code="DELIVERY_VOID_INFO"/></div>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<table class="tbldata" border="0" width="700">
	<tr>
		<td width="400" valign=top>
			 <%@ include file="/admin/jsp/inventory/view_delivery_sales_parties.jsp"%>
		</td>
		<td width="300" valign=top>
			<%@ include file="/admin/jsp/inventory/view_delivery_document.jsp"%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
		  <%@ include file="/admin/jsp/inventory/view_delivery_parties.jsp"%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td valign=top>
			<%@ include file="/admin/jsp/inventory/view_delivery_status.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign=top>
		<td colspan="2" width="700">
		  <%@ include file="/admin/jsp/inventory/view_delivery_cart.jsp"%>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign=top>
		<table border="0">
			<tr>
				<td class="td1" width="110" valign="top"><i18n:label code="GENERAL_REMARK"/>:</td>
				<td colspan="4"><%= doBean.getRemark() != null && doBean.getRemark().length() > 0 ? doBean.getRemark().replaceAll("\n","<br>") : "-" %></td>
			</tr>
		</table>
	</tr>
</table>	

<hr>

<br>

<%
	if (doBean.getStatus() == CounterSalesManager.STATUS_ACTIVE) {
%>

<form name="frmVoid" method="post" action="">
	<table class="outerbox" width="600">
		<tr class="alert">
			<td align="center" colspan="2"><b><i18n:label code="DELIVERY_VOID"/></b></td>
		</tr>
		<tr>
			<td valign="top"><i18n:label code="GENERAL_REMARK"/>:</td>
			<td><textarea name="AdjstRemark" cols=55 rows=5></textarea></td>
		</tr>	
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="DocID" value="<%= doBean.getTrxDocNo() %>"/>
	<std:input type="hidden" name="DeliveryID" value="<%= doBean.getDeliveryID().toString() %>"/>
	
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onclick="validateForm(this.form)">
</form>	

<%
	} // end if active
%>
	