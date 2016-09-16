<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 2 July 2013
    Project     : DSR Report
--%>

<%@ page import="com.ecosmosis.mvc.accesscontrol.user.LoginUserBean" %>
<%@ page import="com.ecosmosis.orca.counter.sales.xclreport.DSR" %>
<%@ page import="com.ecosmosis.orca.counter.sales.xclreport.DSRSummary" %>
<%@ page import="com.ecosmosis.orca.counter.sales.xclreport.DSRCollection" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.File" %>

<%
    String filename = request.getParameter("fileName");
    String DocDateTo = request.getParameter("DocDateTo");
    String outletID = request.getParameter("outletID");
    String DSRCatStat = request.getParameter("DSRCatStat");
    String outletName = request.getParameter("outletName");
    String rptType = request.getParameter("rptType");
    String destination = "D:/DSR_POS/";
    String[] act = filename.split("_");
    String action = act[0];
    
    Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(DocDateTo);
    String DocDateFrom = new SimpleDateFormat("yyyy-MM-01").format(format1);
    
    response.setContentType("application/ms-excel");
    response.setHeader("Expires:", "0"); // eliminates browser caching
    response.setHeader("Content-Disposition", "attachment; filename="+filename+".xls");
    
    if(action.equalsIgnoreCase("DSRSummary"))
    {
        DSRSummary dsrSmry = new DSRSummary();
        dsrSmry.getDSRSummaryXCL(filename,outletID,Integer.parseInt(DSRCatStat),outletName,DocDateFrom,DocDateTo,destination,response.getOutputStream());
    }
    else if(action.equalsIgnoreCase("DSRCollection"))
    {
        DSRCollection dsrCollect = new DSRCollection();
        DocDateFrom = request.getParameter("DocDateFrom");
        %><%@ include file="/payTypeList.jsp"%><%
        
        dsrCollect.getDSRCollectionXCL(filename,outletID,Integer.parseInt(DSRCatStat),outletName,DocDateFrom,DocDateTo,payTypeList,destination,response.getOutputStream());
    }
    else
    {
        DSR dsr = new DSR();
        dsr.getDSRReportXCL(filename,outletID,Integer.parseInt(DSRCatStat),outletName,DocDateFrom,DocDateTo,destination,response.getOutputStream());
    }
%>