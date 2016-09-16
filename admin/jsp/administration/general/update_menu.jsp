<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
	MenuBean menuBean = (MenuBean) returnBean.getReturnObject("MenuBean");
	
	
%>

<html>
<head>

<%@ include file="/lib/header.jsp"%>

</head>
 <body>
<div class="functionhead"><i18n:label code="ADMIN_MENU_UPDATE"/></div>

<form name="update" action="<%=Sys.getControllerURL(ModuleManager.TASKID_UPDATE_MENU_SUBMIT,request)%>" method="post">
<input type="hidden" name="funcid" value="<%=menuBean.getFunctionID()%>">


<%@ include file="/general/mvc_return_msg.jsp"%>
	
<br>
<table class="listbox" width="80%">
	 <tr>
	 	<td class="td1"><i18n:label code="GENERAL_DEFAULT_DESC"/></td>
	 	<td ><%=menuBean.getDesc()%></td>
	 </tr> 
	 
	 <% for (int j=0;j<languagebeans.length;j++) { 
			
		 	String lmsg = "";
		 	String localename = languagebeans[j].getLocaleStr();
		 	
		 	if (menuBean.getLocalemsgs().get(localename) != null)
		 		lmsg = (String) menuBean.getLocalemsgs().get(localename);
		 
	 %>
				
	  <tr>
	 	<td class="td1"><%=languagebeans[j].getLocaleStr()%>:</td>
	 	<td><std:input type="text" name="<%=localename%>" value="<%=lmsg%>" size="70" maxlength="250"/></td>
	 </tr>
	 	
	<% } // end for loop %>
	
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_UPDATE"/>"></td></tr>
</table>

</form>

 </body>
</html>