<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.member.printings.MemberPrintManager"%>
<%@page import="com.ecosmosis.orca.member.printings.MemberIdBean"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">
	
	function doSubmit(){
		
		var myform = document.doc_gen;		
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
		   		   
		}else if(myform.qty.value == ''){
		   alert('Value cannot empty.');
		   myform.qty.focus();
		   myform.qty.select();
		   return false;	
		   	   
		}else if(isNaN(myform.qty.value) || (myform.qty.value * 1) <= 0){
		   alert('Value must be an integer AND greater than 1.');
		   myform.qty.focus();
		   myform.qty.select();
		   return false;
		   
		}
		return true;
	}

</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  String id = (String) returnBean.getReturnObject("ID");   
  String tipe  = (String) returnBean.getReturnObject("tipe");
  long total_generated = (Long) returnBean.getReturnObject("TotalGenerated");  
  long total_used_generated = (Long) returnBean.getReturnObject("TotalUsedGenerated");  
  long total_unused_generated = (Long) returnBean.getReturnObject("TotalUnusedGenerated");  
  MemberIdBean lastBean = (MemberIdBean) returnBean.getReturnObject("LastGeneratedBean");  
%>
<body onLoad="self.focus();document.doc_gen.sect04.focus();">
<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead>Starter Pack Engine > Select Start Number</div>
<form name="doc_gen" action="<%=Sys.getControllerURL(MemberPrintManager.TASKID_STARTER_SUBMIT, request)%>" method="post" onsubmit="return doSubmit();">
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
    <td align=right>Type     : </td>
    <td>                                                    
    <std:input type="radio" name="tipe" value="0" status="checked"/><i18n:label code=" Standart "/>
    <std:input type="radio" name="tipe" value="6" status=""/><i18n:label code=" Pkt. 597"/>
    <std:input type="radio" name="tipe" value="7" status=""/><i18n:label code=" Pkt. 1100 PV"/>    
</td>
</tr>

<tr>
    <td align=right>Quantity : </td>
    <td align=left>
    <std:input type="text" name="qty" maxlength="5" size="5"/>
</td>
</tr>

</table>
<br>
<input class="textbutton" type="submit" name="btnSubmit" value="Generate">
</form>
<hr>
<table>
<tr>
     <td align=left colspan=2><b>Summary : </b></td>
</tr>
<tr>
    <td align=right>Last Generated ID</td>
    <td align=left>: <%=(lastBean!=null)?lastBean.getId():"-" %></td>
</tr>
<tr>
    <td align=right>IDs Used</td>
    <td align=left>: <%=total_used_generated%></td>
</tr>
<tr>
    <td align=right>IDs Available</td>
    <td align=left>: <%=total_unused_generated %></td>
</tr>
<tr>
    <td align=right>Total Generated</td>
    <td align=left>: <%=total_generated %></td>
</tr>

</table>
</body>
</html>
