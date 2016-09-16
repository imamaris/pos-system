<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
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
<div class=functionhead><i18n:label code="STOCK_TRX_REPORT"/></div>
<form name="com_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_TRX_INV,request)%>" method="post">
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
<table class="listbox" width="100%">
  	<tr class="boxhead" valign=top>

  		<td align="right" width="3%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
  		<td align="left" width="15%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.REFERENCE_NO%>"/></td>
		<td align=center width="8%"><i18n:label code="GENERAL_TYPE"/>*</td>
		<td align=center width="8%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.DATE%>"/></td>
  		<td align=left width="8%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUTLET%>"/></td>
  		<td align=left width="8%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.STORE%>"/></td>
  		<td align=left width="8%"><i18n:label code="GENERAL_CREATEDBY"/></td>
     </tr>

<% 
    for(int i=0; i<invenBeans.length;i++){
%>             
     <tr class=<%=((i%2==0)?"odd":"even")%> valign=top>
  		<td align="right"><%=i+1%>.</td>
  		<td align="left"><std:doc_invt doc="<%=invenBeans[i].getTrnxType() %>" value="<%=invenBeans[i].getTrnxDocNo() %>" type="1"/> </td>
  		<td align="center"><%=invenBeans[i].getTrnxType() %></td>
		<td align=center><%=invenBeans[i].getTrnxDate()%></td>
  		<td align=left><%=invenBeans[i].getOwnerID()%></td>
  		<td align=left><%=(invenBeans[i].getStoreCode()!=null)?invenBeans[i].getStoreCode():""%></td>
  		<td align=left><%=invenBeans[i].getStd_createBy()%></td>
     </tr>
<%   
    }//end for 
%>    
        
</table>
<br>
<div align=left><input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()"></div>
<br>
</form>
</c:if>
</body>
</html>
