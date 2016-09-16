<%@ page import="java.sql.*" %> 
<%

// System.out.println("Ke sinikeh 1 index ");

String sku_kode = request.getParameter("sku_kode").toString();
String lokasi = request.getParameter("lokasi").toString();
String tanggal = request.getParameter("tanggal").toString();

System.out.println("Ke sinikeh 2 index "+lokasi+" kode "+sku_kode);
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
    
    
    String query = " update product_inventory " +
            "set piv_status = 100" +
            "where piv_trxdocno=' "+sku_kode+" ' ";        

    st = conn.createStatement();
    // ResultSet  rs = st.executeQuery(query);   
    
    System.out.println("Ke sinikeh 3 index, query "+query);
    
    st.executeUpdate(query);
    st.close(query);            
    
    /*
    while(rs.next()) {
                 
        System.out.println("Ke sinikeh 4 index "+lokasi+" kode "+sku_kode);                       
        /*
        data = "~" + rs.getString("pmp_productid") +      
                "~" + rs.getString("pmp_catid") +
                "~" + rs.getString("pmp_default_desc") +  
                "~" + rs.getString("pcd_name") +
                "~" + rs.getString("ppi_price") +
                "~"+ rs.getString("pmp_productcode") +
                "~"+ rs.getString("ppi_pricingid") +
                "~"+ rs.getString("disc") +
                "~"+ rs.getString("endprice") +    
                "~"+ rs.getString("imbang") +   
                "~"+ rs.getString("pkt_code") +   
                "~"+ sku_kode;     
       */
    }
    */

    // println(query);
    // out.println(data);
    
} catch (Exception e) {
    e.printStackTrace();
}
%>