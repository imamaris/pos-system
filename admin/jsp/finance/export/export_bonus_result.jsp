<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.bonus.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	
	int totalBonus = (Integer) returnBean.getReturnObject("TotalBonusRecord");
	
	int totalCommission = 0;
	//int totalCommission = (Integer) returnBean.getReturnObject("TotalCommissionRecord");  
	
	String fileName = (String) returnBean.getReturnObject("Filename");   
%>

<c:if test="<%=(fileName!=null)%>">
	<META HTTP-EQUIV="refresh" content="2; URL=<%= request.getContextPath()%>/Download?filename=<%=fileName%>">
</c:if>

</head>

<body onLoad="self.focus();">
<div class=functionhead>Export Bonus Data</div>
<table>
  <tr>
	  <td><br><b>Total Bonus Records Exported :</b></td>
	  <td><br><%=totalBonus+totalCommission%></td>
  </tr>
</table>
</body>
</html>
