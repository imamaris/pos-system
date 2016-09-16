<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">
</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  String id = (String) returnBean.getReturnObject("ID");  
  ProductCategoryBean[] beans = (ProductCategoryBean[]) returnBean.getReturnObject("CatList"); 
  
  String target = (String) returnBean.getReturnObject("Target");  
  int taskid = (Integer) returnBean.getReturnObject("TaskID");  
  
  Map sellerMap = (Map) returnBean.getReturnObject(InventoryManager.RETURN_SELLERLIST_CODE);
  
%>
<body onLoad="self.focus();document.ops_inventory.storeTo.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>
<div class=functionhead><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.INVENTORY_OPERATION%>"/> -  <i18n:label code="STOCK_TRANSFER_EXTERNAL"/></div>
<form name="ops_inventory" action="<%=Sys.getControllerURL(taskid, request)%>" method="post">
<table width="80%">
<tr  >
  <td width="10%">Boutique ID </td>
  <td width="30%">: <%=id%></td>    
  <std:input type="hidden" name="id" value="<%=id%>" />
  
  <td width="20%" align=center><b>Transfer To </b></td>
  <td width="10%">Boutique ID</td>               
  <td>: <std:input type="select" name="storeTo" options="<%= sellerMap %>" /></td>    
</tr>

<tr >
  <td width="10%">Doc. Date </td>
  <td width="30%">: <std:input type="date" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/> yyyy-mm-dd</td>
  <td width="20%" align=center><b></td>
                <td>Product Brand</td>
                <td>:
                    <select name="brand">
                        <option value=""></option>
                        <%
                        for (int i=0;i<beans.length;i++) { 
                        %>
                        <option value="<%=beans[i].getName()%>"><%=beans[i].getName()%></option>
                        <%
                        } // end for
                        %>
                    </select>
                </td>   
</tr>

<std:input type="hidden" name="brand"/>

</table>
<br>
<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>
<hr>

</body>
</html>
