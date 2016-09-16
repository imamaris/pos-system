<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	MenuBean[] beans = (MenuBean[]) returnBean.getReturnObject("MenuList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><i18n:label code="ADMIN_MENU_MANAGE"/></div>
 	<form method="post" name=list action="">
    </form>

<%@ include file="/general/mvc_return_msg.jsp"%>
    
<% if (canView) { %>    
	<table  class="listbox" width="90%">

		  <% int count = 0;
		     int currenttype = 0;
		  %>
		  
		  <% for (int i=0;i<beans.length;i++) { %>  
				  
				   <% if (beans[i].getMenutype() == 2) { %> 				  
				       <tr><td colspan="6">&nbsp;</td></tr>
				  	   <tr class="boxhead"  valign=top>
							<td colspan="5"><i18n:label code="ADMIN_SUBSYSTEM"/> : <%=beans[i].getDesc()%>  (<%=beans[i].getFunctionID()%>)</td>
							<td><std:link taskid="<%=ModuleManager.TASKID_UPDATE_MENU%>" text="<%=lang.display("GENERAL_BUTTON_UPDATE")%>" params="<%="funcid="+beans[i].getFunctionID()%>" /> </td>
					   </tr>

					   
				  <% } // end if %> 
				  
				  <% if (currenttype <= 2 && beans[i].getMenutype() > 2) { 
						 count = 0;	  
				  %>
				  		  	
					  	<tr  class="boxhead" valign=top>
							<td width="20" nowrap align=right><i18n:label code="GENERAL_NUMBER"/></td>
							<td><i18n:label code="GENERAL_NAME"/></td>
							<td width="40" nowrap><i18n:label code="GENERAL_TYPE"/></td>
							<td><i18n:label code="ADMIN_LOCALE_DESCRIPTION"/></td>
							<td width="40" nowrap><i18n:label code="GENERAL_VIEW"/>?</td>
							<td>&nbsp;</td>
						  </tr>

				  <% } // end if %>
				  
				  <% currenttype = beans[i].getMenutype(); %>
				  
			      <% if (beans[i].getMenutype() > 2) { 
				  		String space = "";
				  		if (beans[i].getMenutype() == 4)
				  			space = "&nbsp;&nbsp;&nbsp;";
				  		else if (beans[i].getMenutype() == 5)
				  			space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				  			
				  		String visible = "Y";
				  		if (beans[i].getMenuVisibility() == 0)
				  		    visible = "N";
				      
				  %>
					   <tr class="<%= ((count++)%2 == 0) ? "even" : "odd"%>" valign=top>
							<td align=right><%=count%>.</td>
							<td><%=space+beans[i].getDesc()%></td>
							<td align="center"><%=beans[i].getMenutypeStr()%></td>
							<td><%=beans[i].getOtherLocaleDesc()%></td>
							<td align="center"><%=visible%></td>
							<td align="center"><std:link taskid="<%=ModuleManager.TASKID_UPDATE_MENU%>" text="<%=lang.display("GENERAL_BUTTON_UPDATE")%>" params="<%="funcid="+beans[i].getFunctionID()%>" /> </td>
					   </tr>
				  <% } // end if %>
		  <% } // end for %>
	</table>
		<div><br><input type=button name="btnPrint" onClick="window.print();" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>"></div>
<% } // end if canView %>	
	
	</body>
</html>
