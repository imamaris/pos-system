<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 9 Mar 2015
    Project     : Auto Generate DSR Excel
--%>

<%@ page import="com.ecosmosis.orca.counter.sales.xclreport.DSR" %>
<%@ page import="com.ecosmosis.orca.counter.sales.xclreport.DSRSummary" %>
<%@ page import="com.ecosmosis.orca.counter.sales.xclreport.DSRCollection" %>
<%@ page import="com.ecosmosis.orca.counter.sales.DSRReportManager" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>

<%  
    DSRReportManager DSRMgr = new DSRReportManager();
    Date today = new Date();
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-01");
    SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
    
    String outletID = DSRMgr.getOutletInitial()[0].getOutletInitial().replace(" ","_");
    String outletName = DSRMgr.getOutletInitial()[0].getOutletInitialName();
    String destination = "C:/DSR_POS/";
    String logName = "AutoCreateDSR.log";
    String logPath = destination + logName;
    String logstatus = "";
    String filename = "";
    Date lastDocDate = DSRMgr.getLastDocDate();
    String DocDateTo = lastDocDate.toString();
    String DocDateFrom = format.format(lastDocDate);
    FileOutputStream output_file = null;
    int DSRCatStat = DSRMgr.getDSRCatStat();
    
    //DSR
    filename = "DSR_" + outletID + ".xls";
    output_file = new FileOutputStream(new File(destination + filename));
    DSR dsr = new DSR();
    dsr.getDSRReportXCL(filename,outletID,DSRCatStat,outletName,DocDateFrom,DocDateTo,destination,output_file);
    
    logstatus = today + " -> Auto Create DSR Doc Date : " + DocDateFrom + " - " + DocDateTo + " Successfully Run\r\n";
    DSRMgr.createLogFile(logstatus,logPath);
    //
    
    //DSR Summary
    filename = "DSRSummary_" + outletID + ".xls";
    output_file =new FileOutputStream(new File(destination + filename));
    DSRSummary dsrSmry = new DSRSummary();
    dsrSmry.getDSRSummaryXCL(filename,outletID,DSRCatStat,outletName,DocDateFrom,DocDateTo,destination,output_file);
    
    logstatus = today + " -> Auto Create DSR Summary Doc Date : " + DocDateFrom + " - " + DocDateTo + " Successfully Run\r\n";
    DSRMgr.createLogFile(logstatus,logPath);
    //
    
    //DSR Collection
    filename = "DSRCollection_" + outletID + ".xls";
    output_file =new FileOutputStream(new File(destination + filename));
    %><%@ include file="/payTypeList.jsp"%><%
    DSRCollection dsrCollect = new DSRCollection();
    dsrCollect.getDSRCollectionXCL(filename,outletID,DSRCatStat,outletName,DocDateFrom,DocDateTo,payTypeList,destination,output_file);
    
    logstatus = today + " -> Auto Create DSR Collection Doc Date : " + DocDateFrom + " - " + DocDateTo + " Successfully Run\r\n";
    DSRMgr.createLogFile(logstatus,logPath);
    //
    
    /***** LAST MONTH *****/
    
    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.MONTH, -1);
    DocDateFrom = format.format(cal.getTime());
    
    cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
    DocDateTo = format1.format(cal.getTime());
    
    //DSR Last Month
    filename = "DSR_" + outletID + "_LM.xls";
    output_file = new FileOutputStream(new File(destination + filename));
    dsr.getDSRReportXCL(filename,outletID,DSRCatStat,outletName,DocDateFrom,DocDateTo,destination,output_file);
    
    logstatus = today + " -> Auto Create DSR Doc Date Last Month : " + DocDateFrom + " - " + DocDateTo + " Successfully Run\r\n";
    DSRMgr.createLogFile(logstatus,logPath);
    //
    
    //DSR Summary Last Month
    filename = "DSRSummary_" + outletID + "_LM.xls";
    output_file =new FileOutputStream(new File(destination + filename));
    dsrSmry.getDSRSummaryXCL(filename,outletID,DSRCatStat,outletName,DocDateFrom,DocDateTo,destination,output_file);
    
    logstatus = today + " -> Auto Create DSR Summary Doc Date Last Month : " + DocDateFrom + " - " + DocDateTo + " Successfully Run\r\n";
    DSRMgr.createLogFile(logstatus,logPath);
    //
    
    //DSR Collection Last Month
    filename = "DSRCollection_" + outletID + "_LM.xls";
    output_file =new FileOutputStream(new File(destination + filename));
    dsrCollect.getDSRCollectionXCL(filename,outletID,DSRCatStat,outletName,DocDateFrom,DocDateTo,payTypeList,destination,output_file);
    
    logstatus = today + " -> Auto Create DSR Collection Doc Date Last Month : " + DocDateFrom + " - " + DocDateTo + " Successfully Run\r\n";
    DSRMgr.createLogFile(logstatus,logPath);
    //
%>