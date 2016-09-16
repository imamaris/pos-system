<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.helpdesk.*"%>
<%@ page import="com.ecosmosis.orca.helpdesk.category.*"%>
<%@ page import="com.ecosmosis.orca.users.AdminLoginUserBean"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	int memberIDLength = 12;
	String memberID = request.getParameter("MemberID");
	
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	HelpdeskCategoryBean[] categoryBeans = (HelpdeskCategoryBean[]) returnBean.getReturnObject("HelpdeskCategoryList");
	AdminLoginUserBean[] userBeans = (AdminLoginUserBean[]) returnBean.getReturnObject("UserList");
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			if (!validateText(thisform.MemberID)) {
				alert("Please enter Member ID.");
				return;
			} 
			if (!validateMemberId(thisform.MemberID)) {
				alert("Invalid Distributor ID.");
				focusAndSelect(thisform.MemberID);
				return;
	  		}
			if (thisform.CatID.value == "0") {
				alert("Please select Category.");
				return;
			}
			if (!validateText(thisform.Subject)) {
				alert("Please enter Subject.");
				return;
			}
			if (!validateText(thisform.Description)) {
				alert("Please enter Description.");
				thisform.Description.focus();
				return;
			}
			thisform.submit();
		}
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.NEW_INCIDENT%>"/></div>

<form name="frmIncidentRegister" action="<%=Sys.getControllerURL(HelpdeskManager.TASKID_HELPDESK_INCIDENT_ADD,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<p class="required note">* <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.REQUIRED_FIELD%>"/></p>

	<table width="100%">
		<tr>
			<td>
				<table class="tbldata" width="100%">
				  	<tr>
						<td class="td1" width="100"><span class="required note">* </span>Member ID:</td>
				    	<td>
							<input type="text" name="MemberID" size="20" maxlength="<%= memberIDLength %>"/>
							<a href="javascript:popupSmall('<%=Sys.getControllerURL(HelpdeskManager.TASKID_SEARCH_MEMBERS_BY,request) %>&FormName=frmIncidentRegister&ObjName=MemberID')">
			  				<img border="0" alt='Search Distributor' src="<%= Sys.getWebapp() %>/img/lookup.gif"/>
			  				</a>
						</td>
					</tr>
					<tr>
						<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.REQUEST_DATE%>"/>:</td>
			      		<td><std:input type="date" name="Date" size="11" value="<%= Sys.getDateFormater().format(new Date()) %>" maxlength="10"/></td>
			      	</tr>
			  		<tr>
			  			<td class="td1" width="100"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=CategoryMessageTag.CATEGORY%>"/>:</td>
			      		<td>
			      			<select name="CatID">
			      				<option value="0" selected>[CATEGORY]</option>
			      				<%
								for (int i=0;i<categoryBeans.length;i++) { 
								%>
								<option value="<%=categoryBeans[i].getCatID()%>"><%=categoryBeans[i].getName()%></option>
								<%
								} // end for
								%>
			      			</select>
			      		</td>
			  		</tr>
			  		<tr>
						<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.PRIORITY_LEVEL%>"/>:</td>
			      		<td>
			      			<select name="Priority">
			      				<option value="1">1</option>
			      				<option value="2">2</option>
			      				<option value="3">3</option>
			      				<option value="4">4</option>
			      				<option value="5">5</option>
			      			</select>
			      		[Highest] 1-2-3-4-5 [Lowest]
			      		</td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.FOLLOWUP_BY%>"/>:</td>
			      		<td>
			      			<select name="FollowBy">
			      				<option value="" selected>[USER]</option>
			      				<option value="open">Open</option>
			      				<%
								for (int i=0;i<userBeans.length;i++) { 
								%>
								<option value="<%=userBeans[i].getUserId()%>"><%=userBeans[i].getUserId()%> - <%=userBeans[i].getUserName()%></option>
								<%
								} // end for
								%>
			      			</select>
			      		</td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=HelpdeskMessageTag.SUBJECT%>"/>:</td>
			      		<td><input type="text" size="50" name="Subject"/></td>
			  		</tr>
			  		<tr>
			  			<td class="td1" width="100" valign="top"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/>:</td>
			      		<td>
	 						<textarea cols="50" rows="5" name="Description"></textarea><br><br>
	 					</td>
			  		</tr>
				</table>
			</td>
		</tr>	
	</table>
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>

	<input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.SUBMIT%>'/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.RESET%>'/>">
  	
</form>
</html>