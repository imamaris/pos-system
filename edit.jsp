<%@page language="java"%>
<%@page import="java.sql.*"%>


<form method="post" action="update.jsp">
<table border="1">
<tr><th>Name</th><th>Address</th><th>Contact No</th><th>Email</th></tr>
<%
String id=request.getParameter("id");
int no=Integer.parseInt(id);
%>

<tr>    
<td><input type="submit" name="Submit" value="Update" style="background-color:#49743D;font-weight:bold;color:#ffffff;"></td>
</tr>

</table>
</form>