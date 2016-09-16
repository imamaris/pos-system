<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@page import="com.ecosmosis.orca.users.AdminLoginUserBean"%>
<%@page import="com.ecosmosis.orca.users.AdminManager"%>
<%@page import="com.ecosmosis.common.language.LanguageBean"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">

</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  AdminLoginUserBean userBean = (AdminLoginUserBean) returnBean.getReturnObject("UserBean");  
%>
<body onLoad="self.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<div class=functionhead><i18n:label code="GENERAL_CHANGE_PASSWD"/></div>

<form name="view_usr_settings" action="<%=Sys.getControllerURL(AdminManager.TASKID_ADMIN_RESET_PASSWORD_SUBMIT,request)%>" method="post">
<input type="hidden" name="memberid" value="<%=userBean.getUserId()%>" >

<table width=70%>
<tr valign=top>
  <td width=40%><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.USER_ID%>"/> </td>
     <td>: <b><%=userBean.getUserId()%></b>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_PASSWD_NEW"/> (4-10 <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CHARS%>"/>)</td>
     <td>: <input type="password" name="Password" value="" maxlength="10" size="12">
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_PASSWD_CONFIRMNEW"/> (4-10 <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CHARS%>"/>)</td>
     <td>: <input type="password" name="Password2" value="" maxlength="10" size="12">
  </td>
</tr>
</table>

<table width=70%>
<tr>
<td align=left>&nbsp;</td>
</tr>
<tr>
<td align=left><input type=submit name="btnUpdate" value="<i18n:label code="GENERAL_RESET_PASSWD"/>"></td>
</tr>
</table>
</form>

</body>
</html>
