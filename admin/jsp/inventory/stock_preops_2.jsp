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
<body onLoad="self.focus();document.ops_inventory.id.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.INVENTORY_OPERATION%>"/></div>
<form name="ops_inventory" action="<%=Sys.getControllerURL(taskid, request)%>" method="post">
<table>
<tr>
  <td><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUTLET%>"/> / <i18n:label localeRef="mylocale" code="<%=OutletMessageTag.STORE_ID%>"/></td>
     <td>: <std:input type="text" name="id" value="<%=id%>"/>
  </td>
</tr>
</table>
<br>
<input class="textbutton" type="submit" value="Submit">
</form>
<hr>

</body>
</html>
