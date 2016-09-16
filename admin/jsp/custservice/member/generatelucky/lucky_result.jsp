<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.member.lucky.MemberLuckyManager"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">

</script>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  String result = (String) returnBean.getReturnObject("Results");   
  String salesId = (String) returnBean.getReturnObject("SalesId");   
  String memberId = (String) returnBean.getReturnObject("MemberId");   
  String nameId = (String) returnBean.getReturnObject("NameId");   
  int totalRequest = (Integer) returnBean.getReturnObject("TotalRequested");   
  int totalGenerated = (Integer) returnBean.getReturnObject("TotalGenerated");   
  String fileName = (String) returnBean.getReturnObject("Filename");   
%>
<c:if test="<%=(fileName!=null)%>">
	<META HTTP-EQUIV="refresh" content="2; URL=<%= request.getContextPath()%>/Download?filename=<%=fileName%>">
</c:if>
</head>

<body onLoad="self.focus();">
<div class=functionhead>Lucky Draw Generation > Results</div>
<table>
  <tr>
	  <td><b>Cash Bill : </b></td>
	  <td><%=salesId%></td>
  </tr>
  <tr>
	  <td><b>Member ID : </b></td>
	  <td><%=memberId%></td>
  </tr>
  <tr>
	  <td><b>Nama : </b></td>
	  <td><%=nameId%></td>
  </tr>  
  <tr>
	  <td></b></td>
	  <td></td>
  </tr>
  <tr>
	  <td></b></td>
	  <td></td>
  </tr>
  <tr>
	  <td colspan=2><b>Nomor Undian : </b></td>
  </tr>
  <tr valign=top>
	  <td colspan=2><std:text value="<%=result%>"/></td>
  </tr>
  <tr>
	  <td colspan=2>&nbsp;</td>
  </tr>
  <tr>
	  <td><b>Total Requested : </b></td>
	  <td><%=totalRequest%></td>
  </tr>  	
  <tr>
	  <td><b>Total Generated : </b></td>
	  <td><%=totalGenerated%></td>
  </tr>
</table>


</body>
</html>
