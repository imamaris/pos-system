<%@ page import="com.ecosmosis.mvc.authentication.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>

<%@ include file="/lib/header.jsp"%>

<html>
<head>
	<title><%= Sys.getAPP_NAME() %> - <%=loginUser.getUserName().toUpperCase()%></title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">    
</head>

<frameset rows="98,*" frameborder="NO" border="0" framespacing="0">
  <frame name="top" scrolling="NO" border="0" noresize src="<%=Sys.getControllerURL(HttpAuthenticationManager.ADMIN_TOP_FRAME,request)%>">
	<frameset cols="185,*" frameborder="NO" border="0" framespacing="0">
	  <frame name="menu" border="0" scrolling="AUTO" noresize src="<%=Sys.getControllerURL(HttpAuthenticationManager.ADMIN_SIDE_MENU_FRAME,request)%>">
	  <frame name="main" border="0" src="<%=Sys.getControllerURL(HttpAuthenticationManager.ADMIN_MAIN_AREA,request)%>">
	</frameset>
</frameset>

<noframes>

<body/>

</noframes>

</html>
