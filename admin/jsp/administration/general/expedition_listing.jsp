<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.expedition.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ExpeditionBean[] beans = (ExpeditionBean[]) returnBean.getReturnObject("List");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Expedition Listing</div>
 	<form method="post" name="supplierlist" action="">
    </form>

<% if (canView) { %>    
	<table class="listbox" width="100%">
	
		  <tr class="boxhead" valign=top>
			<td align=right>No.</td>
			<td>Expedition Code</td>
			<td>Name</td>
			<td>Description</td>
			<td>Contact Information</td>
			<td></td>
		  </tr>
	
		  <% 
		  		for (int i=0;i<beans.length;i++) { 
		  			
		  			String rowCss = "";
		  		  	if((i+1) % 2 == 0)
		  	      		rowCss = "even";
		  	      	else
		  	        	rowCss = "odd";
		  			
		  			String scode = beans[i].getSupplierCode();
		  			String office = beans[i].getOfficeNo();
		  			String fax = beans[i].getFaxNo();
		  			String email = beans[i].getEmail();
		  			String supervisor = beans[i].getSupervisor().getSuperTitle() + ". " + beans[i].getSupervisor().getSuperName();
		  			String supercontact = beans[i].getSupervisor().getSuperOfficeNo();
		  %>
			   <tr class="<%= rowCss %>" valign=top>
					<td align=right><%=i+1%>. </td>
					<td>
						<a href="<%=Sys.getControllerURL(ExpeditionManager.TASKID_EXPEDITION_INFO,request)%>&scode=<%=scode%>">
							<%=beans[i].getSupplierCode()%>
						</a>
					</td>
					<td nowrap><%=beans[i].getName()%></td>
					<td nowrap><%=beans[i].getDescription()%></td>
					<!--  
					<td><%=beans[i].getAddress().getAddressLine1()%> <%=beans[i].getAddress().getAddressLine2()%> <%=beans[i].getAddress().getZipCode()%> <%=beans[i].getAddress().getCity().getName()%>, <%=beans[i].getAddress().getState().getName()%>, <%=beans[i].getAddress().getCountry().getName()%>.</td>
					-->
					<td align="left">
						<i18n:label localeRef="mylocale" code="<%=StandardMessageTag.OFFICE_NO%>"/>: <%= office.length()>0?office:"-"%><br>
						<i18n:label localeRef="mylocale" code="<%=StandardMessageTag.FAX_NO%>"/>: <%= fax.length()>0?fax:"-"%><br>
						<i18n:label localeRef="mylocale" code="<%=StandardMessageTag.EMAIL%>"/>: <%= email.length()>0?email:"-"%><br>
						<i18n:label localeRef="mylocale" code="<%=StandardMessageTag.SUPERVISOR%>"/>: <%= supervisor.length()>0?supervisor:"-"%><br>
						<i18n:label localeRef="mylocale" code="<%=StandardMessageTag.MOBILE_NO%>"/>: <%= supercontact.length()>0?supercontact:"-"%>
					</td>
					<td>
						<a href="<%=Sys.getControllerURL(ExpeditionManager.TASKID_EXPEDITION_EDIT_FORM,request)%>&scode=<%=scode%>">
							<img border="0" alt='Edit Supplier' src="<%= Sys.getWebapp() %>/img/icon_edit.gif"/>
						</a>
					</td>
				</tr>
		  <% } %>		  
	</table>
	<div><br><input type=button name="btnPrint" onClick="window.print();" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>"></div>
<% } // end if canView %>	
	
	</body>
</html>
