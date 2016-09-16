<%@page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.member.lucky.MemberLuckyManager"%>
<%@page import="com.ecosmosis.orca.member.lucky.MemberLuckyBean"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">
	
	function doSubmit(){
		
		var myform = document.doc_gen;		
		   		   		   		   	   
		if(isNaN(myform.qty.value) || (myform.qty.value * 1) <= 0){
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
  MemberLuckyBean lastBean = (MemberLuckyBean) returnBean.getReturnObject("LastGeneratedBean");  
%>

<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead>Lucky Draw's Engine > Select Start Number</div>
<form name="doc_gen" action="<%=Sys.getControllerURL(MemberLuckyManager.TASKID_STARTER_SUBMIT, request)%>" method="post" onsubmit="return doSubmit();">
<table>
    
    <tr>
        <td align=right><i18n:label code="Sales Ref"/> : </td>
        <td align=left><std:input type="text" name="SalesID" size="13" value="" /></td>        
    </tr>    

    <tr>
        <td align=right><i18n:label code="Member ID"/> : </td>
        <td align=left><std:memberid form="doc_gen" name="MemberID" value="" /></td>
    </tr>    

    <tr>
    <td align=right>Quantity : </td>
    <td align=left><b>2</b>        
    <std:input type="hidden" name="qty" value='2'/>
</td>
</tr>

    <tr>    
     <td align=right>Last Generated : </td>
     <td align=left><%=(lastBean!=null)?lastBean.getId():"-" %>     
     </td>
     <std:input type="hidden" name="sect01" value="LD"/>
     <std:input type="hidden" name="sect04" value="<%=lastBean.getId().substring(2,7)%>"/>
 </tr>

</table>
<br>

<std:input type="hidden" name="tipe" value="0"/>
<input class="textbutton" type="submit" name="btnSubmit" value="Generate">
</form>

<hr>
<table>
<tr>
     <td align=left colspan=2><b>Summary : </b></td>
</tr>
<tr>
    <td align=right>Last Generated </td>
    <td align=left>: <%=(lastBean!=null)?lastBean.getId():"-" %></td>
</tr>
<tr>
    <td align=right>Total Generated</td>
    <td align=left>: <%=total_generated %></td>
</tr>

</table>
</body>
</html>
