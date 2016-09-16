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

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.EDIT_HELPDESK_CAT%>"/></div>

<form name="frm" action="<%=Sys.getControllerURL(HelpdeskCategoryManager.TASKID_HELPDESK_CAT_EDIT,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>

<p class="required note">* <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.REQUIRED_FIELD%>"/></p>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
			  	  	<% for (int i=0;i<default_list.length;i++) { %>
			  	  	<std:input type="hidden" size="50" name="CatID" value="<%=String.valueOf(default_list[i].getCatID())%>"/>
				  	<tr>
			  			<td class="td1" width="250"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.DEFAULT_HELP_DESK_CAT_NAME%>"/>:</td>
			      		<td><std:input type="text" size="50" name="DefaultMsg" value="<%=default_list[i].getDefaultMsg()%>"/></td>
			  		</tr>
			  		<tr>
						<td class="td1" width="250" valign="top"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DEFAULT_DESCRIPTION%>"/>:</td>
			      		<td><textarea cols="50" rows="2" name="Description"><%=default_list[i].getDefaultDesc()%></textarea></td>
			  		</tr>
			  		<!--
			  		<tr>
						<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/>:</td>
			      		<td><std:input type="text" maxlength="5" size="3" value="<%=String.valueOf(default_list[i].getOrderSeq())%>" name="OrderSeq"/></td>
			  		</tr>
					-->
					<%
					String aselected="";
					String iselected="";
					if (default_list[i].getStatus().equalsIgnoreCase("A"))
						aselected="selected";
					if (default_list[i].getStatus().equalsIgnoreCase("I"))
						iselected="selected";
					%>
					
			  		<tr>
			  			<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
			      		<td>
			      			<select name="Status">
			      				<option value="<%=AppConstant.STATUS_ACTIVE%>" <%=aselected %>>Active</option>
			      				<option value="<%=AppConstant.STATUS_INACTIVE%>" <%=iselected %>>Inactive</option>
			      			</select>
			      		</td>
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
	 					<td><input type="text" name="<%=languagebeans[j].getLocaleStr()%>" value="<%=locale_name%>" size="50" maxlength="250"></td>
	 				</tr>
	 				<tr>
	 					<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
	 					<td>
	 						<textarea cols="50" rows="2" name="<%=languagebeans[j].getLocaleStr()%>_desc"><%=locale_desc%></textarea><br><br>
	 					</td>
	 				</tr>

					<% } // end for loop %>
					<% } // end for loop %>

				</table>
			</td>
		</tr>	
	</table>
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="OrderSeq" value="1"/> 

	<input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.SUBMIT%>'/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.RESET%>'/>">
  	
</form>
</html>