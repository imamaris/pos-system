<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.messages.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	
	MessageBean msgBean = (MessageBean) returnBean.getReturnObject("Msg");
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
	TreeMap msgTypeList = (TreeMap) returnBean.getReturnObject("MsgTypeList");
	boolean canView = false;
	int language_types = 0;
	
	if (languagebeans != null && languagebeans.length > 0)
	{
	 	canView = true;
	    language_types = languagebeans.length;
	}	   
	
	String keyword = request.getParameter("keyword");
	String popup = request.getParameter("popup");
	String msgtype = request.getParameter("msgType");
	if (msgtype == null)
		msgtype = "";
%> 
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit()
{
	var agree=confirm("<i18n:label code="MSG_CONFIRM"/>");
	if (agree)
		return true ;
	else
		return false ;
}
// -->
</script> 
</head>
 <body>
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<div class="functionhead">Update Locale Message</div>
<br>
<form name="addtask" action="<%=Sys.getControllerURL(MessageManager.TASKID_EDIT_MESSAGE_SUBMIT ,request)%>#<%=msgBean.getMessageID()%>" method="post">
<input type="hidden" name="msgid" value="<%=msgBean.getMessageID()%>">
<input type="hidden" name="msgType" value="<%=msgtype%>">
<input type="hidden" name="keyword" value="<%=keyword%>">
<%
	if(request.getParameter("popup") != null){
%>	
		<input type=hidden name="popup" value="yes">	
<%	} %>	

<table width="100%">
	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.MESSAGE_ID%>"/>:</td>
	 	<td><%=msgBean.getMessageID()%></td>
	 </tr>
	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TYPE%>"/>:</td>
	 	<td><std:input type="select" name="type" options="<%=msgTypeList%>" value="<%=msgBean.getMsgtype()%>"/></td>
	 </tr>
 	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 	<td><std:input type="text" name="msgdesc" value="<%=msgBean.getDescription()%>" size="70" maxlength="250"/></td>
	 </tr>
	 
	 <!-- tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.DEFINATION_CLASS%>"/>:</td>
	 	<td><std:input type="text" name="source" value="<%=msgBean.getSource()%>" size="70" maxlength="200"/></td>
	 </tr -->
	 
	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.DEFAULT_MESSAGE%>"/>:</td>
	 	<td><std:input type="text" name="defaultmsg" value="<%=msgBean.getDefault_message()%>" size="70" maxlength="250"/></td>
	 </tr>
	 
	 <% for (int j=0;j<language_types;j++) { 
			
		 	String lmsg = "";
		 	String localename = languagebeans[j].getLocaleStr();
		 	ArrayList list = msgBean.getLocaleMsgs();
		 	if (list != null && list.size() > 0)
		 	{	
			 	for (int k=0;k<list.size();k++)
			 	{
				 	MessageBean mbean = (MessageBean) list.get(k);
				 	if (localename.equalsIgnoreCase(mbean.getLocale()))
				 		lmsg = mbean.getMessage();
			 	}
		 	}
		 
	 %>
				
	  <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.LOCALE_MESSAGE%>"/> <%=languagebeans[j].getLocaleStr()%>:</td>
	 	<td><std:input type="text" name="<%=localename%>" value="<%=lmsg%>" size="70" maxlength="250"/></td>
	 </tr>
	 	
	<% } // end for loop %>
	 	
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="UPDATE"></td></tr>
</table>

</form>

 </body>
</html>