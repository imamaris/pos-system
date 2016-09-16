<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] languagebeans = (LanguageBean[]) returnBean.getReturnObject("supportedlocale");
	boolean canView = false;
	int language_types = 0;
	String default_locale = null;
	ProductCategoryBean[] default_list = null;
	
	if (languagebeans != null && languagebeans.length > 0)
	{
	 	canView = true;
	    language_types = languagebeans.length;
	    default_locale = languagebeans[0].getLocaleStr();
	    default_list = (ProductCategoryBean[]) returnBean.getReturnObject(default_locale);
	}

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Brand Listing</div>
 	<form name="listcategory" action="<%=Sys.getControllerURL(ProductCategoryManager.TASKID_PRODUCT_CAT_LISTING,request)%>" method="post">
 	<table width="30%">
 		<tr>
	 		<td >
	            <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>: 
		 		<select name="type">
		 		    <option value=""><i18n:label code="GENERAL_ALL"/></option>
					<option value="A"><i18n:label code="GENERAL_ACTIVE"/></option>
					<option value="I"><i18n:label code="GENERAL_INACTIVE"/></option>
				</select>&nbsp;&nbsp;
			</td>
	 	</tr>
	 	<tr><td><br><input type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>"></td></tr> 
	</table>
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
    </form>

<% if (canView) { %>    
	<table class="listbox" width="50%" cellspacing="0">
		<tr class="boxhead" align="center" valign=top>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td>Category ID</td>
			<% for (int i=0;i<language_types;i++) { %>
				<td width="200"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.LOCALE_CATEGORY_NAME%>"/><br>(<%=languagebeans[i].getLocaleStr()%>)</td>		
			<% } // end for loop %>	
		  </tr>
		  
		  <% for (int i=0;i<default_list.length;i++) { %>
		  	  <tr class="<%= (i%2 == 0) ? "even" : "odd"%>">
				<td align="center"><%=(i+1)%></td>
				<td>
					<a href="<%=Sys.getControllerURL(ProductCategoryManager.TASKID_PRODUCT_CAT_INFO,request)%>&catid=<%=default_list[i].getCatID()%>">
							<%=default_list[i].getDefaultMsg()%>
					</a>
				</td>
					
				<% for (int j=0;j<language_types;j++) { 
					ProductCategoryBean[] list = (ProductCategoryBean[]) returnBean.getReturnObject(languagebeans[j].getLocaleStr());
					 String value = "";
					 if (list[i] != null)
					 {
					 	value = list[i].getName();
					 }
				%>
					<td><%=value.length()>0?value:"--"%></td>		
				<% } // end for loop 
				int catid = default_list[i].getCatID();
				%>

			</tr>	
		  <% } // end for loop %>
	</table>

<% } // end if canView %>	
	
	</body>
</html>
