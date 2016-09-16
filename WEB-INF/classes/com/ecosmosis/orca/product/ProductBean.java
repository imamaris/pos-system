// Decompiled by Yody
// File : ProductBean.class

package com.ecosmosis.orca.product;

import com.ecosmosis.mvc.bean.MvcBean;
import com.ecosmosis.orca.pricing.product.ProductPricingBean;
import com.ecosmosis.orca.product.category.ProductCategoryBean;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.orca.product:
//            ProductDescriptionBean

public class ProductBean extends MvcBean
{

    private int productID;
    private int catID;
    private String productCode;    
    private String skuCode;
    private int productIGN;
    private String defaultName;
    private String defaultDesc;
    private String type;
    private String producttype;
    private String productseries;    
    private String productSelling;    
    private String uom;
    private double delivetyFactor;
    private String inventory;
    private String register;
    private int safeLevel;
    private int priorityLevel;
    private String imgPath;
    private String status;
    private double baseValue;
    private double baseBV1;
    private double baseBV2;
    private double baseBV3;
    private double baseBV4;
    private double baseBV5;
    private ArrayList ProductDescList;
    private String Locale;
    private String Name;
    private String Description;
    private ArrayList ProductItemList;
    private int seq;
    private int subProductID;
    private int orderSeq;
    private int qtySale;
    private int qtyFoc;
    private int inventoryBalance;
    private int permanentPricingCount;
    private int promotinalPricingCount;
    private int qtyOnHand;
    private ArrayList productItemBeanList;
    private ArrayList permanentPricingList;
    private ArrayList promotionPricingList;
    private ProductCategoryBean productCategory;
    private ProductDescriptionBean productDescription;
    private ProductPricingBean currentPricing;
    private ProductPricingBean latestPermanentPricing;
    private ProductPricingBean latestPromotionPricing;

    public ProductBean()
    {
        inventoryBalance = 0;
        permanentPricingCount = 0;
        promotinalPricingCount = 0;
        qtyOnHand = 0;
    }

    public double getBaseBV1()
    {
        return baseBV1;
    }

    public void setBaseBV1(double baseBV1)
    {
        this.baseBV1 = baseBV1;
    }

    public double getBaseBV2()
    {
        return baseBV2;
    }

    public void setBaseBV2(double baseBV2)
    {
        this.baseBV2 = baseBV2;
    }

    public double getBaseBV3()
    {
        return baseBV3;
    }

    public void setBaseBV3(double baseBV3)
    {
        this.baseBV3 = baseBV3;
    }

    public double getBaseBV4()
    {
        return baseBV4;
    }

    public void setBaseBV4(double baseBV4)
    {
        this.baseBV4 = baseBV4;
    }

    public double getBaseBV5()
    {
        return baseBV5;
    }

    public void setBaseBV5(double baseBV5)
    {
        this.baseBV5 = baseBV5;
    }

    public double getBaseValue()
    {
        return baseValue;
    }

    public void setBaseValue(double baseValue)
    {
        this.baseValue = baseValue;
    }

    public int getCatID()
    {
        return catID;
    }

    public void setCatID(int catID)
    {
        this.catID = catID;
    }

    public double getDelivetyFactor()
    {
        return delivetyFactor;
    }

    public void setDelivetyFactor(double delivetyFactor)
    {
        this.delivetyFactor = delivetyFactor;
    }

    public String getImgPath()
    {
        return imgPath;
    }

    public void setImgPath(String imgPath)
    {
        this.imgPath = imgPath;
    }

    public String getInventory()
    {
        return inventory;
    }

    public void setInventory(String inventory)
    {
        this.inventory = inventory;
    }

    public int getPriorityLevel()
    {
        return priorityLevel;
    }

    public void setPriorityLevel(int priorityLevel)
    {
        this.priorityLevel = priorityLevel;
    }

    public String getProductCode()
    {
        return productCode;
    }

    public void setProductCode(String productCode)
    {
        this.productCode = productCode;
    }

    public int getProductID()
    {
        return productID;
    }

    public void setProductID(int productID)
    {
        this.productID = productID;
    }

    public int getProductIGN()
    {
        return productIGN;
    }

    public void setProductIGN(int productIGN)
    {
        this.productIGN = productIGN;
    }
    
    
    public int getSafeLevel()
    {
        return safeLevel;
    }

    public void setSafeLevel(int safeLevel)
    {
        this.safeLevel = safeLevel;
    }

    public String getSkuCode()
    {
        return skuCode;
    }

    public void setSkuCode(String skuCode)
    {
        this.skuCode = skuCode;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getUom()
    {
        return uom;
    }

    public void setUom(String uom)
    {
        this.uom = uom;
    }

    public String getDescription()
    {
        return Description;
    }

    public void setDescription(String description)
    {
        Description = description;
    }

    public String getLocale()
    {
        return Locale;
    }

    public void setLocale(String locale)
    {
        Locale = locale;
    }

    public String getName()
    {
        return Name;
    }

    public void setName(String name)
    {
        Name = name;
    }

    public int getOrderSeq()
    {
        return orderSeq;
    }

    public void setOrderSeq(int orderSeq)
    {
        this.orderSeq = orderSeq;
    }

    public int getQtyFoc()
    {
        return qtyFoc;
    }

    public void setQtyFoc(int qtyFoc)
    {
        this.qtyFoc = qtyFoc;
    }

    public int getQtySale()
    {
        return qtySale;
    }

    public void setQtySale(int qtySale)
    {
        this.qtySale = qtySale;
    }

    public int getSeq()
    {
        return seq;
    }

    public void setSeq(int seq)
    {
        this.seq = seq;
    }

    public int getSubProductID()
    {
        return subProductID;
    }

    public void setSubProductID(int subProductID)
    {
        this.subProductID = subProductID;
    }

    public String getDefaultDesc()
    {
        return defaultDesc;
    }

    public void setDefaultDesc(String defaultDesc)
    {
        this.defaultDesc = defaultDesc;
    }

    public String getDefaultName()
    {
        return defaultName;
    }

    public void setDefaultName(String defaultName)
    {
        this.defaultName = defaultName;
    }

    public String getRegister()
    {
        return register;
    }

    public void setRegister(String register)
    {
        this.register = register;
    }

    public String getProductSelling() {
        return productSelling;
    }

    public void setProductSelling(String productSelling) {
        this.productSelling = productSelling;
    }
    
    public String getProducttype() {
        return producttype;
    }

    
    public void setProducttype(String producttype) {
        this.producttype = producttype;
    }

    
    public String getProductseries() {
        return productseries;
    }

    public void setProductseries(String productseries) {
        this.productseries = productseries;
    }
    
    public ArrayList getProductDescList()
    {
        if(ProductDescList == null)
            ProductDescList = new ArrayList();
        return ProductDescList;
    }

    public ArrayList getProductItemList()
    {
        if(ProductItemList == null)
            ProductItemList = new ArrayList();
        return ProductItemList;
    }

    public ArrayList getProductItemBeanList()
    {
        return productItemBeanList;
    }

    public void setProductItemBeanList(ArrayList productItemBeanList)
    {
        this.productItemBeanList = productItemBeanList;
    }

    public ProductCategoryBean getProductCategory()
    {
        return productCategory;
    }

    public void setProductCategory(ProductCategoryBean productCategory)
    {
        this.productCategory = productCategory;
    }

    public ProductDescriptionBean getProductDescription()
    {
        return productDescription;
    }

    public void setProductDescription(ProductDescriptionBean productDescription)
    {
        this.productDescription = productDescription;
    }

    public ProductPricingBean getLatestPermanentPricing()
    {
        return latestPermanentPricing;
    }

    public ProductPricingBean getCurrentPricing()
    {
        return currentPricing;
    }

    public void setCurrentPricing(ProductPricingBean currentPricing)
    {
        this.currentPricing = currentPricing;
    }

    public void setLatestPermanentPricing(ProductPricingBean latestPermanentPricing)
    {
        this.latestPermanentPricing = latestPermanentPricing;
    }

    public ProductPricingBean getLatestPromotionPricing()
    {
        return latestPromotionPricing;
    }

    public void setLatestPromotionPricing(ProductPricingBean latestPromotionPricing)
    {
        this.latestPromotionPricing = latestPromotionPricing;
    }

    public ArrayList getPermanentPricingList()
    {
        return permanentPricingList;
    }

    public void setPermanentPricingList(ArrayList permanentPricingList)
    {
        this.permanentPricingList = permanentPricingList;
    }

    public ArrayList getPromotionPricingList()
    {
        return promotionPricingList;
    }

    public void setPromotionPricingList(ArrayList promotionPricingList)
    {
        this.promotionPricingList = promotionPricingList;
    }

    public int getInventoryBalance()
    {
        return inventoryBalance;
    }

    public void setInventoryBalance(int inventoryBalance)
    {
        this.inventoryBalance = inventoryBalance;
    }

    public int getPermanentPricingCount()
    {
        if(permanentPricingList != null && permanentPricingList.isEmpty())
            return permanentPricingList.size();
        else
            return permanentPricingCount;
    }

    public void setPermanentPricingCount(int permanentPricingCount)
    {
        this.permanentPricingCount = permanentPricingCount;
    }

    public int getPromotinalPricingCount()
    {
        if(promotionPricingList != null && promotionPricingList.isEmpty())
            return promotionPricingList.size();
        else
            return promotinalPricingCount;
    }

    public void setPromotinalPricingCount(int promotinalPricingCount)
    {
        this.promotinalPricingCount = promotinalPricingCount;
    }

    public int getQtyOnHand()
    {
        return qtyOnHand;
    }

    public void setQtyOnHand(int qtyOnHand)
    {
        this.qtyOnHand = qtyOnHand;
    }

    public void chkProductInfo()
    {
        ProductCategoryBean cat = getProductCategory();
        if(cat.getName() == null)
            cat.setName(cat.getDefaultMsg());
        ProductDescriptionBean desc = getProductDescription();
        if(desc.getName() == null)
            desc.setName(getDefaultName());
        if(desc.getDescription() == null)
            desc.setDescription(getDefaultDesc());
    }

    protected void parseProductBean(ResultSet rs)
        throws SQLException
    {
        parseProductBean(rs, "");
    }

    protected void parseProductBean(ResultSet rs, String prefix)
        throws SQLException
    {
        String empty = "";
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_productid").toString()));
        setProductCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_productcode").toString()));
        setSkuCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_skucode").toString()));
        setDefaultName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_name").toString()));
        setDefaultDesc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_desc").toString()));
        setCatID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_catid").toString()));
        setType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_type").toString()));           
        setProducttype(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_producttype").toString()));
        setProductseries(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_productseries").toString()));
        setProductSelling(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_selling").toString()));        
        
        setUom(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_uom").toString()));
        setSafeLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_safe_level").toString()));
        setPriorityLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_priority_level").toString()));
        setBaseValue(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("pmp_basevalue").toString()));
        setQtySale(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pip_qty_sales").toString()));
        String descid = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_productid").toString());
        if(descid != null)
        {
            String name = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_name").toString());
            String desc = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_desc").toString());
            if(name.equals(""))
                name = empty;
            if(desc.equals(""))
                desc = empty;
            setName(name);
            setDescription(desc);
        } else
        {
            setName(empty);
            setDescription(empty);
        }
        String status = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_status").toString());
        if(status.equalsIgnoreCase("A"))
            setStatus("Active");
        else
            setStatus("Inactive");
        
        String inventory = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_inventory").toString());
        if(inventory.equalsIgnoreCase("Y"))
            setInventory("Yes");
        else
            setInventory("No");        
        
        String register = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_register").toString());
        if(register.equalsIgnoreCase("Y"))
            setRegister("Yes");
        else
            setRegister("No");
    }

    protected void parseComboSubProductBean(ResultSet rs)
        throws SQLException
    {
        parseComboSubProductBean(rs, "");
    }

    protected void parseComboSubProductBean(ResultSet rs, String prefix)
        throws SQLException
    {
        String empty = "";
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_productid").toString()));
        setCatID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_catid").toString()));
        setSkuCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_skucode").toString()));
        setDefaultName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_name").toString()));
        setDefaultDesc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_desc").toString()));
        setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_status").toString()));
        setType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_type").toString()));
        
        setProducttype(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_producttype").toString()));
        setProductseries(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_productseries").toString()));
        setProductSelling(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_selling").toString()));
        
        setUom(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_uom").toString()));
        setInventory(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_inventory").toString()));
        setRegister(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_register").toString()));
        setSafeLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_safe_level").toString()));
        setPriorityLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_priority_level").toString()));
        setSubProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pip_subproductid").toString()));
        setQtySale(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pip_qty_sales").toString()));
        setLocale(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_locale").toString()));
        String locale_name = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_name").toString());
        if(locale_name != null)
        {
            String name = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_name").toString());
            String desc = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_desc").toString());
            if(name.equals(""))
                name = empty;
            if(desc.equals(""))
                desc = empty;
            setName(name);
            setDescription(desc);
        } else
        {
            setName(empty);
            setDescription(empty);
        }
    }

    protected void parseComboProductBean(ResultSet rs)
        throws SQLException
    {
        parseComboProductBean(rs, "");
    }

    protected void parseComboProductBean(ResultSet rs, String prefix)
        throws SQLException
    {
        String empty = "--";
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_productid").toString()));
        setProductIGN(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_ign").toString()));
        setCatID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_catid").toString()));
        setSkuCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_skucode").toString()));
        setDefaultName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_name").toString()));
        setDefaultDesc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_desc").toString()));
        setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_status").toString()));
        setType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_type").toString()));
        
        setProducttype(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_producttype").toString()));
        setProductseries(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_productseries").toString()));
        setProductSelling(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_selling").toString()));        
        
        setUom(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_uom").toString()));
        setInventory(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_inventory").toString()));
        setRegister(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_register").toString()));
        setSafeLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_safe_level").toString()));
        setPriorityLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_priority_level").toString()));
        setLocale(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_locale").toString()));
        String locale_name = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_name").toString());
        if(locale_name != null)
        {
            String name = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_name").toString());
            String desc = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pdp_desc").toString());
            if(name.equals(""))
                name = empty;
            if(desc.equals(""))
                desc = empty;
            setName(name);
            setDescription(desc);
        } else
        {
            setName(empty);
            setDescription(empty);
        }
    }

    protected void parseSingleProductBean(ResultSet rs)
        throws SQLException
    {
        parseSingleProductBean(rs, "");
    }

    protected void parseSingleProductBean(ResultSet rs, String prefix)
        throws SQLException
    {
        //2010-01-27
        setCatID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_catid").toString()));
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_productid").toString()));
        setProductIGN(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_ign").toString()));
        setProductCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_productcode").toString()));
        setSkuCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_skucode").toString()));
        setUom(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_uom").toString()));
        setSafeLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_safe_level").toString()));
        setPriorityLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_priority_level").toString()));
        setBaseValue(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("pmp_basevalue").toString()));
        setDefaultName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_name").toString()));
        setDefaultDesc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_desc").toString()));
        String localemsg = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pcd_name").toString());
        if(localemsg != null && localemsg.length() > 0)
            setName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pcd_name").toString()));
        else
            setName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pcp_default_msg").toString()));
        String type = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_type").toString());
        if(type.equalsIgnoreCase("C"))
            setType("Combo");
        else
            setType("Single");
        setProducttype(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_producttype").toString()));
        setProductseries(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_productseries").toString()));
        setProductSelling(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_selling").toString()));
        
        String status = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_status").toString());
        if(status.equalsIgnoreCase("A"))
            setStatus("Active");
        else
            setStatus("Inactive");
        
        String inventory = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_inventory").toString());
        if(inventory.equalsIgnoreCase("Y"))
            setInventory("Yes");
        else
            setInventory("No");
        
        String register = rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_register").toString());
        if(register.equalsIgnoreCase("Y"))
            setRegister("Yes");
        else
            setRegister("No");
    }

    public void parseBean(ResultSet rs)
        throws SQLException
    {
        parseBean(rs, "");
    }

    public void parseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_productid").toString()));
        setProductIGN(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_ign").toString()));
        setCatID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_catid").toString()));
        setProductCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_productcode").toString()));
        setSkuCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_skucode").toString()));
        setDefaultName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_name").toString()));
        setDefaultDesc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_desc").toString()));
        setType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_type").toString()));
        
        setProducttype(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_producttype").toString()));
        
        setProductseries(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_productseries").toString()));
        
        setProductSelling(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_selling").toString()));        
        
        setUom(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_uom").toString()));
        setDelivetyFactor(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("pmp_delivery_factor").toString()));
        setInventory(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_inventory").toString()));
        setSafeLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_safe_level").toString()));
        setPriorityLevel(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_priority_level").toString()));
        setImgPath(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_img_path").toString()));
        setRegister(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_register").toString()));
        setBaseValue(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("pmp_basevalue").toString()));
        setBaseBV1(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("pmp_basebv1").toString()));
        setBaseBV2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("pmp_basebv2").toString()));
        setBaseBV3(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("pmp_basebv3").toString()));
        setBaseBV4(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("pmp_basebv4").toString()));
        setBaseBV5(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("pmp_basebv5").toString()));
        setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_status").toString()));
    }

}
