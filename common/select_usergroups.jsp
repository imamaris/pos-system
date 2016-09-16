<%@ page import="com.ecosmosis.orca.users.*"%>


<%
	AdminLoginUserBean[] usergroupbeans = (AdminLoginUserBean[]]) returnBean.getReturnObject("UserGroupList");
%>

<% if (usergroupbeans != null) { %>
<% for (int i=0;i<usergroupbeans.length;i++) { %>
<option value="<%=usergroupbeans[i].getUserId()%>"><%=usergroupbeans[i].getName()%> (<%=usergroupbeans[i].getUserId()%>)</option>
<% } // end for %>
<% } // end if %>