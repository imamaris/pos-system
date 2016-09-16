<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.messages.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
	TreeMap msgTypeList = (TreeMap) returnBean.getReturnObject("MsgTypeList");
	String addedMsgID = (String)returnBean.getReturnObject("NewMsgID");
	
	boolean canView = false;
	int language_types = 0;
	
	if (languagebeans != null && languagebeans.length > 0)
	{
	 	canView = true;
	    language_types = languagebeans.length;
	}	   
%> 


<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<html>
<head>
<title>Add Localised Message</title>
<script LANGUAGE="JavaScript">
<!--
function openNewWindow()
{	
	window.open('<%=Sys.getControllerURL(MessageManager.TASKID_ADD_NEW_MESSAGE,request)%>&popup=yes','MessagePopup','menubr=no,resizable=yes,toolbar=no,scrollbars=yes,status=yes,width=650,height=400,screenX=0,screenY=0');
	return false;
}

function confirmSubmit()
{	
	var myform = document.addtask;
	myform.msgid.value = myform.msgid.value.toUpperCase();
	var agree=confirm("Confirm ?");
	
	if (agree)
		return true ;
	else
		return false ;
}

// -->
</script>
  
<%@ include file="/lib/ajax.jsp"%>     
<%@ include file="/lib/header.jsp"%>

</head>

<body onLoad="document.addtask.msgid.focus();">
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<c:if test="<%=(addedMsgID!=null)%>">

	<script LANGUAGE="JavaScript">
		function ClipBoard() 
		{
			holdtext.innerText = copytext.innerText;
			Copied = holdtext.createTextRange();
			Copied.execCommand("Copy");
		}
	</script>

	<DIV ID="copytext" nowrap STYLE="height:20;width:50;background-color:pink;" align=left>&lt;i18n:label code=&quot;<%=addedMsgID%>&quot;&#47;&gt;</DIV>
	<TEXTAREA ID="holdtext" STYLE="display:none;">
	</TEXTAREA>
	<a href="" onClick='ClipBoard();return false;'><small>Copy to clipboard</small></a>
</c:if>

<form name="addtask" action="<%=Sys.getControllerURL(MessageManager.TASKID_ADD_NEW_MESSAGE,request)%><%=(request.getParameter("popup") == null)?"":"&popup=yes"%>" method="post">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.ADD_MESSAGE%>"/></div>
<br>
	
<table width="100%">
	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.MESSAGE_ID%>"/>:</td>
	 	<td><input type="text" id="msgid" name="msgid" value="" size="30" maxlength="30">
	 	<span id="indicator" style="display:none;"><img src="<%=request.getContextPath()%>/img/indicator.gif" /></span>
	 	</td>
	 </tr>
	 
	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TYPE%>"/>:</td>
	 	<td><std:input type="select" name="type" options="<%=msgTypeList%>"/></td>
	 </tr>
	 
 	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 	<td><input type="text" id="make" name="msgdesc" value="" size="70" maxlength="250"></td>
	 </tr>
	 
	 <!-- tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.DEFINATION_CLASS%>"/>:</td>
	 	<td><input type="text" name="source" value="" size="70" maxlength="200"></td>
	 </tr -->
	 
	 <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.DEFAULT_MESSAGE%>"/>:</td>
	 	<td><input type="text" name="defaultmsg" value="" size="70" maxlength="250"></td>
	 </tr>
	 
	 <% for (int j=0;j<language_types;j++) { %>
				
	  <tr>
	 	<td class="td1" width="150"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.LOCALE_MESSAGE%>"/> <%=languagebeans[j].getLocaleStr()%>:</td>
	 	<td><input type="text" name="<%=languagebeans[j].getLocaleStr()%>" value="" size="70" maxlength="250"></td>
	 </tr>
	 	
	<% } // end for loop %>
	 	
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
	<tr><td>&nbsp</td></tr>
	<tr><td>&nbsp</td></tr>
 	<tr class="head">
 		<td align="center"> 			
 			<% if(request.getParameter("popup") == null){ %>
	 			<input type="button" value="Open New Window" onclick="openNewWindow();">
 			<% }%> 			
 			<input type="submit" value="ADD" onclick="return confirmSubmit()">
	 	</td>
	</tr>
</table>
</form>

<ajax:autocomplete
  source="msgid"
  target="make"
  baseUrl="<%= request.getContextPath() + "/autocomplete.view"%>"
  className="autocomplete"
  indicator="indicator"
  minimumCharacters="2"
  parser="new ResponseXmlToHtmlListParser()" />
  
 </body>
</html>