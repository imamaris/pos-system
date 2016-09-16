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
    
    
    String query = " SELECT product_master.pmp_productid, product_master.pmp_catid, product_master.pmp_skucode, product_master.pmp_productcode, replace(product_master.pmp_default_desc,': ','= ') as  pmp_default_desc, product_category_desc.pcd_name, product_pricing.ppi_price * (1 - (product_pricing.ppi_bv1)) as ppi_price, product_pricing.ppi_pricingid,(product_pricing.ppi_bv1 * 100) as disc, product_pricing.ppi_price * (1 - (product_pricing.ppi_bv1)) as endprice, if(inventory.balance  is not null, inventory.balance, 0) as imbang, product_kit.pkt_code " +
            "FROM product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale= 'en_US'  " +
            "left join product_category on pmp_catid = pcp_catid " +
            "left join product_category_desc on pmp_catid = pcd_catid and pcd_locale= 'en_US' " +
            "left join product_pricing on pmp_productcode = ppi_productcode " +
            "left join product_kit on pmp_kitid= product_kit.pkt_id " +
            "left join (select piv_productid, sum(piv_in) - sum(piv_out) as balance from product_inventory  where piv_status = 100  and piv_trxdate <= '"+tanggal+"' and piv_owner = '"+lokasi+"'   group by piv_productid ) as inventory on inventory.piv_productid = product_master.pmp_productid " + 
            "where pmp_status='A' and ppi_pricecode='RTL' and ppi_startdate <= ' "+tanggal+" ' and ppi_enddate >= ' "+tanggal+"' and pmp_skucode= '"+sku_kode+"' order by product_pricing.std_createdate DESC limit 1  ";        

    st = conn.createStatement();
    ResultSet  rs = st.executeQuery(query);
    
    System.out.println("Ke sinikeh 3 index, query "+query);
    
    while(rs.next()) {
        
         System.out.println("Ke sinikeh 4 index "+lokasi+" kode "+sku_kode);
        
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
    }
	

    // println(query);
    out.println(data);
} catch (Exception e) {
    e.printStackTrace();
}
%>