<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.member.printings.MemberPrintManager"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">

</script>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  String result = (String) returnBean.getReturnObject("Results");   
  // int totalRequest = (Integer) returnBean.getReturnObject("TotalRequested");   
  // int totalGenerated = (Integer) returnBean.getReturnObject("TotalGenerated");   
  // String fileName = (String) returnBean.getReturnObject("Filename");   
%>
<c:if test="<%=(fileName!=null)%>">
	<META HTTP-EQUIV="refresh" content="2; URL=<%= request.getContextPath()%>/Download?filename=<%=fileName%>">
</c:if>
</head>

<body onLoad="self.focus();">
<div class=functionhead>Starter Pack Generation > Results</div>
<table>
  <tr>
	  <td><b>Total Requested : </b></td>
	  <td>??</td>
  </tr>
  <tr>
	  <td><b>Total Generated : </b></td>
	  <td>??</td>
  </tr>
  <tr>
	  <td colspan=2><b>Results : </b></td>
  </tr>
  <tr valign=top>
	  <td colspan=2><std:text value="<%=result%>"/></td>
  </tr>
  <tr>
	  <td colspan=2>&nbsp;</td>
  </tr>
  <tr>
	  <td><b>Total Requested : </b></td>
	  <td>??</td>
  </tr>  	
  <tr>
	  <td><b>Total Generated : </b></td>
	  <td>??</td>
  </tr>
</table>


</body>
</html>