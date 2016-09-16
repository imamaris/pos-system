<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>

<html>
<head>
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit()
{
	var agree=confirm("Confirm ?");
	if (agree)
		return true ;
	else
		return false ;
}
// -->
</script>

 



 
<%@ include file="/lib/header.jsp"%>

</head>
 <body>

<form name="addfunction" action="<%=Sys.getControllerURL(FunctionTaskManager.TASKID_ADD_NEW_FUNCTION,request)%>" method="post">

<div class="functionhead">Add New Function</div>

<%@ include file="/general/mvc_return_msg.jsp"%>
	
<br>
<table class="listbox" width=600>
	 <tr>
	 	<td width="200" class="odd">Function ID</td>
	 	<td width="400"><std:input type="text" name="funcid" value="<%=request.getParameter("tmpfuncid")%>" size="12" maxlength="9" /></td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">Default Desc (en_US)</td>
	 	<td width="400"><input type="text" name="desc" value="" size="60" maxlength="60"></td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">Type</td>
	 	<td width="400">
	 		<select name="type">
				<option value="5" >Function</option>
				<option value="4" >Grouping</option>
				<option value="3" >Category</option>
				<option value="2" >Sub System</option>
				<option value="1" >System</option>
	   		</select>
	 	</td>
	 </tr> 
	  <tr>
	 	<td width="200" class="odd">Associated Tasks</td>
	 	<td width="400">1)<input type="text" name="task1" value="" size="8" maxlength="6"> 
	 					2)<input type="text" name="task2" value="" size="8" maxlength="6"> 
	 					3)<input type="text" name="task3" value="" size="8" maxlength="6">
	 					<br>
	 					4)<input type="text" name="task4" value="" size="8" maxlength="6">
	 					5)<input type="text" name="task5" value="" size="8" maxlength="6">
	 					6)<input type="text" name="task6" value="" size="8" maxlength="6">
	 	</td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">Access Group Level</td>
	 	<td width="400">
	 		<select name="agroup">
				<option value="80">Admin</option>
				<option value="100">Super Admin</option>
				<option value="<%=SystemConstant.STOCKIST_USER_SIMPLE %>">Stockist User(Normal)</option>
				<option value="<%=SystemConstant.STOCKIST_USER %>">Stockist User(Admin)</option>		
				<option value="<%=SystemConstant.NORMAL_USER%>">Member</option>		
				<option value="0">Open to All</option>
	   		</select>
	 	</td>
	 	</td>
	 </tr> 
	 <tr>
	 	<td width="200" class="odd">Menu Visibility</td>
	 	<td width="400">
	 		<select name="visibility">
	 			<option value="1" >Direct Access </option>
				<option value="0" >Indirect Access (eg. Edit Admin) </option>
	   		</select>
	 	</td>
	 </tr>  
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="ADD" onclick="return confirmSubmit()"></td></tr>
</table>

</form>

 </body>
</html>