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
  
  Calendar startCal = Calendar.getInstance();
  startCal.setTime(new Date());

  for (int i = 1; i < 7; i++)
  {
    startCal.add(Calendar.DAY_OF_MONTH, -1);
    /* If not Saturday & Sunday 
    while (startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
    {
      startCal.add(Calendar.DAY_OF_MONTH, -1);
    }
    */
  }
  
  String awal1 = Sys.getDateFormater().format(startCal.getTime());
  
%>
<body onLoad="self.focus();document.com_inventory.fromDate.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead><i18n:label code="STOCK_TRX_REPORT"/></div>
<form name="com_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_TRX,request)%>" method="post">
<table>
<tr>
  <td>Boutique ID</td>
  <td>: <%=id%> (<%= outlet.getName() %>) </td>
  <std:input type="hidden" name="id" value="<%=id%>"/>
  
</tr>
<tr>
     <td><b><i18n:label code="STOCK_TRX_DATE"/></b></td>
</tr>
<tr>
     <td><i18n:label code="GENERAL_FROM"/></td>
     <td>: <std:input type="date" name="fromDate" value="<%=awal1%>"/>
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
<table class="listbox" width="60%">
  	<tr class="boxhead" valign=top>

  		<td align="center" width="3%" ><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
  		<td align="center" width="10%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.REFERENCE_NO%>"/></td>
                <td align="center" width="8%">Type </td>
		<td align="center" width="8%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.DATE%>"/></td>
  		<td align="center" width="8%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUTLET%>"/></td>
  		<td align="center" width="8%"><i18n:label code="GENERAL_CREATEDBY"/></td>
         </tr>

<% 
    int no = 0;
    for(int i=0; i<invenBeans.length;i++){
      
      if(!invenBeans[i].getTrnxType().equalsIgnoreCase("STAO") && !invenBeans[i].getTrnxType().equalsIgnoreCase("STAI") && !invenBeans[i].getTrnxType().equalsIgnoreCase("SKDI")  )
       {
          //Updated By Ferdi 2015-09-02
          String docInitial = invenBeans[i].getTrnxDocNo().substring(0,2);
          if(invenBeans[i].getTrnxDocNo().substring(2,3).equalsIgnoreCase("/")) docInitial = invenBeans[i].getTrnxDocNo().substring(3,5);
          //End Updated
          %>
       
      
     <tr class=<%=((no%2==0)?"odd":"even")%> valign=top>
  		<td align="right"><%=no+1%>.</td>
  		<td align="left">
                    <!-- Updated By Ferdi 2015-09-02 -->
                    <% if(docInitial.equalsIgnoreCase("GR")){ %>
                    <std:doc_invt doc="<%=docInitial %>" value2="<%=invenBeans[i].getTrnxDocNo() %>" value="<%=invenBeans[i].getTrnxDocNo() %>" type="1"/> 
                    <% } else { %>
                    <std:doc_invt doc="<%=invenBeans[i].getTrnxType() %>" value2="<%=invenBeans[i].getTrnxDocNo() %>" value="<%=invenBeans[i].getTrnxDocNo() %>" type="1"/> 
                    <% } %>
                    <!-- End Updated -->
                </td>
		<td align=center>
                    <%= (invenBeans[i].getTrnxDocNo().substring(2,3).equalsIgnoreCase("/")) ? invenBeans[i].getTrnxDocNo().substring(3,5) : invenBeans[i].getTrnxDocNo().substring(0,2)%>
                </td>    
                <td align=center><%=invenBeans[i].getTrnxDate()%></td>
  		<td align=left><%=invenBeans[i].getOwnerID()%></td>
  		<td align=left><%=invenBeans[i].getStd_createBy()%></td> 
     </tr>
<%    
        no ++;
      }//end if 
      
    }//end for 
%>    

<tr valign=top>
  <td align="left" colspan="6"><marquee> <font color="blue">  Please click on the Reference No. for preview document </font></marquee></td>
</tr>

</table>

</form>
</c:if>
</body>
</html>
