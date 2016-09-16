<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">
</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  boolean hasInventory = (returnBean.getReturnObject("hasInventory")!=null)?(Boolean) returnBean.getReturnObject("hasInventory"):false;
  StockistBean stockist = (StockistBean) returnBean.getReturnObject("Outlet");
  InventoryBean[] invenBeans  =  (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
%>
<body onLoad="self.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead><i18n:label code="STOCKIST_INVENTORY"/></div>
<form name="com_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_VIEW_INVENTORY_INV, request)%>" method="post">
<table>
<tr>
	 	<td ><i18n:label code="STOCKIST_ID"/></td>
	 	<td>: <std:stockistid form="com_inventory" name="StockistID" value="" /></td>
</tr>
<tr>
     <td><b><i18n:label code="STOCK_TRX_DATE"/></b></td>
</tr>
<tr>
     <td><i18n:label code="GENERAL_FROM"/></td>
     <td>: <std:input type="date" name="fromDate" value="now"/>
     </td>
</tr>
<tr>
     <td><i18n:label code="GENERAL_TO"/></td>
     <td>: <std:input type="date" name="toDate" value="now"/>
     </td>
</tr>
</table>
<br>
<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>
<hr>

<c:if test="<%= hasInventory %>">
<form name="store_inventory">
<table>
	<tr>
		<td><i18n:label code="STOCKIST_ID"/></td>
		<td>: <b><%= stockist.getStockistCode() %></b></td>
	</tr>
	<tr>
		<td><i18n:label code="GENERAL_NAME"/></td>
		<td>: <b><%= stockist.getName() %></b></td>
	</tr>
</table>
<br>
<table class="listbox" width="70%">
  	<tr class="boxhead" valign=top>

  		<td align="right" width="3%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
  		<td align="left" width="5%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PRODUCT_CODE%>"/></td>
  		<td align="left" width="15%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PRODUCT_NAME%>"/></td>
		<td align=right width="3%"><i18n:label code="GENERAL_BRING_FORWARD"/></td>
  		<td align=right width="3%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.IN%>"/></td>
  		<td align=right width="3%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUT%>"/></td>
  		<td align=right width="3%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.BALANCE%>"/></td>
  		<!-- td align="center" width="5%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.ACTION%>"/></td -->
  		<td align="center" width="8%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PRODUCT_STATUS%>"/> *</td>
     </tr>

<% 
    for(int i=0; i<invenBeans.length;i++){
%> 
<%
	
	int total_balance = (invenBeans[i].getTotalBringForward() + invenBeans[i].getTotal());
	String css_class = "";
	if(invenBeans[i].getProductBean().getSafeLevel() >= total_balance)
		css_class = "alert";
%>              
     <tr class="<%=(css_class.length()>0)?css_class:((i%2==0)?"odd":"even")%>" valign=top>
  		<td align="right"><%=i+1%>.</td>
  		<td align="left"><%=invenBeans[i].getProductBean().getProductCode() %></td>
  		<td align="left"><%=invenBeans[i].getProductBean().getDefaultName() %></td>
		<td align=right><%=invenBeans[i].getTotalBringForward()%></td>
  		<td align=right><%=invenBeans[i].getTotalIn()%></td>
  		<td align=right><%=invenBeans[i].getTotalOut()%></td>
  		<td align=right><b><%=(invenBeans[i].getTotalBringForward() + invenBeans[i].getTotal())%></b></td>
  		<!-- td align="center"><small>history</small></td-->
  		<td align=center><%=invenBeans[i].getProductBean().getStatus()%></td>
     </tr>
<%   
    }//end for 
%>    
        
</table>
</form>
<%@ include file="/lib/product_status_legend.jsp"%>
</c:if>
</body>
</html>
