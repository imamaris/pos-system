<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LocationBean[] beans = (LocationBean[]) returnBean.getReturnObject("LocationList");
	boolean canView = false;
	boolean showTotal = false;
	
	if (beans != null)
	 	showTotal = true;
	
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.COUNTRY_LISTING%>"/></div><br>

<% if (showTotal) { %>
	<table><tr><td><i18n:label code="GENERAL_TOTAL_RECORDSFOUND"/> : <%=beans.length%></td></tr></table>
<% } %>

<% if (canView) { %> 
	<table class="listbox" width="75%">
	
		  <tr class="boxhead" valign=top>
			<td width="20"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td width="300"><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.LOCATION_ID%>"/> / Name</td>
			<td><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.PARENT_ID%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TYPE%>"/></td>
			<td>&nbsp;</td>
		  </tr>

	
		  <% for (int i=0;i<beans.length;i++) { 
			  
			  String rowCss = "";
	  		  	if((i+1) % 2 == 0)
	  	      		rowCss = "even";
	  	      	else
	  	        	rowCss = "odd";
			  
			  StringBuffer buf = new StringBuffer();
			  for (int j=0;j<beans[i].getLocationType()-1;j++)
			  	buf.append("&nbsp;&nbsp;");
			  
		  %>
			   <tr class="<%=rowCss%>" valign=top>
					<td><%=i+1%></td>
					<td nowrap><%=buf.toString()+beans[i].getLocationID()+"&nbsp;&nbsp;&nbsp;&nbsp;("+beans[i].getName()+")"%></td>
					<td align="center"><%=beans[i].getParentID()%></td>
					<td align="center"><%=beans[i].getLocationTypeStr()%></td>
					
					<td align=center><small><std:link text="edit" taskid="<%=LocationManager.TASKID_UDPATE_COUNTRY%>" params="<%=("locid="+beans[i].getLocationID())%>" /></small></td>
		
			  </tr>
		  <% } %>		  
	</table>
	<div><br><input type=button name="btnPrint" onClick="window.print();" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>"></div>
<% } // end if canView %>	
	
	</body>
</html>
