<%@ page import="java.sql.*"  %> 
<%

System.out.println("Ke KIT  sinikeh 1 index ");

String sku_kode = request.getParameter("sku_kode").toString();
String lokasi = request.getParameter("lokasi").toString();
String tanggal = request.getParameter("tanggal").toString();

System.out.println("Ke Kit 2 HE sinikeh 2 index "+lokasi+" kode "+sku_kode);
String  data ="";
String  data2 ="";

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
    
    
    System.out.println("hello KIT 2 ");
    
    conn = DriverManager.getConnection(url+dbName,userName,password);
    
    String query =  " SELECT b.pkt_code, b.pkt_desc, d.pmp_skucode, d.pmp_default_name, if(inventory.balance  is not null, inventory.balance, 0) as imbang " +
                    " FROM  product_master as a " +
                    " Left Join product_kit as b ON  a.pmp_kitid = b.pkt_id " +
                    " Left Join product_kit_item as c ON b.pkt_id = c.pki_id " +
                    " Left Join product_master as d ON d.pmp_productid = c.pki_productid " +
                    " Left Join product_category_desc as e ON b.pkt_cat = e.pcd_catid " +
                    " left join (select f.piv_productid, sum(f.piv_in) - sum(f.piv_out) as balance from product_inventory f  where f.piv_status = 100  and f.piv_trxdate <= ' "+tanggal+" '  and f.piv_owner = '"+lokasi+"' and  f.piv_trxtype NOT IN  ('SKLO', 'SKLI') group by f.piv_productid ) as inventory on inventory.piv_productid = d.pmp_productid " +
                    " where b.pkt_id > 1 and a.pmp_skucode = '"+sku_kode+"' order by  d.pmp_productseries  ";                    
        
    st = conn.createStatement();
    ResultSet  rs = st.executeQuery(query);
    
    System.out.println("Ke Kit 2 HE 3 index, query "+query);
    
    int nomor= 0;     
    while(rs.next()) {
        nomor = nomor+1;
        
        if (nomor ==1 )
        {    
        data = "~" + rs.getString("pkt_code") +      
                "~" + rs.getString("pkt_desc") +
                "~" + rs.getString("pmp_skucode") +  
                "~" + rs.getString("pmp_default_name") +
                "~"+ rs.getString("imbang") +    
                "~"+ sku_kode;  
         }else{
        
         data2 = rs.getString("pkt_code") +      
                "~" + rs.getString("pkt_desc") +
                "~" + rs.getString("pmp_skucode") +  
                "~" + rs.getString("pmp_default_name") +
                "~"+ rs.getString("imbang") +    
                "~"+ sku_kode;              
            
         }       
                
                
    }
	

    // println(query);   
 
    out.println(data.concat("~").concat(data2));
} catch (Exception e) {
    e.printStackTrace();
}
%>