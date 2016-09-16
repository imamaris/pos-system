<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	TreeMap months = (TreeMap) returnBean.getReturnObject("MonthList");
	TreeMap years = (TreeMap) returnBean.getReturnObject("YearList");
	
	SalesSummaryBean[] salesList1 = (SalesSummaryBean[]) returnBean.getReturnObject("SalesList1");
	SalesSummaryBean[] salesList2 = (SalesSummaryBean[]) returnBean.getReturnObject("SalesList2");
	
	int totalRecord = 0;
	if (returnBean.getReturnObject("TotalSalesRecord") != null)
		totalRecord = (Integer) returnBean.getReturnObject("TotalSalesRecord");
	
	String rptTitle = (String) returnBean.getReturnObject("ReportTitle");	
  String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
  String taskExport = (String) returnBean.getReturnObject("TaskExportID");
  
  int taskID = 0;
  if (task != null) 
		taskID = Integer.parseInt(task);
	
	int taskExportID = 0;
	if (taskExport != null) 
		taskExportID = Integer.parseInt(taskExport);
					
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	
	boolean canView = false;
	if (salesList1 != null || salesList2 != null)
		canView = true;
	
	java.text.SimpleDateFormat date = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="javascript">
	function doSubmit(thisform) 
	{
		if (thisform.month.value=='' || thisform.year.value=='')
		{
			alert("Please Select Month and Year to proceed !!");
			return;
  	}
  	
		thisform.submit();
	}
</script>
</head>

<body>
  
<div class="functionhead"><%= rptTitle %></div>	

<form name="exp_sales" action="<%=Sys.getControllerURL(taskID, request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<table class="listbox" width="260">
	<tr>
		<td width="" class="odd">Month</td>
		<td><std:input type="select" name="month" options="<%=months%>" value="<%=month%>"/> &nbsp;</td>
		<td width="" class="odd">Year</td>
		<td><std:input type="select" name="year" options="<%=years%>" value="<%=year%>"/> &nbsp;<input class="noprint textbutton" type="button" onClick="doSubmit(this.form);" value="<i18n:label code="GENERAL_BUTTON_GO"/>"></td>
	</tr>
</table>

<input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>">

</form>

<% if (canView) { %>

<form name="exp_sales_submit" action="<%=Sys.getControllerURL(taskExportID, request)%>" method="post" onsubmit="">
<input type="hidden" name="month" value="<%=month%>"/>
<input type="hidden" name="year" value="<%=year%>"/>

<table class="listbox">
	<tr>
		<td class="totalhead" width="170"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TOTAL%>"/> Records Found</td>
		<td width="80"><%= totalRecord %></td>
	</tr>
</table>

<% if (totalRecord > 0) { %>
	<br>
	<div>
		<input class="noprint textbutton" type="submit" value="EXPORT TEXT FILE">
	</div>
<% } %>

</form>

<table class="listbox" width="100%">
	<tr class="boxhead">
		<td><i18n:label code="GENERAL_NUMBER"/></td>
		<td>Trx Date</td>
		<td>Member ID</td>
		<td>SKU Code</td>
		<td>Qty</td>
		<td>Unit Price</td>
		<td>Discount</td>
		<td>Delivery</td>
		<td>Cash</td>
		<td>Cheque</td>
		<td>Others</td>
		<td>Master</td>
		<td>Visa</td>
		<td>Debit</td>
	</tr>
	
	<!-- Member Sales -->
	<%
		int count = 0;
		double totalSales = 0d;
		String curCustID = "";
		
		for (int i=0; i<salesList1.length; i++) {
			
			SalesSummaryBean bean = salesList1[i];
			
			totalSales += bean.getTotalSales();
			
			double[] paymode = bean.getPaymentList();

			CounterSalesItemBean[] itemList = (CounterSalesItemBean[]) bean.getItemList().toArray(new CounterSalesItemBean[0]);
			
			for (int j=0; j<itemList.length; j++) {
				CounterSalesItemBean item = itemList[j];
				++count;
	%>
	<tr class="<%=((i%2==1)?"odd":"even")%>">
		<td><%= count %></td>
		<td><%= date.format(bean.getTrxDate()) %></td>
		<td><%= bean.getMemberID() %></td>
		<td><%= item.getSkucode() %></td>
		<td align="center"><%= item.getQtyOrder() %></td>
		<td align="right"><std:currencyformater code="" value="<%= item.getUnitPrice() %>"/></td>
		<td align="right"><std:currencyformater code="" value="<%= bean.getDiscountAmt() %>"/></td>
		<td align="right"><std:currencyformater code="" value="<%= bean.getDeliveryAmt() %>"/></td>
		<td align="right"><std:currencyformater code="" value="<%= paymode[0] - bean.getChangeDueAmt() %>"/></td>
		
		<% for (int k=1; k<paymode.length; k++) { %>
		<td align="right"><std:currencyformater code="" value="<%= paymode[k] %>"/></td>
		<% } %>
		
	</tr>
	<% }} // end for %>
	
	<!-- Non Member Sales -->
	<%
		for (int i=0; i<salesList2.length; i++) {
			
			SalesSummaryBean bean = salesList2[i];
			
			totalSales += bean.getTotalSales();
			
			double[] paymode = bean.getPaymentList();
			
			CounterSalesItemBean[] itemList = (CounterSalesItemBean[]) bean.getItemList().toArray(new CounterSalesItemBean[0]);
			
			for (int j=0; j<itemList.length; j++) {
				CounterSalesItemBean item = itemList[j];
				++count;
	%>
	<tr class="<%=((i%2==1)?"odd":"even")%>">
		<td><%= count %></td>
		<td><%= date.format(bean.getTrxDate()) %></td>
		<td><%= bean.getMemberID() %></td>
		<td><%= item.getSkucode() %></td>
		<td align="center"><%= item.getQtyOrder() %></td>
		<td align="right"><std:currencyformater code="" value="<%= item.getUnitPrice() %>"/></td>
		<td align="right"><std:currencyformater code="" value="<%= bean.getDiscountAmt() %>"/></td>
		<td align="right"><std:currencyformater code="" value="<%= bean.getDeliveryAmt() %>"/></td>
		<td align="right"><std:currencyformater code="" value="<%= paymode[0] - bean.getChangeDueAmt() %>"/></td>
		
		<% for (int k=1; k<paymode.length; k++) { %>
		<td align="right"><std:currencyformater code="" value="<%= paymode[k] %>"/></td>
		<% } %>
		
	</tr>
	<% }} %>
	
</table>

<br>

<table class="listbox">
	<tr>
		<td class="totalhead">Total Member</td>
		<td align="right"><%= (salesList1.length + salesList2.length) %></td>
	</tr>
	<tr>
		<td class="totalhead">Total Sales</td>
		<td align="right"><std:currencyformater code="" value="<%= totalSales %>"/></td>
	</tr>
</table>

<% } %>

</body>
</html>