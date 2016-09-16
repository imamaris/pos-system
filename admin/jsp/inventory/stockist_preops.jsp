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
  int taskid = (Integer) returnBean.getReturnObject("TaskID");  
%>
<body onLoad="self.focus();document.ops_inventory.StockistID.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead><i18n:label code="<%=InventoryMessageTag.INVENTORY_OPERATION%>"/></div>
<form name="ops_inventory" action="<%=Sys.getControllerURL(taskid, request)%>" method="post">
<table>
<tr>
  <td><i18n:label code="STOCKIST_ID"/></td>
  <td>: <std:stockistid form="ops_inventory" name="StockistID" value="" />
  </td>
</tr>
</table>
<br>
<input class="textbutton" type="submit" value="Submit">
</form>
<hr>

</body>
</html>
