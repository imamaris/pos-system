<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.orca.users.*"%>
<%@ page import="com.ecosmosis.mvc.authentication.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>

<%@ include file="/lib/header.jsp"%> 

<%
  int BOX_WIDTH = 0;
	MenuBean[] subsystem = (MenuBean[]) request.getAttribute("subsystem");
	String selectedsubsystemID = request.getParameter("subsysid");
	
	MenuBean[] category = (MenuBean[]) request.getAttribute("category");
	String selectedcategoryID = request.getParameter("catid"); 
	
	String msg = null;
	if (subsystem == null & category == null)
		msg = "You have NO ACCESS RIGHTS to use the system. Pls contact the System Administrator!";
%>

<html>
<head>
	<style type="text/css">
	<!--
	  body {
			font-family: verdana, arial, sans-serif;
			font-size: 8pt; 
			color: #000000;
			margin: 0px, 0px, 0px, 0px
		}

		div {
			margin-left: 7px;
			margin-right: 10px;
			margin-top: 0px;
			margin-bottom: 3px;
		}
		
	//-->
	</style>    
</head>

<body>

<table width=100% border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td height="52" background="<%=Sys.getWebapp()%>/img/top_bg_chi.jpg">
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		      <td width="70%" height="30">&nbsp;</td>
		      <td nowrap>
		        <table width="100%" border="0" cellspacing="0" cellpadding="0">
		          <tr>
		            <td colspan=2>&nbsp;</td>
		          </tr>
		          <tr>
		            <td align="right" nowrap>
		              <div id="sectionlinks">
			              <img width='<%=BOX_WIDTH%>' src="<%=Sys.getWebapp()%>/img/transparent_box.gif">
			              <a href='<%=Sys.getControllerURL(AdminManager.TASKID_CHANGE_SETTINGS,request)%>' target='main'>
			              <b><i18n:label code="GENERAL_SETTINGS"/></b></a>
		              
                                      <img width='<%=BOX_WIDTH%>' src="<%=Sys.getWebapp()%>/img/transparent_box.gif"><font color="white">|</font>
			              <img width='<%=BOX_WIDTH%>' src="<%=Sys.getWebapp()%>/img/transparent_box.gif">
			              <a href='<%=Sys.getControllerURL(AdminManager.TASKID_CHANGE_PWD,request)%>' target='main' >
			              <b><i18n:label code="GENERAL_CHANGE_PASSWD"/></b></a>
			              
			              <img width='<%=BOX_WIDTH%>' src="<%=Sys.getWebapp()%>/img/transparent_box.gif"><font color="white">|</font>
			              <img width='<%=BOX_WIDTH%>' src="<%=Sys.getWebapp()%>/img/transparent_box.gif">
			              <a href='<%=Sys.getControllerURL(HttpAuthenticationManager.ADMIN_LOGOUT,request)%>' target='main' >
		              	<b><i18n:label code="GENERAL_LOGOUT"/></b></a>
		              </div>
		            </td>
		          </tr>
		        </table>
		      </td>
		    </tr>
		  </table>
		</td>
	</tr>        
	<tr>
	  <td>
			<%
				if (subsystem != null) {
			%>
	  	<table border="0" cellspacing="0" cellpadding="0" bgcolor="#000000">
				<tr>
				  <td width="80" bgcolor="#000000">
				    <img border=0 width='10' src="<%=Sys.getWebapp()%>/img/transparent_box.gif">
          </td>
		             
					<%
						for (int i = 0; (subsystem != null && i < subsystem.length);i++) {
						  
							String bgOn = "#eddfa2";
							
							String tabOn = "tab_sep_on.jpg";
							String tabOff = "tab_sep_off.jpg";
							
							String fontOn = "menuon";
							String fontOff = "menuoff";
							
							String defaultBg = "#000000";
							String defaultTab = "";
							String defaultTabBg = "#000000";
							String defaultFont = "";			
						 		  
							if (selectedsubsystemID != null && selectedsubsystemID.equals(String.valueOf(subsystem[i].getFunctionID()))) {
								defaultBg = bgOn;
								defaultTab = tabOn;
								defaultTabBg = bgOn;
								defaultFont = fontOn;
						  } else { 
								defaultBg = "#000000";	
							  defaultTab = tabOff;
							  defaultTabBg = "#000000";
								defaultFont = fontOff;
							}
					%>
	
					<td valign="bottom" bgcolor="<%= defaultBg %>">
					  <a href='<%=Sys.getControllerURL(HttpAuthenticationManager.ADMIN_TOP_FRAME,request)%>&subsysid=<%=subsystem[i].getFunctionID()%>' target='top'>
				    	<div class=<%= defaultFont %>>&nbsp;<%= subsystem[i].getDesc() %></div>
				    </a>
					</td>
					
					<td bgcolor="<%= defaultTabBg %>">
						<img src="<%=Sys.getWebapp()%>/img/<%= defaultTab %>">
					</td>
			
					<%
						} // end for main menu
					%>
				</tr>
			</table>
			<%
				} // end subsystem is not null
			%>
	  </td>
	</tr>
  <tr>
		<td bgcolor="#eddfa2" nowrap>
		  <%
				if (category != null) {
			%>
			<table border="0">
				<tr>
					<%
						for (int i = 0; (category != null && i < category.length);i++) {
					%>
					
					<td nowrap>
						<a align="left" href='<%=Sys.getControllerURL(HttpAuthenticationManager.ADMIN_SIDE_MENU_FRAME,request)%>&catid=<%=category[i].getFunctionID()%>&desc=<%=category[i].getDesc()%>' target='menu'>
							<div class=menuon><%= category[i].getDesc() %></div>
						</a>
					</td>

					<td nowrap>
						<img width='<%=BOX_WIDTH%>' src="<%=Sys.getWebapp()%>/img/transparent_box.gif">|
					</td>
					
					<%
						} // end for category menu
					%>
				</tr>
			</table>
			<%
				} // end category is not null
			%>
		</td>	
	</tr>
</table>


<% if (msg != null) { %>
<table>
	 <tr align = "center"><td><b><i><font color="red"><%=msg%></font></i></b></td></tr>
</table>
<br>
<% } %>

</body>
</html>

	