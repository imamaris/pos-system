<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
String editURL = Sys.getControllerURL(MemberManager.TASKID_BASIC_EDIT_MEMBER, request);

  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	MemberBean[] beans = (MemberBean[]) returnBean.getReturnObject(MemberManager.RETURN_MBRLIST_CODE);
	
	boolean formSubmitted = returnBean.getReturnObject(AppConstant.RETURN_SUBMIT_CODE) != null ? true : false;

	boolean canView = false;
	if (beans != null && beans.length > 0) {
	 	canView = true;
 	}
%>

<html>
<head>
	<title></title>
	
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
		
  function doSearch(thisform) {
		/*	
  	if (!isDate(thisform.JoinDateFromStr)) {
			alert("Invalid Join Date From.");
			focusAndSelect(thisform.JoinDateFromStr);
    	return;
  	}
  	
  	if (!isDate(thisform.JoinDateToStr)) {
			alert("Invalid Join Date To.");
			focusAndSelect(thisform.JoinDateToStr);
    	return;
  	}*/
  	    		
  	thisform.submit();
	} 
	
	</script>
	
</head>

<body>
  
<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.REGISTRATION_RPT%>"/></div>	

<form name="frmSearch" action="<%=Sys.getControllerURL(MemberReportManager.TASKID_REGISTRATION_LISTING_RPT,request)%>" method="post">
	<table>
	  <tr>
	    <td><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/> <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.FROM%>"/>:</td>
	    <td><std:input type="date" name="JoinDateFromStr" value="<%= Sys.getDateFormater().format(new Date()) %>"/></td>
	    <td>&nbsp;&nbsp;&nbsp;</td>
	    <td><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/> <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TO%>"/>:</td>
	    <td><std:input type="date" name="JoinDateToStr" value="<%= Sys.getDateFormater().format(new Date()) %>"/></td>
	  </tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
		
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="doSearch(this.form);">
</form>

<hr>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>
<% 
	if (canView) { 
%>

<% 
	if (formSubmitted) {
%>

<table>
	<tr>
		<td>
			<table class="listbox" width="100">
				<tr>
					<td class="totalhead" width="50"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TOTAL%>"/></td>
					<td width="50"><%= beans.length %></td>
				</tr>
			</table>
		</td>
		<td>&nbsp;</td>
		<td>
			<input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
		</td>
	</tr>
</table>

<br>

<% 
	} // end formSubmitted 
%>

<table class="listbox" width="70%">
  <tr class="boxhead" valign=top>
    <td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
    <td width="13%">Customer ID</td>
    <td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
    <td width="13%">Mobile No.</td>
    <td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.JOIN_DATE%>"/></td>
    <td width="5%" >Edit</td>
  </tr>
	
    <%
  	for (int i=0; i<beans.length; i++) { 
    	
			String rowCss = "";
	  	
	  	if((i+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";

      if (beans[i].getStatus() != MemberManager.MBRSHIP_ACTIVE)
        rowCss = "alert";
  %>
	<tr class="<%= rowCss %>" valign=top>
    <td><%= i+1 %>.</td>
		<td nowrap>
    	<small><std:link text="<%= beans[i].getMemberID() %>" taskid="<%= MemberManager.TASKID_FULL_VIEW_MEMBER %>" params="<%= ("MemberID="+beans[i].getMemberID()) %>" /></small>
    </td>
    <td><%= beans[i].getName() %></td>
    <td nowrap><%= beans[i].getMobileNo() %></td>
    <td align="center" nowrap><%= (beans[i].getJoinDate() != null) ? Sys.getDateFormater().format(beans[i].getJoinDate()): "" %></td>
    <td align="center">
        <a href="<%= editURL %>&MemberID=<%= beans[i].getMemberID() %>">
            <img border="0" alt='Edit Customer' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
        </a>
    </td>
  </tr>
		    
	<% 
		} // end for 
	%>

</table>  

<% 
	} // end canView 
%>

</body>
</html>