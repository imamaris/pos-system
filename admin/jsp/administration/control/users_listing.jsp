<%@ page import="com.ecosmosis.orca.users.*"%>
<%@ page import="com.ecosmosis.common.customlibs.FIFOMap"%>
<html>
<head>

<%@ include file="/lib/header.jsp"%>
		
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	AdminLoginUserBean[] beans = (AdminLoginUserBean[]) returnBean.getReturnObject("UserList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	
	FIFOMap listoptions = new FIFOMap();	
	listoptions.put("A","ADMIN_USR_ACTIVE");
	listoptions.put("I","ADMIN_USR_INACTIVE");
	listoptions.put("S","ADMIN_USR_SUSPEND");
	listoptions.put("ALL","ADMIN_USR_ALL");
	
	String option = request.getParameter("listoption"); 	
	if (option == null) option = "A";

%> 		
</head>

<script LANGUAGE="JavaScript">
<!--
function submitForm(){
	var myform = document.form;
	myform.submit();
}
// -->
</script>

<body>
	<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.USR_LISTING%>"/></div>
	<br>
	
<form name="form" action="<%=Sys.getControllerURL(AdminManager.TASKID_USER_LISTING,request)%>" method="post">	
	<table  width="80%">
	<tr><td align="right"><i18n:label code="GENERAL_DISPLAY_OPTIONS"/> : <std:input type="select" name="listoption" options="<%=listoptions%>" value="<%=option%>" status="onChange=submitForm();"/></td></tr>
	</table>
</form>

<% if (canView) { %>    



	<table class="listbox" width="80%">
	
		  <tr class="boxhead" valign=top>
			<td width="20"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.USER_ID%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=OutletMessageTag.OUTLET%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.MGMT_HIERARCHY%>"/></td>
	<!--		<td><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.OPERATION_HIERARCHY%>"/></td> --> 
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>

		   <% for (int i=0;i<beans.length;i++) {
			   String rowCss = "";
		  		  	
		  		  	if((i+1) % 2 == 0)
		  	      		rowCss = "even";
		  	      	else
		  	        	rowCss = "odd";
		  	        	
		  	        	
		  	        if (option != null && !option.equals("ALL"))	
		  	        {
			  	        if (!option.equals(beans[i].getStatus()))
			  	    	 	continue;
		  	    	}
		  	        	
		   %>
		 
			   <tr class="<%=rowCss%>" valign=top>
					<td><%=i+1%></td>
					<td align ="left"><%=beans[i].getUserId()%></td>
					<td align ="left"><%=beans[i].getUserName()%></td>
					<td align ="center"><%=beans[i].getOutletID()%></td>
					<td align ="center"><%=beans[i].getManagementLocationID()%></td>
		<!--			<td align ="center"><%=beans[i].getOperationLocationID()%></td>   -->
					<td align ="center"><%=beans[i].getStatus()%></td>
					
		<% if (beans[i].getStatus() != null && 	beans[i].getStatus().equals("A")) { %>
					<td align=center><small><std:link text="<%=lang.display("ADMIN_SETACL")%>" taskid="<%=AdminManager.TASKID_ADMIN_UPDATE_ACL_SETTINGS%>" params="<%=("memberid="+beans[i].getUserId())%>" /></small></td>
		<% } else { %>
					<td align="center">-</td>
		<% } // end else%>	   
		
					<td align=center><small><std:link text="<%=lang.display("GENERAL_SETTINGS")%>" taskid="<%=AdminManager.TASKID_ADMIN_CHANGE_SETTINGS%>" params="<%=("memberid="+beans[i].getUserId())%>" /></small></td>

		<% if (beans[i].getStatus() != null && 	beans[i].getStatus().equals("A")) { %>
			        <td align=center><small><std:link text="<%=lang.display("GENERAL_RESET_PASSWD")%>" taskid="<%=AdminManager.TASKID_ADMIN_RESET_PASSWORD %>" params="<%=("memberid="+beans[i].getUserId())%>" /></small></td>	     
		<% } else { %>
					<td align="center">-</td>
		<% } // end else%>	   
			       
			  </tr>
		<% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
