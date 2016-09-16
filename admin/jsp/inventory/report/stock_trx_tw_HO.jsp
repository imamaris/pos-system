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
<div class=functionhead>Stock Transfer Report</div>
<form name="com_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_TRX_TW,request)%>" method="post">
<table>
<tr>
  <td><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUTLET%>"/> / <i18n:label localeRef="mylocale" code="<%=OutletMessageTag.STORE_ID%>"/></td>
  <td>: <std:input type="text" name="id" value="<%=id%>"/></td>
  
  <td></td>
  <td>Filter Verify :</td>
  <td>OUT/IN</td>

  
</tr>
<tr>
     <td><b><i18n:label code="STOCK_TRX_DATE"/></b></td>
     
     <td colspan="3"></td>
     
</tr>
<tr>
     <td><i18n:label code="GENERAL_FROM"/></td>
     <td>: <std:input type="date" name="fromDate" value="now"/>
     </td>
     
      <td colspan="3"></td>
      
</tr>
<tr>
     <td><i18n:label code="GENERAL_TO"/></td>
     <td>: <std:input type="date" name="toDate" value="now"/>
     </td>
     
      <td colspan="3"></td>
      
</tr>
</table>
<br>
<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>
<hr>

<c:if test="<%= hasInventory %>">
<form name="store_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_TRX_TW,request)%>" method="post">
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

  		<td align=center width="3%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
  		<td align=center width="12%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.REFERENCE_NO%>"/></td>
		<td align=center width="8%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.DATE%>"/></td>
  		<td align=center width="8%">TW From </td>
  		<td align=center width="8%">TW To</td>
                <td align=center width="8%">Status Doc.</td>    
  		<td align=center width="8%"><i18n:label code="GENERAL_CREATEDBY"/></td>                                                     
     </tr>

<% 
    String TwFrom = "";
    String TwTo = "";
    String string1 = "";
    String[] str1;
    String string2 = "";
    String[] str2;
    
    int Out = 0;
    int In = 0;
    
    for(int i=0; i<invenBeans.length;i++){
        
                  string1 = invenBeans[i].getStoreCode();
                  string2 = invenBeans[i].getTarget();
                  str1 = string1.split("-");
                  str2 = string2.split("-");
                  
                if(invenBeans[i].getTrnxType().equalsIgnoreCase("STAI"))
                 {
                  TwTo = str1[0];
                  TwFrom =  str2[0];
                 }else{  
                  TwFrom = str1[0];
                  TwTo =  str2[0];              
                 }
                                 
                        
%>             
     <tr class=<%=((i%2==0)?"odd":"even")%> valign=top>
  		<td align=center><%=i+1%>.</td>
  		<td align=center><std:doc_invt doc="<%=invenBeans[i].getTrnxType() %>" value2="<%=invenBeans[i].getTrnxDocNo() %>" value="<%=invenBeans[i].getTrnxDocNo() %>" type="1"/> </td>
		<td align=center><%=invenBeans[i].getTrnxDate()%></td>                
                
  		<td align=center> <%=TwFrom %></td>
  		<td align=center> <%=TwTo %> </td>
                <% if(invenBeans[i].getStatus()==90 && invenBeans[i].getTrnxType().equalsIgnoreCase("STAO"))  
                   { 
                %>
  		<td align=center><std:doc_invt doc="<%=invenBeans[i].getTrnxType() %>" value2= "<%=invenBeans[i].getTrnxDocNo() %>" value="Verify OUT" type="1"/> </td>
                <% 
                   }else if(invenBeans[i].getStatus()==100 && invenBeans[i].getTrnxType().equalsIgnoreCase("STAI")) { 
                %>
                <td align=center><std:doc_invt doc="<%=invenBeans[i].getTrnxType() %>" value2= "<%=invenBeans[i].getTrnxDocNo() %>" value="Verify IN" type="1"/> </td>
                <% 
                   }else if(invenBeans[i].getStatus()==50 || invenBeans[i].getStatus()==40) { 
                %>
                <td align=center>Voided </td>
                <% 
                   }else {
                %>                                 
                <td align=center>Allocate</td>
                <% 
                   } // end if
                %>   
                
                                
  		<td align=center><%=invenBeans[i].getStd_createBy()%></td>                
            </tr>
<%   
    }//end for 
%>    
<tr><td width="10"></td></tr> 



</table>
<br>
<table>
<tr >
    <td align="left"> <b>Verify OUT</b></td>
    <td align="left"> : The document has been Created, needs to be Verify OUT by Your Boutique </td>
</tr> 
<tr>
    <td align="left"> <b>Verify IN</b></td>    
<td align="left"> : The document has been Verified OUT, needs to be Verified IN by Your Boutique </td>
</tr> 
<tr>
    <td align="left"><b> Allocate</b></td>    
<td align="left"> : The document has been Verified OUT, needs to be Verified IN by Other Boutique </td>
</tr> 
<tr>
    <td align="left"><b> Voided</b></td>    
<td align="left"> : The document has been VOIDED </td>
</tr> 
</table>
<br>
</form>
</c:if>
</body>
</html>
