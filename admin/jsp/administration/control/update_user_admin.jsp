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
  LanguageBean[] languages = (LanguageBean[]) returnBean.getReturnObject("LanguageList");
  
  String taskID = (String) returnBean.getReturnObject("taskID");
  int task = 0;
  if (taskID != null)
  	task = Integer.parseInt(taskID);
  	
  TreeMap locations = (TreeMap) returnBean.getReturnObject("LocationList");
  TreeMap outlets = (TreeMap) returnBean.getReturnObject("OutletList");
  TreeMap status = (TreeMap) returnBean.getReturnObject("StatusList");
  	
%>
<body onLoad="self.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<div class=functionhead><i18n:label code="ADMIN_USR_UPDATEINFO"/></div>

<form name="view_usr_settings" action="<%=Sys.getControllerURL(AdminManager.TASKID_ADMIN_CHANGE_SETTINGS_SUBMIT, request)%>" method="post">
<input type="hidden" name="UserId" value="<%=userBean.getUserId()%>" >

<table width=70%>
<tr valign=top>
  <td width=25%><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.USER_ID%>"/> </td>
     <td>: <b><%=userBean.getUserId()%></b>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
     <td>: <b><std:input type="text" name="UserName" value="<%=userBean.getUserName()%>" maxlength="50" size="50"/></b>
  </td>
</tr>
<tr valign=top>
  		<td width=15%><i18n:label code="GENERAL_STATUS"/></td>
	 	<td>: <std:input type="select" name="Status" options="<%=status%>" value="<%=userBean.getStatus()%>"/></td>
</tr>
<tr valign=top>
  		<td width=15%><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.WORKING_OUTLET%>"/></td>
	 	<td>: <std:input type="select" name="OutletID" options="<%=outlets%>" value="<%=userBean.getOutletID()%>"/></td>
</tr>

<tr valign=top>
  <td width=15%><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.MGMT_HIERARCHY%>"/></td>
     <td>: <std:input type="select" name="ManagementLocationID" options="<%=locations%>" value="<%=userBean.getManagementLocationID()%>"/></td>

  </td>
</tr>

<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_LANG_PREFER"/></td>
     <td>: 
     <select name="Language">
     <%
      for(int i=0; i<languages.length; i++){
     %>
      <option value="<%=languages[i].getLocaleStr()%>" <%=((userBean.getLanguage()!=null && userBean.getLanguage().equalsIgnoreCase(languages[i].getLocaleStr()))?"selected":"")%>><%=languages[i].getDesc()%></option>
     <% }%>
     </select>     
  </td>
</tr>

<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_GENDER"/></td>
     <td>: 
     <select name="Gender">
     <option value="M" <%=((userBean.getGender()!=null && userBean.getGender().equalsIgnoreCase("M"))?"selected":"")%>><i18n:label code="GENERAL_MALE"/></option>
     <option value="F" <%=((userBean.getGender()!=null && userBean.getGender().equalsIgnoreCase("F"))?"selected":"")%>><i18n:label code="GENERAL_FEMALE"/></option>     
     </select>
  </td>
</tr>

<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_NO_HOME"/></td>
     <td>: <std:input type="text" name="HomeNo" value="<%=userBean.getHomeNo()%>" maxlength="30" size="25"/>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_NO_OFFICE"/></td>
     <td>: <std:input type="text" name="OfficeNo" value="<%=userBean.getOfficeNo()%>" maxlength="30" size="25"/>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_NO_FAX"/></td>
     <td>: <std:input type="text" name="FaxNo" value="<%=userBean.getFaxNo()%>" maxlength="30" size="25"/>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_NO_MOBILE"/></td>
     <td>: <std:input type="text" name="MobileNo" value="<%=userBean.getMobileNo()%>" maxlength="30" size="25"/>
  </td>
</tr>
<tr valign=top>
  <td width=15%><i18n:label code="GENERAL_EMAIL"/></td>
     <td>: <std:input type="text" name="Email" value="<%=userBean.getEmail()%>" maxlength="30" size="25"/>
  </td>
</tr>
</table>

<table width=70%>
<tr>
<td align=center><input type=submit name="btnUpdate" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>"></td>
</tr>
</table>
</form>

</body>
</html>
