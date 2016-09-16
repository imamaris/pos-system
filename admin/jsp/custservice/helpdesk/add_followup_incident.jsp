<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.helpdesk.*"%>
<%@ page import="com.ecosmosis.orca.helpdesk.category.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.users.AdminLoginUserBean"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	HelpdeskBean helpdeskBean = (HelpdeskBean) returnBean.getReturnObject("Incident");
	HelpdeskBean detailBean = (HelpdeskBean) returnBean.getReturnObject("IncidentDetail");
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			thisform.submit();
		}
		function doClose(thisform)
		{
			window.close();
		}
		function insert()
		{
			var thisform = document.frmIncidentFollow;
			thisform.ProcessStatus.value = '<%=String.valueOf(helpdeskBean.getProcessStatus())%>';
		}
	</script>
</head>

<body onLoad="self.focus();insert()">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.FOLLOWUP_INCIDENT_PENDING%>"/></div>

<form name="frmIncidentFollow" action="<%=Sys.getControllerURL(HelpdeskManager.TASKID_HELPDESK_INCIDENT_FOLLOW_ADD,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>
<%
if (detailBean==null){
%>
<p class="required note">* <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.REQUIRED_FIELD%>"/></p>
<%
}
%>

	<table class="tbldata" width="100%">
  		<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MEMBER_ID%>"/>:</td>
      		<td><%=helpdeskBean.getRequestByID()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_BY%>"/>:</td>
      		<td><%=helpdeskBean.getRequestBy()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_DATE%>"/>:</td>
      		<td><%=helpdeskBean.getDate()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
      		<td><%=helpdeskBean.getHelpdeskCategory().getName()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.PRIORITY_LEVEL%>"/>:</td>
      		<td><%=String.valueOf(helpdeskBean.getPriority())%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.SUBJECT%>"/>:</td>
      		<td><%=helpdeskBean.getSubject()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
      		<td><%=helpdeskBean.getDescription()%></td>
  		</tr>
  	  	<%
  	  	if (detailBean!=null){
  	  	%>
  	  	<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.FOLLOWUP_BY%>"/>:</td>
      		<td><%=detailBean.getHelpdeskDetail().getFollowBy()%></td>
  		</tr>
  		<tr>
			<td class="td1" width="120" valign="top"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
      		<td><%=detailBean.getHelpdeskDetail().getDescription()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.PROCESS_STATUS%>"/>:</td>
      		<td><%int processStatus = detailBean.getProcessStatus();%>
      			<%=processStatus==HelpdeskManager.STATUS_PENDING?"Pending":""%>
      			<%=processStatus==HelpdeskManager.STATUS_UPDATED?"Updated":""%>
				<%=processStatus==HelpdeskManager.STATUS_ONHOLD?"On Hold":""%>
				<%=processStatus==HelpdeskManager.STATUS_RESOLVED?"Resolved":""%>
				<%=processStatus==HelpdeskManager.STATUS_UNRESOLVED?"Unresolved":""%>
      		</td>
  		</tr>
  		<tr>
  			<td colspan="2">
  				<br><input class="textbutton" type="button" value="<i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CLOSE%>"/>" onClick="doClose(this.form);">
			</td>
  		</tr>
  	  	<%
  	  	} else {
  	  	%>
  	  	<tr>
  			<td class="td1" width="120"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.FOLLOWUP_BY%>"/>:</td>
      		<td><%=helpdeskBean.getFollowBy()!=null?helpdeskBean.getFollowBy():"--"%></td>
  		</tr>
  		<tr>
			<td class="td1" width="120" valign="top"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
      		<td><textarea cols="50" rows="3" name="Description"></textarea></td>
  		</tr>
  		<tr>
  			<td class="td1" width="120"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.PROCESS_STATUS%>"/>:</td>
      		<td>
      			<select name="ProcessStatus">
      				<option value="">[STATUS]</option>
      				<option value="10">Pending</option>
      				<option value="15">Updated</option>
      				<option value="20">On Hold</option>
      				<option value="30">Resolved</option>
      				<option value="40">Unresolved</option>
      			</select>
      		</td>
  		</tr>
  		<tr>
  			<td colspan="2">
  				<br><input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.SUBMIT%>'/>" onClick="doSubmit(this.form);">
				<input class="textbutton" type="reset" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.RESET%>'/>">
				<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
				<std:input type="hidden" name="SeqID" value="<%=String.valueOf(helpdeskBean.getSeq())%>"/>
				<std:input type="hidden" name="FollowBy" value="<%=helpdeskBean.getFollowBy()%>"/>
  			</td>
  		</tr>
  	  	<%
  	  	}
  	  	%>
  	  	
	</table>
	
	<br>
</form>
</html>