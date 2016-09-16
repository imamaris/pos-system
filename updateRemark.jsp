<%-- 
    Created By  : Mila Yuliani
    Created on  : 03-Aug-2016
    Project     : Remark
--%>

<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.accesscontrol.user.LoginUserBean" %>
<%@ page import="com.ecosmosis.orca.counter.sales.CounterSalesManager" %>

<%
CounterSalesManager csoMgr = new CounterSalesManager();

String salesID = request.getParameter("salesID");
String remark = request.getParameter("remark");
String result = "failed";
    
if(csoMgr.updateRemark(salesID,remark)) result = "success";

out.println(result);
%>