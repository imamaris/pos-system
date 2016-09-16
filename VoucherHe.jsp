<%@ page import="java.sql.*" %> 
<%

// System.out.println("Ke sinikeh 1 index ");

String sku_kode = request.getParameter("sku_kode").toString();
// String lokasi = request.getParameter("lokasi").toString();
String tanggal = request.getParameter("tanggal").toString();

System.out.println("Voucher Ke sinikeh 2 index kode "+sku_kode);
String  data ="";
String  data1 ="test";

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
    
    
    System.out.println("Voucher hello");
    
    conn = DriverManager.getConnection(url+dbName,userName,password);
            
    String query = " SELECT outlet_voucher.ovc_outletid, outlet_voucher.ovc_code, outlet_voucher.ovc_desc, outlet_voucher.ovc_issuedate, outlet_voucher.ovc_startdate, outlet_voucher.ovc_enddate, outlet_voucher.ovc_currencyid, outlet_voucher.ovc_rate, outlet_voucher.ovc_amount, outlet_voucher.ovc_status " +
               " FROM outlet_voucher WHERE outlet_voucher.ovc_startdate <= '"+tanggal+"'  and outlet_voucher.ovc_enddate >= ' "+tanggal+" '  AND outlet_voucher.ovc_status = 'A' and  trim(outlet_voucher.ovc_code) = '"+sku_kode+"' order by ovc_id DESC limit 1 " ; 
            
    st = conn.createStatement();
    ResultSet  rs = st.executeQuery(query);
    
    System.out.println("Voucher Ke sinikeh 3 index, query "+query);
    
    while(rs.next()) {
        
         System.out.println("Voucher Ke sinikeh 4 index kode "+sku_kode);
        
        data = "~" + rs.getString("ovc_outletid") +      
                "~" + rs.getString("ovc_code") +
                "~" + rs.getString("ovc_desc") +  
                "~" + rs.getString("ovc_issuedate") +
                "~" + rs.getString("ovc_startdate") +
                "~"+ rs.getString("ovc_enddate") +
                "~"+ rs.getString("ovc_currencyid") +
                "~"+ rs.getString("ovc_rate") +
                "~"+ rs.getString("ovc_amount") +    
                "~"+ rs.getString("ovc_status") +    
                "~"+ sku_kode;        
    }
	

    // println(query);
    out.println(data);
} catch (Exception e) {
    e.printStackTrace();
}
%>