<%@ page import="com.ecosmosis.common.locations.*"%>


<%
	LocationBean[] locationbeans2 = (LocationBean[]) returnBean.getReturnObject("LocationList");
%>

<% if (locationbeans2 != null) { %>
<% for (int i=0;i<locationbeans2.length;i++) { 
	    StringBuffer buf = new StringBuffer();
		for (int j=0;j<locationbeans2[i].getLocationType()-2;j++)
			buf.append("&nbsp;&nbsp;&nbsp;");
%>
<option value="<%=locationbeans2[i].getLocationID()%>"><%=buf.toString()%>(<%=locationbeans2[i].getLocationID()%>)&nbsp;<%=locationbeans2[i].getName()%> </option>
<% } // end for %>
<% } // end if %>