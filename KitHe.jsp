<%@ page import="java.sql.*" %> 
<%

System.out.println("Ke KIT  sinikeh 1 index ");

String sku_kode = request.getParameter("sku_kode").toString();
String lokasi = request.getParameter("lokasi").toString();
String tanggal = request.getParameter("tanggal").toString();

System.out.println("Ke Kit HE sinikeh 2 index "+lokasi+" kode "+sku_kode);
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
    
    
    System.out.println("hello KIT");
    
    conn = DriverManager.getConnection(url+dbName,userName,password);
    
    String query = " SELECT product_kit.pkt_code, product_kit.pkt_desc, product_master.pmp_skucode, product_master.pmp_default_name, if(inventory.balance  is not null, inventory.balance, 0) as imbang " 
            " FROM product_kit " +
            " Left Join product_kit_item ON product_kit.pkt_id = product_kit_item.pki_id " +
            " Left Join product_master ON product_master.pmp_productid = product_kit_item.pki_productid " +
            " Left Join product_category_desc ON product_kit.pkt_cat = product_category_desc.pcd_catid " +
            " left join (select piv_productid, sum(piv_in) - sum(piv_out) as balance from product_inventory  where piv_status = 100  and piv_trxdate <= ' "+tanggal+" ' and piv_owner = '"+lokasi+"' group by piv_productid ) as inventory on inventory.piv_productid = product_master.pmp_productid " +
            " where product_kit.pkt_code = '"+sku_kode+"' ";
        
        
    st = conn.createStatement();
    ResultSet  rs = st.executeQuery(query);
    
    System.out.println("Ke Kit HE 3 index, query "+query);
    
    while(rs.next()) {
        
         System.out.println("Ke sinikeh KIT 4 index "+lokasi+" kode "+sku_kode);
        
        data = "~" + rs.getString("pkt_code") +      
                "~" + rs.getString("pkt_desc") +
                "~" + rs.getString("pmp_skucode") +  
                "~" + rs.getString("pmp_default_name") +
                "~"+ rs.getString("imbang") +    
                "~"+ sku_kode;        
    }
	

    // println(query);
    out.println(data);
} catch (Exception e) {
    e.printStackTrace();
}
%>