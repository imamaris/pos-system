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
  
	String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);

	int taskID = 0;
	if (task != null) 
		taskID = Integer.parseInt(task);

  CounterSalesOrderBean bean = (CounterSalesOrderBean) returnBean.getReturnObject("CounterSalesOrderBean");
  CounterSalesOrderBean adjstBean = (CounterSalesOrderBean) returnBean.getReturnObject("AdjstCounterSalesOrderBean");
  OutletPaymentModeBean[] paymodeList = (OutletPaymentModeBean[]) returnBean.getReturnObject("PaymentModeList");
  
  ArrayList confirmBonusPeriodList = (ArrayList) returnBean.getReturnObject(CounterSalesManager.RETURN_CFIMBNSPERIODLIST_CODE);
	
  boolean isBonusConfirmed = false;
  boolean canView = bean != null;
  
  if (canView) {

	  if (bean.getBonusPeriodID() != null) {
  		isBonusConfirmed = confirmBonusPeriodList.contains(bean.getBonusPeriodID());
  	} else {
	  	isBonusConfirmed = true;
		}
  }
%>

<html>
<head>
	<title></title>

	<%@ include file="/lib/header.jsp"%>
	<%@ include file="/lib/counter.jsp"%>
	
	<script language="javascript">
	<!--
		function validateForm(thisform) {

			if (confirm('<i18n:label code="MSG_CONFIRM"/>')) {
				thisform.action = "<%= Sys.getControllerURL(taskID,request) %>";
		    thisform.submit(); 
			} else {
				alert('<i18n:label code="MSG_ACTION_CANCEL"/>');
			}
		}
		
	//-->
	</script>

</head>

<body>

<div class="functionhead"><i18n:label code="SALES_VOID"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

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
		  <%@ include file="/admin/jsp/sales/view_sales_cart.jsp"%>
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
		<td>
			<table>
				<tr>
					<td class="td1" width="110" valign="top"><i18n:label code="GENERAL_REMARK"/>:</td>
					<td><%= bean.getRemark() != null ? bean.getRemark().replaceAll("\n","<br>") : "-" %></td>
                                        
				</tr>
			</table>
		</td>
	</tr>
</table>	


<hr>

<br>

<%
	if (bean.getStatus() == CounterSalesManager.STATUS_ACTIVE) {
%>	
	
<form name="frmSalesOrder" method="post" action="">
	<table class="outerbox" width="600">
		<tr class="alert">
			<td align="center" colspan="2"><b><i18n:label code="GENERAL_REMARK"/></b></td>
		</tr>
		
		<%
			if (!isBonusConfirmed) {
		%>
		
		<tr>
			<td class="error note" colspan="2">
				This sales is voided on Document Date <%= bean.getBonusPeriodID() %>. <br>

			</td>
		</tr>
		
		<tr>
			<td>&nbsp;</td>
		</tr>
		
		<%
			}
		%>
		
		<tr valign="top">
			<td><i18n:label code="GENERAL_REMARK"/>:</td>
			<td><textarea name="AdjstRemark" cols=40 rows=5></textarea></td>
		</tr>	
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="DocID" value="<%= bean.getTrxDocNo() %>"/>
	<std:input type="hidden" name="SalesID" value="<%= bean.getSalesID().toString() %>"/>
	<std:input type="hidden" name="CancelBonus" value="<%= isBonusConfirmed ? "N" : "Y" %>"/>
	
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onclick="validateForm(this.form)">
</form>	

<%
	} // end if active
%>

<%
	} // end canView
%>


	