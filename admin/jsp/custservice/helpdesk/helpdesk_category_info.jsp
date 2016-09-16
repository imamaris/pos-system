<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.helpdesk.category.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
	
	String default_locale = null;
	HelpdeskCategoryBean[] default_list = null;

	if (languagebeans != null && languagebeans.length > 0)
	{
	    default_locale = languagebeans[0].getLocaleStr();
	    default_list = (HelpdeskCategoryBean[]) returnBean.getReturnObject(default_locale);
	}
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	 
			thisform.submit();
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.HELPDESK_CAT_INFO%>"/></div>

<form name="frm" action="" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
			  	  	<% for (int i=0;i<default_list.length;i++) { %>
				  	<tr>
			  			<td class="td1" width="250"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.DEFAULT_HELP_DESK_CAT_NAME%>"/>:</td>
			      		<td><%=default_list[i].getDefaultMsg()%></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="250" valign="top"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DEFAULT_DESCRIPTION%>"/>:</td>
			      		<td><%=default_list[i].getDefaultDesc()%></td>
			  		</tr>
			  		<!--
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/>:</td>
			      		<td><%=String.valueOf(default_list[i].getOrderSeq())%></td>
			  		</tr>
			  		-->
			  		<tr>
			  			<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
			      		<td><%=default_list[i].getStatus().equalsIgnoreCase("A")?"Active":"Inactive"%></td>
			  		</tr>
	 				
	 				<% for (int j=0;j<languagebeans.length;j++) { 
	 					HelpdeskCategoryBean[] list = (HelpdeskCategoryBean[]) returnBean.getReturnObject(languagebeans[j].getLocaleStr());
	 					String locale_name = "";
	 					String locale_desc = "";
	 					if (list[i] != null)
	 						locale_name = list[i].getName();
	 						locale_desc = list[i].getDescription();
	 				%>
					
					<tr>
	 					<td class="td1"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.LOCALE_CATEGORY_NAME%>"/> (<%=languagebeans[j].getLocaleStr()%>):</td>
	 					<td><%=locale_name.length()>0?locale_name:"--"%></td>
	 				</tr>
	 				<tr>
	 					<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 					<td><%=locale_desc.length()>0?locale_desc:"--"%></td>
	 				</tr>

					<% } // end for loop %>
					<% } // end for loop %>

				</table>
			</td>
		</tr>	
	</table>
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name=""/> 
	<!--
	<input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.BACK%>'/>" onClick="doSubmit(this.form);">
	-->
  	
</form>
</html>