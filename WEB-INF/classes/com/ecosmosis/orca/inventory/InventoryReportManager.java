// Decompiled by Yody
// File : InventoryReportManager.class

package com.ecosmosis.orca.inventory;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.orca.outlet.OutletBean;
import com.ecosmosis.orca.outlet.OutletManager;
import com.ecosmosis.orca.outlet.store.OutletStoreBean;
import com.ecosmosis.orca.outlet.store.OutletStoreManager;
import com.ecosmosis.orca.product.ProductBean;
import com.ecosmosis.orca.product.ProductManager;
import com.ecosmosis.orca.product.category.ProductCategoryBean;
import com.ecosmosis.orca.stockist.StockistManager;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.orca.inventory:
//            InventoryReportBroker, InventoryBean, StockMovementRptBean

public class InventoryReportManager extends DBTransactionManager {
    
    public static final int TASKID_RPT_MOVEMENT = 0x19199;
    public static final int TASKID_RPT_TRX = 0x1919a;
    
    public static final int TASKID_RPT_TRX_TW = 0x18e9c;
    
    public static final int TASKID_VIEW_INVENTORY = 0x1919c;
    public static final int TASKID_RPT_MOVEMENT_INV = 0x1919d;
    public static final int TASKID_RPT_TRX_INV = 0x1919e;
    public static final int TASKID_VIEW_INVENTORY_INV = 0x1919f;
    public static final int TASKID_RPT_TRX_USR = 0x318f9;
    public static final int TASKID_VIEW_INVENTORY_USR = 0x318fa;
    
    public static final String RETURN_SELLERLIST_CODE = "SellerList";
    public static final String RETURN_STATUS_PRODUCT  = "ProductStatus";
    public static final String RETURN_STATUS_TW       = "TransactionStatus";
    
    private InventoryReportBroker broker;
    
    public InventoryReportManager() {
        broker = null;
    }
    
    public InventoryReportManager(Connection _con) {
        super(_con);
        broker = null;
    }
    
    private InventoryReportBroker getBroker(Connection conn) {
        if(broker == null)
            broker = new InventoryReportBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginuser) {
        setLoginUser(loginuser);
        MvcReturnBean returnBean = null;
        try {
            switch(taskId) {
                default:
                    break;
                    
                case 102809:
                {
                    // String id = null;
                    boolean isOutlet = false;
                    // boolean isOutlet = true;
                    returnBean = new MvcReturnBean();
                    Date dateFrom = null;
                    Date dateTo = null;                   
                    Date dNow = new Date();
                    SimpleDateFormat ft = new SimpleDateFormat("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
                    String id  = request.getParameter("id");
                    String product  = request.getParameter("product");
                    String prodStatus  = request.getParameter("prodStatus");
                    String prodDesc  = request.getParameter("productDesc");
                    String prodType  = request.getParameter("prodType");
                    String brand  = request.getParameter("brand");
                    
                    if(product == null)
                        product = "";
                    if(brand == null)
                        brand = "";
                    if(prodStatus == null)
                        prodStatus = "";                    
                    if(prodDesc == null)
                        prodDesc = "";
                    if(prodType == null)
                        prodType = "";

                    // System.out.println(" 1. product "+ product+ " brand "+brand + " product Desc "+ productDesc + " Prod Status "+prodStatus);
                    
                    Locale currentLocale = getLoginUser().getLocale();
                    String LocaleStr = currentLocale.toString();
                    returnBean.addReturnObject("CatList", getList(LocaleStr));
                    returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
                    returnBean.addReturnObject("ProductStatus", getMapForProductStatus());
                    
                    // if(request.getParameter("id") != null && request.getParameter("id").length() > 0)
                    if(id != null && id.length() > 0) {
                        id = request.getParameter("id");
                        if(request.getParameter("fromDate").length() > 0)
                            dateFrom = Sys.parseDate(request.getParameter("fromDate"));
                        if(request.getParameter("toDate").length() > 0)
                            dateTo = Sys.parseDate(request.getParameter("toDate"));
                        
                        System.out.println("0. masuk sini mas bro ");
                    }
                    
                    if(id == null)
                        break;
                    
                    OutletManager outletManager = new OutletManager();
                    OutletStoreManager storeManager = new OutletStoreManager();
                    OutletStoreBean storeBeans[] = (OutletStoreBean[])null;
                    OutletBean outletBean = outletManager.getRecord(id);
                    
                    if(outletBean == null) {
                        OutletStoreBean storeBean = storeManager.getOutletStore(id);
                        if(storeBean != null)
                            outletBean = outletManager.getRecord(storeBean.getOutletID());
                        storeBeans = new OutletStoreBean[1];
                        storeBeans[0] = storeBean;
                    } else {
                        storeBeans = storeManager.getStoreListByOutlet(id);
                        isOutlet = true;
                    }
                    
                    
                    System.out.println("1. masuk sini 1 mas bro ");
                    
                    if(outletBean != null && storeBeans != null) {
                        System.out.println("1. Mulai viewStoreInventory, waktu : " + ft.format(dNow));
                        //StockMovementRptBean reportBean = getStockMovementReport(getLoginUser().getLocale(), outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo);
                        StockMovementRptBean reportBean = getStockMovementReport(getLoginUser().getLocale(), outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo, brand, product, prodDesc, prodType, prodStatus);
                        returnBean.done();
                        returnBean.addReturnObject("hasInventory", Boolean.valueOf(reportBean != null ));
                        returnBean.addReturnObject("ID", id);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, true));
                        returnBean.addReturnObject("MovementReport", reportBean);
                        
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                
                case 102810:
                {
                    String id = null;
                    boolean isOutlet = false;
                    returnBean = new MvcReturnBean();
                    Date dateFrom = null;
                    Date dateTo = null;
                    if(request.getParameter("id") != null && request.getParameter("id").length() > 0) {
                        id = request.getParameter("id");
                        if(request.getParameter("fromDate").length() > 0)
                            dateFrom = Sys.parseDate(request.getParameter("fromDate"));
                        if(request.getParameter("toDate").length() > 0)
                            dateTo = Sys.parseDate(request.getParameter("toDate"));
                    } else {
                        id = getLoginUser().getOutletID();
                        Calendar startCal = Calendar.getInstance();
                        startCal.setTime(new Date());
                        
                        for (int i = 1; i < 7; i++) {
                            startCal.add(Calendar.DAY_OF_MONTH, -1);
                            
                            /* If not Saturday & Sunday
                                while (startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
                                {
                                    startCal.add(Calendar.DAY_OF_MONTH, -1);
                                }
                            */
                        }
                        
                        String awal = Sys.getDateFormater().format(startCal.getTime());                        
                        System.out.println("Nilai awal "+awal);
                        // dateFrom = new Date();
                        dateFrom = startCal.getTime();
                        dateTo = new Date();
                    }
                    if(id == null)
                        break;
                    OutletManager outletManager = new OutletManager();
                    OutletStoreManager storeManager = new OutletStoreManager();
                    OutletStoreBean storeBeans[] = (OutletStoreBean[])null;
                    OutletBean outletBean = outletManager.getRecord(id);
                    if(outletBean == null) {
                        OutletStoreBean storeBean = storeManager.getOutletStore(id);
                        if(storeBean != null)
                            outletBean = outletManager.getRecord(storeBean.getOutletID());
                        storeBeans = new OutletStoreBean[1];
                        storeBeans[0] = storeBean;
                    } else {
                        storeBeans = storeManager.getStoreListByOutlet(id);
                        isOutlet = true;
                    }
                    if(outletBean != null && storeBeans != null) {
                        InventoryBean  beans[] = viewInventoryTrx(outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo);
                        // InventoryBean _beans[] = viewInventoryTrxAllocate(outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo);
                        
                        returnBean.done();
                        returnBean.addReturnObject("hasInventory", Boolean.valueOf(beans != null && beans.length > 0));
                        returnBean.addReturnObject("ID", id);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, true));
                        returnBean.addReturnObject("InventoryBeans", beans);
                        // returnBean.addReturnObject("InventoryBeans", (taskId == 0x18e9c) ? _beans : beans);
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                
                case 203001:
                {
                    String id = null;
                    boolean isOutlet = false;
                    returnBean = new MvcReturnBean();
                    Date dateFrom = null;
                    Date dateTo = null;
                    if(request.getParameter("id") != null && request.getParameter("id").length() > 0) {
                        id = request.getParameter("id");
                        if(request.getParameter("fromDate").length() > 0)
                            dateFrom = Sys.parseDate(request.getParameter("fromDate"));
                        if(request.getParameter("toDate").length() > 0)
                            dateTo = Sys.parseDate(request.getParameter("toDate"));
                    } else {
                        id = getLoginUser().getOutletID();
                        Calendar startCal = Calendar.getInstance();
                        startCal.setTime(new Date());
                        
                        for (int i = 1; i < 7; i++) {
                            startCal.add(Calendar.DAY_OF_MONTH, -1);
                            
                            /* If not Saturday & Sunday
                                while (startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
                                {
                                    startCal.add(Calendar.DAY_OF_MONTH, -1);
                                }
                            */
                        }
                        
                        String awal = Sys.getDateFormater().format(startCal.getTime());                        
                        System.out.println("Nilai awal "+awal);
                        // dateFrom = new Date();
                        dateFrom = startCal.getTime();
                        dateTo = new Date();
                    }
                    if(id == null)
                        break;
                    OutletManager outletManager = new OutletManager();
                    OutletStoreManager storeManager = new OutletStoreManager();
                    OutletStoreBean storeBeans[] = (OutletStoreBean[])null;
                    OutletBean outletBean = outletManager.getRecord(id);
                    if(outletBean == null) {
                        OutletStoreBean storeBean = storeManager.getOutletStore(id);
                        if(storeBean != null)
                            outletBean = outletManager.getRecord(storeBean.getOutletID());
                        storeBeans = new OutletStoreBean[1];
                        storeBeans[0] = storeBean;
                    } else {
                        storeBeans = storeManager.getStoreListByOutlet(id);
                        isOutlet = true;
                    }
                    if(outletBean != null && storeBeans != null) {
                        InventoryBean  beans[] = viewInventoryTrx(outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo);
                        // InventoryBean _beans[] = viewInventoryTrxAllocate(outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo);
                        
                        returnBean.done();
                        returnBean.addReturnObject("hasInventory", Boolean.valueOf(beans != null && beans.length > 0));
                        returnBean.addReturnObject("ID", id);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, true));
                        returnBean.addReturnObject("InventoryBeans", beans);
                        // returnBean.addReturnObject("InventoryBeans", (taskId == 0x18e9c) ? _beans : beans);
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                case 102044:
                {
                    String id = null;
                    boolean isOutlet = false;
                    returnBean = new MvcReturnBean();
                    Date dateFrom = null;
                    Date dateTo = null;
                    String transStatus  = request.getParameter("transStatus");
                    
                    if(transStatus == null)
                        transStatus = "";
                    
                    if(request.getParameter("id") != null && request.getParameter("id").length() > 0) {
                        id = request.getParameter("id");
                        if(request.getParameter("fromDate").length() > 0)
                            dateFrom = Sys.parseDate(request.getParameter("fromDate"));
                        if(request.getParameter("toDate").length() > 0)
                            dateTo = Sys.parseDate(request.getParameter("toDate"));
                    } else {
                        id = getLoginUser().getOutletID();
                        
                        Calendar startCal = Calendar.getInstance();
                        startCal.setTime(new Date());
                        
                        for (int i = 1; i < 60; i++) {
                            startCal.add(Calendar.DAY_OF_MONTH, -1);
                            
                            /* If not Saturday & Sunday
                                while (startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || startCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
                                {
                                    startCal.add(Calendar.DAY_OF_MONTH, -1);
                                }
                            */
                        }
                        
                        String awal = Sys.getDateFormater().format(startCal.getTime());                        
                        System.out.println("Nilai awal "+awal);
                        // dateFrom = new Date();
                        dateFrom = startCal.getTime();
                        dateTo = new Date();
                    }
                    
                    System.out.println("transStatus : "+transStatus);
                    
                    if(id == null)
                        break;
                    OutletManager outletManager = new OutletManager();
                    OutletStoreManager storeManager = new OutletStoreManager();
                    OutletStoreBean storeBeans[] = (OutletStoreBean[])null;
                    OutletBean outletBean = outletManager.getRecord(id);
                    if(outletBean == null) {
                        OutletStoreBean storeBean = storeManager.getOutletStore(id);
                        if(storeBean != null)
                            outletBean = outletManager.getRecord(storeBean.getOutletID());
                        storeBeans = new OutletStoreBean[1];
                        storeBeans[0] = storeBean;
                    } else {
                        storeBeans = storeManager.getStoreListByOutlet(id);
                        isOutlet = true;
                    }                    
                        
                    
                    if(outletBean != null && storeBeans != null) {
                        // InventoryBean  beans[] = viewInventoryTrx(outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo);
                        InventoryBean beans[] = viewInventoryTrxAllocate(outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo, transStatus);
                        
                        InventoryBean beans2[] = viewInventoryTrxVerifyIN(outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo);
                        
                        returnBean.done();
                        returnBean.addReturnObject("hasInventory", Boolean.valueOf(beans != null && beans.length > 0));
                        returnBean.addReturnObject("ID", id);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, true));
                        returnBean.addReturnObject("InventoryBeans", beans);
                        returnBean.addReturnObject("InventoryBeans2", beans2);
                        
                        returnBean.addReturnObject("TransactionStatus", getMapForTransactionStatus());
                        
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                case 102812:
                case 203002:
                {
                    // String id = null;
                    boolean isOutlet = false;
                    // boolean isOutlet = true;
                    returnBean = new MvcReturnBean();
                    Date dateFrom = null;
                    Date dateTo = null;
                    String fromTime = "00:00:01";
                    String toTime = "23:59:00";
                    String productDesc  = request.getParameter("productDesc");
                    String productType  = request.getParameter("productType");
                    Date dNow = new Date();
                    SimpleDateFormat ft = new SimpleDateFormat("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
                    String id  = request.getParameter("id");
                    String product  = request.getParameter("product");
                    String prodStatus  = request.getParameter("prodStatus");
                    String brand  = request.getParameter("brand");
                    String fromTime1 = request.getParameter("fromTime1");
                    String toTime1 = request.getParameter("toTime1");   
                    String fromTime2 = request.getParameter("fromTime2");
                    String toTime2 = request.getParameter("toTime2");   
                   
                   // di synch ga bisa detik 00 
                   fromTime = fromTime1 + ":"+ fromTime2 + ":01";
                   toTime = toTime1 + ":" + toTime2 + ":59";                    
                    
                    if(product == null)
                        product = "";
                    if(brand == null)
                        brand = "";
                    if(prodStatus == null)
                        prodStatus = "";
                    // System.out.println(" product "+ product+ " brand "+brand + "Status "+prodStatus+" fromTime ="+fromTime+" toTime = "+toTime);
                    
                    Locale currentLocale = getLoginUser().getLocale();
                    String LocaleStr = currentLocale.toString();
                    returnBean.addReturnObject("CatList", getList(LocaleStr));
                    returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
                    returnBean.addReturnObject("ProductStatus", getMapForProductStatus());
                    
                    // if(request.getParameter("id") != null && request.getParameter("id").length() > 0)
                    if(id != null && id.length() > 0) {
                        id = request.getParameter("id");
                        if(request.getParameter("fromDate").length() > 0)
                            dateFrom = Sys.parseDate(request.getParameter("fromDate"));
                        if(request.getParameter("toDate").length() > 0)
                            dateTo = Sys.parseDate(request.getParameter("toDate"));                                                
                        
                        System.out.println("0. masuk sini mas bro, fromTime="+fromTime+" toTime="+toTime);
                    }
                    
                    if(id == null)
                        break;
                    
                    OutletManager outletManager = new OutletManager();
                    OutletStoreManager storeManager = new OutletStoreManager();
                    OutletStoreBean storeBeans[] = (OutletStoreBean[])null;
                    OutletBean outletBean = outletManager.getRecord(id);
                    
                    if(outletBean == null) {
                        OutletStoreBean storeBean = storeManager.getOutletStore(id);
                        if(storeBean != null)
                            outletBean = outletManager.getRecord(storeBean.getOutletID());
                        storeBeans = new OutletStoreBean[1];
                        storeBeans[0] = storeBean;
                    } else {
                        storeBeans = storeManager.getStoreListByOutlet(id);
                        isOutlet = true;
                    }
                    
                    
                    System.out.println("1. masuk sini 1 mas bro ");
                    
                    if(outletBean != null && storeBeans != null) {
                        System.out.println("1. Mulai viewStoreInventory, waktu : " + ft.format(dNow));
                        InventoryBean beans[] = viewStoreInventoryUpdate(getLoginUser().getLocale(), outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo, brand, product, productDesc, productType, prodStatus, fromTime, toTime);
                        returnBean.done();
                        returnBean.addReturnObject("hasInventory", Boolean.valueOf(beans != null && beans.length > 0));
                        returnBean.addReturnObject("ID", id);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, true));
                        returnBean.addReturnObject("InventoryBeans", beans);
                        
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                case 102813:
                {
                    String stockistID = null;
                    returnBean = new MvcReturnBean();
                    Date dateFrom = null;
                    Date dateTo = null;
                    String fromTime = request.getParameter("fromTime");
                    String toTime = request.getParameter("toTime");
                        
                    if(request.getParameter("StockistID") != null && request.getParameter("StockistID").length() > 0) {
                        stockistID = request.getParameter("StockistID");
                        if(request.getParameter("fromDate").length() > 0)
                            dateFrom = Sys.parseDate(request.getParameter("fromDate"));
                        if(request.getParameter("toDate").length() > 0)
                            dateTo = Sys.parseDate(request.getParameter("toDate"));
                    }
                    if(stockistID == null)
                        break;
                    StockistManager stockistManager = new StockistManager();
                    stockistID = stockistManager.filterStockistID(stockistID);
                    com.ecosmosis.orca.stockist.StockistBean stockist = stockistManager.getStockist(null, stockistID, null);
                    if(stockist != null) {
                        // StockMovementRptBean reportBean = getStockMovementReport(getLoginUser().getLocale(), stockistID, null, dateFrom, dateTo);
                        String brand ="";
                        String product = "";
                        String prodDesc = "";
                        String prodStatus = "";
                        String prodType = "";
                        
                        StockMovementRptBean reportBean = getStockMovementReport(getLoginUser().getLocale(), stockistID, null, dateFrom, dateTo, brand, product, prodDesc, prodType, prodStatus);
                        returnBean.done();
                        returnBean.addReturnObject("hasInventory", Boolean.valueOf(reportBean != null));
                        returnBean.addReturnObject("ID", stockistID);
                        returnBean.addReturnObject("Outlet", stockist);
                        returnBean.addReturnObject("MovementReport", reportBean);
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                case 102814:
                {
                    String stockistID = null;
                    returnBean = new MvcReturnBean();
                    Date dateFrom = null;
                    Date dateTo = null;
                    if(request.getParameter("StockistID") != null && request.getParameter("StockistID").length() > 0) {
                        stockistID = request.getParameter("StockistID");
                        if(request.getParameter("fromDate").length() > 0)
                            dateFrom = Sys.parseDate(request.getParameter("fromDate"));
                        if(request.getParameter("toDate").length() > 0)
                            dateTo = Sys.parseDate(request.getParameter("toDate"));
                    }
                    if(stockistID == null)
                        break;
                    StockistManager stockistManager = new StockistManager();
                    stockistID = stockistManager.filterStockistID(stockistID);
                    com.ecosmosis.orca.stockist.StockistBean stockist = stockistManager.getStockist(null, stockistID, null);
                    if(stockist != null) {
                        InventoryBean beans[] = viewInventoryTrx(stockistID, null, dateFrom, dateTo);
                        returnBean.done();
                        returnBean.addReturnObject("hasInventory", Boolean.valueOf(beans != null && beans.length > 0));
                        returnBean.addReturnObject("Outlet", stockist);
                        returnBean.addReturnObject("InventoryBeans", beans);
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                case 102815:
                {
                    String stockistID = null;
                    returnBean = new MvcReturnBean();
                    Date dateFrom = null;
                    Date dateTo = null;
                    String fromTime = request.getParameter("fromTime");
                    String toTime = request.getParameter("toTime");
                    
                    if(request.getParameter("StockistID") != null && request.getParameter("StockistID").length() > 0) {
                        stockistID = request.getParameter("StockistID");
                        if(request.getParameter("fromDate").length() > 0)
                            dateFrom = Sys.parseDate(request.getParameter("fromDate"));
                        if(request.getParameter("toDate").length() > 0)
                            dateTo = Sys.parseDate(request.getParameter("toDate"));
                        
                        if(fromTime == null) fromTime = "00.00";
                        if(toTime == null) fromTime = "23.59";                        
                    }
                    if(stockistID == null)
                        break;
                    StockistManager stockistManager = new StockistManager();
                    stockistID = stockistManager.filterStockistID(stockistID);
                    com.ecosmosis.orca.stockist.StockistBean stockist = stockistManager.getStockist(null, stockistID, null);
                    if(stockist != null) {
                        InventoryBean beans[] = viewStoreInventory(getLoginUser().getLocale(), stockistID, null, dateFrom, dateTo, fromTime, toTime);
                        returnBean.done();
                        returnBean.addReturnObject("hasInventory", Boolean.valueOf(beans != null && beans.length > 0));
                        returnBean.addReturnObject("Outlet", stockist);
                        returnBean.addReturnObject("InventoryBeans", beans);
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
            }
        } catch(Exception e) {
            if(returnBean == null)
                returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        return returnBean;
    }
    
    private FIFOMap getStoreCodeOnlyList(OutletStoreBean stores[], boolean showDefault)
    throws Exception {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        for(int i = 0; i < stores.length; i++)
            maps.put(stores[i].getStoreID(), stores[i].getStoreID());
        
        return maps;
    }
    
    private InventoryBean[] viewStoreInventory(Locale locale, String ownerId, String storeCode, Date from, Date to, String fromTime, String toTime)
    throws Exception {
        InventoryBean beans[];
        ProductBean productBeans[];
        Connection conn;
        ArrayList list;
        list = new ArrayList();
        beans = (InventoryBean[])null;
        
        Date dNow1 = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
        
        // awal
        productBeans = (new ProductManager()).getProductFullList(locale.toString());
        
        // edit
        // productBeans = (new ProductManager()).getProductFullListNew(locale.toString(), ownerId);
        
        conn = null;
        if(productBeans == null || productBeans.length <= 0)
            //  break MISSING_BLOCK_LABEL_197;
            list = new ArrayList();
        try {
            conn = getConnection();
            for(int i = 0; i < productBeans.length; i++) {
                InventoryBean inventoryBean = getBroker(conn).viewStoreInventory(productBeans[i].getProductID(), productBeans[i].getProductCode(), ownerId, storeCode, from, to, fromTime, toTime);
                if(inventoryBean.getTotal() > 0 || productBeans[i].getInventory().equalsIgnoreCase("Y")) {
                    // list = new ArrayList();
                    inventoryBean.setProductBean(productBeans[i]);
                    list.add(inventoryBean);
                }
            }
            
            // System.out.println("1b. Locale, ownerId, storeCode, Date from, Date to" +locale+ " - " +ownerId + " - "+storeCode+" - "+from +" - "+to);
            
            
            if(!list.isEmpty())
                beans = (InventoryBean[])list.toArray(new InventoryBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        System.out.println("3. Selesai viewStoreInventory, waktu : "+ft.format(dNow1) );
        
        releaseConnection(conn);
        return beans;
    }
    
    // private InventoryBean[] viewStoreInventoryUpdate(Locale locale, String ownerId, String storeCode, Date from, Date to, String brand, String product, String prodStatus)
    
    private InventoryBean[] viewStoreInventoryUpdate(Locale locale, String ownerId, String storeCode, Date from, Date to, String brand, String product, String productDesc, String productType, String prodStatus, String fromTime, String toTime)
    throws Exception {
        InventoryBean beans[];
        ProductBean productBeans[];
        Connection conn;
        ArrayList list;
        list = new ArrayList();
        beans = (InventoryBean[])null;
        
        Date dNow1 = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
        
        // awal
        // productBeans = (new ProductManager()).getProductFullListUpdate(locale.toString(), brand, product, prodStatus);
        
        productBeans = (new ProductManager()).getProductFullListUpdate(locale.toString(), brand, product, productDesc, productType, prodStatus);
        // edit
        // productBeans = (new ProductManager()).getProductFullListNew(locale.toString(), ownerId);
        
        conn = null;
        if(productBeans == null || productBeans.length <= 0)
            list = new ArrayList();
        try {
            conn = getConnection();
            for(int i = 0; i < productBeans.length; i++) {
                InventoryBean inventoryBean = getBroker(conn).viewStoreInventory(productBeans[i].getProductID(), productBeans[i].getProductCode(), ownerId, storeCode, from, to, fromTime, toTime);
                if(inventoryBean.getTotal() > 0 || productBeans[i].getInventory().equalsIgnoreCase("Y")) {
                    // list = new ArrayList();
                    inventoryBean.setProductBean(productBeans[i]);
                    list.add(inventoryBean);
                }
            }
            
            // System.out.println("1b. Locale, ownerId, storeCode, Date from, Date to" +locale+ " - " +ownerId + " - "+storeCode+" - "+from +" - "+to);
            
            
            if(!list.isEmpty())
                beans = (InventoryBean[])list.toArray(new InventoryBean[0]);
        }
        
        catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        System.out.println("3. Selesai viewStoreInventory, waktu : "+ft.format(dNow1) );
        
        releaseConnection(conn);
        return beans;
    }
    
    private InventoryBean[] viewInventoryTrx(String ownerId, String storeCode, Date from, Date to)
    throws Exception {
        InventoryBean beans[];
        Connection conn;
        beans = new InventoryBean[0];
        conn = null;
        // ArrayList list = new ArrayList();
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).viewInventoryTrx(ownerId, storeCode, from, to);
            if(!list.isEmpty())
                beans = (InventoryBean[])list.toArray(new InventoryBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    private InventoryBean[] viewInventoryTrxAllocate(String ownerId, String storeCode, Date from, Date to, String transStatus)
    throws Exception {
        InventoryBean beans[];
        Connection conn;
        beans = new InventoryBean[0];
        conn = null;
        // ArrayList list = new ArrayList();
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).viewInventoryTrxAllocate(ownerId, storeCode, from, to, transStatus);
            if(!list.isEmpty())
                beans = (InventoryBean[])list.toArray(new InventoryBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    private InventoryBean[] viewInventoryTrxVerifyIN(String ownerId, String storeCode, Date from, Date to)
    throws Exception {
        InventoryBean beans[];
        Connection conn;
        beans = new InventoryBean[0];
        conn = null;
        // ArrayList list = new ArrayList();
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).viewInventoryTrxVerifyIN(ownerId, storeCode, from, to);
            if(!list.isEmpty())
                beans = (InventoryBean[])list.toArray(new InventoryBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    // public StockMovementRptBean getStockMovementReport(Locale locale, String ownerId, String storeCode, Date from, Date to)
    // InventoryBean beans[] = viewStoreInventoryUpdate(getLoginUser().getLocale(), outletBean.getOutletID(), isOutlet ? null : id, dateFrom, dateTo, brand, product, productDesc, prodStatus);
    public StockMovementRptBean getStockMovementReport(Locale locale, String ownerId, String storeCode, Date from, Date to, String brand, String product, String prodDesc, String productType, String prodStatus)
    throws Exception {
        StockMovementRptBean report;
        Connection conn;
        report = null;
        conn = null;
        try {
            conn = getConnection();
            // System.out.println(" 2. product "+ product+ " brand "+brand + " product Desc "+ prodDesc + " Prod Status "+prodStatus);

            ProductBean productlist[] = (new ProductManager()).getProductFullListUpdate(locale.toString(), brand, product, prodDesc, productType, prodStatus);
            // System.out.println(" Dah sampai di sini fren 1 ");
            report = getBroker(conn).getStockMovementByProduct(ownerId, storeCode, from, to, productlist);
            // System.out.println(" Dah sampai di sini fren 2 ");
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }

        releaseConnection(conn);
        return report;
    }
    
    protected ProductCategoryBean[] getList(String locale)
    throws MvcException {
        ProductCategoryBean clist[];
        Connection conn;
        clist = new ProductCategoryBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getProductCategoryList(locale);
            if(!list.isEmpty())
                clist = (ProductCategoryBean[])list.toArray(new ProductCategoryBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return clist;
    }
    
    private FIFOMap getMapForSalesOutletList()
    throws Exception {
        FIFOMap map;
        Connection conn;
        map = new FIFOMap();
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSalesOutletList();
            // map.put("", "Any");
            map.put("", "");
            for(int i = 0; i < list.size(); i++)
                map.put(list.get(i), list.get(i));
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return map;
    }
    
    private FIFOMap getMapForTransactionStatus()
    throws Exception {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put("TW", "Transfer Warehouse");
        map.put("SL", "Stock Loan");
        
        System.out.println("masuk TransactionStatus ");
        
        return map;
    }
    
    private FIFOMap getMapForProductStatus()
    throws Exception {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put("Y", "Selling");
        map.put("N", "Non Selling");
        
        System.out.println("masuk ProductStatus ");
        
        return map;
    }
    
}