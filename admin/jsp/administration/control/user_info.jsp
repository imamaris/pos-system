<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@page import="com.ecosmosis.orca.users.AdminLoginUserBean"%>
<%@page import="com.ecosmosis.orca.users.AdminManager"%>
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
<div class=functionhead>
<i18n:label code="ADMIN_USR_INFO"/>
</div>
<form name="view_usr_settings" action="<%=Sys.getControllerURL(AdminManager.TASKID_CHANGE_SETTINGS_FORM,request)%>" method="post">

<table class=listbox width=50%>
<tr valign=top>
  <td width=25%><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.USER_ID%>"/></td>
     <td>: <b><%=userBean.getUserId()%></b>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
     <td>: <b><%=userBean.getUserName()%></b>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.WORKING_OUTLET%>"/></td>
     <td>: <b><%=userBean.getOutletID()%></b>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.MGMT_HIERARCHY%>"/></td>
     <td>: <b><%=userBean.getOperationLocationBean().getName()%> (<%=userBean.getOperationLocationBean().getLocationID()%>)</b>
  </td>
</tr>

<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_LANG_PREFER"/></td>
     <td>: <b><%=userBean.getLanguage()%></b>
  </td>
</tr>

<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_GENDER"/></td>
     <td>: <b><std:text value="<%=userBean.getGender()%>" defaultvalue=" - "/></b>
  </td>
</tr>

<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_NO_HOME"/></td>
     <td>: <b><std:text value="<%=userBean.getHomeNo()%>" defaultvalue=" - "/></b>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_NO_OFFICE"/></td>
     <td>: <b><std:text value="<%=userBean.getOfficeNo()%>" defaultvalue=" - "/></b>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_NO_FAX"/></td>
     <td>: <b><std:text value="<%=userBean.getFaxNo()%>" defaultvalue=" - "/></b>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_NO_MOBILE"/></td>
     <td>: <b><std:text value="<%=userBean.getMobileNo()%>" defaultvalue=" - "/></b>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_EMAIL"/></td>
     <td>: <b><std:text value="<%=userBean.getEmail()%>" defaultvalue=" - "/></b>
  </td>
</tr>
</table>

<table width=50%>
<tr>
<td align=center><input type=submit name="btnUpdate" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>" ></td>
</tr>
</table>
</form>

</body>
</html>
