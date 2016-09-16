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
    
    System.out.println("hello serial");
    
    String  data ="";
    String  data1 ="test";
    conn = DriverManager.getConnection(url+dbName,userName,password);
    String  queryFlag = "";
   
    queryFlag = " SELECT ovc_code, ovc_desc, ovc_startdate, ovc_enddate" +
            " FROM outlet_voucher_parking Left Join bvwallet ON bvw_refno = ovc_code" +
            " WHERE ovc_outletid =  '"+sku_kode+"' AND ovc_startdate <=  ' "+tanggal+" '  and ovc_enddate >=  ' "+tanggal+" '  " +
            " AND ovc_status =  'A'  AND bvw_refno is null order by ovc_code ";
    
    
    Statement stFlag = conn.createStatement();
    ResultSet rsFlag = stFlag.executeQuery(queryFlag);  

%>
<html>
    <head>
        <title>Voucher Number Listing </title>
        <link rel="stylesheet" type="text/css" media="screen" href="<%= request.getContextPath() %>/lib/screen.css" />
    </head>
    <body onLoad="loaded = true;">
        <table class="listbox" width="80%">
            <%  if(rsFlag != null && rsFlag.isBeforeFirst()){%>
            <tr class="boxhead" valign="top">
                <td width="3%" align="center">No</td>
                <td align="center" >Voucher No.</td>
                <td align="center" >Description</td>
                <td align="center" >Valid From</td>
                <td align="center" >Valid to</td>
            </tr>
            <%
            int a = 1;
            while(rsFlag.next()) {
                
                String rowCss = "";
                
                if((a+1) % 2 == 0)
                    rowCss = "even";
                else
                    rowCss = "odd";
                    
                data = ":" + rsFlag.getString("ovc_code") + ":" + rsFlag.getString("ovc_desc") + ":" + rsFlag.getString("ovc_startdate") + ":" + rsFlag.getString("ovc_enddate")  ;
            %>
            <tr class="<%= rowCss %>" valign=top>
                <td align="center"><%= a%></td>
                <td><a href="javascript:window.opener.document.getElementById('voucher').value='<% out.print(rsFlag.getString("ovc_code")); %>';window.close(); window.opener.document.getElementById('submit').disabled = false; window.opener.document.getElementById('submit').focus();"><% out.println(rsFlag.getString("ovc_code")); %></a></td> 
                <td align="left"><% out.println(rsFlag.getString("ovc_desc")); %></td>
                <td align="left"><% out.println(rsFlag.getString("ovc_startdate")); %></td>
                <td align="left"><% out.println(rsFlag.getString("ovc_enddate")); %></td>

            </tr>
            <%
            a++;
            }
            }else{%>
            <tr class="boxhead" valign="top">
                <td>All Voucher numbers have been used !</td>
            </tr>
            <%}
            } catch (Exception e) {
            e.printStackTrace();
            }
            %>
        </table>
    </body>
</html>