<%@ page import="java.sql.*" %> 
<%

System.out.println("Ke sinikeh index ");

String sku_kode = request.getParameter("sku_kode").toString();
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
    
    
    System.out.println("hello");
    
    conn = DriverManager.getConnection(url+dbName,userName,password);
    
    
    String query = "SELECT mbr_mbrid, mbr_name, mbr_deposit, mbr_idcrm, mbr_idcrm_valid, mbr_segmentation " +
            " FROM member " +
            " WHERE mbr_mobileno='"+sku_kode+"' or mbr_faxno='"+sku_kode+"' or mbr_homeno='"+sku_kode+"' order by mbr_idcrm desc ";
    
    
    System.out.println("SQL "+query);
    st = conn.createStatement();
    ResultSet  rs = st.executeQuery(query);
    while(rs.next()) {
        
        data = ":" + rs.getString("mbr_mbrid") +
                ":" + rs.getString("mbr_name") +
                ":" + rs.getString("mbr_deposit") +
                ":" + rs.getString("mbr_idcrm") +
                ":" + rs.getString("mbr_idcrm_valid") +
                ":" + rs.getString("mbr_segmentation") +                
                ":"+ sku_kode;
    }
    
    
    
    
// println(query);
    out.println(data);
} catch (Exception e) {
    e.printStackTrace();
}
%>