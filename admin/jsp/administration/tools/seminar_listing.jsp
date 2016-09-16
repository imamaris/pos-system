<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.tools.seminar.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	SeminarBean[] titleBeans = (SeminarBean[]) returnBean.getReturnObject("TitleList");
	SeminarBean[] seminarBeans = (SeminarBean[]) returnBean.getReturnObject("SeminarList");
	
	boolean canView = false;
	if (seminarBeans != null)
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
			newwindow=window.open(url,'name','scrollbars=1,height=350,width=550');
			if (window.focus) {newwindow.focus()}
			return false;
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.SEMINAR_LISTING%>"/></div>

<form name="frmSeminarListing" action="<%=Sys.getControllerURL(SeminarManager.TASKID_SEMINAR_LISTING,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

	<table class="tbldata" width="100%">
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.SEMINAR_TITLE%>"/>:</td>
      		<td width="100">
      			<select name="Title">
      				<option value="" selected>[ALL]</option>
      				<%
					for (int i=0;i<titleBeans.length;i++) { 
					%>
					<option value="<%=titleBeans[i].getTitle()%>"><%=titleBeans[i].getTitle()%></option>
					<%
					} // end for
					%>
      			</select>
      		</td>
			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
      		<td width="100">
      			<select name="Status">
      				<option value="">[ALL]</option>
      				<option value="<%= AppConstant.STATUS_ACTIVE %>">Active</option>
      				<option value="<%= AppConstant.STATUS_INACTIVE %>">Inactive</option>
      			</select>
      		</td>
  			<td class="td1" width="100">Post Status:</td>
      		<td>
      			<select name="PostStatus">
      				<option value="" selected>[ALL]</option>
      				<option value="10">Prerpare</option>
      				<option value="20">Open</option>
      				<option value="30">Close</option>
      			</select>
      		</td>
  		</tr>
		<tr>
	 		<td><br><input type="submit" value="Submit" onClick="doSubmit(this.form)"></td>
	 		
	 	</tr> 
	 	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	</table>
	<br><hr><br>
	<% if (canView) { %>   
	
	<% 
	for (int j=0; j<seminarBeans.length; j++) {
		int seq = seminarBeans[j].getSeq();
		SeminarEventBean[] eventBeans = (SeminarEventBean[]) returnBean.getReturnObject("EventList"+seq);
	%>
	
	<table width="100%">
		<tr>
			<td class="sectionhead" width="100%">
				<i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.SEMINAR_TITLE%>"/> : <%=seminarBeans[j].getTitle()%> 
				<% int post =  seminarBeans[j].getPostStatus();%>
				(<%=post==10?"Prepare":""%>
      			<%=post==20?"Open":""%>
				<%=post==30?"Close":""%>)
			</td>
		</tr>
	</table>
	<br>
	
	

			<% for (int i=0;i<eventBeans.length;i++) {
			  	String activities = eventBeans[i].getActivities();
			  	String newAct = activities.replaceAll("\n","<br>");
			  	String rowCss = "";
			  	
	  		  	if((i+1) % 2 == 0)
	  	      		rowCss = "even";
	  	      	else
	  	        	rowCss = "odd";
		    %>
				<table class="listbox" width="70%" cellspacing="0">
					<tr>
						<td class="sectionhead"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.EVENT%>"/><%=(i+1)%></td>
						<td class="sectionhead" align="right">
							<img border="0" alt='Edit Event' src="<%= Sys.getWebapp() %>/img/icon_edit.gif" onClick="return popitup('<%=Sys.getControllerURL(SeminarManager.TASKID_SEMINAR_EDIT,request)%>'+'&seq='+'<%=String.valueOf(eventBeans[i].getSeq())%>')"/>
						</td>
			  	  	</tr>
					<tr valign=top align="center">
						<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.VENUE%>"/>:</td>
						<td align="left"><%=eventBeans[i].getVenue()%></td>
					</tr>
					<tr valign=top align="center">
						<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.ACTIVITIES%>"/>:</td>
						<td align="left"><%=newAct%></td>
					</tr>
					<tr valign=top align="center">
						<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
						<td align="left"><%=eventBeans[i].getStatus().equalsIgnoreCase("A")?"Active":"Inactive"%></td>
					</tr>
				</table>
				<br>
			<% } // end for loop %>
	<hr><br>
	<% } // end for %>
	<% } // end if canView %>	
</form>
</html>