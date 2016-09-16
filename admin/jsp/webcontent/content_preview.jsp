<html>
<head>
<script language="JavaScript" type="text/JavaScript">

</script>
<%@ include file="/lib/header.jsp"%>
<%
  String topic = request.getParameter("Topic");
  String content = request.getParameter("Contents");
  String _cat = request.getParameter("CatID");
  String source = request.getParameter("Source");
%>
<title>Preview Content : <%=(topic!=null)?topic:""%></title>
</head>

<body topmargin="0" leftmargin="0">
<br>
<table width="766" height="430" border="0" align="center"  valign="top" cellpadding="0" cellspacing="0">  
  <tr valign="top" height="430">
    <td ><%=content%></td>
  </tr>
</table>

<br>
<table width="766" border="0" align="center" cellpadding="0" cellspacing="0">
  <c:if test="<%=(source!=null && source.length()>0)%>">
  <tr>
    <td>
      <small>Source : <%=source%></small>
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
