<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.salesman.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
  Map searchByMap = (Map) returnBean.getReturnObject(SalesmanManager.RETURN_SEARCHBY_CODE);
  
	Map recordsMap = (Map) returnBean.getReturnObject(SalesmanManager.RETURN_SHOWRECS_CODE);
	
  String formName = (String) returnBean.getReturnObject("FormName");
  String objName= (String) returnBean.getReturnObject("ObjName");
  String propName = (String) returnBean.getReturnObject("PropName");
  String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
  
  int taskID = 0;
	if (task != null) 
		taskID = Integer.parseInt(task);

	SalesmanBean[] beans = (SalesmanBean[]) returnBean.getReturnObject(SalesmanManager.RETURN_MBRLIST_CODE);
	
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;	 
%>

<html>
<head>
	
	<%@ include file="/lib/header.jsp"%>

	<title>Search Salesman</title>

	<script language="javascript">
		
		function invokeParent(keyValue, propValue) {
      var opener = window.opener.document.<%= formName %>;
      opener.<%= objName %>.value = keyValue;

      <%
        if (propName != null && propName.length() > 0)
          out.println("opener."+propName+".value = propValue;");
      %>
      
      window.close();
    }
     
    function enterKeyword(type, obj) {
  	}
    
  	function doSubmit(thisform) {
    	var vl = thisform.Keyword.value;
			vl = Trim(vl);
			
    	if (vl == ""){
    		alert("<i18n:label code="MSG_ENTER_KEYWORD"/>");
    		focusAndSelect(thisform.Keyword);
    		return false;
    	} else {
	    	return true;
    	}
  	}      	 
	</script>
</head>

<body>
  
<div class="functionhead">Quick Search Salesman</div>

<form name="frmSearch" action="<%=Sys.getControllerURL(taskID,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
	<table>
	  <tr>
	    <td>Search In</td>
	    <td colspan="4">
	    	<std:input type="select" name="SearchBy" options="<%= searchByMap %>" value="<%= SalesmanBean.FIELD_ID %>"/>
	    	<std:input type="text" name="Keyword" size="30" status="onKeyUp=\"javascript:enterKeyword(this.form.SearchBy.value, this);\""/>
	    </td>
	  </tr>
	  <tr>
			<td class="td1"><i18n:label code="GENERAL_DISPLAY"/>:</td>
			<td colspan="4"><std:input type="select" name="Limits" options="<%= recordsMap %>"/></td>
		</tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="FormName" value="<%= formName %>"/>
	<std:input type="hidden" name="ObjName"  value="<%= objName %>"/>
	<std:input type="hidden" name="PropName" value="<%= propName %>"/>  
	
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>

<hr>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) { 
%>

<table class="listbox" width="100%">
  <tr class="boxhead" valign=top>
    <td width="5%">No. </td>
    <td width="10%">Sales ID</td>
    <td>Name </td>
   	<td width="10%">IC Number</td>
    <td width="10%">Join Date </td>
    <td width="10%">Saleship</td>
  </tr>

  <%
  	for (int i=0; i<beans.length; i++) { 
    	
	  	String idCss = "";
	  	String rowCss = "";
	  	String propValue = "";
	  	
	  	if((i+1) % 2 == 0)
      	rowCss = "even";
      else
        rowCss = "odd";
			
      if (beans[i].getIntroducerMissing() != null && beans[i].getIntroducerMissing().equalsIgnoreCase(SalesmanManager.MISSING_INTRODUCER))
        idCss = "wordAlert";
      else
      	idCss = "";  
         
      if (beans[i].getStatus() != SalesmanManager.MBRSHIP_ACTIVE)
        rowCss = "alert";
        
    	if (propName != null && !propName.equals("null"))	{
	    	
	    	if (propName.equalsIgnoreCase("IdentityNo"))
	    		propValue = beans[i].getIdentityNo();
	    	else
	    		propValue = beans[i].getName();
    	}
    	
    	if (propValue != null && propValue.length() > 0) {
	    	propValue = propValue.replaceAll("\"", "&quot;");
				propValue = propValue.replaceAll("\'", "&#39;");
    	}
  %>
	<tr class="<%= rowCss %>" valign=top>
    <td width="5%"><%= i+1 %>.</td>
	  <td nowrap><a href="javascript:invokeParent('<%= beans[i].getMemberID() %>','<%= propValue %>')"><%= beans[i].getMemberID() %></a></td>
    <td><%= beans[i].getName() %></td>
    <td nowrap><std:text value="<%= beans[i].getIdentityNo() %>" defaultvalue="-"/></td>
    <td align="center" nowrap><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= (beans[i].getJoinDate()) %>" /></td>
    <td align="center" nowrap><%= SalesmanManager.defineMbrshipStatus(beans[i].getStatus()) %></td>
  </tr>
		    
	<% 
		} // end for 
	%>

</table>      

<% 
	} // end canView 
%>

</body>
</html>
