<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bvwallet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
BonusPeriodBean bean = (BonusPeriodBean) returnBean.getReturnObject("BonusPeriodBean");

%>


<html>
    <head>
        <%@ include file="/lib/header.jsp"%>
        
        <script LANGUAGE="JavaScript">	
            function confirmSubmit()
            {
                    <!-- var agree=confirm("<--i18n:label code="MSG_CONFIRM"/>");
                    if (agree)
                            return true ;
                    else
                            return false ; -->
                    window.open("admin/jsp/sales/report/export_excel.jsp?fileName="+fileName+"&"+$("#add").serialize(),'popUpWindow','height=400,width=600,left=10,top=10,,scrollbars=yes,menubar=no'); return false;                    
            }	
        </script>
        
    </head>
    
    <body>
        
        <div class="functionhead">End of Day</div>
        
        <%@ include file="/general/mvc_return_msg.jsp"%>
        
        <form name="add" id="add" action="<%=Sys.getControllerURL(BonusPeriodManager.TASKID_UPDATE_NEW_BONUSPERID,request)%>" method="post">
            
            <table  class="listbox" width=400>

	<tr>
	<td width="200"  class="odd">Initial Date :</td>
	  <td><std:input type="date" name="periodid" value="<%= Sys.getDateFormater().format(new Date()) %>"  size="12"/></td>
	</tr>	 
                
            </table>
            
            
            
            <table width=500 border="0" cellspacing="0" cellpadding="0" >
                <tr><td>&nbsp</td></tr>
                <tr><td>&nbsp</td></tr>
                <tr class="head">
                    <td align="center"><input type="submit" value="  Pre DSR  " onclick="confirmSubmit()"></td>
                </tr>
            </table>
            
        </form>
        
    </body>
</html>