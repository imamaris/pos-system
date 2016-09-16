<%-- 
    Created By  : Mila Yuliani
    Created on  : 17 Desember 2015
    Project     : Preview DSR
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
                var fileName = $("#fileId").val() + $("#outletID").val();
                $("#dsr_xcl_form").attr("action","admin/jsp/sales/report/export_excel.jsp?fileName="+fileName+"&"+$("#frmSearch").serialize());
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
                    <!--td>&nbsp;</td -->
                    <td class="td1"><i18n:label code="GENERAL_USERID"/>:</td>
                    
                    <td>
                        <% 
                        if (taskID == DSRReportManager.TASKID_ADMIN_DSR_PREVIEW) {
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
            
            <input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">            
        </form>
        <% 
            if (canView) {            
        %>        
        <form name="dsr_xcl_form" id="dsr_xcl_form" method="post">
            <input type="hidden" id="DSRCatStat" name="DSRCatStat" value="0" />
            <input type="hidden" id="outletID" name="outletID" value="<%=loginUser.getOutletID()%>" />
            <input type="hidden" id="outletName" name="outletName" value="<%=loginUser.getUserName()%>" />
            <table border=0>
                <tr>
                    <td width="80px" align="center">
                        <button id="btn_export_xcl" title="Preview DSR" onclick="gotoXCL()" style="cursor:hand">
                            <input type="hidden" value="DSR_" id="fileId" />
                            <img src="<%=request.getContextPath()%>/img/excel_icon.gif" border="0" width="36" />
                        </button> 
                    </td>   
                    <td width="10px">&nbsp;</td>
                    <td width="80px" align="center">
                        <button id="btn_export_xcl" title="Preview DSR Summary" onclick="gotoXCL()" style="cursor:hand">
                            <input type="hidden" value="DSRSummary_" id="fileId" />
                            <img src="<%=request.getContextPath()%>/img/excel_icon.gif" border="0" width="36" />
                        </button>                    
                    </td>
                    <td width="10px">&nbsp;</td>
                    <td width="80px" align="center">
                        <button id="btn_export_xcl" title="Preview DSR Collection" onclick="gotoXCL()" style="cursor:hand">
                            <input type="hidden" value="DSRCollection_" id="fileId" />
                            <img src="<%=request.getContextPath()%>/img/excel_icon.gif" border="0" width="36" />
                        </button>                    
                    </td>
                </tr>
                <tr>
                    <td align="center">DSR</td>
                    <td width="10px">&nbsp;</td>
                    <td align="center">DSR Summary</td>
                    <td width="10px">&nbsp;</td>
                    <td align="center">DSR Collection</td>
                </tr>
            </table>
        </form>       
        <% } %>
</body>	
</html>
