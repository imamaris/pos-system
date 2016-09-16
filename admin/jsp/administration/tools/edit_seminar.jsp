<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.tools.seminar.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	SeminarBean eventBean = (SeminarBean) returnBean.getReturnObject("EventBean");
	SeminarBean edited = (SeminarBean) returnBean.getReturnObject("Edited");
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			//window.opener.location.href='<%=Sys.getControllerURL(SeminarManager.TASKID_SEMINAR_LISTING,request)%>'+'&Status=&Title=';
			thisform.submit();
		}
		function doClose(thisform)
		{
			window.close();
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.EDIT_SEMINAR_EVENT%>"/></div>

<form name="frmIncidentAssign" action="<%=Sys.getControllerURL(SeminarManager.TASKID_SEMINAR_EDIT,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<%
	String activities = eventBean.getSeminarEventBean().getActivities();
	String newAct = activities.replaceAll("\n","<br>");
	String aSel = "";
	String iSel = "";
	String status = eventBean.getSeminarEventBean().getStatus();
	if (status.equalsIgnoreCase("A"))
		aSel = "selected";
	else
		iSel = "selected";
%>

	<table class="tbldata" width="100%">
  	  	<tr><td height="15"><input type="hidden" name="Seq" value="<%=String.valueOf(eventBean.getSeminarEventBean().getSeq())%>"></td></tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.SEMINAR_TITLE%>"/>:</td>
      		<td><%=eventBean.getTitle()%></td>
  		</tr>
  		<%
  		if (edited==null) {
  		%>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
      		<td>
				<select name="Status">
      				<option value="<%= AppConstant.STATUS_ACTIVE %>" <%=aSel%>>Active</option>
      				<option value="<%= AppConstant.STATUS_INACTIVE %>" <%=iSel%>>Inactive</option>
      			</select>
			</td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.VENUE%>"/>:</td>
      		<td><input type="text" size="60" name="Venue" value="<%=eventBean.getSeminarEventBean().getVenue()%>"/></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100" valign="top"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.ACTIVITIES%>"/>:</td>
      		<td><textarea cols="60" rows="4" name="Activity"><%=eventBean.getSeminarEventBean().getActivities()%></textarea></td>
  		</tr>
  		<tr>
  			<td colspan="2"><br>
  				<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
				<input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.SUBMIT%>'/>" onClick="doSubmit(this.form);">
			  	<input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.RESET%>'/>">
  			</td>
  		</tr>
  		<%
  		} else {
  		%>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
      		<td><%=eventBean.getSeminarEventBean().getStatus().equalsIgnoreCase("A")?"Active":"Inactive"%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.VENUE%>"/>:</td>
      		<td><%=eventBean.getSeminarEventBean().getVenue()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.ACTIVITIES%>"/>:</td>
      		<td><%=newAct%></td>
  		</tr>
  		<tr>
  			<td colspan=""2><br>
  				<input class="textbutton" type="button" value="Close" onClick="doClose(this.form);">
			</td>
  		</tr>
  		<%
  		}
  		%>
	</table>

</form>
</html>