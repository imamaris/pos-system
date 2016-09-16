<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@page import="com.ecosmosis.orca.webcontent.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ContentCategoryBean[] list = (ContentCategoryBean[])returnBean.getReturnObject("CatList");
	TreeMap status_list = (TreeMap) returnBean.getReturnObject("Status");
	
	boolean canView = (list!=null);			
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><i18n:label code="WEB_CATEGORY_LIST"/></div>
 	<form name="listcategory" action="<%=Sys.getControllerURL(WebManager.TASKID_CONTENT_CAT_LISTING,request)%>" method="post">
 	<table width="30%">
 		<tr>
	 		<td >
	            <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>: 
		 		<std:input name="Status" type="select" options="<%=status_list %>" />
		 		&nbsp;&nbsp;<input type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
			</td>
	 	</tr>
	 	<tr><td><br></td></tr> 
	</table>
	
    </form>

<%
if (canView) {
%>    
	<table class="listbox" width="50%" cellspacing="0">
		<tr class="boxhead" align="center" valign=top>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.DEFAULT_CATEGORY_NAME%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/></td>
			<td></td>
		  </tr>
		  <%
		  		  		if(list.length>0){	
		  		  		for(int i=0; i<list.length;i++){
		  %>
		  <tr>
		  	<td align=right><%=(i+1)%>.</td>
		  	<td><%=list[i].getCategoryName()%></td>
		  	<td align=center><%=list[i].getStatus()%></td>
		  	<td align=center><%=list[i].getOrder()%></td>
		  	<td align=center><std:link taskid="<%=WebManager.TASKID_CONTENT_CAT_EDIT%>" text="edit" params="<%=("&catid=" + list[i].getCategoryID())%>"/></td>
		  </tr>
		  <%	}//end for 
		  	}else{
		  %>
		  <tr><td colspan=5 align=center><i18n:label code="MSG_NO_RECORDFOUND"/></td></tr>
		  <%} %>
	</table>

<% } // end if canView %>	
	
	</body>
</html>
