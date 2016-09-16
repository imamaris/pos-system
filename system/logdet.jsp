<%@ page import="com.syscatech.calendar.*"%>
<%@ page import="com.syscatech.language.*"%>
<%@ page import="com.syscatech.util.log.*"%>
<%@ page import="com.syscatech.mvc.logging.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<html>
<head>
 <meta http-equiv="content-type" content="text/html; charset=UTF-8">
 <%@ include file="/jsp/lib/header.jsp"%>

</head>
 <body>
<%
	DecimalFormat df = new DecimalFormat("#,###.##");
	String log  = (String) request.getAttribute("log");	
	BufferedReader reader = (BufferedReader) request.getAttribute("reader");
	File logFile = (File) request.getAttribute("file");
%>

<h5>Access Log Detail</h5>

<%
	if (logFile != null) 
	{
%>
<table>
  <tr>
    <td>Log File</td>
    <td>: <%= logFile.getName() %></td>
  </tr>
  <tr>
    <td>Last Updated</td>
    <td>: <%= new Date(logFile.lastModified()) %></td>
  </tr>
  <tr>
    <td>File Size</td>
    <td>: <%= df.format(logFile.length() / 1024.0) %> KB</td>
  </tr>
</table>
<%
	}
%>
  <hr>
<%
	if (reader!=null)
	{
		try
		{
			String line = null;
			while((line = reader.readLine())!=null)		
			{
%>
	<%=line%><br>
<%			
			}
		}
		finally
		{
			try
			{
				if (reader!= null) reader.close();
			}
			catch (Exception ignore) {}
		}
	}
%>
  
 </body>
</html>
