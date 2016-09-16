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
  function submitUpdate(myform,link)
  {
	  //alert("AA : " + link);
	  myform.action = link;
	  myform.submit();
  }
  
 </script>

</head>
 <body>
<%
	String dateFromStr = null;	
%>
 <h5>System Log</h5>
<FORM name="syslog" method='post' action='' >

<table>
  <tr class=head>
    <td>Log</td>
    <td colspan=2> Enable/Disable</td>
    <td>Log File</td>
    <td>Detail</td>
  </tr>
  <tr class=odd>
    <td class=even>1. Access Log</td>
    <td>Enable <INPUT TYPE=radio name="access" value="ON" <%= Log.isAccessLog()?"checked":""%> ></td>
    <td>Disble <INPUT TYPE=radio name="access" value="OFF" <%= !Log.isAccessLog()?"checked":""%>></td>
    <td>Log File : <INPUT TYPE=text name="accessLogFile" value="<%= (Log.getAccessLogFileName() != null)? Log.getAccessLogFileName():"" %>">
    <input type="button" name="upd" value="Update" onclick="submitUpdate(this.form,'<%=Sys.getControllerURL(LoggingManager.ACCESS_LOG,request) %>')"></td>
    <td><INPUT TYPE=checkbox name="fullLog" value="" <%= Log.isFullAccessLog()?"checked":""%>></td>
  </tr>
  <tr class=odd>
    <td class=even>2. Info Log</td>
    <td>Enable <INPUT TYPE=radio name="info" value="ON" <%= Log.isInfo()?"checked":""%>></td>
    <td>Disble <INPUT TYPE=radio name="info" value="OFF" <%= !Log.isInfo()?"checked":""%>></td>
    <td>Log File : <INPUT TYPE=text name="infoLogFile" value="<%= (Log.getInfoLogFileName() != null)? Log.getInfoLogFileName():"" %>">
    <input type="button" name="upd" value="Update" onclick="submitUpdate(this.form,'<%=Sys.getControllerURL(LoggingManager.INFO_LOG,request) %>')"></td>
    <td>&nbsp;</td>
  </tr>
  <tr class=odd>
    <td class=even>3. Debug Log</td>
    <td>Enable <INPUT TYPE=radio name="debug" value="ON" <%= Log.isDebug()?"checked":""%>></td>
    <td>Disble <INPUT TYPE=radio name="debug" value="OFF" <%= !Log.isDebug()?"checked":""%>></td>
    <td>Log File : <INPUT TYPE=text name="debugLogFile" value="<%= (Log.getDebugLogFileName() != null)? Log.getDebugLogFileName():"" %>">
    <input type="button" name="upd" value="Update" onclick="submitUpdate(this.form,'<%=Sys.getControllerURL(LoggingManager.DEBUG_LOG,request) %>')"></td>
    <td>&nbsp;</td>
  </tr>
  <tr class=odd>
    <td class=even>4. Error Log</td>
    <td>Enable <INPUT TYPE=radio name="error" value="ON" <%= Log.isError()?"checked":""%>></td>
    <td>Disble <INPUT TYPE=radio name="error" value="OFF" <%= !Log.isError()?"checked":""%>></td>
    <td>Log File : <INPUT TYPE=text name="errorLogFile" value="<%= (Log.getErrorLogFileName() != null)? Log.getErrorLogFileName():"" %>">
    <input type="button" name="upd" value="Update" onclick="submitUpdate(this.form,'<%=Sys.getControllerURL(LoggingManager.ERROR_LOG,request) %>')"></td>
    <td>&nbsp;</td>
  </tr>
  <tr class=odd>
    <td class=even>5. Warning Log</td>
    <td>Enable <INPUT TYPE=radio name="warning" value="ON" <%= Log.isWarning()?"checked":""%>></td>
    <td>Disble <INPUT TYPE=radio name="warning" value="OFF" <%= !Log.isWarning()?"checked":""%>></td>
    <td>Log File : <INPUT TYPE=text name="warningLogFile" value="<%= (Log.getWarningLogFileName() != null)? Log.getWarningLogFileName():"" %>">
    <input type="button" name="upd" value="Update" onclick="submitUpdate(this.form,'<%=Sys.getControllerURL(LoggingManager.WARNING_LOG,request) %>')"></td>
    <td>&nbsp;</td>
  </tr>
  
  </table>
  <i>* Default Logging data is output to Application Server Log File</i>
  <p>
  <br>
  <input type="reset" name="Reset" value="Reset">
  
</form>
<p>

 </body>
</html>
