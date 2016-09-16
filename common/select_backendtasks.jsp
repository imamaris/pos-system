<%@ page import="com.ecosmosis.mvc.backend.*"%>

<%
	BackendTaskConfigBean[] taskconfigbeans = (BackendTaskConfigBean[]) returnBean.getReturnObject("ConfigList");
%>

<% if (taskconfigbeans != null) { %>
<% for (int i=0;i<taskconfigbeans.length;i++) { %>
<option value="<%=taskconfigbeans[i].getTaskID()%>"><%=taskconfigbeans[i].getName()%> (<%=taskconfigbeans[i].getTaskID()%>)</option>
<% } // end for %>
<% } // end if %>