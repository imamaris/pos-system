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
	HelpdeskCategoryBean[] categoryBeans = (HelpdeskCategoryBean[]) returnBean.getReturnObject("HelpdeskCategoryList");
	HelpdeskBean date = (HelpdeskBean) returnBean.getReturnObject("Date");
	
	HelpdeskBean[] pending = (HelpdeskBean[]) returnBean.getReturnObject("Pending");
	HelpdeskBean[] updated = (HelpdeskBean[]) returnBean.getReturnObject("Updated");
	HelpdeskBean[] onhold= (HelpdeskBean[]) returnBean.getReturnObject("Onhold");
	HelpdeskBean[] unresolved = (HelpdeskBean[]) returnBean.getReturnObject("Unresolved");
	HelpdeskBean[] resolved = (HelpdeskBean[]) returnBean.getReturnObject("Resolved");

	boolean canView = true;
	int total = pending.length + updated.length + onhold.length + unresolved.length + resolved.length;
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			thisform.submit();
		}
		function popitup(url)
		{
			newwindow=window.open(url,'name','scrollbars=1,height=400,width=550');
			if (window.focus) {newwindow.focus()}
			return false;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.INCIDENT_ANALYSIS%>"/></div>

<form name="frmIncidentAnalysis" action="<%=Sys.getControllerURL(HelpdeskManager.TASKID_HELPDESK_INCIDENT_ANALYSIS,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

	<table class="tbldata" width="100%">
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
      		<td width="150">
      			<select name="CatID">
      				<option value="" selected>[ALL]</option>
      				<%
					for (int i=0;i<categoryBeans.length;i++) { 
					%>
					<option value="<%=categoryBeans[i].getCatID()%>"><%=categoryBeans[i].getName()%></option>
					<%
					} // end for
					%>
      			</select>
      		</td>
      		<td align="left">&nbsp;<i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_DATE%>"/>: &nbsp; <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.FROM%>"/>
				<std:input type="date" name="DateFrom" size="11" value="<%= Sys.getDateFormater().format(new Date()) %>" maxlength="10"/> &nbsp; <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TO%>"/>
				<std:input type="date" name="DateTo" size="11" value="<%= date.getDateTo() %>" maxlength="10"/>
			</td>
  		</tr>
		<tr>
	 		<td><br><input type="submit" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.SUBMIT%>'/>" onClick="doSubmit(this.form)"></td>
	 		
	 	</tr> 
	 	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	</table>
	<br><hr><br>
	<% if (canView) { %>    
	<table class="listbox" width="30%" cellspacing="0">
		<tr>
			<td class="sectionhead" colspan="2">Incident Summary</td>
		</tr>
		<tr>
			<td colspan="2">
				(<%= Sys.getDateFormater().format(new Date()) %> to <%= Sys.getDateFormater().format(date.getDateTo()) %>) 
				<br>Total Incident: <%=String.valueOf(total)%>
			</td>
		</tr>
		<tr>
			<td class="td1" width="30%"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.PENDING%>"/>:</td>
			<td><%=pending.length%></td>
		</tr>
		<tr>
			<td class="td1" width="30%"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.UPDATED%>"/>:</td>
			<td><%=updated.length%></td>
		</tr>
		<tr>
			<td class="td1" width="30%"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.ONHOLD%>"/>:</td>
			<td><%=onhold.length%></td>
		</tr>
		<tr>
			<td class="td1" width="30%"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.UNRESOLVED%>"/>:</td>
			<td><%=unresolved.length%></td>
		</tr>
		<tr>
			<td class="td1" width="30%"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.RESOLVED%>"/>:</td>
			<td><%=resolved.length%></td>
		</tr>
	</table>
	<br><hr><br>
	
	<%
	String[] incident = {"Pending","Updated","Onhold","Unresolved","Resolved"};
	for (int i=0; i<incident.length; i++)
	{
		HelpdeskBean[] incidentBean = null;
		incidentBean = (HelpdeskBean[]) returnBean.getReturnObject(incident[i]);
	%>
	
	<% if (incidentBean.length>0){ %>
	<table class="listbox" width="100%" cellspacing="0">
		<tr>
			<td class="sectionhead" colspan="6"><%=incident[i]%> Incident</td>
		</tr>
		<tr class="boxhead" valign=top align="center">
			<td width="5%">No</td>
			<td width="20%">Category</td>
			<td width="10%">Request Date</td>
			<td width="18%">Request By</td>
			<td width="35%">Subject</td>
			<td width="12%">Follow-up By</td>
		</tr>
		<%
		for (int j=0; j<incidentBean.length; j++){
			String rowCss = "";
		  	if((j+1) % 2 == 0)
  	      		rowCss = "even";
  	      	else
  	        	rowCss = "odd";
		%>
		<tr class="<%=rowCss%>">
			<td><%=j+1%></td>
			<td><%=incidentBean[j].getHelpdeskCategory().getName()%></td>
			<td><%=incidentBean[j].getDate()%></td>
			<td><%=incidentBean[j].getRequestBy()%></td>
			<td><%=incidentBean[j].getSubject()%></td>
			
			<%
			if (incidentBean[j].getFollowBy()==null||incidentBean[j].getFollowBy().length()<=0) {
			%>
			<td align="center">--</td>
			<%
			} else {
			%>
			<td align="center">
				<a href="#" alt="Follow-up History" onClick="popitup('<%=Sys.getControllerURL(HelpdeskManager.TASKID_HELPDESK_INCIDENT_DETAILS_LISTING,request)%>'+'&SeqID='+'<%=incidentBean[j].getSeq()%>')">
					<%=incidentBean[j].getFollowBy()%>
				</a>
			</td>
			<%
			}
			%>
		</tr>
		<%
		}
		%>
	</table>
	<br><hr><br>
	<% } // end if %>
	
	<% } // end for %>
	
	<% } // end if canView %>	
</form>
</html>