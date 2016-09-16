<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">
</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  String id = (String) returnBean.getReturnObject("ID");  
  String target = (String) returnBean.getReturnObject("Target");  
  int taskid = (Integer) returnBean.getReturnObject("TaskID");  
  
  Map sellerMap = (Map) returnBean.getReturnObject(InventoryManager.RETURN_SELLERLIST_CODE);
  
%>
<body onLoad="self.focus();document.ops_inventory.id.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>
<div class=functionhead><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.INVENTORY_OPERATION%>"/> -  <i18n:label code="STOCK_TRANSFER_EXTERNAL"/></div>
<form name="ops_inventory" action="<%=Sys.getControllerURL(taskid, request)%>" method="post">
<table width="80%">
<tr  >
  <td width="10%">Boutique ID </td>
  <td width="20%">: <std:input type="text" name="id" value="<%=id%>"/></td>  
  <td width="20%" align=center><b>Transfer To </b></td>
  <td width="10%">Boutique ID</td>               
  <td>: <std:input type="select" name="storeTo" options="<%= sellerMap %>" /></td>  
  
</tr>

</table>
<br>
<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>
<hr>

</body>
</html>
