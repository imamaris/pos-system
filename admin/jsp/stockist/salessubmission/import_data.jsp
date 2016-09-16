<%@page import="com.ecosmosis.orca.counter.salessubmission.ExcelUploadManager"%>
<%@page import="com.ecosmosis.orca.product.ProductBean"%>
<%@page import="com.ecosmosis.orca.counter.sales.CounterSalesOrderBean"%>
<%@page import="com.ecosmosis.mvc.sys.SystemConstant"%>
<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<%@page import="com.ecosmosis.orca.qwallet.QuotaWalletBean"%>
<%@page import="com.ecosmosis.orca.qwallet.QuotaWalletManager"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<% 
	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	CounterSalesOrderBean[] salesBeans = (CounterSalesOrderBean[]) returnBean.getReturnObject(ExcelUploadManager.RETURN_SUBMISSIONS_CODE); 
	StockistBean stockist = (StockistBean) returnBean.getReturnObject(StockistManager.RETURN_STKBEAN_CODE);
	QuotaWalletBean wallet = (QuotaWalletBean) returnBean.getReturnObject(QuotaWalletManager.RETURN_WALLETBEAN_CODE);
	
	double balance = (wallet!=null)?wallet.getBvBalance():0d;

	boolean canView = (salesBeans!=null && salesBeans.length > 0);
%>
<script language="Javascript">
</script>
</head>
<body>
<script language=Javascript src="<%= request.getContextPath()%>/lib/no_right_click.js"></script>
<div class="functionhead">Sales Submission > Select Stockist > Upload > Data</div>

<form name="frm">
<%@ include file="/lib/return_error_msg.jsp"%>
<c:if test="<%=canView%>" >
	<table class="noprint">
		<tr>
			<td align="right"><b>Stockist ID:</b></td>
	    	<td>
		    	<std:text value="<%=stockist.getStockistCode()%>" />
	    	</td>
		</tr>
		<tr>
			<td align="right"><b>Stockist Name :</b></td>
	    	<td>
		    	<std:text value="<%=stockist.getName()%>" />	
	    	</td>
		</tr>
		<tr>
			<td align="right"><b>Latest Quota Balance:</b></td>
	    	<td>
	    		<std:currencyformater code="" value="<%=balance%>" />	
	    	</td>
		</tr>
		<tr>
			<td colspan=2>&nbsp;</td>
		</tr>
	</table>
	
	<table class="listbox" >
			<tr class="boxhead" valign=top>
				<td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
				<td>Period</td>
				<td>Trx Date</td>
				<td>CFO No.</td>
				<td>Total PV</td>
				<td>Total</td>
				<td>Doc. No.</td>
				<td>Status</td>
			</tr>
			
<%				
		   int grand_bv = 0;
		   double grand_amount = 0d;
		   for(int i=0; i< salesBeans.length; i++){
%>
			<tr class="<%= ((i%2)==0)?"odd":"even"%>" valign=top>
				<td align=right><%= (i+1) %>.</td>				
				<td nowrap><%=salesBeans[i].getBonusPeriodID()%></td>
				<td nowrap><fmt:formatDate value="<%=salesBeans[i].getTrxDate()%>" pattern="<%=SystemConstant.DEFAULT_DATEFORMAT%>"/>   </td>
				<td nowrap><%=salesBeans[i].getCustomerID()%></td>
				<td align=right><std:bvformater value="<%=salesBeans[i].getTotalBv1()%>" /></td>				
				<td align=right><std:currencyformater value="<%=salesBeans[i].getNetSalesAmount()%>" code=""/></td>
				<td nowrap align=center>&nbsp;<b><std:text value="<%=salesBeans[i].getTrxDocNo()%>"  defaultvalue="-"/></b>&nbsp;</td>
				<td nowrap>
					<%if(salesBeans[i].getTrxDocNo()!=null){%>
					  <font color="blue">Success</font>
					<%}else{ %>
					  <font color="red">Failed</font>
					<%}%>
				</td>
			</tr>		
<%			

			}//end for 
%>			

	</table>

<br>
<input id="btnSubmit" type="button" value="Import Again?" onClick='location.href="<%=Sys.getControllerURL(ExcelUploadManager.TASKID_EXCEL_SELECT_STOCKIST, request)%>&StockistID=<%=stockist.getStockistCode()%>";'>

</c:if>

</form>     

</body>
</html>