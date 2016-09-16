<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.helpdesk.category.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
	boolean canView = false;
	int language_types = 0;
	String default_locale = null;
	HelpdeskCategoryBean[] default_list = null;
	
	if (languagebeans != null && languagebeans.length > 0)
	{
	 	canView = true;
	    language_types = languagebeans.length;
	    default_locale = languagebeans[0].getLocaleStr();
	    default_list = (HelpdeskCategoryBean[]) returnBean.getReturnObject(default_locale);
	}

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.HELP_DESK_CAT_LISTING%>"/></div>
 	<form name="listcategory" action="<%=Sys.getControllerURL(HelpdeskCategoryManager.TASKID_HELPDESK_CAT_LISTING,request)%>" method="post">
 	<table width="30%">
 		<tr>
	 		<td >
	            <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>: 
		 		<select name="type">
		 		    <option value="">ALL</option>
					<option value="<%=AppConstant.STATUS_ACTIVE%>">Active</option>
					<option value="<%=AppConstant.STATUS_INACTIVE%>">Inactive</option>
				</select>&nbsp;&nbsp;
			</td>
	 	</tr>
	 	<tr><td><br><input type="submit" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.SUBMIT%>'/>"></td></tr> 
	</table>
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
    </form>

<% if (canView) { %>    
	<table class="listbox" width="100%" cellspacing="0">
		<tr class="boxhead" align="center">
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.DEFAULT_CATEGORY_NAME%>"/></td>
			<% for (int i=0;i<language_types;i++) { %>
				<td><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.LOCALE_CATEGORY_NAME%>"/> (<%=languagebeans[i].getLocaleStr()%>)</td>		
			<% } // end for loop %>	
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/></td>
			<td width="15"></td>
		  </tr>
		  
		  <% for (int i=0;i<default_list.length;i++) { %>
		  	  <tr class="<%= (i%2 == 0) ? "even" : "odd"%>">
				<td align="center"><%=(i+1)%></td>
				<td>
					<a href="<%=Sys.getControllerURL(HelpdeskCategoryManager.TASKID_HELPDESK_CAT_INFO,request)%>&catid=<%=default_list[i].getCatID()%>">
							<%=default_list[i].getDefaultMsg()%>
					</a>
				</td>
					
				<% for (int j=0;j<language_types;j++) { 
					HelpdeskCategoryBean[] list = (HelpdeskCategoryBean[]) returnBean.getReturnObject(languagebeans[j].getLocaleStr());
					 String value = "";
					 if (list[i] != null)
					 {
					 	value = list[i].getName();
					 }
				%>
					<td><%=value.length()>0?value:"--"%></td>		
				<% } // end for loop %>
				<td align="center"><%=default_list[i].getStatus()%></td>
				<td>
					<a href="<%=Sys.getControllerURL(HelpdeskCategoryManager.TASKID_HELPDESK_CAT_EDIT,request)%>&catid=<%=default_list[i].getCatID()%>">
						<img border="0" alt='Edit Helpdesk Category' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
					</a>
				</td>
			</tr>	
		  <% } // end for loop %>
	</table>

<% } // end if canView %>	
	
	</body>
</html>