// Decompiled by Yody
// File : ProductPricingManager.class

package com.ecosmosis.orca.pricing.product;

import com.ecosmosis.common.currency.CurrencyRateBean;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.orca.pricing.PriceCodeManager;
import com.ecosmosis.orca.product.ProductBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.orca.pricing.product:
//            ProductPricingBroker, ProductPricingBean

public class ProductPricingManager extends DBTransactionManager {
    
    public static final int TASKID_PRICING_MANAGE_LISTING = 0x1a29d;
    public static final int TASKID_PRICING_MANAGE = 0x1a29f;
    public static final int TASKID_PRICING_LISTING = 0x1a29e;
    public static final int TASKID_PRICING_PROMOTIONAL_LISTING = 0x1a2a0;
    public static final int TASKID_PRICING_EDIT = 0x1a2a1;
    public static final String TYPE_PERMANENT = "N";
    public static final String TYPE_PROMOTIONAL = "Y";
    private ProductPricingBroker broker;
    
    public ProductPricingManager() {
        broker = null;
    }
    
    public ProductPricingManager(Connection conn) {
        super(conn);
        broker = null;
    }
    
    private ProductPricingBroker getBroker(Connection conn) {
        if(broker == null)
            broker = new ProductPricingBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginUser) {
        setLoginUser(loginUser);
        MvcReturnBean returnBean = null;
        boolean formSubmitted = request.getParameter("SubmitData") != null;
        try {
            switch(taskId) {
                default:
                    break;
                    
                case 107165:
                {
                    if(formSubmitted) {
                        String locale = loginUser.getLocale().toString();
                        String pricecode = request.getParameter("PriceCode");
                        Date date = Sys.parseDate(request.getParameter("Date"));
                        
                        // String jumlah = request.getParameter("Jumlah");
                        int jumlah = Integer.parseInt(request.getParameter("Jumlah"));
                        // returnBean = getManagePricingListing(pricecode, date, locale);
                        returnBean = getManagePricingListing(pricecode, date, locale, jumlah);
                    } else {
                        returnBean = getManagePricingPage();
                    }
                    break;
                }
                
                case 107167:
                {
                    String locale = loginUser.getLocale().toString();
                    if(request.getParameter("Type") != null && request.getParameter("Type").equalsIgnoreCase("edit")) {
                        String status = request.getParameter("Status");
                        String pricingid = request.getParameter("PriceID");
                        String pricecode = request.getParameter("PriceCode");
                        String productid = request.getParameter("ProductID");
                        String promotional = request.getParameter("Promotional");
                        boolean update = editProductPricing(pricingid, status, promotional);
                        if(update) {
                            returnBean = getManagePage(productid, pricecode, promotional, locale);
                        } else {
                            returnBean.fail();
                            returnBean.setSysMessage("Update Fail !!");
                        }
                        break;
                    }
                    if(request.getParameter("Type") != null && request.getParameter("Type").equalsIgnoreCase("add")) {
                        String productid = request.getParameter("ProductID");
                        String promotional = request.getParameter("Promotional");
                        String pricecode = request.getParameter("PriceCode");
                        ProductPricingBean bean = new ProductPricingBean();
                        parseAddBean(bean, request);
                        int count = checkExistPromotional(bean.getProductID(), bean.getPriceCode(), bean.getStartDate());
                        if(count > 0) {
                            returnBean.done();
                            returnBean.setSysMessage("Product Pricing is overlapped !!");
                            break;
                        }
                        boolean add = addProductPricing(bean);
                        if(add) {
                            returnBean = getManagePage(productid, pricecode, promotional, locale);
                        } else {
                            returnBean.fail();
                            returnBean.setSysMessage("Insert Fail !!");
                        }
                    } else {
                        String productid = request.getParameter("productid");
                        String pricecode = request.getParameter("pricecode");
                        String type = request.getParameter("type");
                        returnBean = getManagePage(productid, pricecode, type, locale);
                    }
                    break;
                }
                
                case 107168:
                {
                    String locale = loginUser.getLocale().toString();
                    String productid = request.getParameter("productid");
                    String type = request.getParameter("type");
                    String pricecode = request.getParameter("pricecode");
                    returnBean = getManagePage(productid, pricecode, type, locale);
                    break;
                }
                
                case 107166:
                {
                    if(formSubmitted) {
                        String locale = loginUser.getLocale().toString();                        
                        String pricecode = request.getParameter("PriceCode");
                        // String jumlah = request.getParameter("Jumlah");
                        int jumlah = Integer.parseInt(request.getParameter("Jumlah"));
                        
                        Date tanggal = new Date();                        
                        returnBean = getPricingListingPage(pricecode, tanggal, locale, jumlah);
                        // returnBean = getPricingListingPage(pricecode, tanggal, locale);
                        // returnBean = getPricingListingPage(pricecode, null, locale);
                        // returnBean = getPricingListingPageUpdate(pricecode, null, locale);
                    } else {
                        returnBean = getManagePricingPage();
                    }
                    break;
                }
            }
        } catch(Exception e) {
            returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        return returnBean;
    }
    
    public MvcReturnBean getManagePricingPage()
    throws Exception {
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        conn = getConnection();
        PriceCodeManager mgr = new PriceCodeManager(conn);
        com.ecosmosis.orca.pricing.PriceCodeBean beans[] = mgr.getActivePriceCodeList();
        returnBean.addReturnObject("PriceCodeList", beans);
        releaseConnection(conn);
        return returnBean;
    }
    
    public MvcReturnBean getManagePage(String productid, String pricecode, String type, String locale)
    throws Exception {
        MvcReturnBean returnBean = new MvcReturnBean();
        int intProductID = 0;
        if(productid != null)
            intProductID = Integer.parseInt(productid);
        ProductBean beans[] = getPricingHistory(pricecode, intProductID, type);
        ProductBean productBean = getProduct(productid, locale);
        returnBean.addReturnObject("PricingHistory", beans);
        returnBean.addReturnObject("Product", productBean);
        return returnBean;
    }
    
    public MvcReturnBean getManagePricingListing(String pricecode, Date date, String locale, int jumlah)
    throws Exception {
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        conn = getConnection();
        PriceCodeManager mgr = new PriceCodeManager(conn);
        com.ecosmosis.orca.pricing.PriceCodeBean beans[] = mgr.getActivePriceCodeList();
        returnBean.addReturnObject("PriceCodeList", beans);
        ProductBean pricingBeans[] = getProductPricingList(pricecode, date, locale, jumlah);
        returnBean.addReturnObject("ProductPricingList", pricingBeans);
        releaseConnection(conn);
        return returnBean;
    }
    
    public MvcReturnBean getManagePricingListingUpdate(String pricecode, Date date, String locale, int jumlah)
    throws Exception {
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        conn = getConnection();
        PriceCodeManager mgr = new PriceCodeManager(conn);
        com.ecosmosis.orca.pricing.PriceCodeBean beans[] = mgr.getActivePriceCodeList();
        returnBean.addReturnObject("PriceCodeList", beans);
        // ProductBean pricingBeans[] = getProductPricingList(pricecode, date, locale);
        ProductBean pricingBeans[] = getProductPricingList(pricecode, date, locale, jumlah);
        returnBean.addReturnObject("ProductPricingList", pricingBeans);
        releaseConnection(conn);
        return returnBean;
    }
    
    // public MvcReturnBean getPricingListingPage(String pricecode, Date date, String locale)
    public MvcReturnBean getPricingListingPage(String pricecode, Date date, String locale, int jumlah)
    throws Exception {
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        conn = getConnection();
        PriceCodeManager mgr = new PriceCodeManager(conn);
        com.ecosmosis.orca.pricing.PriceCodeBean beans[] = mgr.getActivePriceCodeList();
        returnBean.addReturnObject("PriceCodeList", beans);
        // ProductBean pricingBeans[] = getPricingListing(pricecode, date, locale);
        ProductBean pricingBeans[] = getPricingListing(pricecode, date, locale, jumlah);
        returnBean.addReturnObject("ProductPricingList", pricingBeans);
        releaseConnection(conn);
        return returnBean;
    }
    
    public ProductPricingBean getProductPricing(int productID, int pricingID)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getProductPricing(productID, pricingID);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public ProductPricingBean getProductPricingHE(String productID, int pricingID)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getProductPricingHE(productID, pricingID);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    
    public ProductBean[] getProductPricingList(String pricecode, Date date, String locale, int jumlah)
    throws MvcException {
        ProductBean productBean[];
        Connection conn;
        productBean = new ProductBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getProductPricingList(pricecode, date, locale, jumlah);
            if(!list.isEmpty()) {
                productBean = (ProductBean[])list.toArray(new ProductBean[0]);
                for(int i = 0; i < productBean.length; i++) {
                    // productBean[i].setLatestPermanentPricing(getActivePermanentPricing(productBean[i].getProductID(), pricecode));
                    productBean[i].setLatestPermanentPricing(getActivePermanentPricing(productBean[i].getProductCode(), pricecode));
                    productBean[i].setLatestPromotionPricing(getLatestPromotionalPricing(productBean[i].getProductCode(), pricecode));
                    productBean[i].setPromotinalPricingCount(getPromotionalPricingCount(productBean[i].getProductCode(), pricecode));
                    // awal productBean[i].setCurrentPricing(getCurrentPricing(productBean[i].getProductID(), pricecode, date));
                    productBean[i].setCurrentPricing(getCurrentPricing(productBean[i].getProductCode(), pricecode, date));
                }
                
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return productBean;
    }
    
    // public ProductBean[] getProductPricingListUpdate(String pricecode, Date date, String locale)    
    public ProductBean[] getProductPricingListUpdate(String pricecode, Date date, String locale, int jumlah)
    throws MvcException {
        ProductBean productBean[];
        Connection conn;
        productBean = new ProductBean[0];
        conn = null;
        try {
            conn = getConnection();
            // ArrayList list = getBroker(conn).getProductPricingList(pricecode, date, locale);
            ArrayList list = getBroker(conn).getProductPricingList(pricecode, date, locale, jumlah);
            if(!list.isEmpty()) {
                productBean = (ProductBean[])list.toArray(new ProductBean[0]);
                for(int i = 0; i < productBean.length; i++) {
                    // productBean[i].setLatestPermanentPricing(getActivePermanentPricing(productBean[i].getProductID(), pricecode));
                    productBean[i].setLatestPermanentPricing(getActivePermanentPricing(productBean[i].getProductCode(), pricecode));
                    productBean[i].setLatestPromotionPricing(getLatestPromotionalPricing(productBean[i].getProductCode(), pricecode));
                    productBean[i].setPromotinalPricingCount(getPromotionalPricingCount(productBean[i].getProductCode(), pricecode));
                    // awal productBean[i].setCurrentPricing(getCurrentPricing(productBean[i].getProductID(), pricecode, date));
                    productBean[i].setCurrentPricing(getCurrentPricing(productBean[i].getProductCode(), pricecode, date));
                }
                
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return productBean;
    }
    
    // public ProductBean[] getPricingListing(String pricecode, Date date, String locale)
    public ProductBean[] getPricingListing(String pricecode, Date date, String locale, int jumlah)
    throws MvcException {
        ProductBean productBean[];
        Connection conn;
        productBean = new ProductBean[0];
        conn = null;
        try {
            conn = getConnection();
            System.out.println("Proses getProductPricingList : ");
            Date dNow = new Date();
            SimpleDateFormat ft = new SimpleDateFormat("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
            System.out.println("Start : " + ft.format(dNow));
            // ArrayList list = getBroker(conn).getProductPricingList(pricecode, date, locale);
            ArrayList list = getBroker(conn).getProductPricingList(pricecode, date, locale, jumlah);
            // System.out.println("Akhir : "+date.getTime());
            if(!list.isEmpty()) {
                productBean = (ProductBean[])list.toArray(new ProductBean[0]);
                //chek waktu proses
                Date dNow1 = new Date( );
                System.out.println("LatestPermanentPricing :");
                System.out.println("Start : " + ft.format(dNow1));
                for(int i = 0; i < productBean.length; i++) {
                    productBean[i].setLatestPermanentPricing(getActivePermanentPricing(productBean[i].getProductCode(), pricecode));
                    System.out.println("No. "+i+ " Product Code :"+ productBean[i].getProductCode() + " Price : " + productBean[i].getLatestPermanentPricing().getPrice());
                }
                
                Date dNow2 = new Date( );
                System.out.println("End : " + ft.format(dNow2));
                
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return productBean;
    }
    
   /*
    public ProductPricingBean getActivePermanentPricingAwal(int productid, String pricecode)
        throws MvcException
    {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getActivePermanentPricing(productid, pricecode);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    */
    
    public ProductPricingBean getActivePermanentPricing(String productcode, String pricecode)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getActivePermanentPricing(productcode, pricecode);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public ProductPricingBean getActivePermanentPricingUpdate(String productcode, String pricecode, String lokasi)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getActivePermanentPricingUpdate(productcode, pricecode, lokasi);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public ProductPricingBean getLatestPromotionalPricing(String productid, String pricecode)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            // awal bean = getBroker(conn).getLatestPromotionalPricing(productid, pricecode);
            bean = getBroker(conn).getLatestPromotionalPricing(productid, pricecode);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    
    public ProductPricingBean getCurrentPricing(String productCode, String priceCodeID, Date effectiveDate)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            //awal
            // bean = getBroker(conn).getCurrentPricing(productID, priceCodeID, effectiveDate);
            bean = getBroker(conn).getCurrentPricing(productCode, priceCodeID, effectiveDate);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public int getPromotionalPricingCount(String productid, String pricecode)
    throws MvcException {
        int promotionalCount;
        Connection conn;
        promotionalCount = 0;
        conn = null;
        try {
            conn = getConnection();
            // awal promotionalCount = getBroker(conn).getPromotionalPricingCount(productid, pricecode);
            promotionalCount = getBroker(conn).getPromotionalPricingCount(productid, pricecode);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return promotionalCount;
    }
    
    public ProductBean[] getPricingHistory(String pricecode, int productID, String type)
    throws MvcException {
        ProductBean pricingBeans[];
        Connection conn;
        pricingBeans = new ProductBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getPricingHistory(pricecode, productID, type);
            if(!list.isEmpty())
                pricingBeans = (ProductBean[])list.toArray(new ProductBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return pricingBeans;
    }
    
    public ProductBean[] getPricingHistory(String pricecode, String type)
    throws MvcException {
        ProductBean pricingBeans[];
        Connection conn;
        pricingBeans = new ProductBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getPricingHistory(pricecode, type);
            if(!list.isEmpty())
                pricingBeans = (ProductBean[])list.toArray(new ProductBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return pricingBeans;
    }
    
    public ProductBean getProduct(String productid, String locale)
    throws MvcException {
        ProductBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getProduct(productid, locale);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public boolean editProductPricing(String pricingid, String status, String promotional)
    throws Exception {
        MvcReturnBean returnBean;
        Connection conn;
        boolean succ;
        returnBean = new MvcReturnBean();
        conn = null;
        succ = false;
        try {
            ProductPricingBean bean = new ProductPricingBean();
            bean.setPricingID(Integer.parseInt(pricingid));
            bean.setStatus(status);
            bean.setPromotional(promotional);
            if(pricingid != null || pricingid.length() > 0) {
                conn = getConnection();
                succ = getBroker(conn).updateProductPricing(bean);
            }
        } catch(Exception e) {
            Log.error(e);
            returnBean.setSysError(e.getMessage());
        }
        releaseConnection(conn);
        return succ;
    }
    
    public boolean addProductPricing(ProductPricingBean bean)
    throws Exception {
        MvcReturnBean returnBean;
        Connection conn;
        boolean succ;
        returnBean = new MvcReturnBean();
        conn = null;
        succ = false;
        try {
            conn = getConnection();
            succ = getBroker(conn).addProductPricing(bean);
        } catch(Exception e) {
            Log.error(e);
            returnBean.setSysError(e.getMessage());
        }
        releaseConnection(conn);
        return succ;
    }
    
    public int checkExistPromotional(int productid, String pricecode, Date startDate)
    throws Exception {
        MvcReturnBean returnBean;
        Connection conn;
        int promotionCount;
        returnBean = new MvcReturnBean();
        conn = null;
        promotionCount = 0;
        try {
            conn = getConnection();
            promotionCount = getBroker(conn).checkExistPromotional(productid, pricecode, startDate);
        } catch(Exception e) {
            Log.error(e);
            returnBean.setSysError(e.getMessage());
        }
        releaseConnection(conn);
        return promotionCount;
    }
    
    private void parseAddBean(ProductPricingBean bean, HttpServletRequest req)
    throws Exception {
        String temp = "-1";
        double bv = Double.parseDouble(temp);
        String bv1Str = req.getParameter("BV1");
        String bv2Str = req.getParameter("BV2");
        String bv3Str = req.getParameter("BV3");
        String bv4Str = req.getParameter("BV4");
        String bv5Str = req.getParameter("BV5");
        double bv1 = 0.0D;
        double bv2 = 0.0D;
        double bv3 = 0.0D;
        double bv4 = 0.0D;
        double bv5 = 0.0D;
        bean.setPriceCode(req.getParameter("PriceCode"));
        bean.setProductID(Integer.parseInt(req.getParameter("ProductID")));
        bean.setPromotional(req.getParameter("Promotional"));
        bean.setStatus(req.getParameter("Status"));
        bean.setStartDate(Sys.parseDate(req.getParameter("StartDate")));
        bean.setEndDate(Sys.parseDate(req.getParameter("EndDate")));
        double price = 0.0D;
        try {
            price = Double.parseDouble(req.getParameter("Price"));
        } catch(NumberFormatException numberformatexception) { }
        bean.setPrice(price);
        double tax = 0.0D;
        try {
            tax = Double.parseDouble(req.getParameter("Tax"));
        } catch(NumberFormatException numberformatexception1) { }
        bean.setTax(tax);
        if(bv1Str != null && bv1Str.length() > 0) {
            try {
                bv1 = Double.parseDouble(req.getParameter("BV1"));
            } catch(NumberFormatException numberformatexception2) { }
            bean.setBv1(bv1);
        } else {
            bean.setBv1(bv);
        }
        if(bv2Str != null && bv2Str.length() > 0) {
            try {
                bv2 = Double.parseDouble(req.getParameter("BV2"));
            } catch(NumberFormatException numberformatexception3) { }
            bean.setBv2(bv2);
        } else {
            bean.setBv2(bv);
        }
        if(bv3Str != null && bv3Str.length() > 0) {
            try {
                bv3 = Double.parseDouble(req.getParameter("BV3"));
            } catch(NumberFormatException numberformatexception4) { }
            bean.setBv3(bv3);
        } else {
            bean.setBv3(bv);
        }
        if(bv4Str != null && bv4Str.length() > 0) {
            try {
                bv4 = Double.parseDouble(req.getParameter("BV4"));
            } catch(NumberFormatException numberformatexception5) { }
            bean.setBv4(bv4);
        } else {
            bean.setBv4(bv);
        }
        if(bv5Str != null && bv5Str.length() > 0) {
            try {
                bv5 = Double.parseDouble(req.getParameter("BV5"));
            } catch(NumberFormatException numberformatexception6) { }
            bean.setBv5(bv5);
        } else {
            bean.setBv5(bv);
        }
    }
    
    public ProductPricingBean getIdProductPricing(int productID)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getIdProductPricing(productID);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public ProductPricingBean getIdProductPricingUpdate(int productID, String tanggal, String lokasi)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getIdProductPricingUpdate(productID, tanggal, lokasi);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
        
    public ProductPricingBean getIdProductPricingUpdateHE(String productID, String tanggal, java.util.Date waktu, String lokasi)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getIdProductPricingUpdateHE(productID, tanggal, waktu, lokasi);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    
    public ProductPricingBean getIdProductPricingUpdateHEForce(String productID, String tanggal, java.util.Date waktu,  String lokasi)
    throws MvcException {
        ProductPricingBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getIdProductPricingUpdateHEForce(productID, tanggal, waktu, lokasi);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    
    public CurrencyRateBean getRateUpdate(String tanggal)
    throws MvcException {
        CurrencyRateBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getRateUpdate(tanggal);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public CurrencyRateBean getRateUpdate2(String tanggal)
    throws MvcException {
        CurrencyRateBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getRateUpdate2(tanggal);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    //Updated By Ferdi 2015-06-18
    public double getCurrentSGDRate()
    throws Exception {
        MvcReturnBean returnBean;
        Connection conn;
        double rate;
        returnBean = new MvcReturnBean();
        conn = null;
        rate = 0d;
        try {
            conn = getConnection();
            rate = getBroker(conn).getCurrentSGDRate();
        } catch(Exception e) {
            Log.error(e);
            returnBean.setSysError(e.getMessage());
        }
        releaseConnection(conn);
        return rate;
    }
    //End Updated

    public CurrencyRateBean getRateMultiCurrency(String currencyid)
    throws MvcException {
        CurrencyRateBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getRateMultiCurrency(currencyid);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
}
