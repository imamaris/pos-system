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
  
	Map orderByMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_ORDERBY_CODE);
	
	Map recordsMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SHOWRECS_CODE);
	
	CounterSalesOrderBean[] beans = (CounterSalesOrderBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SALESLIST_CODE);
	
  boolean canView = beans != null;
%>

<html>
<head>
<title></title>

	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
    
  	function doSubmit(thisform) {
    	thisform.submit();
  	}      	 
	</script>
		
</head>

<body>

<div class="functionhead"><i18n:label code="DELIVERY_LISTING_ISSUE"/> <%= loginUser.getOutletID() %></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(CounterSalesManager.TASKID_ISSUE_DELIVERY_LIST,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
	<table border="0">
	  <tr>
	    <td class="td1"><i18n:label code="SALES_REFERENCE"/>:</td>
	    <td><std:input type="text" name="TrxDocNo" size="30" maxlength="20"/></td>
	    <td colspan="3">&nbsp;</td>
	  </tr>
	  <tr>
	  	<td class="td1"><i18n:label code="GENERAL_ID"/>:</td>
	  	<td><std:memberid name="CustomerID" form="frmSearch"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="GENERAL_NAME"/>:</td>
	    <td><std:input type="text" name="CustomerName" size="30" maxlength="50"/></td>
	  </tr>
	  <tr>
	  	<td class="td1"><i18n:label code="GENERAL_FROMDATE"/>:</td>
	    <td><std:input type="date" name="TrxDateFrom" value="now"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="GENERAL_TODATE"/>:</td>
	    <td><std:input type="date" name="TrxDateTo" value="now"/></td>
	  </tr>
	  <tr>
			<td class="td1"><i18n:label code="GENERAL_DISPLAY"/>:</td>
			<td><std:input type="select" name="Limits" options="<%= recordsMap %>"/></td>
			<td>&nbsp;</td>
			<td class="td1"><i18n:label code="GENERAL_ORDERBY"/>:</td>
			<td><std:input type="select" name="OrderBy" options="<%= orderByMap %>"/></td>
		</tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>

<hr>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<form name="frmList" action="" method="post">

<table class="listbox" width="100%">
  <tr class="boxhead" valign=top>
    <td><i18n:label code="GENERAL_NUMBER"/></td>
    <td><i18n:label code="SALES_REFERENCE"/></td>
    <td><i18n:label code="GENERAL_CUSTOMER"/></td>
    <td><i18n:label code="SALES_TRX_DATE"/></td>
    <td><i18n:label code="GENERAL_STATUS"/></td>
    <td nowrap width=12%> Delivery Note</td>
  </tr>
	
  <%
   	for (int i=0; i<beans.length; i++) { 
    	
	  	String rowCss = "";
				
	  	if ((i+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";
  %>
  
	<tr class="<%= rowCss %>" valign=top>
    <td nowrap align=right width=3%><%= i+1 %>.</td>
    <td nowrap width=12%>
    	<small><std:link text="<%= beans[i].getTrxDocNo() %>" taskid="<%= CounterSalesManager.TASKID_VIEW_SALES %>" params="<%=("SalesID="+beans[i].getSalesID())%>" /></small>
    </td>
          
	  <td nowrap>
	  	<std:text value="<%= beans[i].getCustomerID().trim().concat(" - ").concat(beans[i].getCustomerName()).trim() %>"/>
	  </td>          
    <td align="center" nowrap width=12%><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= beans[i].getTrxDate() %>" /></td>
    <td align="center" nowrap>
    	<%= CounterSalesManager.defineDeliveryStatusName(beans[i].getDeliveryStatus()) %> 
    </td>
    <td align="center" nowrap>
    	<small><std:link text="Process" taskid="<%= CounterSalesManager.TASKID_ISSUE_DELIVERY_FORM %>" params="<%=("SalesID="+beans[i].getSalesID())%>" /></small>
    </td>
  </tr>
		    
<% 
	} // end for 
%>
	<c:if test="<%=(beans.length == 0)%>">
		<tr><td colspan=6 align=center><i18n:label code="MSG_NO_RECORDFOUND"/></td></tr>			
	</c:if>
	
</table>  
</form>
<% 
	} // end canView
%>

</body>
</html>
