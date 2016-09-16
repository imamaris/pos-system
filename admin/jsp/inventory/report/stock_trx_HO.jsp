<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
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
  InventoryBean[] invenBeans  =  (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
%>
<body onLoad="self.focus();document.com_inventory.id.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead><i18n:label code="STOCK_TRX_REPORT"/></div>
<form name="com_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_TRX,request)%>" method="post">
<table>
<tr>
  <td><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUTLET%>"/> / <i18n:label localeRef="mylocale" code="<%=OutletMessageTag.STORE_ID%>"/></td>
     <td>: <std:input type="text" name="id" value="<%=id%>"/>
  </td>
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
<form name="store_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_TRX,request)%>" method="post">
<std:input type="hidden" name="outletid" value="<%= outlet.getOutletID() %>"/>
<std:input type="hidden" name="fromDate"/>
<std:input type="hidden" name="toDate"/>
<div align=left><input class=noprint type="button" value="PRINT" onclick="window.print()"></div>
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
    int no = 0;
    for(int i=0; i<invenBeans.length;i++){
      
      if(!invenBeans[i].getTrnxType().equalsIgnoreCase("STAO") && !invenBeans[i].getTrnxType().equalsIgnoreCase("STAI") && !invenBeans[i].getTrnxType().equalsIgnoreCase("SKDI")  )
       {          
          %>
       
      
     <tr class=<%=((no%2==0)?"odd":"even")%> valign=top>
  		<td align="right"><%=no+1%>.</td>
  		<td align="left"><std:doc_invt doc="<%=invenBeans[i].getTrnxType() %>" value2="<%=invenBeans[i].getTrnxDocNo() %>" value="<%=invenBeans[i].getTrnxDocNo() %>" type="1"/> </td>
  		<td align="center"><%=invenBeans[i].getTrnxType() %></td>
		<td align=center><%=invenBeans[i].getTrnxDate()%></td>
  		<td align=left><%=invenBeans[i].getOwnerID()%></td>
  		<td align=left><%=(invenBeans[i].getStoreCode()!=null)?invenBeans[i].getStoreCode():""%></td>
  		<td align=left><%=invenBeans[i].getStd_createBy()%></td>
     </tr>
<%    
        no ++;
      }//end if 
      
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
