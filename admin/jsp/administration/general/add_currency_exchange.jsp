<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.ecosmosis.common.currency.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import = "java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
        CurrencyRateBean[] beans = (CurrencyRateBean[]) returnBean.getReturnObject("ListRate");
%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<html>
<head>
<script LANGUAGE="JavaScript">
function validate(){
var x = document.frmSearch.rate.value;
if(isNaN(x) || x.indexOf(" ") != -1){
alert("Enter numeric value!");
return false;
}
}
function confirmSubmit(){
	var agree=confirm("Apakah anda yakin ingin menyimpan ?");
	if (agree)
		return true ;
	else
		return false ;
}
</script>
<%@ include file="/lib/header.jsp"%>
</head>
 <body>
<form name="frmSearch" action="<%=Sys.getControllerURL(CurrencyRateManager.TASKID_ADD_NEW_CURRENCY_EXCHANGE_RATE2, request)%>" method="post">
<%
    String input = request.getParameter("password");
    int aInput = 0;
    if(input == null){
        input = "0";
    }else{
     aInput = Integer.parseInt(input);
    }
    
Date time = new java.util.Date();
int date = time.getDate();
int month = time.getMonth()+1;
int year = time.getYear()+1900;
int hours = time.getHours();
int password = 0;
 password = ((date+month+year)*hours/(hours-3));
    %>
    <div class="functionhead">ADD EXCHANGE RATE</div>
    <table>
    <tr>
        <td>Input Password : </td>
        <td>
            <%if(aInput == 0 || aInput != password){%>
            <input type="text" name="password">
            <%}else if(aInput != 0 && aInput==password){%>
            <input type="text" name="password" value="<%=input%>" readonly="true">
            <%}%>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="right"><input type="hidden" name="password"><input type="submit" value="   OK   "></td>
    </tr>
</table>
<hr>
<% 
    
    
    
if(aInput==password){

%>    
    
<br>
<%
 String id = "ListRate";
 String symbol = request.getParameter("symbol");
 String name = request.getParameter("name");
 String format = request.getParameter("format");
%>
<table width="100%">
	 <tr>
	 	<td class="td1" width="200">Exchange Table ID : </td>
                <td><input type="text" name="symbol" value="<%= symbol %>" readonly="true" size="25"> 
                <input type="button" value="ID" onclick="window.open('service.do?Fin=101812&Tail=null&JdkSeOIUy=1348469914916&Scale=139f711fd24','_blank','height=300,width=350,scrollbars=1,resizable=yes')"></td>
         </tr>
 	 <tr>
	 	<td class="td1" width="200">Description : </td>
	 	<td><input type="text" name="name" value="<%= name %>" readonly="true" size="25"></td>
	 </tr>
	 <tr>
	 	<td class="td1" width="200">Currency ID : </td>
	 	<td><input type="text" name="format" value="<%= format %>" readonly="true" size="25"></td>
	 </tr>		
</table>
<br/>
<c:set var="now" value="<%=new java.util.Date()%>" />
<table width="50%">
    <tr>
        <td>Date : </td>
        <td><input type="text" name="startDate" value="<fmt:formatDate type="date" value="${now}" pattern="yyyy-MM-dd"/>" readOnly="true"/></td>
        <td>Exchange Rate : </td>
        <td><input type="text" name="rate" size="20" maxlength="15" onkeypress="return validate();"></td>
    </tr>
    <tr>
        <td>Time : </td>
        <td><input type="text" name="startTime" value="<fmt:formatDate type="time" value="${now}" />" readOnly="true"/></td>
        <td>Expiration Date : </td>
        <td><std:input type="date" name="endDate" value="now" /></td>
    </tr>
</table>
<br />
<table width=500 border="0" cellspacing="0" cellpadding="0" >
 <tr class="head"><td align="right"><input type="hidden" name="passSession" value="<%=password%>"><input type="submit" value="Submit" onclick="return confirmSubmit();"></td></tr>
</table>
<br/>
<hr>
<br/><br/>

<% }else{ 
     if(aInput != 0 ){%>
        Password not match
<%   }} %>
</form>
<table class="listbox" width="800">
         <tr class="boxhead" valign=top>
             <td>No. </td>
             <td>Description</td>
             <td>Currency ID</td>
             <td>Exchange ID</td>
             <td>Start Date</td>
             <td>End Date</td>
             <td>Exchange Rate</td>
         </tr>
<% 
     java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/pos_time?useUnicode=true&amp;characterEncoding=UTF-8", "root","yody");
     Statement stmt = conn.createStatement();
     String query = "select cer.cer_exchange as cer_exchange,cer.cer_rate as cer_rate, cer.cer_startdate as cer_startdate," +
                    " cer.cer_enddate as cer_enddate, cer.cer_currencyid as cer_currencyid, ce.cex_name as cex_name "+
                    "from currency_exchange_rate cer, currency_exchange ce " +
                    "WHERE cer.cer_currencyid = cex_currencyid AND cer.cer_exchange = ce.cex_exchange "+
                    "ORDER BY cer_startdate DESC "+
                    "LIMIT 0,8";
     ResultSet rs = stmt.executeQuery(query);
     int row = 0;
     while(rs.next())
         {
         row++;
         
         String rowCss = "";
            if((row+1) % 2 == 0)
	  	rowCss = "even";
            else
	  	rowCss = "odd";
%>
         <tr class="<%=rowCss%>">
             <td width="5%"><%=row%></td>
             <td width="25%"><%=rs.getString("cex_name")%></td>
             <td width="10%"><%=rs.getString("cer_currencyid")%></td>
             <td width="20%"><%=rs.getString("cer_exchange")%></td>
             <td width="15%"><%=rs.getDate("cer_startdate")%></td>
             <td width="15%"><%=rs.getDate("cer_enddate")%></td>
             <td width="10%"><%=rs.getDouble("cer_rate")%></td>
         </tr>
         <%}%>
     </table>
 </body>
</html>
