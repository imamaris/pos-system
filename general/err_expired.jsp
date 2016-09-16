<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%
	String group  = (String)request.getAttribute("gp");
%>

<HTML>
<HEAD>
<TITLE>Session Expired</TITLE>
<%@ include file="/lib/header_no_auth.jsp"%>
</head>

<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" onLoad="top.location.href='<%=Sys.getWebapp()%>/general/err_expiredpage.jsp?gp=<%=group%>'">

</BODY>
</HTML>
