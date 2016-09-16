<%@ page import="com.ecosmosis.common.locations.*"%>


<%
	LocationBean[] countrybeans = (LocationBean[]) returnBean.getReturnObject("CountryList");
%>

<% if (countrybeans != null) { %>
<% for (int i=0;i<countrybeans.length;i++) { %>
<option value="<%=countrybeans[i].getLocationID()%>"><%=countrybeans[i].getName()%> (<%=countrybeans[i].getLocationID()%>)</option>
<% } // end for %>
<% } // end if %>