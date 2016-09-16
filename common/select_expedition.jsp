<%@ page import="com.ecosmosis.orca.expedition.*"%>


<%
	ExpeditionBean[] expeditionbeans = (ExpeditionBean[]) returnBean.getReturnObject("ExpeditionList");
%>

<% if (expeditionbeans != null) { %>
<% for (int i=0;i<expeditionbeans.length;i++) { %>
<option value="<%=expeditionbeans[i].getName()%>">(<%=expeditionbeans[i].getName()%>)</option>
<% } // end for %>
<% } // end if %>