<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 22 July 2015
    Project     : e-receipt
--%>

<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.accesscontrol.user.LoginUserBean" %>
<%@ page import="com.ecosmosis.orca.ereceipt.EreceiptManager" %>

<%
EreceiptManager rcptMgr = new EreceiptManager();

String customerID = request.getParameter("customerID");
String custEmail = request.getParameter("custEmail");
String salesID = request.getParameter("salesID");
String invoiceNo = request.getParameter("invoiceNo");
String urlHost = "http://localhost:8080"+ request.getContextPath();
String userID = request.getParameter("userID");
String password = request.getParameter("password");
String width = "550";
String height = "600";
String result = "failed";
String layout = "potrait";
//String bccEmail = "ereceipt-check@time.co.id";

int status = Integer.parseInt(request.getParameter("status"));

rcptMgr.updateEmailCustomerByID(customerID,custEmail);

if(status == 1)
{
    if(rcptMgr.generateEreceipt(salesID,invoiceNo,urlHost,userID,password,width,height,custEmail,layout)) result = "success";
}
else if(status == 0)
{
    if(rcptMgr.generateEDM(invoiceNo,custEmail)) result = "success";
}

out.println(result);
%>