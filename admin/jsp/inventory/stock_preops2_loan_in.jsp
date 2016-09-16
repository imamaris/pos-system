<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

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
    
  String custID = (String) returnBean.getReturnObject("CustomerID");
  if(custID.equalsIgnoreCase("33620"))
     custID = ""; 
  String custName = (String) returnBean.getReturnObject("CustomerName");

  System.out.println("Nilai custID "+custID +" Nama "+custName);
  
  String target = (String) returnBean.getReturnObject("Target");  
  int taskid = (Integer) returnBean.getReturnObject("TaskID");  
  
  Calendar startCal = Calendar.getInstance();
  startCal.setTime(new Date());

  for (int i = 1; i < 7; i++)
  {
    startCal.add(Calendar.DAY_OF_MONTH, 1);
  }
  
  String awal1 = Sys.getDateFormater().format(startCal.getTime());

  System.out.println("Nilai awal "+awal1);
  
%>
<body onLoad="self.focus();document.ops_inventory.storeTo.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>
<div class=functionhead>Store Operations -  Stock Loan IN </div>
<form name="ops_inventory" action="<%=Sys.getControllerURL(taskid, request)%>" method="post">
<table width="80%">
<tr  >
  <td width="10%">Boutique ID </td>
  <td width="30%">: <%=id%></td>    
  <std:input type="hidden" name="id" value="<%=id%>" />
  
  <td width="20%" align=center><b>Receive From </b></td>
  <td width="10%">Customer ID</td>               

            <td>:
                <std:memberidloan name="storeTo" form="ops_inventory"  value="<%= custID %>" />  
            </td>    
            
            <%
              System.out.println("chek nilai custID "+ custID);
            %>            
</tr>

<tr >
  <td width="10%">Doc. Date </td>
  <td width="30%">: <std:input type="date" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/> yyyy-mm-dd</td>
  <td width="20%" align=center><b></td>
  <td>Reminder Date</td>
  <td width="30%">: <%=awal1%></td>  
</tr>


<std:input type="hidden" name="brand"/>

</table>
<br>
<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>
<hr>

</body>
</html>
