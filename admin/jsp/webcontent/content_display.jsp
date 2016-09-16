<%@page import="com.ecosmosis.orca.webcontent.*"%>
<html>
<head>

<%@ include file="/lib/header.jsp"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ContentBean bean = (ContentBean) returnBean.getReturnObject("Content");

	boolean canView = (bean!=null);			
%>
<title><%=(canView)?bean.getTopic():""%></title>
</head>

<body topmargin="0" leftmargin="0">
<br>
<table width="766" height="430" border="0" align="center"  valign="top" cellpadding="0" cellspacing="0">  
  <tr valign="top" height="430">
    <td ><%=(canView)?new WebManager().convertToHTMLTag(bean.getContents()):""%></td>
  </tr>
</table>

<br>
<table width="766" border="0" align="center" cellpadding="0" cellspacing="0">
  <c:if test="<%=(canView && bean.getSource()!=null && bean.getSource().length()>0)%>">
  <tr>
    <td>
      <small>Source : <%=bean.getSource()%></small>
      <hr color="#CCCCCC" size="1">
    </td>
  </tr>
  </c:if>
  
  <tr>
    <td><div align="center"><font face="sans-serif" size="2">&copy; Copyright by PT Chi 2006. All rights reserved.</font></div></td>
  </tr>
</table>

<p>&nbsp;</p>


</body>
</html>
