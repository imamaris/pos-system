<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 24 April 2013
    Project     : DSR Report
--%>

<%@ page import="com.ecosmosis.mvc.accesscontrol.user.LoginUserBean" %>
<%@ page import="com.ecosmosis.orca.counter.sales.pdfreport.DSRReportPDF" %>
<%@ page import="java.io.File" %>

<%  
    String filename = request.getParameter("fileName");
    String DocDateFrom = request.getParameter("DocDateFrom");
    String DocDateTo = request.getParameter("DocDateTo");
    String outletID = request.getParameter("outletID");
    String DSRCatStat = request.getParameter("DSRCatStat");
    String outletName = request.getParameter("outletName");
    String destination = "D:/DSR_POS/";
    
    response.setContentType("application/pdf");
    response.setHeader("Expires:", "0"); // eliminates browser caching
    response.setHeader("Content-Disposition", "attachment; filename="+filename+".pdf");
    
    DSRReportPDF dsr = new DSRReportPDF();
    dsr.getDSRReportPDF(filename,outletID,Integer.parseInt(DSRCatStat),outletName,DocDateFrom,DocDateTo,destination,response.getOutputStream());
%>