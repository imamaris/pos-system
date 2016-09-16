 <%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@page import="com.ecosmosis.orca.product.ProductBean"%>
<%@page import="com.ecosmosis.orca.inventory.StockMovementRptBean.StockInfo"%>
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

  StockMovementRptBean report  =  (StockMovementRptBean) returnBean.getReturnObject("MovementReport");
%>
<body onLoad="self.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>

<div class=functionhead><i18n:label code="STOCK_MOVEMENT_REPORT"/></div>
<form name="com_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_MOVEMENT_INV,request)%>" method="post">
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
<table class=listbox width=60%>
	<tr class="boxhead" valign=top>
	  <td rowspan=2 width="26%" align="left"><i18n:label code="PRODUCT_NAME"/></td>
	  <td rowspan=2 width="8%" align="right"><i18n:label code="GENERAL_BRING_FORWARD"/></td>
	  
	  <td colspan=2 width="8%"><i18n:label code="STOCK_SALES"/></td>
	  <td colspan=2 width="8%"><i18n:label code="STOCK_TRANSFER"/></td>
	  
	  <td rowspan=2 width="8%" align="right"><i18n:label code="STOCK_BALANCE"/></td>
	</tr>
	<tr class="boxhead">
	<td align="right"><i18n:label code="STOCK_IN"/></td>
  	<td align="right"><i18n:label code="STOCK_OUT"/></td>
	<td align="right"><i18n:label code="STOCK_IN"/></td>
  	<td align="right"><i18n:label code="STOCK_OUT"/></td>

	</tr>
	<%
		int[] qty = new int[18];
		ProductBean[] items = report.getProductItems();
		int prevCategory = -1;
		boolean isHeader = false;
		int total_fields = 0;

	if(	items.length > 0){
		for (int i=0; i < items.length; i++) {
			isHeader = items[i].getProductCategory().getCatID() != prevCategory; 
			prevCategory = items[i].getProductCategory().getCatID();
			
			int counter = 0;
			StockMovementRptBean.StockInfo stock = report.getStockInfo(String.valueOf(items[i].getProductID()));
	
			qty[counter++] += stock.getSalesIn();
			qty[counter++] += stock.getSalesOut();
			qty[counter++] += stock.getTransferIn();
			qty[counter++] += stock.getTransferOut();

			total_fields = counter;
	%>
	<%if (isHeader){%>
	  	<!--<tr class="head" valign=top>
	  	  <td colspan=21 align=left>--><!--%=items[i].getCategoryBean().getPct_name()%--><!--</td>
	  	</tr>-->
	<%}%>
	<%	
	String css_class = "";
	if(items[i].getSafeLevel() >= stock.getBalance())
		css_class = "alert";
	%>  
	<tr align=right class="<%=css_class%>">
	  <td align=left width=30% ><%= items[i].getDefaultName() %><br>(<%= items[i].getProductCode() %>)</td>
	  <td ><%= stock.getBringForwardBalance() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>"><%= stock.getSalesIn() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"even"%>"><%= stock.getSalesOut() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>" colspan=1><%= stock.getTransferIn() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"even"%>" colspan=1><%= stock.getTransferOut() %></td>
  	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>"><b><%= stock.getBalance() %></b></td>
	</tr>
	<%
			} // end for
	
	%>
	<tr class="head">
	  <td colspan=2 align=right><b><i18n:label code="GENERAL_TOTAL"/></b></td>
	<%
			for (int i=0; i< total_fields; i++) {
	%>
	  			<td align=right><%= qty[i] %></td>
	<%
			}
	%>
	  <td>&nbsp;</td>
	</tr>
</table>
<br>
<div align=left><input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()"></div>
<br>
</form>
<%}%>
</c:if>
</body>
</html>
