<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<%@page import="com.ecosmosis.orca.stockist.StockistUserBean"%>
<%@page import="com.ecosmosis.mvc.manager.MvcReturnBean"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<title><%=(lang.display("GENERAL_CHECK_AVAILABILITY")).toUpperCase()%></title>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><%=(lang.display("GENERAL_CHECK_AVAILABILITY")).toUpperCase()%></div>
<%@ include file="/lib/return_error_msg.jsp"%>
<%
	if (returnBean == null || !returnBean.hasErrorMessages()) {
%>

	<br>
	<font color="blue"><b><i18n:label code="MSG_USERID_NOT_USE"/></b></font>
<%	}%>	

<form name="frmView">
	<div align=center><input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick='window.close();'></div> 
</form>	
</body>
</html>		