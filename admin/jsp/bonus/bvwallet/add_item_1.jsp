<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bonus.bonusperiod.*"%>
<%@ page import="com.ecosmosis.orca.bvwallet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>


<meta http-equiv="content-type" content="text/html; charset=UTF-8">

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
 
<%@ include file="/general/mvc_return_msg.jsp"%>

<form name="add" action="<%=Sys.getControllerURL(BvWalletManager.TASKID_ADD_NEW_BVWALLET_DISTR_ITEM,request)%>" method="post">

<div class="functionhead">ADD NEW BV WALLET ENTRY</div>
<br>
	
<table  class="listbox"  width=600>

	<!--
	<tr>
	 	<td width="200" class="odd">Bonus Period</td>
	 	<td>
	 		<select name="periodid">
	 			 <%@ include file="/common/select_bonusperiod.jsp"%>
	   		</select>
	 	</td>
	 </tr> 
	-->
	 
	 <tr>
	 	<td width="200" class="odd">Bonus Date</td>
	 	<td><std:input type="date" name="BonusDate" value="<%= Sys.getDateFormater().format(new Date()) %>"/></td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">Transaction Type</td>
	 	<td>
	 		<select name="trxtype">
	 			 <%@ include file="/common/select_bvwallet_trxtypes.jsp"%>
	   		</select>
	 	</td>
	 </tr>
	 
	  <tr>
	 	<td width="200" class="odd">Member ID</td>
	 	<td><std:memberid form="add" name="memberid" value="" /></td>
	 </tr>	
	 
	 <tr>
	 	<td width="200" class="odd">BV</td>
	 	<td><input type="text" name="bv" value="" size="10" maxlength="10"></td>
	 </tr>
	 
	 <tr>
	 	<td width="200" class="odd">BV 2</td>
	 	<td><input type="text" name="bv1" value="" size="10" maxlength="10"></td>
	 </tr>
	 
	 <tr>
	 	<td width="200" class="odd">BV AMOUNT IN</td>
	 	<td><input type="text" name="bvamount" value="" size="10" maxlength="10"></td>
	 </tr>

	 <tr>
	 	<td width="200" class="odd">BV FULL AMOUNT IN</td>
	 	<td><input type="text" name="bvfullamount" value="" size="10" maxlength="10"></td>
	 </tr>

         <tr>
	 	<td width="150" class="odd">Remark</td>
	 	<td><textarea name="remark" rows="5" cols="50"></textarea></td>
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