<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LocationBean[] beans = (LocationBean[]) returnBean.getReturnObject("LocationList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class=functionhead><i18n:label code="ADMIN_LOCATION_LISTING"/></div><br>

	
<% if (canView) { %>    
	<table class="listbox" width="100%">
	
		  <tr class="boxhead" valign=top>
			<td width="20"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td width="300"><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.LOCATION_ID%>"/> / <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.PARENT_ID%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.TYPE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.CURRENCY%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.REGISTER_PREFIX%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.CONTINENT%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.COUNTRY%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.REGION%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.STATE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=GeographicMessageTag.CITY%>"/></td>
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
			  
			  String name = buf.toString()+beans[i].getLocationID()+"&nbsp;&nbsp;&nbsp;&nbsp;("+beans[i].getName()+")";
			  
		  %>
			   <tr class="<%=rowCss%>" valign=top>
					<td><%=i+1%></td>
					<td><std:link text="<%=name%>" taskid="<%=LocationManager.TASKID_FULL_LOCATIONS_LISTING%>" params="<%=("locid="+beans[i].getLocationID())%>" /></td>
					
					<% if (i > 0) { %>
					<td align="center"><%=beans[i].getParentID()%></td>
					<% } else { %>
					<td align="center"><std:link text="<%=beans[i].getParentID()%>" taskid="<%=LocationManager.TASKID_FULL_LOCATIONS_LISTING%>" params="<%=("locid="+beans[i].getParentID())%>" /></td>
					<% } %>
					
					<td align="center"><%=beans[i].getLocationTypeStr()%></td>
					<td align="center"><%=beans[i].getCurrency()%></td>
					<td align="center"><%=beans[i].getRegPrefix()%></td>
					<td align="center"><%=((beans[i].getLevel1() != null) ? beans[i].getLevel1() : "")%></td>
					<td align="center"><%=((beans[i].getLevel2() != null) ? beans[i].getLevel2() : "")%></td>
					<td align="center"><%=((beans[i].getLevel3() != null) ? beans[i].getLevel3() : "")%></td>
					<td align="center"><%=((beans[i].getLevel4() != null) ? beans[i].getLevel4() : "")%></td>
					<td align="center"><%=((beans[i].getLevel5() != null) ? beans[i].getLevel5() : "")%></td>
			  </tr>
		  <% } %>
		  
	</table>
	<div><br><input type=button name="btnPrint" onClick="window.print();" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>"></div>
<% } // end if canView %>	
	
	</body>
</html>
