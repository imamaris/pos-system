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
	AdminLoginUserBean[] userBeans = (AdminLoginUserBean[]) returnBean.getReturnObject("UserList");
	HelpdeskBean helpdeskBean = (HelpdeskBean) returnBean.getReturnObject("Incident");
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			//window.opener.location.href='<%=Sys.getControllerURL(HelpdeskManager.TASKID_HELPDESK_INCIDENT_OPEN,request)%>'+'&<%=AppConstant.RETURN_SUBMIT_CODE%>=&CatID=&PriorityLevel=&Name=';
			thisform.submit();
		}
		function doClose(thisform)
		{
			window.close();
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.ASSIGN_INCIDENT%>"/></div>

<form name="frmIncidentAssign" action="<%=Sys.getControllerURL(HelpdeskManager.TASKID_HELPDESK_INCIDENT_ASSIGN,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>
<%
if (userBeans!=null){
%>
<p class="required note">* <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.REQUIRED_FIELD%>"/></p>
<%
}
%>
	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MEMBER_ID%>"/>:</td>
			      		<td><%=helpdeskBean.getRequestByID()%></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_BY%>"/>:</td>
			      		<td><%=helpdeskBean.getRequestBy()%></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_DATE%>"/>:</td>
			      		<td><%=helpdeskBean.getDate()%></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
			      		<td><%=helpdeskBean.getHelpdeskCategory().getName()%></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.PRIORITY_LEVEL%>"/>:</td>
			      		<td><%=String.valueOf(helpdeskBean.getPriority())%></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.SUBJECT%>"/>:</td>
			      		<td><%=helpdeskBean.getSubject()%></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
			      		<td><%=helpdeskBean.getDescription()%></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.ASSIGN_BY%>"/>:</td>
			      		<td><%=helpdeskBean.getAssignBy()!=null?helpdeskBean.getAssignBy():"--"%></td>
			  		</tr>
			  		<%
			  		if (userBeans!=null){
			  		%>
			  		<tr>
			  			<td class="td1" width="100"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.FOLLOWUP_BY%>"/>:</td>
			      		<td>
			      			<select name="FollowBy">
			      				<option value="" selected>[USER]</option>
			      				<option value="open">Open</option>
			      				<%
								for (int i=0;i<userBeans.length;i++) { 
									String selected = "";
									if (userBeans[i].getUserId().equals(helpdeskBean.getFollowBy()))
										selected = "selected";
								%>
								<option value="<%=userBeans[i].getUserId()%>" <%=selected%>><%=userBeans[i].getUserId()%> - <%=userBeans[i].getUserName()%></option>
								<%
								} // end for
								%>
			      			</select>
			      		</td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.PROCESS_STATUS%>"/>:</td>
			      		<td><%int processStatus = helpdeskBean.getProcessStatus();%>
			      			<%=processStatus==HelpdeskManager.STATUS_PENDING?"Pending":""%>
			      			<%=processStatus==HelpdeskManager.STATUS_UPDATED?"Updated":""%>
							<%=processStatus==HelpdeskManager.STATUS_ONHOLD?"On Hold":""%>
							<%=processStatus==HelpdeskManager.STATUS_RESOLVED?"Resolved":""%>
							<%=processStatus==HelpdeskManager.STATUS_UNRESOLVED?"Unresolved":""%>
			      		</td>
			  		</tr>
			  		<tr>
			  			<td colspan="2">
			  				<br><input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.SUBMIT%>'/>" onClick="doSubmit(this.form);">
  							<input class="textbutton" type="reset" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.RESET%>'/>">
  							<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
							<std:input type="hidden" name="SeqID" value="<%=String.valueOf(helpdeskBean.getSeq())%>"/>
			  			</td>
			  		</tr>
			  		
			  		<%
			  		} else {
			  		%>
			  		<tr>
			  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.FOLLOWUP_BY%>"/>:</td>
			      		<td><%=helpdeskBean.getFollowBy()!=null?helpdeskBean.getFollowBy():"--"%></td>
			  		</tr>
			  		<tr>
			  			<td><br><input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.CLOSE%>'/>" onClick="doClose(this.form);"></td>
			      		<td></td>
			  		</tr>
			  		<%
			  		}
			  		%>
				</table>
			</td>
		</tr>	
	</table>
	<br>
</form>
</html>