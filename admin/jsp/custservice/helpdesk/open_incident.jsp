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
	int memberIDLength = 12;
	String memberID = request.getParameter("MemberID");
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	HelpdeskCategoryBean[] categoryBeans = (HelpdeskCategoryBean[]) returnBean.getReturnObject("HelpdeskCategoryList");
	HelpdeskBean[] incidentBeans = (HelpdeskBean[]) returnBean.getReturnObject("IncidentList");
	HelpdeskBean date = (HelpdeskBean) returnBean.getReturnObject("Date");
	
	//System.out.println("bean size = " + incidentBeans.length);
	
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
		function popitup(url)
		{
			newwindow=window.open(url,'name','scrollbars=1,height=400,width=550');
			if (window.focus) {newwindow.focus()}
			return false;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.OPEN_INCIDENT_PENDING%>"/></div>

<form name="frmIncidentOpen" action="<%=Sys.getControllerURL(HelpdeskManager.TASKID_HELPDESK_INCIDENT_OPEN,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

	<table class="tbldata" width="100%">
  		<tr>
			<td class="td1" width="75">Member ID:</td>
	    	<td width="170">
				<input type="text" name="MemberID" size="20" maxlength="<%= memberIDLength %>"/>
				<a href="javascript:popupSmall('<%=Sys.getControllerURL(HelpdeskManager.TASKID_SEARCH_MEMBERS_BY,request) %>&FormName=frmIncidentOpen&ObjName=MemberID')">
  				<img border="0" alt='Search Distributor' src="<%= Sys.getWebapp() %>/img/lookup.gif"/>
  				</a>
			</td>
			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
      		<td width="170">
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
      		<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.PRIORITY_LEVEL%>"/>:</td>
      		<td>
      			<select name="Priority">
      				<option value="">[ALL]</option>
      				<option value="1">1</option>
      				<option value="2">2</option>
      				<option value="3">3</option>
      				<option value="4">4</option>
      				<option value="5">5</option>
      			</select>
      		</td>
		</tr>
  		<tr>
			<td align="left" width="" colspan="6"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_DATE%>"/>: &nbsp; <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.FROM%>"/>
				<std:input type="date" name="DateFrom" size="11" value="<%= Sys.getDateFormater().format(new Date()) %>" maxlength="10"/> &nbsp; <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TO%>"/>
				<std:input type="date" name="DateTo" size="11" value="<%= date.getDateTo() %>" maxlength="10"/>
			</td>
      	</tr>
		<tr>
	 		<td><br><input type="submit" value="<i18n:label localeRef="mylocale" code="<%=StandardMessageTag.SUBMIT%>"/>" onClick="doSubmit(this.form)"></td>
	 		
	 	</tr> 
	 	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	</table>
	<br>	
	<% if (canView) { %> 
	<span class='required note'>*</span> No follow-up History !<br><br>  
	<table class="listbox" width="100%" cellspacing="0">
		<tr class="boxhead" valign=top align="center">
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/></td>
			<td width="80"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_DATE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_BY%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.SUBJECT%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.ASSIGN_BY%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.FOLLOWUP_BY%>"/></td>
			<td width="50"><i18n:label localeRef="mylocale" code="<%=ProductMessageTag.PRIORITY_LEVEL%>"/></td>
			<td width="50"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.PROCESS_STATUS%>"/></td>
			<td></td>
		  </tr>
		  
		  <%
		  if (incidentBeans.length<=0) {
		  %>
		  <tr><td colspan="12" class="required note"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.NO_INCIDENT_EXIST%>"/> !!</td></tr>
		  <%
		  }
		  %>
		  
		  <% 
		  int cnt = 1;
		  for (int i=0;i<incidentBeans.length;i++) {
			  
			  	HelpdeskDetailBean[] incidentDetailBeans = (HelpdeskDetailBean[]) returnBean.getReturnObject("IncidentDetail"+incidentBeans[i].getSeq());
			  
			 	if ((incidentDetailBeans==null || incidentDetailBeans.length<=0))
			  	{
					  	String rowCss = "";
					  	int processStatus = incidentBeans[i].getProcessStatus();
			  		  	
			  		  	if((cnt) % 2 == 0)
			  	      		rowCss = "even";
			  	      	else
			  	        	rowCss = "odd";
		  %>
		  
		  	  <tr class="<%= rowCss %>" valign=top>
				<td align="center"><%=(cnt++)%></td>
				<td align="center"><%=incidentBeans[i].getHelpdeskCategory().getName().length()>0?incidentBeans[i].getHelpdeskCategory().getName():incidentBeans[i].getHelpdeskCategory().getDefaultMsg()%></td>
				<td align="center"><%=incidentBeans[i].getDate()%></td>
				<td align="center"><%=incidentBeans[i].getRequestBy()%></td>
				<td><%=incidentBeans[i].getSubject()%></td>
				<td align="center"><%=incidentBeans[i].getAssignBy()!=null&&incidentBeans[i].getAssignBy().length()>0?incidentBeans[i].getAssignBy():"--"%></td>
				<td align="center"><%=incidentBeans[i].getFollowBy()!=null&&incidentBeans[i].getFollowBy().length()>0?"<span class='required note'>*</span>"+incidentBeans[i].getFollowBy():"--"%></td>
				<td align="center"><%=incidentBeans[i].getPriority()%></td>
				<td align="center">
					<%=processStatus==HelpdeskManager.STATUS_PENDING?"Pending":""%>
					<%=processStatus==HelpdeskManager.STATUS_UPDATED?"Updated":""%>
					<%=processStatus==HelpdeskManager.STATUS_ONHOLD?"On Hold":""%>
					<%=processStatus==HelpdeskManager.STATUS_RESOLVED?"Resolved":""%>
					<%=processStatus==HelpdeskManager.STATUS_UNRESOLVED?"Unresolved":""%>
				</td>
				<td>
					<img border="0" alt='Assign Staff' src="<%= Sys.getWebapp() %>/img/icon_edit.gif" onClick="return popitup('<%=Sys.getControllerURL(HelpdeskManager.TASKID_HELPDESK_INCIDENT_ASSIGN,request)%>'+'&id='+'<%=String.valueOf(incidentBeans[i].getSeq())%>')"/>
				</td>
			  </tr>	
		  <% }} // end if end for loop %>
	</table>
	<% } // end if canView %>	
</form>
</html>