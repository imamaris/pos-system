<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%

String sku_kode = request.getParameter("skuCode");
// String tanggal = request.getParameter("tanggal").toString();
String tanggal = "2013-02-18";

// String i = request.getParameter("increment").toString();
// String list = request.getParameter("list").toString();
// String[] arrList = list.split(",");

Connection conn = null;
String url = "jdbc:mysql://localhost:3306/";
String dbName = "pos_time";
String driver = "com.mysql.jdbc.Driver";
String userName = "root";
String password = "yody";

int sumcount=0;
Statement st;
try {
    Class.forName(driver).newInstance();
    
    System.out.println("hello pin");
    
    String  data ="";
    String  data1 ="test";
    conn = DriverManager.getConnection(url+dbName,userName,password);
    String  queryFlag = "";
    
    queryFlag = " SELECT mbr_mbrid, mbr_name, mbr_epin, mbr_idcrm, mbr_idcrm_valid, mbr_segmentation " +
            " FROM member_pin ";
    
    Statement stFlag = conn.createStatement();
    ResultSet rsFlag = stFlag.executeQuery(queryFlag);  

%>
<html>
    <head>
        <title>Customer PIN Listing </title>
        <link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath() %>/lib/screen.css" />
    </head>
    <body onLoad="loaded = true;">
        <table class="listbox" width="80%">
            <%  if(rsFlag != null && rsFlag.isBeforeFirst()){%>
            <tr class="boxhead" valign="top">
                <td width="3%" align="center">No</td>
                <td align="center" >Customer No.</td>
                <td align="center" >Name</td>
                <td align="center" >PIN</td>
                <td align="center" >Previllage No.</td>
                <td align="center" >Valid To</td>
                <td align="center" >Segmentation</td>
            </tr>
            <%
            int a = 1;
            while(rsFlag.next()) {
                String rowCss = "";
                
                if((a+1) % 2 == 0)
                    rowCss = "even";
                else
                    rowCss = "odd";
                
                
                data = ":" + rsFlag.getString("mbr_mbrid") + ":" + rsFlag.getString("mbr_name") + ":" + rsFlag.getString("mbr_epin") + ":" + rsFlag.getString("mbr_idcrm") + ":" + rsFlag.getString("mbr_idcrm_valid") + ":" + rsFlag.getString("mbr_segmentation")  ;
            %>
            <tr class="<%= rowCss %>" valign=top>
                <td align="center"><%= a%></td>
                <td><a href="javascript:window.opener.document.getElementById('icode3').value='<% out.print(rsFlag.getString("mbr_epin")); %>'; window.opener.document.getElementById('IdCrm').value='<% out.print(rsFlag.getString("mbr_idcrm")); %>'; window.opener.document.getElementById('ValidCrm').value='<% out.print(rsFlag.getString("mbr_idcrm_valid")); %>' ; window.opener.document.getElementById('SegmentationCrm').value='<% out.print(rsFlag.getString("mbr_segmentation")); %>' ; window.opener.document.getElementById('custID2').value='<% out.print(rsFlag.getString("mbr_mbrid")); %>' ; window.opener.document.getElementById('custID').value='<% out.print(rsFlag.getString("mbr_mbrid")); %>' ;window.opener.document.getElementById('NmCust').value='<% out.print(rsFlag.getString("mbr_name")); %>' ; window.opener.document.getElementById('NmCust2').value='<% out.print(rsFlag.getString("mbr_name")); %>' ; window.close();"><% out.println(rsFlag.getString("mbr_mbrid")); %></a></td>
                <td align="left"><% out.println(rsFlag.getString("mbr_name")); %></td>
                <td align="left">****</td>
                <td align="left"><% out.println(rsFlag.getString("mbr_idcrm")); %></td>
                <td align="left"><% out.println(rsFlag.getString("mbr_idcrm_valid")); %></td>
                <td align="left"><% out.println(rsFlag.getString("mbr_segmentation")); %></td>
            </tr>
            <%
            a++;
            }
            }else{%>
            <tr class="boxhead" valign="top">
                <td>No Find PIN Number !</td>
            </tr>
            <%}
            } catch (Exception e) {
            e.printStackTrace();
            }
            %>
        </table>
    </body>
</html>