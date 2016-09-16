<%@ page import="com.syscatech.calendar.*"%>
<%@ page import="com.syscatech.language.*"%>
<%@ page import="com.syscatech.util.log.*"%>
<%@ page import="com.syscatech.mvc.logging.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<html>
<head>
 <meta http-equiv="content-type" content="text/html; charset=UTF-8">
 <%@ include file="/jsp/lib/header.jsp"%>
  <script language="javascript">
  
 </script>

</head>
 <body>
<%
	String dateFromStr = null;	
%>
 <h5>View Current System Log Detail</h5>

<table>
  <tr class=head>
    <td width=20%>Log</td>
    <td width=20%>Status</td>
    <td width=40%>Log File</td>
    <td width=20%>Detail</td>
  </tr>
  <tr class=odd>
    <td class=even>1. Access Log</td>
    <td><%= Log.isAccessLog()?"Enable":"Disable" %></td>
    <td><a href='<%=Sys.getControllerURL(LoggingManager.LOG_DETAIL,request)+"&LogType="+Log.ACCESS %>'><%= Log.getAccessLogFileName() %></a></td>
    <td><%= Log.isFullAccessLog()?"Yes":"No"%> <a href='<%=Sys.getControllerURL(LoggingManager.VIEW_DB_LOG,request) %>'> Log Filtering </a></td>
  </tr>
  <tr class=odd>
    <td class=even>2. Info Log</td>
    <td><%= Log.isInfo()?"Enable":"Disable" %></td>
    <td><a href='<%=Sys.getControllerURL(LoggingManager.LOG_DETAIL,request)+"&LogType="+Log.INFO %>'><%= Log.getInfoLogFileName() %></a></td>
    <td>No</td>
  </tr>
  <tr class=odd>
    <td class=even>3. Debug Log</td>
    <td><%= Log.isDebug()?"Enable":"Disable" %></td>
    <td><a href='<%=Sys.getControllerURL(LoggingManager.LOG_DETAIL,request)+"&LogType="+Log.DEBUG %>'><%= Log.getDebugLogFileName() %></a></td>
    <td>No</td>
  </tr>
  <tr class=odd>
    <td class=even>4. Error Log</td>
    <td><%= Log.isError()?"Enable":"Disable" %></td>
    <td><a href='<%=Sys.getControllerURL(LoggingManager.LOG_DETAIL,request)+"&LogType="+Log.ERROR %>'><%= Log.getErrorLogFileName() %></a></td>
    <td>No</td>
  </tr>
  <tr class=odd>
    <td class=even>5. Warning Log</td>
    <td><%= Log.isWarning()?"Enable":"Disable" %></td>
    <td><a href='<%=Sys.getControllerURL(LoggingManager.LOG_DETAIL,request)+"&LogType="+Log.WARNING %>'><%= Log.getWarningLogFileName() %></a></td>
    <td>No</td>
  </tr>
  
  </table>
  <br>
<p>

 </body>
</html>
