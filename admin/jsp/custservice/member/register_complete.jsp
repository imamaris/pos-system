<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
  MemberBean newBean = (MemberBean) returnBean.getReturnObject(MemberManager.RETURN_MBRBEAN_CODE);
  
  String alamat1 = newBean.getAddress().getAddressLine1().trim().toString();
  String alamat2 = newBean.getAddress().getAddressLine2().trim().toString();
  String alamat3 = newBean.getAddress().getZipCode().trim().toString();
  String alamat4 = newBean.getAddress().getCity().getName().trim().toString();
  String alamat5 = newBean.getAddress().getCountry().getName().trim().toString();
  
  String alamat = alamat1.concat(" ").concat(alamat2).concat(" ").concat(alamat3).concat(" - ").concat(alamat4).concat(" - ").concat(alamat5).toString();
  
  System.out.println("Nilai Alamat "+alamat);
  
  String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
  
  String noPin = request.getParameter("nopin");
  
  String noPinParam = "";
  if (noPin != null)
  	noPinParam = "&nopin=f";
  
  int taskID = 0;
  int taskID2 = 0;      
	if (task != null) 
		taskID = Integer.parseInt(task);
		taskID2 = Integer.parseInt("101023");                
%>

<html>
<head>
  <title></title>
  
  <%@ include file="/lib/header.jsp"%>
</head>

<body>

<div class="functionhead">Customer Registration Complete</div>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<%@ include file="/admin/jsp/custservice/member/full_member_profile.jsp"%>

<br>

<input class="textbutton noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print()">
<input class="textbutton noprint" type="button" value="CUSTOMER SALES ENTRY" onClick="location.href='<%= Sys.getControllerURL(CounterSalesManager.TASKID_NORMAL_SALES_PREFORM_FULL_DELIVERY_HE,request) %>&CustomerContact=<%= newBean.getMobileNo() %>&CustomerID=<%= newBean.getMemberID() %>&CustomerName=<%= newBean.getName() %>&CustomerAlamat=<%= alamat %>'">            

</body>
</html>