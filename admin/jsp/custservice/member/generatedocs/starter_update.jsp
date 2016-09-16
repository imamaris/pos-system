<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.member.printings.MemberPrintManager"%>
<%@page import="com.ecosmosis.orca.member.printings.MemberIdBean"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">
	
	function doSubmit(){
		
		var myform = document.doc_gen2;		
		if(myform.sect01.value == ''){
		   alert('Value cannot empty.');
		   myform.sect01.focus();
		   myform.sect01.select();
		   return false;
		   
		}else if(myform.sect04.value == ''){
		   alert('Value cannot empty.');
		   myform.sect04.focus();
		   myform.sect04.select();
		   return false;
		   
		}else if(isNaN(myform.sect02.value)){
		   alert('Value must be an integer.');
		   myform.sect02.focus();
		   myform.sect02.select();
		   return false;
		   
		}else if(isNaN(myform.sect03.value)){
		   alert('Value must be an integer.');
		   myform.sect03.focus();
		   myform.sect03.select();
		   return false;
		   
		}else if(isNaN(myform.sect04.value)){
		   alert('Value must be an integer.');
		   myform.sect04.focus();
		   myform.sect04.select();
		   return false;
		   		   
		}
                
		return true;
	}

</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  String id = (String) returnBean.getReturnObject("ID");   
  //long total_generated = (Long) returnBean.getReturnObject("TotalGenerated");  
  //long total_used_generated = (Long) returnBean.getReturnObject("TotalUsedGenerated");  
  //long total_unused_generated = (Long) returnBean.getReturnObject("TotalUnusedGenerated");  
   // lastBean = (MemberIdBean) returnBean.getReturnObject("LastGeneratedBean");  
%>
<body onLoad="self.focus();document.doc_gen2.sect04.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead>Starter Pack Engine > Select Start Number</div>
<form name="doc_gen2" action="<%=Sys.getControllerURL(MemberPrintManager.TASKID_STARTER_UPDATE_SUBMIT, request)%>" method="post" onsubmit="return doSubmit();">
<table>
<tr>
      <td align=right>Code Start From : </td>
     <td> 
     <b>ID</b><std:input type="hidden" name="sect01" value="ID"/>
     <std:input type="text" name="sect02" value="00" maxlength="2" size="2"/>
     <std:input type="text" name="sect03" value="000" maxlength="3" size="3"/>
     <std:input type="text" name="sect04" value="" maxlength="5" size="5"/>
  	</td>
</tr>
<tr>
      <td align=right>Code Start To : </td>
     <td> 
     <b>ID</b><std:input type="hidden" name="sect05" value="ID"/>
     <std:input type="text" name="sect06" value="00" maxlength="2" size="2"/>
     <std:input type="text" name="sect07" value="000" maxlength="3" size="3"/>
     <std:input type="text" name="sect08" value="" maxlength="5" size="5"/>
  	</td>
</tr>
<tr>
	 	<td align=right><i18n:label code="STOCKIST_ID"/> : </td>
	 	<td align=left><std:stockistid form="doc_gen2" name="StockistID" value="" /></td>
</tr>

</table>
<br>
<input class="textbutton" type="submit" name="btnSubmit" value="Update">
</form>
<hr>
<table>

    

</table>
</body>
</html>
