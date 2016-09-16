<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<%@page import="com.ecosmosis.orca.constants.*"%>
<%@page import="com.ecosmosis.orca.msgcode.*"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
  String formName = (String) returnBean.getReturnObject("FormName");
  String objName= (String) returnBean.getReturnObject("ObjName");
  String propName = (String) returnBean.getReturnObject("PropName");
  String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
  
  int taskID = 0;
	if (task != null) 
		taskID = Integer.parseInt(task);
	else
		taskID = StockistManager.TASKID_SEARCH_STOCKISTS_BY;

	StockistBean[] beans = (StockistBean[]) returnBean.getReturnObject(StockistManager.RETURN_STKLIST_CODE);
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;	 
%>


<html>
<head>	
	<%@ include file="/lib/header.jsp"%>
	<title><i18n:label code="STOCKIST_QUICK_SEARCH"/></title>
	
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

  	function doSubmit(thisform) {
    	var vl = thisform.Keyword.value;

    	if (vl == ""){
    		alert("<i18n:label code="MSG_ENTER_KEYWORD"/>");
    		focusAndSelect(thisform.Keyword);
    		return false;
    	}else{
	    	return true;
    	}
  	}      	 
	</script>
</head>

<body>
  
<div class="functionhead"><i18n:label code="STOCKIST_QUICK_SEARCH"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(taskID,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
	<table>
	  <tr>
	    <td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.SEARCH_IN%>"/>:</td>
	    <td>
	    	<std:input type="select" name="SearchBy" options="<%= StockistManager.searchByMap %>" value="otl_outletid"/>
	    	<std:input type="text" name="Keyword" size="30" status="onKeyUp=\"javascript:enterKeyword(this.form.SearchBy.value, this);\""/>
	    </td>
	  </tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	<std:input type="hidden" name="FormName" value="<%= formName %>"/>
	<std:input type="hidden" name="ObjName"  value="<%= objName %>"/>
	<std:input type="hidden" name="PropName" value="<%= propName %>"/>  
	
	<input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick="window.close();">
</form>

<hr>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<c:if test="<%=canView %>">

		<table class="listbox" width="100%">
			<tr class="boxhead" valign=top>
			<td width="5%" align=right><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td width="10%"><i18n:label code="STOCKIST_ID"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
			<td width="10%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.IC_NO%>"/> / <br> <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/></td>
			<td width="10%"><i18n:label code="GENERAL_NO_MOBILE"/></td>	
		</tr>
	
	<%
	   for(int i=0; i< beans.length; i++){
		   String propValue = "";
	%>
		<tr class="<%= ((i%2)==0)?"odd":"even"%>" valign=top>
			<td width="5%" align=right><%= (i+1) %>.</td>
			<td nowrap><a href="javascript:invokeParent('<%= beans[i].getStockistCode() %>','<%= propValue %>')"><%= beans[i].getStockistCode() %></a></td>
			<td><%= beans[i].getName() %></td>
			<td nowrap><%= beans[i].getRegistrationInfo() %></td>
			<td nowrap><std:text value="<%= beans[i].getMobileTel() %>"/></td>
		</tr>
	<%}//end for %>
	</table>
	<br>
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick="window.close();">
</c:if>
</body>
</html>
