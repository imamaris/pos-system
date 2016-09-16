<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	MenuBean[] beans = (MenuBean[]) returnBean.getReturnObject("MenuList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

	boolean filter = false;
	String idstr = request.getParameter("filterid");

	if (idstr != null && idstr.length() > 0)
		filter = true;

	boolean showdelete = false;
	if (request.getParameter("showdelete") != null && request.getParameter("showdelete").equals("Y"))
		showdelete = true;
%> 

<%!
	private boolean checkSubString(String str,String checkstr)
	{
		int checklen = checkstr.length();
		
		if (str.length() < checklen)
			checklen = str.length();
			
		String targetstr = str.substring(0,checklen);
		if (checkstr.equalsIgnoreCase(targetstr))
			return true;
		else
			return false;
	}
%>


<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">System Functions Listing</div>
	
 	<form method="post" name=tasklist action="" action="<%=Sys.getControllerURL(FunctionTaskManager.TASKID_FUNCTIONS_LISTING,request)%>">
 	<table  class="listbox"  width=350>

	<tr>
	 	<td width="250" class="odd">Display Function IDs Begin With</td>
	 	<td><std:input type="text"  name="filterid"  size="10" value="<%=idstr%>" /></td>
	 </tr> 
	 
	 <tr>
	 	<td width="250" class="odd">Disply Delete Option</td>
	 	
	 	<td>
	 	   <select name="showdelete">	
				<option value="N">NO</option>
				<option value="Y">YES</option>
	   		</select>
	 	&nbsp;<input type="submit" value="GO">
	 	</td>
	 </tr> 
	 
    </form>
<table>	 <tr><td>&nbsp;</td></tr></table>

<% if (canView) { %>  
	<table  class="listbox" width="98%">

		  <% int count = 0;
		     int currenttype = 0;
		  %>
		  
		  <% 	
		  		for (int i=0;i<beans.length;i++) { 
		  
		  			if (filter)
					{
						if (!checkSubString(Integer.toString(beans[i].getFunctionID()),idstr))	
								continue;
					}
		  %>  
			  
				  <% if (beans[i].getMenutype() == 1) { %> 				  
				 
				  	   <tr valign=top class=title>
							<td class="boxhead" colspan="20"><b><u><%=beans[i].getDesc()%>  (<%=beans[i].getFunctionID()%>)</u></b></td>
					   </tr>
				       
					   
				  <% } // end if %>
				  
				   <% if (beans[i].getMenutype() == 2) { %> 				  
				       <tr><td colspan="20">&nbsp;</td></tr>
				  	   <tr class="head" valign=top>
							<td class="boxhead" colspan="20">SUBSYSTEM : <%=beans[i].getDesc()%>  (<%=beans[i].getFunctionID()%>)</td>
					   </tr>

					   
				  <% } // end if %>
				  
				  
				  
				  
				  <% if (currenttype <= 2 && beans[i].getMenutype() > 2) { 
						 count = 0;	  
				  %>
				  		  	
					  	<tr  class="boxhead" valign=top>
							<td width="20" nowrap>No.</td>
							<td>ID</td>
							<td>Name</td>
							<td width="40" nowrap>Type</td>
							<td>Locale<br>Desc</td>
							<td>Tasks</td>
							<td width="40" nowrap>Order<br>Seq</td>
							<td width="40" nowrap>Visi</td>
							<td width="40" nowrap>Status</td>
							<td>&nbsp;</td>
	<% if (showdelete) { %>	<td>&nbsp;</td>   <% } %>
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
				  			
				  		String funcid = Integer.toString(beans[i].getFunctionID());
				      
				  %>
					   <tr class="<%= ((++count)%2 == 0) ? "even" : "odd"%>" valign=top>
							<td><%=count%></td>
							<td><%=space+beans[i].getFunctionID()%></td>
							<td><%=beans[i].getDesc()%></td>
							<td align="center"><%=beans[i].getMenutypeStr()%></td>
							<td><%=beans[i].getOtherLocaleDesc()%></td>
							<td align="center" nowrap><%=beans[i].getTaskDesc()%></td>
							<td align="center"><%=beans[i].getOrderSequence()%></td>
							<td align="center"><%=beans[i].getMenuVisibility()%></td>
							<td align="center"><%=beans[i].getStatus()%></td>
							<td align=center nowrap><small><std:link text="ADD" taskid="<%=FunctionTaskManager.TASKID_ADD_NEW_FUNCTION%>" params="<%=("tmpfuncid="+funcid)%>" /></small></td>
	<% if (showdelete) { %>	<td align=center nowrap><small><std:link text="DELETE" taskid="<%=FunctionTaskManager.TASKID_DELETE_FUNCTION%>" params="<%=("funcid="+beans[i].getFunctionID())%>" /></small></td>  <% } %>
							<td align=center nowrap><small><std:link text="UPDATE" taskid="<%=FunctionTaskManager.TASKID_UPDATE_FUNCTION%>" params="<%=("funcid="+beans[i].getFunctionID())%>" /></small></td>
					   </tr>
				  <% } // end if %>
		  <% } // end for %>
	</table>
<% } // end if canView %>	
	
	</body>
</html>
