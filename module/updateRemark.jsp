<%-- 
    Created By  : Mila Yuliani
    Created on  : 03-Aug-2016
    Project     : Remark
--%>

<%@ page import="com.ecosmosis.orca.counter.sales.CounterSalesManager" %>

<%
CounterSalesManager csoMgr = new CounterSalesManager();

String salesID = request.getParameter("salesID");
String remark = request.getParameter("remark");
    
boolean status = csoMgr.updateRemark(salesID,remark);

out.println(status);

%>