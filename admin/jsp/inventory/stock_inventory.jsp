<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">

function searchInventory(){

  var myform = document.store_inventory;
  if(myform.id.value == ""){
     
     myform.id.options[myform.id.selectedIndex].value = myform.outletid.value;
  }
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
  InventoryBean[] invenBeans  =  (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
%>
<body onLoad="self.focus();document.com_inventory.id.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead>
<i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.COMPANY_INVANTORY%>"/></div>
<form name="com_inventory" action="<%=Sys.getControllerURL(InventoryManager.TASKID_VIEW_INVENTORY,request)%>" method="post">
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

<c:if test="<%= hasInventory %>">
<form name="store_inventory" action="<%=Sys.getControllerURL(InventoryManager.TASKID_VIEW_INVENTORY,request)%>" method="post">
<std:input type="hidden" name="outletid" value="<%= outlet.getOutletID() %>"/>
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
<table class="listbox" width="70%">
  	<tr class="boxhead" valign=top>

  		<td align="right" width="3%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
                <td align="left"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PRODUCT_CODE%>"/></td>
  		<td align="left" width="10%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PRODUCT_NAME%>"/></td>
  		<td align="right" ><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.IN%>"/></td>
  		<td align="right" ><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUT%>"/></td>
  		<td align="right"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.BALANCE%>"/></td>
  		<td align="center" ><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.ACTION%>"/></td>
  		<td align="center"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PRODUCT_STATUS%>"/> *</td>
     </tr>

<% 
    for(int i=0; i<invenBeans.length;i++){
%>             
     <tr class=<%=((i%2==0)?"odd":"even")%> valign=top>
  		<td align="right"><%=i+1%>.</td>
  		<td align="left"><%=invenBeans[i].getProductBean().getProductCode() %></td>
  		<td align="left"><%=invenBeans[i].getProductBean().getDefaultName() %></td>
  		<td align=right><%=invenBeans[i].getTotalIn()%></td>
  		<td align=right><%=invenBeans[i].getTotalOut()%></td>
  		<td align=right><%=invenBeans[i].getTotal()%></td>
  		<td align="center"><small>history</small></td>
  		<td align=center><%=invenBeans[i].getProductBean().getStatus()%></td>
     </tr>
<%   
    }//end for 
%>    
        
</table>
</form>
</c:if>
<%@ include file="/lib/product_status_legend.jsp"%>
</body>
</html>
