<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.tools.seminar.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	boolean canView = false;
	String numRows = "";
	if (request.getParameter("NumRows")!=null){
		numRows = request.getParameter("NumRows");
		canView = true;
	}
%>

<html>
<head>
	<%@ include file="/lib/header.jsp"%>
	
	<script language="javascript">
	
		function doSubmit(thisform) 
		{	
			if (!validateText(thisform.NumRows)) {
					alert("Please enter No of Events.");
					thisform.NumRows.focus();
					return;
			}  
			thisform.submit();
		}
		function doShowList(thisform) 
		{	
			window.location.href='<%=Sys.getControllerURL(SeminarManager.TASKID_SEMINAR_ADD,request)%>';
			thisform.submit();
		}
		function selectAll(formObj) 
		{
		   for (var i=0;i < formObj.length;i++) 
		   {
		      fldObj = formObj.elements[i];
		      if (fldObj.type == 'checkbox')
		      { 
		         //if(isInverse)
		            fldObj.checked = (fldObj.checked) ? false : true;
		         //else fldObj.checked = true; 
		       }
		   }
		}
		
	</script>
</head>

<body onLoad="self.focus();">

<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.ADD_NEW_SEMINAR%>"/></div>

<form name="frmSeminarAdd" action="<%=Sys.getControllerURL(SeminarManager.TASKID_SEMINAR_ADD,request)%>" method="post">

<%@ include file="/lib/return_error_msg.jsp"%>
<%@ include file="/general/mvc_return_msg.jsp"%>

<p class="required note">* <i18n:label localeRef="mylocale" code="<%=StandardMessageTag.REQUIRED_FIELD%>"/></p>

	<table class="tbldata" width="100%">
	  	<tr>
  			<td class="td1" width="100"><span class="required note">* </span><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.SEMINAR_TITLE%>"/>:</td>
      		<td><input type="text" size="20" name="SeminarTitle"/></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/>:</td>
      		<td>
      			<select name="Status">
      				<option value="<%=AppConstant.STATUS_ACTIVE%>">Active</option>
      				<option value="<%=AppConstant.STATUS_INACTIVE%>">Inactive</option>
      			</select>
      		</td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/>:</td>
      		<td><std:input type="text" size="3" name="OrderSeq" value="1"/></td>
  		</tr>
  		<tr>
  			<td class="td1" width="100">Post Status:</td>
      		<td>
      			<select name="PostStatus">
      				<option value="10">Prerpare</option>
      				<option value="20" selected>Open</option>
      				<option value="30">Close</option>
      			</select>
      		</td>
  		</tr>
  		<tr>
  			<td class="td1" width="100"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.NO_OF_EVENTS%>"/>:</td>
      		<td><std:input type="text" size="3" name="NumRows"/></td>
  		</tr>
  	</table>
  	<table><tr><td height="15"></td></tr></table>
<% if (canView) { %>  
  	<!-- event table listing -->
	<table class="listbox" width="90%" cellspacing="0">
		<tr class="boxhead" valign=top align="center">
			<td width="15"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td width="400"><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.VENUE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=SeminarMessageTag.ACTIVITIES%>"/></td>
			<td width="30"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.ORDER%>"/></td>
			<td width="15"><input type="checkbox" name="checkAll" onclick="selectAll(this.form);"></td>
		</tr>
		  
		  <% 
		  int rows = Integer.parseInt(numRows);
		  for (int i=0;i<rows;i++) { 
			    
			  String rowCss = "";
	  		  	
	  		  	if((i+1) % 2 == 0)
	  	      		rowCss = "even";
	  	      	else
	  	        	rowCss = "odd";
	  		  	
	  		  	int k = i+1;
		  		String venueStr = "Venue_" + String.valueOf(k);
		  		String actStr = "Act_" + String.valueOf(k);
		  		String orderStr = "Order_" + String.valueOf(k);
		  		String selStr = "Sel_" + String.valueOf(k);
		  %>
		  
		  	  <tr class="<%=rowCss%>" align="center">
				<td align="center" valign="top"><%=(i+1)%></td>
				<td align="left" valign="top"><input type="text" size="60" name="<%=venueStr%>"/></td>
				<td align="left"><textarea cols="60" rows="4" name="<%=actStr%>"></textarea></td>
				<td align="center" valign="top"><input type="text" size="3" name="<%=orderStr%>"/></td>
				<td align="center" valign="top"><input type="checkbox" name="EventSel" value="<%=k%>"><std:input type="hidden" name="<%=selStr%>" value="<%=selStr%>"/></td>
			  </tr>	
		  <% } // end for loop %>
	</table>
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
<% } %> 
	<br><br>
	<input class="textbutton" type="button" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.SUBMIT%>'/>" onClick="doSubmit(this.form);">
  	<input class="textbutton" type="reset" value="<i18n:label localeRef='mylocale' code='<%=StandardMessageTag.RESET%>'/>">

</form>
</html>