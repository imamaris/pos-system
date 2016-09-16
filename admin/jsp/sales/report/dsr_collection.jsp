<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 9 Mar 2015
    Project     : DSR Collection
--%>

<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.document.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

String taskTitle = (String) returnBean.getReturnObject("TaskTitle");
String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
int taskID = 0;
if (task != null)
    taskID = Integer.parseInt(task);
    
DSRReportBean[] DSRdocDate = (DSRReportBean[]) returnBean.getReturnObject("DSRReport");
DSRReportManager dsrMgr = new DSRReportManager();

boolean canView = DSRdocDate != null;
%>
<html>
    <head>
        <title></title>
        
        <%@ include file="/lib/header.jsp"%>
        
        <script type="text/javascript">
            function gotoXCL()
            {
                $("#dsr_xcl_form").attr("action","admin/jsp/sales/report/export_excel.jsp?"+$("#frmSearch").serialize());
                $("#dsr_xcl_form").submit();
            }  
        </script>
        
    </head>
    
    <body>
        <div class="functionhead"><%= taskTitle %></div>
        
        <br>
        
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <form name="frmSearch" id="frmSearch" action="<%=Sys.getControllerURL(taskID,request)%>" method="post">
            
            <table border="0">
                <tr>
                    <td class="td1">Boutique:</td>
                    <td><std:text value="<%= loginUser.getOutletID() %>" defaultvalue="-"/></td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="GENERAL_USERID"/>:</td>
                    
                    <td>
                        <% 
                        if (taskID == DSRReportManager.TASKID_ADMIN_DSR_COLLECTION) {
                        %>
                        
                        <std:text value="<%= loginUser.getUserId() %>" defaultvalue="-"/>
                        
                        <% 
                        } else {
                        %>
                        
                        <std:input type="text" name="UserID" size="30" maxlength="20"/>
                        
                        <% 
                        }
                        %>
                        
                    </td>
                    
                </tr>
                <tr>
                    <td class="td1">Doc Date From :</td>
                    <td><std:input type="date" name="DocDateFrom" value="now"/></td>
                    <td class="td1">Doc Date To :</td>
                    <td><std:input type="date" name="DocDateTo" value="now"/></td>
                </tr>
            </table>
            
            <br>
            
            <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
        </form>
        <%
            String exportFileName = "DSRCollection_" + loginUser.getOutletID();
        %>
        <form name="dsr_xcl_form" id="dsr_xcl_form" method="post">
            <input type="hidden" id="DSRCatStat" name="DSRCatStat" value="0" />
            <input type="hidden" id="fileName" name="fileName" value="<%=exportFileName%>" />
            <input type="hidden" id="outletID" name="outletID" value="<%=loginUser.getOutletID()%>" />
            <input type="hidden" id="outletName" name="outletName" value="<%=loginUser.getUserName()%>" />
            <button id="btn_export_xcl" title="Export to Excel" onclick="gotoXCL()" style="cursor:hand"><img src="<%=request.getContextPath()%>/img/excel_icon.gif" border="0" width="36" /></button>
        </form>
</body>	
</html>