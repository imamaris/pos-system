<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.accesscontrol.menu.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	MenuBean bean = (MenuBean) returnBean.getReturnObject("MenuBean");
	TreeMap menutype = (TreeMap) returnBean.getReturnObject("MenuTypeList");
	TreeMap usertype = (TreeMap) returnBean.getReturnObject("UserTypeList");
	TreeMap visitype = (TreeMap) returnBean.getReturnObject("VisiTypeList");
	TreeMap statustype = (TreeMap) returnBean.getReturnObject("StatusTypeList");
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

<form name="addfunction" action="<%=Sys.getControllerURL(FunctionTaskManager.TASKID_UPDATE_FUNCTION_SUBMIT,request)%>" method="post">
<std:input type="hidden" name="funcid" value="<%=bean.getFunctionID()%>" />

<div class="functionhead">Update Function</div>

<%@ include file="/general/mvc_return_msg.jsp"%>
	
<br>
<table class="listbox" width=600>
	 <tr>
	 	<td width="200" class="odd">Function ID</td>
	 	<td width="400"><%=bean.getFunctionID()%></td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">Default Desc (en_US)</td>
	 	<td width="400"><std:input type="text" name="desc"  value="<%=bean.getDesc()%>"  size="60" maxlength="60" /></td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">Type</td>
	 	<td><std:input type="select" name="functype" options="<%=menutype%>" value="<%=bean.getMenutype()%>"/></td>
	 </tr> 
	 
<%


	String[] task = new String[8];	 
	
	for (int i=0;i < bean.getTaskIdGroup().size();i++)
	{
		task[i] = (String) bean.getTaskIdGroup().get(i);
	}
	 
	 
%>	 
	 
	  <tr>
	 	<td width="200" class="odd">Associated Tasks</td>
	 	<td width="400">
                                                1)<std:input type="text" name="task1" value="<%=task[0]%>" size="8" maxlength="6" /> 
	 					2)<std:input type="text" name="task2" value="<%=task[1]%>" size="8" maxlength="6" /> 
	 					3)<std:input type="text" name="task3" value="<%=task[2]%>" size="8" maxlength="6" />
	 					4)<std:input type="text" name="task4" value="<%=task[3]%>" size="8" maxlength="6" />
                                                <br>
	 					5)<std:input type="text" name="task4" value="<%=task[4]%>" size="8" maxlength="6" />
	 					6)<std:input type="text" name="task5" value="<%=task[5]%>" size="8" maxlength="6" />
	 					7)<std:input type="text" name="task6" value="<%=task[6]%>" size="8" maxlength="6" />
                                                8)<std:input type="text" name="task4" value="<%=task[7]%>" size="8" maxlength="6" />
	 	</td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">Access Group Level</td>
	 	<td><std:input type="select" name="agroup" options="<%=usertype%>" value="<%=bean.getAccesscgroupid()%>"/></td>
	 </tr> 
	 <tr>
	 	<td width="200" class="odd">Menu Visibility</td>
	 	<td><std:input type="select" name="visibility" options="<%=visitype%>" value="<%=bean.getMenuVisibility()%>"/></td>
	 </tr>  
	 <tr>
	 	<td width="200" class="odd">Order Sequence</td>
	 	<td><std:input type="text" name="orderseq" value="<%=bean.getOrderSequence()%>" size="4" maxlength="3" /></td>
	 </tr> 
	 <tr>
	 	<td width="200" class="odd">Status</td>
	 	<td><std:input type="select" name="status" options="<%=statustype%>" value="<%=bean.getStatus()%>"/></td>
	 </tr> 
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="UPDATE"></td></tr>
</table>

</form>

 </body>
</html>