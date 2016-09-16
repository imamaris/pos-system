<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@page import="com.ecosmosis.orca.webcontent.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ContentCategoryBean[] list = (ContentCategoryBean[])returnBean.getReturnObject("CatList");
	TreeMap status_list = (TreeMap) returnBean.getReturnObject("Status");
	
	boolean canView = (list!=null);			
%> 

<html>
<head>
<%@ include file="/lib/header.jsp"%>

<style>
a:link{ 
	color: #9fbd00;
}
a:active{ 
	color: #9fbd00;
}

a:visited{ 
	color: #9fbd00;
}

a:hover{ 
	color: #9fbd00;
}
.categoryname{ 
	color: #849164;
	font-weight: bold;
}
.topic{ 
	color: #9fbd00;
	font-weight: normal;
}
</style>

</head>

	<body>
	<div class="functionhead"><i18n:label code="WEB_CONTENT_LIST"/></div>
 	<form name="listcategory" action="<%=Sys.getControllerURL(WebManager.TASKID_CONTENT_LISTING,request)%>" method="post">
 	<table width="30%">
 		<tr>
	 		<td >
	            <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>: 
		 		<std:input name="Status" type="select" options="<%=status_list %>" value="A"/>
		 		&nbsp;&nbsp;<input type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
			</td>
	 	</tr>	 	
	</table>	
    </form>
	<hr noshade>
<%
if (canView) {
%>    
	<table width="50%" cellspacing="0" noborder>
		  <tr><td height="10"></td></tr>
		  <%
  		  		if(list.length>0){	
  		  			for(int i=0; i<list.length;i++){
  		  				boolean isActive = (list[i].getStatus().equalsIgnoreCase("A"));
		  %>
		  <c:if test="<%=(i>0)%>">
			  <tr><td height="20" colspan=3></td></tr>
		  </c:if>		  
		  <tr>		  	
		  	<td colspan=3 class="categoryname"><%=(isActive)?"":"<S>"%><%=list[i].getCategoryName()%><%=(isActive)?"":"</S>"%>
		  	<std:link taskid="<%=WebManager.TASKID_CONTENT_ADD%>" text="[+]" params="<%=("&CatID=" + list[i].getCategoryID())%>"/> </td>		  
		  </tr>
		  <tr><td height="10" colspan=3></td></tr>
		  <%
		  		  		if(list[i].getContents()!=null){	
			  		  		for(int j=0; j<list[i].getContents().length;j++){
				  		  		boolean isContentActive = (list[i].getContents()[j].getStatus().equalsIgnoreCase("A"));
		  %>
			  <tr class="topic">
			  	<td width="2%" align=right ><%=(j+1)%>. </td>
			  	<td colspan=3 width="78%"><%=(isActive)?"":"<S>"%>
			  	
			  	<a href="<%=Sys.getControllerURL(WebManager.TASKID_CONTENT_DISPLAY,request)%>&ID=<%=list[i].getContents()[j].getContentID()%>" target="_new">
			  	<%=list[i].getContents()[j].getTopic()%>
			  	</a>
			  	
			  	<%=(isActive)?"":"</S>"%></td>
			  	<td align=center><%=list[i].getContents()[j].getPostDate()%>
			  	&nbsp;&nbsp;
			  	<std:link taskid="<%=WebManager.TASKID_CONTENT_EDIT%>" text="edit" params="<%=("&ID=" + list[i].getContents()[j].getContentID())%>"/>
			  	</td>
			  </tr>
			  
			  <tr><td height="10" colspan=3></td></tr>
		 <%
			  		  		}//end for
		  		  		}//end if	
		 %>				  		
		  
		  <%	}//end for 
		  	}else{
		  %>
		  	<tr><td colspan=3 align=center><i18n:label code="MSG_NO_RECORDFOUND"/></td></tr>
		  <%} %>
	</table>

<% } // end if canView %>	
	
	</body>
</html>
