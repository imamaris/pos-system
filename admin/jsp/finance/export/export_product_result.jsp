<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	int totalGenerated = (Integer) returnBean.getReturnObject("TotalProductExported");   
	String fileName = (String) returnBean.getReturnObject("Filename");   
%>

<c:if test="<%=(fileName!=null)%>">
	<META HTTP-EQUIV="refresh" content="2; URL=<%= request.getContextPath()%>/Download?filename=<%=fileName%>">
</c:if>

</head>

<body onLoad="self.focus();">
<div class=functionhead>Export Product Data</div>
<table>
  <tr>
	  <td><br><b>Total Records Exported :</b></td>
	  <td><br><%=totalGenerated%></td>
  </tr>
</table>
</body>
</html>
