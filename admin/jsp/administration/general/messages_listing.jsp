<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.messages.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
	boolean canView = false;
	int language_types = 0;
	String default_locale = null;
	MessageBean[] default_list = null;
	
	if (languagebeans != null && languagebeans.length > 0)
	{
	 	canView = true;
	    language_types = languagebeans.length;
	    default_locale = languagebeans[0].getLocaleStr();
	    default_list = (MessageBean[]) returnBean.getReturnObject(default_locale);
	}	   
	
	String keyword = request.getParameter("keyword");
	String msgtype = request.getParameter("msgType");
	if (msgtype == null)
		msgtype = "";
		
	TreeMap msgTypeList = (TreeMap) returnBean.getReturnObject("MsgTypeList");
%> 


<html>
<head>
<title>Search Localised Message</title>

<script LANGUAGE="JavaScript">
<!--
function openNewWindow()
{	
	window.open('<%=Sys.getControllerURL(MessageManager.TASKID_MESSAGE_LISTING,request)%>&popup=yes','SearchMessagePopup','menubr=no,resizable=yes,toolbar=no,scrollbars=yes,status=yes,width=600,height=400,screenX=0,screenY=0');
	return false;
}
function tagPostSubmit(link, msgid)
{
	var myform = document.clickeditform;
	myform.action = link;
	
	myform.msgid.value = msgid;
	myform.submit();
}
// -->
</script>

<%@ include file="/lib/header.jsp"%>
</head>

<body onLoad="document.listmsg.keyword.focus();document.listmsg.keyword.select();">
	<script LANGUAGE="JavaScript">
		function ClipBoard(thisObj) 
		{	
			holdtext.innerText = thisObj;
			Copied = holdtext.createTextRange();
			Copied.execCommand("Copy");
			return false;
		}
	</script>
	
	<TEXTAREA ID="holdtext" STYLE="display:none;">
	</TEXTAREA>
	
<div class=functionhead><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.LOCALE_MESSAGE_LISTING%>"/></div><br>

<form name="clickeditform" method="POST">
	<input type=hidden name="msgid">
	<input type=hidden name="msgType" value="<%=msgtype%>">
	<input type=hidden name="keyword" value="<%=keyword%>">
<%
	if(request.getParameter("popup") != null){
%>	
		<input type=hidden name="popup" value="yes">	
<%	} %>	
</form>

<form name="listmsg" action="<%=Sys.getControllerURL(MessageManager.TASKID_MESSAGE_LISTING,request)%><%=(request.getParameter("popup") == null)?"":"&popup=yes"%>" method="post">
	
	<table width="100%">
 	<tr>
	 	<td width="5%" nowrap>
            <b><i18n:label code="GENERAL_KEYWORD"/></b>
	 	</td>
 		<td>: <std:input type="text" name="keyword" size="40"/></td>
	 </tr> 
 	 <tr>
	 	<td>
            <b><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TYPE%>"/></b>
        </td>
	 	<td>: <std:input type="select" name="msgType" options="<%=msgTypeList%>"/></td>
	 </tr>
	 <tr>
	 	<td colspan=2>&nbsp;</td>
	 </tr>
	 <tr>
	 	<td colspan=2>
	 	<% if(request.getParameter("popup") == null){ %>
	 			<input type="button" value="<i18n:label code="GENERAL_BUTTON_POPUPWINDOW"/>" onclick="openNewWindow();">
		<% }else{%> 			
 			    <input type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onclick="window.close();">
		<% }%>
	 	<input type="submit" value="<i18n:label code="GENERAL_BUTTON_SEARCH"/>">	 	
	 	</td>
	 </tr>  
	 </table>
    </form>

    <%@ include file="/general/mvc_return_msg.jsp"%>
    
<% if (canView) { %>    
	<table class="listbox" width="100%">
	
		  <tr class="boxhead" valign=top>
			<td align=right><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td align=center><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.MESSAGE_ID%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TYPE%>"/></td>
	<!--		<td><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.DEFINATION_CLASS%>"/></td>   -->
			<td align=left width="200"><i18n:label localeRef="mylocale" code="<%=MessageMessageTag.DEFAULT_MESSAGE%>"/></td>
			<% for (int i=0;i<language_types;i++) { %>
				<td width="200"><%=languagebeans[i].getLocaleStr()%></td>		
			<% } // end for loop %>	
			<td>&nbsp;</td>
		  </tr>

		  	
		  	<% 
		  	   int counter = 0;
		  	   for (int i=0;i<default_list.length;i++) { 
			  		
			  		counter++;
			  		
			  		String rowCss = "";
		  		  	if((i+1) % 2 == 0)
		  	      		rowCss = "even";
		  	      	else
		  	        	rowCss = "odd";
		  	%>
		  	  <tr class="<%=rowCss%>">
				<td align=right><%=(i+1)%>.</td>
				<td align=left>
				<a href="" onClick="ClipBoard('&lt;i18n:label code=&quot;<%=default_list[i].getMessageID()%>&quot;&#47;&gt;');return false;"><%=default_list[i].getMessageID()%></a>
				<a name="<%=default_list[i].getMessageID()%>">
				</td>
				<td align="center"><%=default_list[i].getMsgtype()%></td>
		<!--		<td><%=(default_list[i].getSource()!=null)?default_list[i].getSource():""%></td> -->
				<td><%=default_list[i].getDefault_message()%></td>
					
				<% for (int j=0;j<language_types;j++) { 
					 MessageBean[] list = (MessageBean[]) returnBean.getReturnObject(languagebeans[j].getLocaleStr());
					 String value = " -- ";
					 if (list!=null && list.length > 0 && list[i].isTranslated())
					 	value = list[i].getMessage();
				%>
					<td><%=value%></td>		
				<% } // end for loop %>
				   
				    <td><std:link taskid="<%= MessageManager.TASKID_EDIT_MESSAGE%>" text="edit" type="2" params="<%=("tagPostSubmit(this.href,'" + default_list[i].getMessageID() + "');return false;")%>"/> </td>
			  </tr>	
			<% } // end for loop %>
			
		  	<%if(counter == 0){ %>
		  	
		  	<tr>
		  		<td colspan="<%=(5 + languagebeans.length)%>" align=center><i18n:label code="MSG_NO_RECORDFOUND"/></td>
		  	</tr>
		  	<% } //end if(i == 0) %>
	</table>

<% } // end if canView %>		
	
	</body>
</html>
