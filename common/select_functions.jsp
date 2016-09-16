<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="com.ecosmosis.orca.users.*"%>
<%@ page import="java.util.*"%>
	
<%
	MenuBean[] menubeans = (MenuBean[]) returnBean.getReturnObject("MenuList");
	boolean canViewMenu = false;
	if (menubeans != null && menubeans.length > 0)
	 	canViewMenu = true;
	
    Hashtable acltable = (Hashtable) returnBean.getReturnObject("AclList");
    boolean canViewACL = false;
    if (acltable != null)
       canViewACL = true;
	 		
	 	
%> 

<% if (canViewMenu) { %>    
	<table class="listbox" width="100%">

		  <% 
		  	 int menuCount = 0;
		     int menuCurrenttype = 0;
		  %>
		  
		  <% for (int i=0;i<menubeans.length;i++) { 
	  			String rowCss = "";
	  		  	
	  		  	if((i+1) % 2 == 0)
	  	      		rowCss = "even";
	  	      	else
	  	        	rowCss = "odd";
		  %>  
			  
				  <% if (menubeans[i].getMenutype() == 1) { %> 				  	 
				  	   <tr valign=top class="sectionhead">		  	   
							<td colspan="20"><b><u><%=menubeans[i].getDesc()%></u></b></td>
					   </tr>
				  <% }  else if (menubeans[i].getMenutype() == 2) { 
					  		String chkkey = Integer.toString(menubeans[i].getFunctionID());
				  %> 				  
				       <tr><td colspan="20">&nbsp;</td></tr>
				  	   <tr class="head" valign=top>
							<td colspan="20"><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.SUBSYSTEM%>"/> : <%=menubeans[i].getDesc()%> &nbsp;<input type="checkbox" style="width: 15px; border-style: none" name="<%=menubeans[i].getFunctionID()%>" onClick="checkKey(this,<%=chkkey.substring(0,3)%>);"></td>
					   </tr> 
				  <% }  else if (menubeans[i].getMenutype() == 3) { 
					  		
				  %> 		
				       <tr><td colspan="20">&nbsp;</td></tr>		  
				  	   <tr class="sectionhead" valign=top>
							<td colspan="20"><b><%=menubeans[i].getDesc()%></b></td>
					   </tr> 
				  <% }  else if (menuCurrenttype <= 3 && menubeans[i].getMenutype() > 3) {   
					  		String chkkey = Integer.toString(menubeans[i].getFunctionID());	  
				  %>
	  	
					  	<tr class="boxhead" valign=top>
							<td width="20" nowrap><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
							<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
							<td><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.LOCAL_DESC%>"/></td>
							<td width="40" nowrap><i18n:label localeRef="mylocale" code="<%=ControlCtrMessageTag.VISIBLE%>"/></td>
							<td width="40" align="center"><input type="checkbox" style="width: 15px; border-style: none" name="<%=menubeans[i].getFunctionID()%>" onClick="checkKey(this,<%=chkkey.substring(0,5)%>);"></td>
						  </tr>
				  <% } // end if %>
				  
				  <% menuCurrenttype = menubeans[i].getMenutype(); %>
				  
			      <% if (menubeans[i].getMenutype() == 4) { 
				       menuCount = 0;	
				  %>
					   <tr class="sectionhead" valign=top>
							<td align="left" colspan="5"><u><%=menubeans[i].getDesc()%></u></td>
					   </tr>
				  <% } // end if %>
				  
				  <% if (menubeans[i].getMenutype() == 5) { 
				  		String space = "";
				  		String visible = "Y";
				  		if (menubeans[i].getMenutype() == 4)
				  			space = "&nbsp;&nbsp;&nbsp;";
				  		else if (menubeans[i].getMenutype() == 5)
				  			space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				  			
				  		if (menubeans[i].getMenuVisibility() == 0)
				  			visible = "N"; 
				  			
				  		String chk = "";
				  		
				  		if (canViewACL && acltable.get(Integer.toString(menubeans[i].getFunctionID())) != null)
				  		     chk = "checked";
				  		
				  %>
					   <tr class="" valign=top>
							<td><%=menuCount%></td>
							<td><%=menubeans[i].getDesc()%></td>
							<td><%=menubeans[i].getOtherLocaleDesc()%></td>
							<td align="center"><%=visible%></td>
							<td width="40" align="center" nowrap>
								<input type="checkbox" style="width: 15px; border-style: none" name="accesslist" value="<%=menubeans[i].getFunctionID()%>" <%=chk%>>
							</td>
					   </tr>
				  <% } // end if %>
				  
		  <% } // end for %>
	</table>
<% } // end if canViewMenu %>	
