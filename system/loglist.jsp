<%@ page import="com.syscatech.mvc.logging.*"%>
<%@ page import="com.syscatech.mvc.sys.*"%>
<%@ page import="com.syscatech.language.*"%>
<%@ page import="com.syscatech.calendar.*"%>
<%@ page import="java.util.*"%>

<html>
<head>
  <%@ include file="/jsp/lib/header.jsp"%>
<%

	AccessLogBean[] logs = (AccessLogBean[]) request.getAttribute("logs");
	
	String dateFrom = request.getParameter("DateFrom");
	String dateTo = request.getParameter("DateTo");
	String userid = request.getParameter("UserID");
	String actionid = request.getParameter("ActionID");
	String remoteIP = request.getParameter("RemoteIP");
	String today = Sys.getDateFormater().format(new java.util.Date());
	
	
%>
<script language="javascript">
 function focusAndSelect(obj)
 {
 	obj.focus();
  	obj.select();
 }
</script>
</head>
<body>
 <h5>Access Logs Listing</h5>
 <form name="logs" method="post" action="<%=Sys.getControllerURL(LoggingManager.VIEW_DB_LOG,request)%>">
 <table>
  <tr>
   <td>Date From</td>
   <td>: <input type="text" name="DateFrom" value='<%=(dateFrom != null) ? dateFrom :today %>'>
   	<a href="javascript:opennewcal('<%=Sys.getControllerURL(CalendarManager.VIEW_PICKER,request) %>&FormName=logs&ObjName=DateFrom')">
	      				<img border="0" src="<%=request.getContextPath()%>/img/calendar.gif">
	</a>(<%= Sys.getDateFormat().toUpperCase() %>)
   </td>
  </tr>
  <tr>
   <td>Date To</td>
   <td>: <input type="text" name="DateTo" value='<%=(dateTo != null) ? dateTo:today %>' >
   	<a href="javascript:opennewcal('<%=Sys.getControllerURL(CalendarManager.VIEW_PICKER,request) %>&FormName=logs&ObjName=DateTo')">
	      				<img border="0" src="<%=request.getContextPath()%>/img/calendar.gif">
	</a>(<%= Sys.getDateFormat().toUpperCase() %>)
   </td>
  </tr>
  <tr>
   <td>User ID</td>
   <td>: <input type="text" name="UserID" value='<%=(userid != null) ? userid :"" %>'> </td>
  </tr>
  <tr>
   <td>Action ID</td>
   <td>: <input type="text" name="Actionid" value='<%=(actionid != null) ? actionid :"" %>' > </td>
  </tr>
  <tr>
   <td>IP Address</td>
   <td>: <input type="text" name="RemoteIP" value='<%=(remoteIP != null) ? remoteIP :request.getHeader("host") %>' > Example : (202.123.111.110)</td>
  </tr>
 </table>
 <br>
 <input type="submit" value="<%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"SEARCH")%>">
</form>
<hr>
<br>

<%
	if (logs != null) {
%>
 <b>Access Log Listing</b>	
 <table width="95%">
  <tr class=head>
   <td align=right width="3%"><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"NO.")%></td>
   <td><%=MessageResource.getJSPLocalizedMessage(basicLoginInfo,"DATE")%></td>
   <td>User ID</td>
   <td>IP Address</td>
   <td>Access Method</td>
   <td>Action ID</td>
   <td>Action Desc</td>
   <td>Parameters</td>
  </tr>
<%
	for (int i = 0; i < logs.length; i++) {
%>  
  <tr class='<%=((i+1) % 2 == 0)?"even":"odd"%>'> 
   <td align=right><%= i+1 %>.</td>  
   <td><%= logs[i].getDate() %></td>
   <td><%= logs[i].getUserid() %></td>
   <td><%= logs[i].getRemoteIP() %></td>
   <td><%= logs[i].getAction() %></td>
   <td><%= logs[i].getActionid() %></td>
   <td><%= logs[i].getActionDesc() %></td>
   <td><%= logs[i].getParameters() %></td>
  </tr>
<%	
	}
%>  
 </table>
<%
	} 
%>

</body>

</html>
