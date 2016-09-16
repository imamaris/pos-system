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
  
  Map deliveryStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_DELIVERYSTATUS_CODE);
  
  Map orderByMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_ORDERBY_CODE);
	
	Map recordsMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SHOWRECS_CODE);
	
	DeliveryOrderBean[] beans = (DeliveryOrderBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_DELIVERYLIST_CODE);
  
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

<div class="functionhead"><i18n:label code="DELIVERY_LISTING"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(CounterSalesManager.TASKID_DELIVERY_LIST,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
	<table border="0">
	  <tr>
	    <td class="td1"><i18n:label code="DELIVERY_REFERENCE"/>:</td>
	    <td><std:input type="text" name="TrxDocNo" size="30" maxlength="20"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="SALES_REFERENCE"/>:</td>
	    <td><std:input type="text" name="SalesTrxDocNo" size="30" maxlength="20"/></td>
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
	    <td><std:input type="date" name="TrxDateFrom"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="GENERAL_TODATE"/>:</td>
	    <td><std:input type="date" name="TrxDateTo"/></td>
	  </tr>
	  <tr>
	    <td class="td1"><i18n:label code="GENERAL_STATUS"/>:</td>
	    <td colspan="4"><std:input type="select" name="Status" options="<%= deliveryStatusMap %>" /></td>
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
    <td><i18n:label code="DELIVERY_REFERENCE"/></td>
    <td><i18n:label code="GENERAL_CUSTOMER"/></td>
    <td><i18n:label code="SALES_TRX_DATE"/></td>
    <td><i18n:label code="GENERAL_STATUS"/></td>
    <td><i18n:label code="DELIVERY_VOID"/></td>
  </tr>
	
  <%
  	boolean isActive = false;
  	boolean isOwn = false;
  	boolean canAdjst = false;
  	
   	for (int i=0; i<beans.length; i++) { 
    	
	  	String rowCss = "";
				
	  	if ((i+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";
	  	
      isOwn = false;
      isActive = beans[i].getStatus() == CounterSalesManager.STATUS_ACTIVE;
      canAdjst = !beans[i].getTrxDocNo().equals(beans[i].getSalesRefNo());
      
      if (isActive) {
	      if (loginUser.getOutletID().equals(beans[i].getShipByOutletID()))
      		isOwn = true;
      } else {
	      rowCss = "alert";
      }
  %>
  
	<tr class="<%= rowCss %>" valign=top>
    <td nowrap align=right><%= i+1 %>.</td>
    <td><small><std:link text="<%= beans[i].getSalesRefNo() %>" taskid="<%= CounterSalesManager.TASKID_VIEW_SALES %>" params="<%=("SalesID="+beans[i].getSalesID())%>" /></small></td>
    <td><small><std:link text="<%= beans[i].getTrxDocNo() %>" taskid="<%= CounterSalesManager.TASKID_VIEW_DELIVERY %>" params="<%=("DeliveryID="+beans[i].getDeliveryID())%>" /></small></td>
	  <td nowrap>
	  	<std:text value="<%= beans[i].getCustomerID() %>"/>
  		<% if (beans[i].getCustomerID() != null) { %>
			<br>
			<% } %>
		  <std:text value="<%= beans[i].getCustomerName() %>"/>
	  </td>
    <td align="center" nowrap><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= beans[i].getTrxDate() %>" /></td>
    <td align="center" nowrap>
    	<%= CounterSalesManager.defineTrxStatusName(beans[i].getStatus()) %> 
    </td>
    
     <% 
    	if (isActive && isOwn && canAdjst) {
    %>
    
    <td align="center">
    	<small><std:link text="<%=lang.display("DELIVERY_VOID")%>" taskid="<%= CounterSalesManager.TASKID_VOID_DELIVERY %>" params="<%=("DeliveryID="+beans[i].getDeliveryID())%>" /></small>
    </td>

    <%
    	} else {
    %>
    
    <td>-</td>
    
    <%
    	} // end refund action
    %>
    
  </tr>
		    
	<% 
		} // end for 
	%>
	<c:if test="<%=(beans.length == 0)%>">
		<tr><td colspan=7 align=center><i18n:label code="MSG_NO_RECORDFOUND"/></td></tr>			
	</c:if>
</table>  
</form>

<% 
	} // end canView
%>

</body>
</html>
