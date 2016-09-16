<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.helpdesk.*"%>
<%@ page import="com.ecosmosis.orca.helpdesk.category.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	HelpdeskBean incidentBeans = (HelpdeskBean) returnBean.getReturnObject("Incident");
	HelpdeskDetailBean[] detailBeans = (HelpdeskDetailBean[]) returnBean.getReturnObject("IncidentDetailList");
	
	boolean canView = false;
	if (incidentBeans != null)
		canView = true;
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			thisform.submit();
		}
		function doClose()
		{
			window.close();
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.INCIDENT_FOLLOWUP_HISTORY%>"/></div>

<form name="frmIncidentFollow" action="" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

	<table class="tbldata" width="100%">
		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.MEMBER_ID%>"/>:</td>
      		<td><%=incidentBeans.getRequestByID()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_BY%>"/>:</td>
  			<td><%=incidentBeans.getRequestBy()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_DATE%>"/>:</td>
  			<td><%=incidentBeans.getDate()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
  			<td><%=incidentBeans.getHelpdeskCategory().getName()!=null?incidentBeans.getHelpdeskCategory().getName():incidentBeans.getHelpdeskCategory().getDefaultMsg()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.PRIORITY_LEVEL%>"/>:</td>
  			<td><%=incidentBeans.getPriority()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.SUBJECT%>"/>:</td>
  			<td><%=incidentBeans.getSubject()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
  			<td><%=incidentBeans.getDescription()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.ASSIGN_BY%>"/>:</td>
  			<td><%=incidentBeans.getAssignBy()%></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.PROCESS_STATUS%>"/>:</td>
  			<td><% int processStatus = incidentBeans.getProcessStatus(); %>
  				<%=processStatus==HelpdeskManager.STATUS_PENDING?"Pending":""%>
  				<%=processStatus==HelpdeskManager.STATUS_UPDATED?"Updated":""%>
				<%=processStatus==HelpdeskManager.STATUS_ONHOLD?"On Hold":""%>
				<%=processStatus==HelpdeskManager.STATUS_RESOLVED?"Resolved":""%>
				<%=processStatus==HelpdeskManager.STATUS_UNRESOLVED?"Unresolved":""%>
 			</td>
  		</tr>
	</table>
	<br>	
	<% if (canView) { %>    
	<table class="listbox" width="100%" cellspacing="0">
		<tr class="boxhead" valign=top align="center">
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td width="80"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DATE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TIME%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.FOLLOWUP_BY%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.PROCESS_STATUS%>"/></td>
		</tr>
		
		<%
		if (detailBeans.length<=0) {
		%>
		<tr><td colspan="6" class="required note"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.NO_FOLLOWUP_INCIDENT_EXIST%>"/> !!</td></tr>
		<%
		}
		%>
		  
		<% for (int i=0;i<detailBeans.length;i++) {
			String rowCss = "";
			  	
	  		if((i+1) % 2 == 0)
	  	    	rowCss = "even";
	  	    else
	  	        rowCss = "odd";
		%>
		  
		<tr class="<%= rowCss %>" valign=top>
			<td align="center"><%=(i+1)%></td>
			<td align="center" width="80"><%=detailBeans[i].getDate()%></td>
			<td align="center"><%=detailBeans[i].getTime()%></td>
			<td align="left"><%=detailBeans[i].getDescription()%></td>
			<td align="center"><%=detailBeans[i].getFollowBy()%></td>
			<td>
				<% int proStatus = detailBeans[i].getProcessStatus(); %>
				<%=proStatus==HelpdeskManager.STATUS_PENDING?"Pending":""%>
  				<%=proStatus==HelpdeskManager.STATUS_UPDATED?"Updated":""%>
				<%=proStatus==HelpdeskManager.STATUS_ONHOLD?"On Hold":""%>
				<%=proStatus==HelpdeskManager.STATUS_RESOLVED?"Resolved":""%>
				<%=proStatus==HelpdeskManager.STATUS_UNRESOLVED?"Unresolved":""%>
			</td>
		</tr>	
		<% } // end for loop %>
	</table>
	<% } // end if canView %>	
	<br>
	<input type="button" value="<i18n:label localeRef="mylocale" code="<%=StandardMessageTag.CLOSE%>"/>" onClick="doClose()" />
</form>
</html>