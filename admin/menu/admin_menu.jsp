<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.authentication.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>

<%@ include file="/lib/header.jsp"%>

<%
	MenuBean[] list = (MenuBean[]) request.getAttribute("menu");
	String menuDesc = request.getParameter("desc");
%>

<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>

<body id="nav">

<table border="0">
	<tr>
		<td>
			<div id="category"><%= URLDecoder.decode((menuDesc != null)? menuDesc : "") %><div>
		</td>
	</tr>
	<%  
		String groupdesc = "";
		for (int i=0; i < list.length ; i++) { 
			
			int taskID = 0;
			String link = null;
			
			if (list[i].getTaskID() != null) {		
				taskID = Integer.parseInt(list[i].getTaskID());
				link = Sys.getControllerURL(taskID,request)+ "&" + list[i].getDefault_parameter();
			}
			
			if (list[i].getGroupDesc() != null && !list[i].getGroupDesc().equals(groupdesc) && list[i].getMenuVisibility() >= 1) {
				groupdesc = list[i].getGroupDesc();
	%>
	<tr>
		<td>&nbsp;</td>
	</tr>
  <tr>
  	<td
  		<div id="functiongrp">
  			<%= groupdesc %>
  		</div>
  	</td>	
  </tr>
					     			
	<% 		
			} // end if function grp
	%>

	<%
		if (list[i].getMenuVisibility() >= 1) {
	%>	
	<tr>
		<td>
			  <div id="functionlinks">
			    <% 
			    	if (link != null) { 
				  %>
					  <a href='<%=link%>' target='main'>
							<%= list[i].getDesc() %>
						</a>
				  <% 
				  	} else { 
					%>
						<%=list[i].getDesc()%>
					<%
						}
					%>
				</div>	
		</td>
	</tr>     
	<% 
		} // end MenuVisibility 
	%>	
	<% 
		} // end for
	%>
</table>
<p style="position:absolute;bottom:0;left:0;width:100%;text-align:center;color:#999"><%@ include file="/version.jsp"%></p>
</body>
</form>
