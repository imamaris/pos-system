<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@page import="com.ecosmosis.orca.product.ProductBean"%>
<%@page import="com.ecosmosis.orca.inventory.StockMovementRptBean.StockInfo"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">

function searchInventory(){

  var upperform = document.com_inventory;
  var myform = document.store_inventory;
  if(myform.id.value == ""){
     
     myform.id.options[myform.id.selectedIndex].value = myform.outletid.value;
  }
  
  myform.fromDate.value = upperform.fromDate.value;
  myform.toDate.value = upperform.toDate.value;
  myform.submit();
}
</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  String id = (String) returnBean.getReturnObject("ID");
  boolean hasInventory = (returnBean.getReturnObject("hasInventory")!=null)?(Boolean) returnBean.getReturnObject("hasInventory"):false;
  OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
  TreeMap stores = (TreeMap) returnBean.getReturnObject("Stores");

  StockMovementRptBean report  =  (StockMovementRptBean) returnBean.getReturnObject("MovementReport");
  
  // 2010-02-12
  // Map catMap = (Map) returnBean.getReturnObject(InventoryReportManager.RETURN_CATLIST_CODE);
  // String CatID = request.getParameter("CatID");
  
  //2010-02-22
  ProductCategoryBean[] beans = (ProductCategoryBean[]) returnBean.getReturnObject("CatList");
%>
<body onLoad="self.focus();document.com_inventory.id.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>

<div class=functionhead><i18n:label code="STOCK_MOVEMENT_REPORT"/></div>
<form name="com_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_MOVEMENT,request)%>" method="post">
<table>
<tr>
    <td><b><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUTLET%>"/> / <i18n:label localeRef="mylocale" code="<%=OutletMessageTag.STORE_ID%>"/></b></td>
     <td>: <std:input type="text" name="id" value="<%=id%>"/></td>

     
     
			<td align="right"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
	 		<td >
	            <select name="CatID">
		 		    <option value=""><i18n:label code="GENERAL_ALL"/></option>
					<%
					for (int i=0;i<beans.length;i++) { 
					%>
					<option value="<%=beans[i].getCatID()%>"><%=beans[i].getName()%></option>
					<%
					} // end for
					%>
				</select>
			</td>
     
</tr>
<tr>
     <td><b><i18n:label code="STOCK_TRX_DATE"/></b></td>
</tr>
<tr>
     <td align="right"><i18n:label code="GENERAL_FROM"/></td>
     <td>: <std:input type="date" name="fromDate" value="now"/>
     </td>

</tr>
<tr>
     <td align="right"><i18n:label code="GENERAL_TO"/></td>
     <td>: <std:input type="date" name="toDate" value="now"/>
     </td>
</tr>

</table>
<br>
<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>
<hr>

<c:if test="<%= hasInventory %>">
<form name="store_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_MOVEMENT,request)%>" method="post">
<std:input type="hidden" name="outletid" value="<%= outlet.getOutletID() %>"/>
<std:input type="hidden" name="fromDate"/>
<std:input type="hidden" name="toDate"/>
<div align=left><input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()"></div>
<br>
<table>
	<tr>
		<td><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUTLET%>"/></td>
		<td>: <b><%= outlet.getOutletID() %> (<%= outlet.getName() %>)</b></td>
	</tr>
	<tr>
		<td><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.STORE%>"/></td>
		<td>: 
        	<std:input type="select" name="id" options="<%=stores%>" value="" status="onChange=searchInventory();"/>
        </td>
	</tr>

</table>
<br>
<table class=listbox width=100%>
	<tr class="boxhead" valign=top>
          <td rowspan=2 width="10%" align="left"><i18n:label code="PRODUCT_CODE"/></td>
          <td rowspan=2 width="26%" align="left"><i18n:label code="PRODUCT_NAME"/></td>
	  <td rowspan=2 width="8%" align="right"><i18n:label code="GENERAL_BRING_FORWARD"/></td>
	  
	  <td colspan=2 width="8%"><i18n:label code="STOCK_PURCHASE_SHORT"/></td>	  
	  <td colspan=2 width="8%"><i18n:label code="STOCK_LOAN"/></td>
	  <td colspan=2 width="8%"><i18n:label code="STOCK_DISCREPANCY_SHORT"/></td>
	  
	  <td colspan=2 width="8%"><i18n:label code="STOCK_SALES"/></td>
	  <td colspan=2 width="8%"><i18n:label code="STOCK_TRANSFER"/></td>
	  	  
	  <td colspan=2 width="8%"><i18n:label code="STOCK_ABOLISH_SHORT"/></td>	  
	  <td colspan=2 width="8%"><i18n:label code="STOCK_COMPLIMENT_SHORT"/></td>

	  
	  <td rowspan=2 width="8%" align="right"><i18n:label code="STOCK_BALANCE"/></td>
	</tr>
        
        
	<tr class="boxhead">            
	<td align="right"><i18n:label code="STOCK_IN"/></td>
  	<td align="right"><i18n:label code="STOCK_OUT"/></td>
	<td align="right"><i18n:label code="STOCK_IN"/></td>
  	<td align="right"><i18n:label code="STOCK_OUT"/></td>
	<td align="right"><i18n:label code="STOCK_IN"/></td>
  	<td align="right"><i18n:label code="STOCK_OUT"/></td>  	
	<td align="right"><i18n:label code="STOCK_IN"/></td>
  	<td align="right"><i18n:label code="STOCK_OUT"/></td>
	<td align="right"><i18n:label code="STOCK_IN"/></td>
  	<td align="right"><i18n:label code="STOCK_OUT"/></td>
  	  	
  	<td colspan=2 align="right"><i18n:label code="STOCK_OUT"/></td>
  	<td colspan=2 align="right"><i18n:label code="STOCK_OUT"/></td>

	</tr>
	<%
		int[] qty = new int[18];
		ProductBean[] items = report.getProductItems();                		
                int prevCategory = -1;
		boolean isHeader = false;
		int total_fields = 0;
        
                
	if(items.length > 0){
			
		for (int i=0; i < items.length; i++) {
			// isHeader = items[i].getProductCategory().getCatID() != prevCategory; 
			// prevCategory = items[i].getProductCategory().getCatID();
			
			int counter = 0;
			StockMovementRptBean.StockInfo stock = report.getStockInfo(String.valueOf(items[i].getProductID()));
                        
			qty[counter++] += stock.getPurchaseIn();
			qty[counter++] += stock.getPurchaseOut();
			qty[counter++] += stock.getLoanIn();
			qty[counter++] += stock.getLoanOut();
			qty[counter++] += stock.getDiscrIn();
			qty[counter++] += stock.getDiscrOut();
			qty[counter++] += stock.getSalesIn();
			qty[counter++] += stock.getSalesOut();
			qty[counter++] += stock.getTransferIn();
			qty[counter++] += stock.getTransferOut();
			qty[counter++] += stock.getDisposeOut();
			qty[counter++] += stock.getFreeOut();

			
			//qty[counter++] += 0;
			//qty[counter++] += stock.getReturnOut();
			//qty[counter++] += stock.getAdjustmentIn();
			//qty[counter++] += stock.getAdjustmentOut();
			//qty[counter++] += stock.getDisposeIn();			
			//qty[counter++] += stock.getTransferIn();
			//qty[counter++] += stock.getTransferOut();			
			//qty[counter++] += stock.getFreeIn();
			//qty[counter++] += stock.getFreeOut();
			total_fields = counter;
	%>
        
        
        <%		
	if((stock.getBringForwardBalance() > 0d) || (stock.getBringForwardBalance() > 0d)){
	%>   
                 
        <% isHeader = items[i].getProductCategory().getCatID() != prevCategory;
           prevCategory = items[i].getProductCategory().getCatID(); 
        %>

	<%if (isHeader){%>
	  	<tr class="head" valign=top>
                    <td colspan=21 align=left><b><%=items[i].getProductCategory().getName()%></b></td>
	  	</tr>
	<%}%>
        
	<%	
	String css_class = "";
	if(items[i].getSafeLevel() >= stock.getBalance())
		css_class = "alert";
	%>             
        
        
	<tr align=right class="<%=css_class%>" >
          <td align=left width=10% ><%= items[i].getProductCode() %></td>
          <td align=left width=30% ><%= items[i].getDefaultName() %></td>
	  <td ><%= stock.getBringForwardBalance() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>"><%= stock.getPurchaseIn() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>"><%= stock.getPurchaseOut() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"even"%>"><%= stock.getLoanIn() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"even"%>"><%= stock.getLoanOut() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>"><%= stock.getDiscrIn() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>"><%= stock.getDiscrOut()  %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"even"%>"><%= stock.getSalesIn() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"even"%>"><%= stock.getSalesOut() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>" colspan=1><%= stock.getTransferIn() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"even"%>" colspan=1><%= stock.getTransferOut() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>" colspan=2><%= stock.getDisposeOut() %></td>
	  <td class="<%=(css_class.length()>0)?css_class:"even"%>" colspan=2><%= stock.getFreeOut() %></td>

	  
	  <td class="<%=(css_class.length()>0)?css_class:"odd"%>"><b><%= stock.getBalance() %></b></td>
	</tr>
                
        <%
            }     // end if
        %>
        
	<%                        
			} // end for
	
	%>
	<tr class="head">
	  <td colspan=3 align=center><b><i18n:label code="GENERAL_TOTAL"/></b></td>
	<%
			for (int i=0; i< total_fields - 2 ; i++) {
	%>
	  <td align=right><%= qty[i] %></td>
	<%
			}
	%>
      	<td align=right colspan=2><%= qty[total_fields - 2] %></td>
      	<td align=right colspan=2><%= qty[total_fields - 1] %></td>
	  <td></td>
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
