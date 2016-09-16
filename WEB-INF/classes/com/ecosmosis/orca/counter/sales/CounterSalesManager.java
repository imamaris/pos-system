// Decompiled by Yody
// File : CounterSalesManager.class

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.common.currency.Currency;
import com.ecosmosis.common.currency.CurrencyBean;
import com.ecosmosis.common.currency.CurrencyRateBean;
import com.ecosmosis.common.currency.CurrencyRateManager;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.common.staff.StaffBean;

import com.ecosmosis.common.sysparameters.SystemParameters;
import com.ecosmosis.common.sysparameters.SystemParametersBean;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.orca.bean.AddressBean;
import com.ecosmosis.orca.bonus.bonusperiod.BonusPeriodBean;
import com.ecosmosis.orca.bonus.bonusperiod.BonusPeriodManager;
import com.ecosmosis.orca.bvwallet.BvWalletBean;
import com.ecosmosis.orca.bvwallet.BvWalletManager;
import com.ecosmosis.orca.document.DocumentFactory;
import com.ecosmosis.orca.document.DocumentInterface;
import com.ecosmosis.orca.inventory.InventoryBean;
import com.ecosmosis.orca.inventory.InventoryManager_1;
import com.ecosmosis.orca.member.MemberBean;
import com.ecosmosis.orca.member.MemberManager;
import com.ecosmosis.orca.outlet.OutletBean;
import com.ecosmosis.orca.outlet.OutletManager;
import com.ecosmosis.orca.outlet.paymentmode.OutletPaymentModeBean;
import com.ecosmosis.orca.outlet.store.OutletStoreBean;
import com.ecosmosis.orca.outlet.store.OutletStoreManager;
import com.ecosmosis.orca.pricing.PriceCodeBean;
import com.ecosmosis.orca.pricing.PriceCodeManager;
import com.ecosmosis.orca.pricing.product.ProductPricingBean;
import com.ecosmosis.orca.pricing.product.ProductPricingManager;
import com.ecosmosis.orca.product.ProductBean;
import com.ecosmosis.orca.product.ProductItemBean;
import com.ecosmosis.orca.product.ProductManager;
import com.ecosmosis.orca.product.category.ProductCategoryBean;
import com.ecosmosis.orca.purchase.PurchaseItemBean;
import com.ecosmosis.orca.purchase.PurchaseManager;
import com.ecosmosis.orca.purchase.PurchaseOrderBean;
import com.ecosmosis.orca.purchase.PurchaseProductBean;
import com.ecosmosis.orca.qwallet.QuotaWalletBean;
import com.ecosmosis.orca.qwallet.QuotaWalletManager;
import com.ecosmosis.orca.salesman.SalesmanBean;
import com.ecosmosis.orca.salesman.SalesmanManager;
import com.ecosmosis.orca.stockist.StockistManager;
import com.ecosmosis.orca.util.UtilsManager;
import com.ecosmosis.util.http.RequestParser;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Time;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import java.util.Set;
import java.util.SortedSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            CounterSalesOrderBean, CounterSalesItemBean, CounterSalesProductBean, CounterSalesFormBean,
//            CounterSalesPaymentBean, DeliveryOrderBean, DeliveryItemBean, DeliveryProductBean,
//            CounterSalesBroker

public class CounterSalesManager extends DBTransactionManager {
    
    public static final int TASKID_MEMBER_SALES_PREFORM = 0x18a89;
    public static final int TASKID_MEMBER_SALES_FORM = 0x18a8a;
    
    public static final int TASKID_NORMAL_SALES_PREFORM = 0x18a8b;
    public static final int TASKID_NORMAL_SALES_FORM = 0x18a8c;
    public static final int TASKID_STAFF_SALES_PREFORM = 0x18a8d;
    public static final int TASKID_STAFF_SALES_FORM = 0x18a8e;
    
    public static final int TASKID_VIEW_SALES = 0x18a8f;
    
    public static final int TASKID_SALES_LIST_SUMMARY = 0x18a96;
    public static final int TASKID_SALES_LIST_DETAIL_PRODUCT = 0x18a95;
    
    public static final int TASKID_VIEW_SALES_TYPEII = 0x18aa5;
    public static final int TASKID_VIEW_SALES_TYPEIII = 0x18aa6;
    
    public static final int TASKID_SALES_LIST = 0x18a90;
    public static final int TASKID_SALES_LIST_DETAIL = 0x18a94;
    
    public static final int TASKID_SALES_LIST_RETURN = 0x18aba;
    public static final int TASKID_SALES_LIST_INVOICE_RETURN = 0x18abb;
    public static final int TASKID_SALES_LIST_REPRINT = 0x18abc;
    public static final int TASKID_SALES_LIST_VOID = 0x18abd;
    
    
    public static final int TASKID_SALES_LIST_TYPEII = 0x18aa3;
    public static final int TASKID_SALES_LIST_TYPEIII = 0x18aa4;
    public static final int TASKID_SALES_LIST_TYPES_PRINT = 0x18aab;
    public static final int TASKID_ADMIN_VOID_SALES = 0x18a91;
    public static final int TASKID_SUPER_VOID_SALES = 0x18a92;
    public static final int TASKID_MASTER_VOID_SALES = 0x18a93;
    public static final int TASKID_ADMIN_CANCEL_SALES = 0x18a94;
    public static final int TASKID_SUPER_CANCEL_SALES = 0x18a95;
    public static final int TASKID_MASTER_CANCEL_SALES = 0x18a96;
    public static final int TASKID_REFUND_SALES = 0x18a97;
    public static final int TASKID_REFUND_SALES_INVOICE = 0x18a98;
    
    // public static final int TASKID_EXCHANGE_SALES = 0x18a98;
    public static final int TASKID_STARTER_SALES_PREFORM = 0x18a99;
    public static final int TASKID_STARTER_SALES_FORM = 0x18a9a;
    public static final int TASKID_STOCKIST_SALES_PREFORM = 0x18a9b;
    public static final int TASKID_STOCKIST_SALES_FORM = 0x18a9c;
    
    public static final int TASKID_MOBILE_SALES_PREFORM = 0x18a2b;
    public static final int TASKID_MOBILE_SALES_FORM = 0x18a2c;
    
    public static final int TASKID_MEMBER_SALES_PREFORM_FULL_DELIVERY = 0x18a9d;
    public static final int TASKID_MEMBER_SALES_FORM_FULL_DELIVERY = 0x18a9e;
    
    public static final int TASKID_NORMAL_SALES_PREFORM_FULL_DELIVERY = 0x18a9f;
    public static final int TASKID_NORMAL_SALES_FORM_FULL_DELIVERY = 0x18aa0;
    
    public static final int TASKID_NORMAL_SALES_PREFORM_FULL_DELIVERY_HE = 0x18abe;
    public static final int TASKID_NORMAL_SALES_FORM_FULL_DELIVERY_HE = 0x1818abf;
    
    public static final int TASKID_NORMAL_SALES_PREFORM_FULL_DELIVERY_HE_FORCE = 0x18ac0;
    public static final int TASKID_NORMAL_SALES_FORM_FULL_DELIVERY_HE_FORCE = 0x18ac1;
    
    public static final int TASKID_NORMAL_SALES_PREFORM_FULL_DELIVERY_RETURN = 0x18aac;
    public static final int TASKID_NORMAL_SALES_FORM_FULL_DELIVERY_RETURN = 0x18aad;
    
    public static final int TASKID_NORMAL_SALES_FORM_FULL_DELIVERY_RETURN_HE = 0x18aaf;
    
    public static final int TASKID_STAFF_SALES_PREFORM_FULL_DELIVERY = 0x18aa1;
    public static final int TASKID_STAFF_SALES_FORM_FULL_DELIVERY = 0x18aa2;
    
    public static final int TASKID_ISSUE_DELIVERY_LIST = 0x18e71;
    public static final int TASKID_ISSUE_DELIVERY_FORM = 0x18e72;
    public static final int TASKID_DELIVERY_LIST = 0x18e73;
    public static final int TASKID_VIEW_DELIVERY = 0x18e74;
    public static final int TASKID_VOID_DELIVERY = 0x18e75;
    public static final int TASKID_SALES_DELIVERY_HISTORY = 0x18e76;
    
    public static final int TASKID_ISSUE_DELIVERY_FORM_AFTER_SALES = 0x18ac5;
    // 101040
    public static final int TASKID_DOC_CB = 0x18ab0;
    public static final int TASKID_DOC_CB_CARTIER = 0x18ab9;
    public static final int TASKID_DOC_CB_TYPEII = 0x18aa7;
    public static final int TASKID_DOC_CB_TYPEIII = 0x18aa8;
    public static final int TASKID_DOC_CGN = 0x18ab1;
    public static final int TASKID_DOC_TCGN = 0x18ab2;
    public static final int TASKID_DOC_CN = 0x18ab3;
    public static final int TASKID_DOC_DN = 0x18ab4;
    public static final int TASKID_DOC_DO = 0x18ab5;
    public static final int TASKID_DOC_GRN = 0x18ab6;
    public static final int TASKID_DOC_CB_RECEIPT = 0x18ab7;
    public static final int TASKID_DOC_CB_RECEIPT_TYPEII = 0x18aa9;
    public static final int TASKID_DOC_CB_RECEIPT_TYPEIII = 0x18aaa;
    public static final int TASKID_DOC_SALESDO = 0x18ab8;
    
    public static final int TASKID_ESTK_MEMBER_SALES_PREFORM = 0x320c9;
    public static final int TASKID_ESTK_MEMBER_SALES_FORM = 0x320ca;
    
    public static final int TASKID_ESTK_SALES_PREFORM_FULL_DELIVERY = 0x320ce;
    public static final int TASKID_ESTK_SALES_FORM_FULL_DELIVERY = 0x320cf;
    
    public static final int TASKID_ESTK_VIEW_SALES = 0x320cb;
    public static final int TASKID_ESTK_SALES_LIST = 0x320cc;
    public static final int TASKID_ESTK_VOID_SALES = 0x320cd;
    public static final int TASKID_ESTK_REFUND_SALES = 0x320ce;
    public static final int TASKID_ESTK_STARTER_SALES_PREFORM = 0x320cf;
    public static final int TASKID_ESTK_STARTER_SALES_FORM = 0x320d0;
    public static final int TASKID_ESTK_ISSUE_DELIVERY_LIST = 0x320fb;
    public static final int TASKID_ESTK_ISSUE_DELIVERY_FORM = 0x320fc;
    public static final int TASKID_ESTK_DELIVERY_LIST = 0x320fd;
    public static final int TASKID_ESTK_VIEW_DELIVERY = 0x320fe;
    public static final int TASKID_ESTK_VOID_DELIVERY = 0x320ff;
    public static final int TASKID_ESTK_SALES_DELIVERY_HISTORY = 0x32100;
    public static final int TASKID_ESTK_DOC_CB = 0x320dd;
    public static final int TASKID_ESTK_DOC_CN = 0x320de;
    public static final int TASKID_ESTK_DOC_DO = 0x320df;
    public static final int TASKID_ESTK_DOC_GRN = 0x320e0;
    public static final int TASKID_ESTK_DOC_CB_RECEIPT = 0x320e1;
    
    public static final int TASKID_ESTK_MOBILE_SALES_PREFORM = 0x320e2;
    public static final int TASKID_ESTK_MOBILE_SALES_FORM = 0x320e3;
    public static final int TASKID_ESTK_ISSUE_DELIVERY_FORM_AFTER_SALES = 0x320e4;
    public static final int TASKID_ESTK_MOBILE_VIEW_SALES = 0x320e5;
    
    public static final int TASKID_EMEMBER_SALES_LIST = 0x493ff;
    public static final int TASKID_EMEMBER_VIEW_SALES = 0x49400;
    public static final CounterSalesOrderBean EMPTY_SALES_ORDER_ARRAY[] = new CounterSalesOrderBean[0];
    public static final CounterSalesItemBean EMPTY_SALES_ITEM_ARRAY[] = new CounterSalesItemBean[0];
    public static final CounterSalesProductBean EMPTY_SALES_PRODUCT_ARRAY[] = new CounterSalesProductBean[0];
    public static final CounterSalesFormBean EMPTY_SALES_FORM_ARRAY[] = new CounterSalesFormBean[0];
    public static final CounterSalesPaymentBean EMPTY_SALES_PAYMENT_ARRAY[] = new CounterSalesPaymentBean[0];
    public static final DeliveryOrderBean EMPTY_DELIVERY_ORDER_ARRAY[] = new DeliveryOrderBean[0];
    public static final DeliveryItemBean EMPTY_DELIVERY_ITEM_ARRAY[] = new DeliveryItemBean[0];
    public static final DeliveryProductBean EMPTY_DELIVERY_PRODUCT_ARRAY[] = new DeliveryProductBean[0];
    public static final ProductPricingManager ppm = new ProductPricingManager();
    
    public static final CounterSalesOrderBeanDetail EMPTY_SALES_ORDER_ARRAY_DETAIL[] = new CounterSalesOrderBeanDetail[0];
    public static final CounterSalesOrderBeanSummaryProduct EMPTY_SALES_ORDER_ARRAY_SUMMARY_PRODUCT[] = new CounterSalesOrderBeanSummaryProduct[0];
    
    public static final String COUNTER_KEY = "C@8Jb#p985468";
    public static final String MOBILE_KEY = "C@8Jb#p985555";
    
    public static final String TYPE_OUTLET = "O";
    public static final String TYPE_STOCKIST = "S";
    public static final String TYPE_DISTRIBUTOR = "D";
    public static final String TYPE_NORMAL = "N";
    public static final String TRX_TYPE_MBR_SALES = "DS";
    public static final String TRX_TYPE_NORMAL_SALES = "NS";
    public static final String TRX_TYPE_STAFF_SALES = "WS";
    public static final String TRX_TYPE_STOCKIST_SALES = "SS";
    public static final int TRX_GRP_SALES = 10;
    public static final int TRX_GRP_CANCEL = 20;
    public static final int TRX_GRP_VOID = 30;
    public static final int TRX_GRP_REFUND = 40;
    public static final int TRX_GRP_EXCHANGE = 50;
    public static final int STATUS_PROC_UNPROCESSED = 0;
    public static final int STATUS_PROC_REVIEWED = 10;
    public static final int STATUS_PROC_INVOICED = 20;
    public static final int STATUS_DO_PENDING = 0;
    public static final int STATUS_DO_PARTIAL = 10;
    public static final int STATUS_DO_COMPLETED = 20;
    public static final int STATUS_ADJST = -10;
    public static final int STATUS_APPROVAL_PENDING = 10;
    public static final int STATUS_APPROVAL_REJECTED = 20;
    
    public static final int STATUS_ACTIVE = 30;
    public static final int STATUS_CANCELED = 40;
    public static final int STATUS_VOIDED = 50;
    public static final int STATUS_FULL_REFUNDED = 60;
    public static final int STATUS_PARTIAL_REFUNDED = 70;
    public static final int STATUS_FULL_EXCHANGED = 80;
    public static final int STATUS_PARTIAL_EXCHANGED = 90;
    
    public static final int DO_TRX_GRP_SALES_DO = 10;
    public static final int DO_TRX_GRP_SALES_CANCEL = 20;
    public static final int DO_TRX_GRP_SALES_VOID = 30;
    public static final int DO_TRX_GRP_SALES_REFUND = 40;
    public static final int DO_TRX_GRP_SALES_EXCHANGE = 50;
    public static final int DO_TRX_GRP_DO_VOID = 60;
    public static final int SHIP_OWN_PICKUP = 10;
    public static final int SHIP_TO_RECEIVER = 20;
    public static final String RETURN_SHOWRECS_CODE = "ShowRecords";
    public static final String RETURN_ORDERBY_CODE = "OrderBy";
    
    public static final String RETURN_TRXTYPELIST_CODE = "TrxTypeList";
    
    public static final String RETURN_TRXSELLERTYPELIST_CODE = "TrxSellerTypeList";
    public static final String RETURN_CATLIST_CODE = "CatList2";
    
    public static final String RETURN_SELLERLIST_CODE = "SellerList";
    public static final String RETURN_BNSPERIODLIST_CODE = "BonusPeriodList";
    // 2009-12-30
    public static final String RETURN_EXPEDITIONLIST_CODE = "ExpeditionList";
    public static final String RETURN_STAFFLIST_CODE = "StaffList";
    
    public static final String RETURN_CFIMBNSPERIODLIST_CODE = "ConfirmBonusPeriodList";
    public static final String RETURN_DELIVERYSTATUS_CODE = "DeliveryStatusList";
    public static final String RETURN_DELIVERYSTATUS_CODE2 = "DeliveryStatusList2";
    
    public static final String RETURN_STATUS_CODE = "StatusList";
    public static final String RETURN_STATUS_CODE2 = "StatusList2";
    
    public static final String RETURN_SALESLIST_CODE = "SalesList";
    // 2010-07-22
    public static final String RETURN_SALESLIST_CODE_DETAIL = "SalesListDetail";
    // Peter
    public static final String RETURN_SALESLIST_CODE_PRODUCT = "SalesListSummary";
    public static final String RETURN_DELIVERYLIST_CODE = "DeliveryList";
    
    //Senja Summary Sales Report
    public static final String RETURN_SUMMARYREPORT_CODE="SummarySalesReport";
    public static final String RETURN_SUMMARYREPORT_DETAIL="SummaryReportDetail";
    public static final int SUMMARY_SALES_REPORT_ID = 101806;
    
    public static final String RETURN_SUMMARY_REPORT_PAYMENT="SummaryReportPayment";
    public static final String RETURN_SUMMARY_REPORT_PAYMENT_DETAIL="SummaryReportPaymentDetail";
    public static final int RETURN_SUMMARY_REPORT_PAYMENT_ID = 101807;
    
    public static final String RETURN_SUMMARY_REPORT_BRAND_CATEGORY = "SummaryReportBrandCategory";
    public static final String RETURN_SUMMARY_REPORT_BRAND_CATEGORY_DETAIL = "SummaryReportBrandCategoryDetail";
    public static final int RETURN_SUMMARY_REPORT_BRAND_ID = 101808;
    
    public static final String RETURN_SUMMARY_SALES_RETURN_BRAND = "SummarySalesReturnReportByBrand";
    public static final String RETURN_SUMMARY_SALES_RETURN_BRAND_DETAIL = "SummarySalesReturnReportByBrandDetail";
    public static final int RETURN_SUMMARY_SALES_RETURN_REPORT_ID = 101809;
    
    private CounterSalesBroker broker;
    private InventoryManager_1 invMgr;
    private BvWalletBean chekBonusDate;
    
    
    public CounterSalesManager() {
        broker = null;
        invMgr = null;
    }
    
    public CounterSalesManager(Connection conn) {
        super(conn);
        broker = null;
        invMgr = null;
    }
    
    private CounterSalesBroker getBroker(Connection conn) {
        if(broker == null)
            broker = new CounterSalesBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
    public static CounterSalesOrderBean getSalesInfoFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        
        System.out.println("Trap 2 : getSalesInfoFromSession ");
        
        CounterSalesOrderBean sales = (CounterSalesOrderBean)session.getAttribute("C@8Jb#p985468");
        if(sales == null) {
            sales = new CounterSalesOrderBean();
            session.setAttribute("C@8Jb#p985468", sales);
            
            System.out.println("Trap 2a : getSalesInfoFromSession ");
        }
        
        System.out.println("Trap 2b : getSalesInfoFromSession ");
        // System.out.println("getSalesInfoFromSession, sales.getServiceAgentID " + sales.getServiceAgentID());
        return sales;
    }
    
    public String defineTaskTitle(int taskID) {
        String taskTitle = "";
        switch(taskID) {
            case 101001:
            case 101002:
            case 205001:
            case 205002:
                taskTitle = "Customer Sales";
                break;
                
            case 101021:
            case 101022:
            case 205006:
            case 205007:
                taskTitle = "Supermarket > Customer Sales";
                break;
                
            case 101003:
            case 101004:
                taskTitle = "Retailer Sales";
                break;
                
            case 101023:
                
            case 101036:
                
            case 101024:
                // he
            case 101054:
            case 101055:
                
            case 101056:
            case 101057:
                
            case 101058:
            case 101059:                
                taskTitle = "Supermarket > Retailer Sales";
                break;
                
            case 101005:
            case 101006:
                taskTitle = "Staff Sales";
                break;
                
            case 101025:
            case 101026:
                taskTitle = "Supermarket > Staff Sales";
                break;
                
            case 101019:
            case 101020:
                taskTitle = "Stockist Sales";
                break;
                
            case 205026:
            case 205027:
                taskTitle = "Mobile Sales";
                break;
                
            case 101806: //mila
                taskTitle = "Summary Sales Report by Brand";
                break;
        }
        return taskTitle;
    }
    
    
    
    private FIFOMap getStaff(boolean showAny, String branch)
    throws Exception {
        FIFOMap map;
        Connection conn;
        map = new FIFOMap();
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getStaffList(branch);
            if(showAny)
                map.put("", "Any");
            for(int i = 0; i < list.size(); i++)
                map.put(list.get(i), list.get(i));
            
            System.out.println("Size " + list.size());
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        
        releaseConnection(conn);
        return map;
    }
    
    /*
    private FIFOMap getSales(String branch)
    throws Exception {
        FIFOMap map;
        Connection conn;
        map = new FIFOMap();
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSalesList(branch);
            // if(showAny)
            //    map.put("", "Any");
     
            for(int i = 0; i < list.size(); i++)
                map.put(list.get(i), list.get(i));
     
            System.out.println("Size " + list.size());
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
     
     
        releaseConnection(conn);
        return map;
    }
     */
    
    public static String defineTrxGroupName(int trxGroup) {
        String name = "";
        switch(trxGroup) {
            case 10: // '\n'
                name = "Sales";
                break;
                
            case 30: // '\036'
                name = "Void";
                break;
                
            case 40: // '('
                name = "Return";
                break;
                
            case 50: // '2'
                name = "Exchange";
                break;
        }
        return name;
    }
    
    public static String defineTrxTypeName(String trxType) {
        if(trxType == null)
            return "";
        String name = "";
        if(trxType.equalsIgnoreCase("DS"))
            name = "Distributor Sales";
        else
            if(trxType.equalsIgnoreCase("NS"))
                name = "Retailer Sales";
            else
                if(trxType.equalsIgnoreCase("WS"))
                    name = "Staff Sales";
        return name;
    }
    
    public static String defineTrxStatusName(int trxStatus) {
        String name = "-";
        switch(trxStatus) {
            case 30: // '\036'
                name = "Active";
                break;
                
            case 50: // '2'
                name = "Voided";
                break;
                
            case 60: // '<'
                name = "Return";
                break;
        }
        return name;
    }
    
    public static String defineDeliveryStatusName(int doStatus) {
        String name = "";
        switch(doStatus) {
            case 0: // '\0'
                name = "Pending";
                break;
                
            case 10: // '\n'
                name = "Partial";
                break;
                
            case 20: // '\024'
                name = "Completed";
                break;
        }
        return name;
    }
    
    public static String defineShippingOptionName(int shipOption) {
        String desc = "-";
        if(shipOption == 10)
            desc = "Pick up stock at Outlet";
        else
            if(shipOption == 20)
                desc = "Shipping to Receiver";
        return desc;
    }
    
    public String definePriceCodeType(int taskID) {
        String priceCodeType = "";
        switch(taskID) {
            case 101001:
            case 101017:
            case 101019:
            case 205026:
            case 101021:
            case 205001:
            case 205006:
                priceCodeType = "D";
                break;
                
            case 101003:
            case 101023:
                
            case 101036:
                //he
            case 101054:
            case 101056:
            case 101058:
                
                priceCodeType = "R";
                break;
                
            case 101005:
            case 101025:
                priceCodeType = "S";
                break;
        }
        return priceCodeType;
    }
    
    
    // for staff
    private StaffBean[] getStaffListForSales(StaffBean fullList[], String staffName)
    throws Exception {
        ArrayList list = new ArrayList();
        if(fullList.length > 0) {
            for(int i = 0; i < fullList.length; i++)
                if(fullList[i].getName().equalsIgnoreCase(staffName))
                    list.add(fullList[i]);
            
        }
        return (StaffBean[])list.toArray(new StaffBean[0]);
    }
    
    
    // for staff
    private SalesmanBean[] getSalesListForSales(SalesmanBean fullList[], String salesName)
    throws Exception {
        ArrayList list = new ArrayList();
        if(fullList.length > 0) {
            for(int i = 0; i < fullList.length; i++)
                if(fullList[i].getName().equalsIgnoreCase(salesName))
                    list.add(fullList[i]);
            
        }
        return (SalesmanBean[])list.toArray(new SalesmanBean[0]);
    }
    
    private FIFOMap getMapForRecords(boolean showDefault)
    throws Exception {
        String records = "records";
        FIFOMap map = new FIFOMap();
        if(showDefault)
            map.put("", "");
        map.put("50", (new StringBuilder("50 ")).append(records).toString());
        map.put("100", (new StringBuilder("100 ")).append(records).toString());
        map.put("200", (new StringBuilder("200 ")).append(records).toString());
        map.put("500", (new StringBuilder("500 ")).append(records).toString());
        map.put("1000", (new StringBuilder("1000 ")).append(records).toString());
        return map;
    }
    
    private FIFOMap getMapForSalesOrderBy(boolean isAdmin)
    throws Exception {
        FIFOMap maps = new FIFOMap();
        maps.put("cso_trxdate", "Trx Date");
        maps.put("cso_bonusdate", "Doc Date");
        maps.put("cso_bvsales_amt", "Gross");
        maps.put("cso_netsales_amt", "Net Total");
        maps.put("cso_trxdocno", "Sales Ref");
        if(isAdmin) {
            maps.put("cso_custid", "ID");
            maps.put("cso_cust_name", "Name");
        }
        return maps;
    }
    
    private FIFOMap getMapForDeliveryOrderBy()
    throws Exception {
        FIFOMap maps = new FIFOMap();
        maps.put("dod_trxdate", "Trx Date");
        maps.put("dod_trxdocno", "Delivery Ref");
        maps.put("dod_custid", "ID");
        maps.put("dod_cust_name", "Name");
        return maps;
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
            map.put("", "Any");
            // map.put("", "");
            for(int i = 0; i < list.size(); i++)
                map.put(list.get(i), list.get(i));
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return map;
    }
    
    private FIFOMap getMapForSalesOutletListForInventory()
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
    
    /*  private FIFOMap getMapForSalesBonusPeriod(boolean showAny)
        throws Exception
    {
        FIFOMap map;
        Connection conn;
        map = new FIFOMap();
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSalesBonusPeriodList();
            if(showAny)
                map.put("", "Any");
            for(int i = 0; i < list.size(); i++)
                map.put(list.get(i), list.get(i));
     
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
     
        releaseConnection(conn);
        return map;
    }
     */
    
    private FIFOMap getMapForSalesBonusPeriod(boolean showAny)
    throws Exception {
        FIFOMap map;
        Connection conn;
        map = new FIFOMap();
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSalesBonusPeriodList();
            if(showAny)
                map.put("", "Any");
            for(int i = 0; i < list.size(); i++)
                map.put(list.get(i), list.get(i));
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return map;
    }
    
    private ArrayList getConfirmedBonusPeriodList()
    throws Exception {
        ArrayList list;
        Connection conn;
        list = new ArrayList();
        conn = null;
        try {
            conn = getConnection();
            BonusPeriodBean beans[] = (new BonusPeriodManager(conn)).getAllConfirmedPeriod();
            for(int i = 0; i < beans.length; i++)
                list.add(beans[i].getPeriodID());
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return list;
    }
    
    private FIFOMap getMapForSalesTypes()
    throws Exception {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put("DS", "Distributor Sales");
        map.put("NS", "Retailer Sales");
        map.put("WS", "Staff Sales");
        map.put("SS", "Stockist Sales");
        return map;
    }
    
    private FIFOMap getMapForSalesStatus()
    throws Exception {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put(String.valueOf(30), "Active");
        map.put(String.valueOf(50), "Voided");
        map.put(String.valueOf(60), "Returned");
        return map;
    }
    
    private FIFOMap getMapForSalesDeliveryStatus()
    throws Exception {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put(String.valueOf(0), "Pending");
        map.put(String.valueOf(10), "Partial");
        map.put(String.valueOf(20), "Completed");
        return map;
    }
    
    private FIFOMap getMapForDeliveryStatus()
    throws Exception {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put(String.valueOf(30), "Active");
        map.put(String.valueOf(50), "Voided");
        return map;
    }
    
    public PriceCodeBean getPriceCode(String priceCode)
    throws Exception {
        PriceCodeBean priceCodeBean;
        Connection conn;
        priceCodeBean = null;
        conn = null;
        try {
            conn = getConnection();
            priceCodeBean = (new PriceCodeManager(conn)).getPriceCode(priceCode);
            if(priceCodeBean == null)
                throw new Exception((new StringBuilder("No Price Code found -> ")).append(priceCode).toString());
            CurrencyBean currencyBean = (CurrencyBean)Currency.getObject(priceCodeBean.getCurrency());
            if(currencyBean == null)
                throw new Exception((new StringBuilder("No Price Code Currency found -> ")).append(priceCodeBean.getCurrency()).toString());
            priceCodeBean.setCurrencyBean(currencyBean);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return priceCodeBean;
    }
    
    private SalesmanBean getSales(String id)
    throws Exception {
        SalesmanBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            /*
            SalesmanBean mgr = new SalesmanManager(conn);
            bean = mgr.getRecord(id);
            if(bean == null)
                throw new Exception((new StringBuilder("No Seller found -> ")).append(id).toString());
            if(!bean.getStatus().equalsIgnoreCase("A"))
                throw new Exception((new StringBuilder("Seller status is INACTIVE -> ")).append(id).toString());
            boolean isStockist = (new StockistManager(conn)).isStockist(bean.getOutletID());
            if(isStockist) {
                bean.setStockist(isStockist);
                bean.setPriceCodes(mgr.getPriceCode(bean.getHomeBranchID()));
            }
            if(bean.getPriceCodes().length <= 0)
                throw new Exception((new StringBuilder("No PriceCodesList found -> ")).append(id).toString());
             
             */
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    
    private OutletBean getSeller(String id)
    throws Exception {
        OutletBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            OutletManager mgr = new OutletManager(conn);
            bean = mgr.getRecord(id);
            if(bean == null)
                throw new Exception((new StringBuilder("No Seller found -> ")).append(id).toString());
            if(!bean.getStatus().equalsIgnoreCase("A"))
                throw new Exception((new StringBuilder("Seller status is INACTIVE -> ")).append(id).toString());
            boolean isStockist = (new StockistManager(conn)).isStockist(bean.getOutletID());
            if(isStockist) {
                bean.setStockist(isStockist);
                bean.setPriceCodes(mgr.getPriceCode(bean.getHomeBranchID()));
            }
            if(bean.getPriceCodes().length <= 0)
                throw new Exception((new StringBuilder("No PriceCodesList found -> ")).append(id).toString());
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    private OutletBean getStockist(String id)
    throws Exception {
        OutletBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            StockistManager mgr = new StockistManager(conn);
            id = mgr.filterStockistID(id);
            bean = (new OutletManager(conn)).getRecord(id);
            if(id == null)
                throw new Exception((new StringBuilder("No Stockist found -> ")).append(id).toString());
            if(!bean.getStatus().equalsIgnoreCase("A"))
                throw new Exception((new StringBuilder("Stockist status is INACTIVE -> ")).append(id).toString());
            // if(!bean.getType().equalsIgnoreCase("S"))
            //    throw new Exception((new StringBuilder("Stockist Type is not MOBILE STORE or FRANCHISE STORE -> ")).append(id).toString());
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return bean;
    }
    
    private OutletBean getMobile(String id)
    throws Exception {
        OutletBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            StockistManager mgr = new StockistManager(conn);
            id = mgr.filterStockistID(id);
            
            bean = (new OutletManager(conn)).getRecord(id);
            if(id == null)
                throw new Exception((new StringBuilder("No Stockist found -> ")).append(id).toString());
            if(!bean.getStatus().equalsIgnoreCase("A"))
                throw new Exception((new StringBuilder("Stockist status is INACTIVE -> ")).append(id).toString());
            if(bean.getType().equalsIgnoreCase("S"))
                throw new Exception((new StringBuilder("Stockist Type is not MOBILE STORE or FRANCHISE STORE -> ")).append(id).toString());
            System.out.println("Trap 11 : chek outletId " + bean.getOutletID()+" TypeID " + bean.getType());
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return bean;
    }
    
    
    private SalesmanBean getSalesman(String customerID, boolean bonusEarner)
    throws Exception {
        SalesmanBean buyer;
        Connection conn;
        String entity;
        buyer = null;
        conn = null;
        entity = bonusEarner ? "Bonus Earner" : "Salesman";
        try {
            conn = getConnection();
            buyer = (new SalesmanManager(conn)).getMemberByID(customerID, false);
            if(buyer == null)
                throw new Exception((new StringBuilder("No ")).append(entity).append(" found -> ").append(customerID).toString());
            if(buyer.getStatus() != 10)
                throw new Exception((new StringBuilder(String.valueOf(entity))).append(" status is INACTIVE -> ").append(customerID).toString());
            if(buyer.isHidden())
                throw new Exception((new StringBuilder(String.valueOf(entity))).append(" account is not valid for sales -> ").append(customerID).toString());
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return buyer;
    }
    
    
    private MemberBean getMember(String customerID, boolean bonusEarner)
    throws Exception {
        MemberBean buyer;
        Connection conn;
        String entity;
        buyer = null;
        conn = null;
        entity = bonusEarner ? "Bonus Earner" : "Customer";
        try {
            conn = getConnection();
            buyer = (new MemberManager(conn)).getMemberByID(customerID, false);
            
            if(buyer == null)
                throw new Exception((new StringBuilder("No ")).append(entity).append(" found -> ").append(customerID).toString());
            if(buyer.getStatus() != 10)
                throw new Exception((new StringBuilder(String.valueOf(entity))).append(" status is INACTIVE -> ").append(customerID).toString());
            if(buyer.isHidden())
                throw new Exception((new StringBuilder(String.valueOf(entity))).append(" account is not valid for sales -> ").append(customerID).toString());
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return buyer;
    }
    
    
    private MemberBean getMemberByMobile(String MobileNo, boolean bonusEarner)
    throws Exception {
        boolean insert;
        MemberBean member;
        MemberBean buyer;
        MemberBean buyer2;
        Connection conn;
        String entity;
        buyer = null;
        conn = null;
        
        
        entity = bonusEarner ? "Bonus Earner" : "Member";
        try {
            conn = getConnection();
            buyer = (new MemberManager(conn)).getMemberByMobile(MobileNo, false);
            
            if(buyer == null) {
                
                /*
                member = new MemberBean();
                member.setMemberID("T09999999999999");
                member.setName("NewMember");
                member.setMobileNo(MobileNo);
                member.setStatus(10);
                member.setBonusTree(0);
                member.setBonusRank(0);
                member.setStatus(10);
                member.setRegister(0);
                member.setOriginalID("");
                 
                insert = addMember(member);
                // buyer = member;
                buyer2 = (new MemberManager(conn)).getMemberByMobile(MobileNo, false);
                buyer = buyer2;
                 
                throw new Exception((new StringBuilder("No ")).append(entity).append(" found -> ").append(MobileNo).toString());
                System.out.println("masuk addmember, nMobileNo " + MobileNo);
                 
                 */
                
                // buyer.setName("NewMember");
                // buyer.setMobileNo(MobileNo);
                // System.out.println("masuk addmember, nMobileNo " + MobileNo);
                
                // dimatikan sementara
                // throw new Exception((new StringBuilder("No ")).append(entity).append(" found -> ").append(MobileNo).toString());
            }
            
            // if(buyer.getStatus() != 10)
            //   throw new Exception((new StringBuilder(String.valueOf(entity))).append(" status is INACTIVE -> ").append(MobileNo).toString());
            
            // if(buyer.isHidden())
            //    throw new Exception((new StringBuilder(String.valueOf(entity))).append(" account is not valid for sales -> ").append(MobileNo).toString());
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return buyer;
    }
    
    
    private OutletBean getShipper(String shipperID)
    throws Exception {
        OutletBean shipper;
        Connection conn;
        shipper = null;
        conn = null;
        try {
            conn = getConnection();
            shipper = (new OutletManager(conn)).getRecord(shipperID);
            if(shipper == null)
                throw new Exception((new StringBuilder("No Delivery By found -> ")).append(shipperID).toString());
            if(!shipper.getStatus().equalsIgnoreCase("A"))
                throw new Exception((new StringBuilder("Delivery By status is INACTIVE -> ")).append(shipperID).toString());
            OutletStoreBean salesStore = shipper.getSalesStore();
            if(salesStore == null)
                salesStore = (new OutletStoreManager(conn)).getOutletStore(shipper.getSalesStoreCode());
            if(salesStore == null)
                throw new Exception((new StringBuilder("No Sales Store defined in Delivery By -> ")).append(shipperID).toString());
            shipper.setSalesStore(salesStore);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return shipper;
    }
    
    private OutletBean[] getShipperList(String sellerID)
    throws Exception {
        OutletBean shippers[] = (OutletBean[])null;
        return shippers;
    }
    
    private PriceCodeBean[] getPriceCodeListForSales(PriceCodeBean fullList[], String priceCodeType)
    throws Exception {
        ArrayList list = new ArrayList();
        if(fullList.length > 0) {
            for(int i = 0; i < fullList.length; i++)
                if(fullList[i].getType().equalsIgnoreCase(priceCodeType))
                    list.add(fullList[i]);
            
        }
        return (PriceCodeBean[])list.toArray(new PriceCodeBean[0]);
    }
    
    private ProductCategoryBean[] getProductCategoryListForSales(String priceCodeID, Date effectiveDate)
    throws Exception {
        HashMap map = null;
        ArrayList list = new ArrayList();
        ProductBean productList[] = getProductSetListForSales(priceCodeID, effectiveDate);
        if(productList.length <= 0)
            throw new Exception("No Product Category List found");
        map = new HashMap();
        for(int i = 0; i < productList.length; i++) {
            ProductCategoryBean catBean = productList[i].getProductCategory();
            if(!map.containsKey(Integer.valueOf(catBean.getCatID()))) {
                map.put(Integer.valueOf(catBean.getCatID()), catBean);
                list.add(catBean);
            }
        }
        
        System.out.println("Trap 3c getProductCategoryListForSales " );
        
        return (ProductCategoryBean[])list.toArray(new ProductCategoryBean[0]);
    }
    
    
    private CurrencyRateBean[] getCurrencyRateSetListForSales(String priceCodeID,  Date effectiveDate)
    throws Exception {
        CurrencyRateBean list[];
        Connection conn;
        list = (CurrencyRateBean[])null;
        conn = null;
        try {
            conn = getConnection();
            // why error
            // list = (new CurrencyRateManager(conn)).getCurrencyRateSetListForSales(priceCodeID, effectiveDate, getLoginUser().getLocale().toString());
            
            if(list.length <= 0)
                throw new Exception("No Product List found for sales");
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return list;
    }
    
    
    private ProductBean[] getProductSetListForSales(String priceCodeID, Date effectiveDate)
    throws Exception {
        ProductBean list[];
        Connection conn;
        list = (ProductBean[])null;
        conn = null;
        try {
            conn = getConnection();
            list = (new ProductManager(conn)).getProductSetListForSales(priceCodeID, effectiveDate, getLoginUser().getLocale().toString());
            if(list.length <= 0)
                throw new Exception("No Product List found for sales");
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        System.out.println("Trap 3b getProductSetListForSales " );
        
        releaseConnection(conn);
        return list;
    }
    
    private OutletPaymentModeBean[] getPaymentModeList(String sellerTypeStatus, String sellerID, String sellerHomeBranchID)
    throws Exception {
        OutletPaymentModeBean list[];
        Connection conn;
        list = (OutletPaymentModeBean[])null;
        conn = null;
        try {
            conn = getConnection();
            String id = sellerID;
            if(sellerTypeStatus.equals("S"))
                id = sellerHomeBranchID;
            OutletManager mgr = new OutletManager(conn);
            OutletPaymentModeBean fullList[] = mgr.getPaymentModeList(id);
            if(fullList.length > 0) {
                ArrayList activeList = new ArrayList();
                for(int i = 0; i < fullList.length; i++)
                    // if(fullList[i].getStatus().equalsIgnoreCase("A"))
                    activeList.add(fullList[i]);
                
                list = (OutletPaymentModeBean[])activeList.toArray(new OutletPaymentModeBean[0]);
            } else {
                throw new Exception("No Payment Mode List found");
            }
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        
        System.out.println(" Trap 4, getPaymentModeList ");
        
        return list;
    }
    
    /*
    private CurrencyRateBean[] getCurrencyRateList(String sellerTypeStatus, String sellerID, String sellerHomeBranchID)
    throws Exception {
        CurrencyRateBean list[];
        Connection conn;
        list = (CurrencyRateBean[])null;
        conn = null;
        try {
            conn = getConnection();
            String id = sellerID;
            if(sellerTypeStatus.equals("S"))
                id = sellerHomeBranchID;
            CurrencyRateManager mgr = new CurrencyRateManager(conn);
     
            CurrencyRateBean fullList[] = mgr.getCurrencyRateList(id);
            if(fullList.length > 0) {
                ArrayList activeList = new ArrayList();
                for(int i = 0; i < fullList.length; i++)
                    // if(fullList[i].getStatus().equalsIgnoreCase("A"))
                    activeList.add(fullList[i]);
     
                list = (CurrencyRateBean[])activeList.toArray(new CurrencyRateBean[0]);
            } else {
                throw new Exception("No Payment Mode List found");
            }
     
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
     
        releaseConnection(conn);
     
        System.out.println(" Trap 4, GetCurrencyRateBean ");
     
        return list;
    }
     */
    
   /*
    private OutletPaymentModeBean[] getPaymentModeListAsal(String sellerTypeStatus, String sellerID, String sellerHomeBranchID)
    throws Exception {
        OutletPaymentModeBean list[];
        Connection conn;
        list = (OutletPaymentModeBean[])null;
        conn = null;
        try {
            conn = getConnection();
            String id = sellerID;
            if(sellerTypeStatus.equals("S"))
                id = sellerHomeBranchID;
            OutletManager mgr = new OutletManager(conn);
            OutletPaymentModeBean fullList[] = mgr.getPaymentModeList(id);
            if(fullList.length > 0) {
                ArrayList activeList = new ArrayList();
                for(int i = 0; i < fullList.length; i++)
                    if(fullList[i].getStatus().equalsIgnoreCase("A"))
                        activeList.add(fullList[i]);
    
                list = (OutletPaymentModeBean[])activeList.toArray(new OutletPaymentModeBean[0]);
            } else {
                throw new Exception("No Payment Mode List found");
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
    
        releaseConnection(conn);
        return list;
    }
    
    */
    
    private void checkSellerQuotaWalletBalance(String sellerID, double compareValue, MvcReturnBean returnBean) {
        double balance = 0.0D;
        DecimalFormat dcf = new DecimalFormat("#,###,###");
        try {
            balance = getQuotaWalletBalance(sellerID);
            if(balance <= 0.0D || compareValue > balance)
                returnBean.addError((new StringBuilder("Not enough quota to proceed !!! Current balance is ")).append(dcf.format(balance)).toString());
        } catch(Exception e) {
            Log.error(e);
            returnBean.addError(e.getMessage());
        }
    }
    
    private double getQuotaWalletBalance(String ownerID)
    throws Exception {
        double balance;
        Connection conn;
        balance = 0.0D;
        conn = null;
        try {
            conn = getConnection();
            QuotaWalletBean bean = (new QuotaWalletManager(conn)).getQuotaBalance(ownerID);
            if(bean == null)
                throw new Exception((new StringBuilder("No Quota Wallet found for -> ")).append(ownerID).toString());
            balance = bean.getBvBalance();
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return balance;
    }
    
    private void preparePreSalesPage(MvcReturnBean returnBean, HttpServletRequest request, int taskID) {
        returnBean.addReturnObject("TaskID", String.valueOf(taskID));
        returnBean.addReturnObject("TaskTitle", defineTaskTitle(taskID));
        String custID = request.getParameter("CustomerID");
        String salesman = request.getParameter("Salesman");
        String custContact = request.getParameter("CustomerContact");
        
        // tambahan tuk HI
        String custAlamat = request.getParameter("CustomerAlamat");
        if(custAlamat == null)
            custAlamat = "";
        returnBean.addReturnObject("CustomerAlamat", custAlamat);
        
        String custName = request.getParameter("CustomerName");
        if(custName == null)
            custName = "";
        returnBean.addReturnObject("CustomerName", custName);
        
        String custDeposit = request.getParameter("CustomerDeposit");
        String invoiceReturn = request.getParameter("InvoiceReturn");
        
        System.out.println("Chek 1 custID "+ custID);
        
        if(custID == null)
            custID = "";
        returnBean.addReturnObject("CustomerID", custID);
        
        if(custContact == null)
            custContact = "";
        returnBean.addReturnObject("CustomerContact", custContact);
        
        if(custDeposit == null)
            custDeposit = "";
        returnBean.addReturnObject("CustomerDeposit", custDeposit);
        
        if(invoiceReturn == null)
            invoiceReturn = "";
        returnBean.addReturnObject("InvoiceReturn", invoiceReturn);
        
        if(salesman == null)
            salesman = "";
        returnBean.addReturnObject("Salesman", salesman);
        
        // CRM Card
        String custSegmentation = request.getParameter("CustomerSegmentation");
        String custCRM = request.getParameter("CustomerCRM");
        String custValid = request.getParameter("CustomerValid");
        String custPin = request.getParameter("CustomerPin");
        
        System.out.println("Trap 2c : preparePreSalesPage ");
        
        if(custSegmentation == null)
            custSegmentation = "";
        returnBean.addReturnObject("CustomerSegmentation", custSegmentation);
        
        if(custCRM == null)
            custCRM = "";
        returnBean.addReturnObject("CustomerCRM", custCRM);
        
        if(custValid == null)
            custValid = "";
        returnBean.addReturnObject("CustomerValid", custValid);
        
        if(custPin == null)
            custPin = "";
        returnBean.addReturnObject("CustomerPin", custPin);
        
        System.out.println("Trap 2d : preparePreSalesPage ");
        
        try {
            OutletBean seller = getSeller(getLoginUser().getOutletID());
            returnBean.addReturnObject("SellerBean", seller);
            
            SalesmanBean sales = getSales(getLoginUser().getOutletID());
            returnBean.addReturnObject("SalesmanBean", sales);
            
            if(seller.isStockist())
                checkSellerQuotaWalletBalance(seller.getOutletID(), 0.0D, returnBean);
            returnBean.addReturnObject("ShipperBy", getShipper(getLoginUser().getOutletID()));
            returnBean.addReturnObject("PriceCodeList", getPriceCodeListForSales(seller.getPriceCodes(), definePriceCodeType(taskID)));
            
            boolean showAny = false;
            returnBean.addReturnObject("StaffList", getStaff(showAny, getLoginUser().getOutletID()));
            // returnBean.addReturnObject("SalesList", getSales(getLoginUser().getOutletID() ));
            
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
        System.out.println("preparePreSalesPage, CustomerContact : " + custContact + " CustomerAlamat : " + custAlamat );
        
    }
    
    private void prepareSalesOrderPage(MvcReturnBean returnBean, HttpServletRequest request, int taskID) {
        
        System.out.println("Trap 1 : prepareSalesOrderPage ");
        
        CounterSalesOrderBean sales = getSalesInfoFromSession(request);
        
        returnBean.addReturnObject("TaskID", String.valueOf(taskID));
        
        System.out.println("Trap 2c : prepareSalesOrderPage ");
        
        returnBean.addReturnObject("TaskTitle", defineTaskTitle(taskID));
        
        System.out.println("Trap 2d : prepareSalesOrderPage ");
        
        try {
            
            // 3 dibawah sementara diremark
            // ProductBean productList[] = getProductSetListForSales(sales.getPriceCode(), sales.getTrxDate());
            //fillUpProductBalanceForSales(sales.getShipByOutletID(), sales.getShipByStoreCode(), productList);
            //returnBean.addReturnObject("ProductList", productList);
            
            System.out.println("Trap 2e : prepareSalesOrderPage ");
            
            // returnBean.addReturnObject("CategoryList", getProductCategoryListForSales(sales.getPriceCode(), sales.getTrxDate()));
            returnBean.addReturnObject("PaymentModeList", getPaymentModeList(sales.getSellerTypeStatus(), sales.getSellerID(), sales.getSellerHomeBranchID()));
            
            // returnBean.addReturnObject("CurrencyRateList", getCurrencyRateList(sales.getPriceCode(), sales.getTrxDate()));
            
            /*
            if(sales.getSellerTypeStatus().equals("S")) {
                double balance = getQuotaWalletBalance(sales.getSellerID());
                returnBean.addReturnObject("QuotaBvBalance", new Double(balance));
            }
             
            String custTypeStatus = sales.getCustomerTypeStatus();
            if(custTypeStatus.equalsIgnoreCase("S")) {
                String paramKey = "";
                String paramValue = "0";
                String custType = sales.getCustomerType();
                if(custType.equalsIgnoreCase("F"))
                    paramKey = "FS_DISCOUNT";
                else
                    if(custType.equalsIgnoreCase("S"))
                        paramKey = "SS_DISCOUNT";
                    else
                        if(custType.equalsIgnoreCase("M"))
                            paramKey = "MS_DISCOUNT";
                SystemParametersBean paramBean = (SystemParametersBean)SystemParameters.getObject(paramKey);
                if(paramBean != null)
                    paramValue = paramBean.getValue();
                returnBean.addReturnObject("StockistDiscountValue", paramValue);
            }
             *
             */
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void parseSalesBean(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            sales.setShippingAddressBean(new AddressBean());
            getRequestParser().parse(sales, request);
            getRequestParser().parse(sales.getShippingAddressBean(), request);
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
        System.out.println("Trap 4 : chek nilai sales " + sales);
    }
    
    private void parseSalesOrderForm(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        double qtyFoc = 0;
        
        int totalQtyOrder = 0;
        double totalBv1 = 0.0D;
        double totalBv2 = 0.0D;
        double totalBv3 = 0.0D;
        double totalBv4 = 0.0D;
        double totalBv5 = 0.0D;
        double totalBvSalesAmt = 0.0D;
        double totalNoBvSalesAmt = 0.0D;
        double totalGrossSalesAmt = 0.0D;
        double totalChiSalesAmt = 0.0D;
        double totalCorpSalesAmt = 0.0D;
        
        double totalDiscountAmt = 0.0D;
        
        try {
            resetSales(sales);
            ProductManager productMgr = new ProductManager();
            ProductPricingManager pricingMgr = new ProductPricingManager();
            UtilsManager utilsMgr = new UtilsManager();
            
            String irate = request.getParameter("irate");
            System.out.println("01. nilai irate " + irate);
            
            String tanggal = request.getParameter("tanggal");
            System.out.println("01. nilai bonusdate " + tanggal);
            
            System.out.println("1. mulai for ");
            
            StringBuffer kode = new StringBuffer();
            StringBuffer kode2 = new StringBuffer();
            
            StringBuffer brand = new StringBuffer();
            StringBuffer jum = new StringBuffer();
            StringBuffer harga = new StringBuffer();
            StringBuffer disc = new StringBuffer();
            
            String ulang = request.getParameter("ulangi");
            int ulangi = Integer.parseInt(request.getParameter("ulangi"));
            
            System.out.println(" nilai ulang " + ulangi);
            
            for(int i=1;i<ulangi ;i++) {                
                String quantity = request.getParameter("Qty_" + i);
                System.out.println("2. mulai Qty " + quantity);
                
                if(quantity != null && quantity.length() > 0) {
                    
                    int Qty = Integer.parseInt(quantity);
                    
                    String diskon = request.getParameter("Foc_" + i);
                    
                    if (diskon.isEmpty())
                        diskon = "0";
                    
                    System.out.println("3. mulai Foc " + diskon);
                    
                    double Disc1 = Double.valueOf((diskon).trim()).doubleValue();
                    
                    System.out.println("3. nilai diskon " + Disc1);
                    
                    String productSerial = request.getParameter("icode_" + i);
                    
                    String productCode = request.getParameter("iserial_" + i);
                    
                    kode.append(productSerial).append((new StringBuilder("\r\n"))).toString();
                    kode2.append(productCode).append((new StringBuilder("\r\n"))).toString();
                    
                    jum.append(quantity).append((new StringBuilder("\r\n"))).toString();
                    disc.append(diskon).append((new StringBuilder("\r\n"))).toString();
                    
                    String Unitsales = request.getParameter("isales_" + i);
                    int idproduct = productMgr.getIdProduct(productSerial).getProductID();
                    
                    // tuk HE
                    // int idpricing = pricingMgr.getIdProductPricingUpdateHE(productCode, Sys.getDateFormater().format(sales.getBonusDate()), sales.getSellerID()).getPricingID();
                    int idpricing = pricingMgr.getIdProductPricingUpdate(idproduct, Sys.getDateFormater().format(sales.getBonusDate()), sales.getSellerID()).getPricingID();
                    
                    double pricerate = Double.valueOf(request.getParameter("irate").trim()).doubleValue();
                    
                    System.out.println("3a. nilai icode " + productSerial + " nilai isales " + Unitsales + " nilai pricerate " + pricerate);
                    
                    
                    if(Qty > 0) {
                        ProductBean productBean = productMgr.getProductSet(idproduct, getLoginUser().getLocale().toString());
                        
                        ProductPricingBean priceBean = pricingMgr.getProductPricing(idproduct, idpricing);
                        
                        // tuk HE
                        // ProductPricingBean priceBean = pricingMgr.getProductPricingHE(idproduct, idpricing);
                        
                        harga.append(priceBean.getPrice() * pricerate).append((new StringBuilder("\r\n"))).toString();
                        brand.append(productBean.getProductCategory().getName()).append((new StringBuilder("\r\n"))).toString();
                        
                        productBean.setCurrentPricing(priceBean);
                        CounterSalesItemBean itemSales = new CounterSalesItemBean();
                        itemSales.setPricingID(idpricing);
                        itemSales.setProductID(idproduct);
                        
                        itemSales.setInventory(productBean.getInventory());
                        itemSales.setQtyOrder(Qty);
                        
                        itemSales.setDeliveryStatus(sales.getDeliveryStatus());
                        itemSales.setProductBean(productBean);
                        
                        if(Qty > 0) {
                            // nilai rate
                            itemSales.setBv1(pricerate);
                            itemSales.setBv2(Qty);
                            itemSales.setBv3(0.0D);
                            itemSales.setBv4(0.0D);
                            itemSales.setBv5(0.0D);
                            
                            itemSales.setUnitPrice(priceBean.getPrice());
                            itemSales.setUnitNetPrice((priceBean.getPrice()*Qty*pricerate) - Disc1);
                            itemSales.setUnitDiscount(Disc1);
                            itemSales.setUnitSales(Unitsales);
                            
                            double chiItemUnitPrice = getTypeUnit(productBean.getSkuCode(), itemSales.getUnitPrice(), itemSales.getBv1(), 2);
                            double coprItemUnitPrice = getTypeUnit(productBean.getSkuCode(), itemSales.getUnitPrice(), itemSales.getBv1(), 3);
                            
                            itemSales.setChiUnitPrice(chiItemUnitPrice);
                            itemSales.setCorpUnitPrice(coprItemUnitPrice);
                            
                            totalGrossSalesAmt += (double)((Qty * itemSales.getUnitPrice() * pricerate) - Disc1) ;
                            totalChiSalesAmt += (double)((Qty * chiItemUnitPrice * pricerate) - Disc1);
                            totalCorpSalesAmt += (double)((Qty * coprItemUnitPrice * pricerate) - Disc1);
                            
                            totalDiscountAmt += (double)Disc1 * 1;
                            
                            double qtyAmt = (double)((Qty * itemSales.getUnitPrice() * pricerate) - Disc1) ;
                            // if(itemSales.getBv1() > 0.0D)
                            totalBvSalesAmt += qtyAmt;
                            //else
                            totalNoBvSalesAmt += qtyAmt;
                            
                            itemSales.setProductType(0);
                            
                            System.out.println("3b. masuk item id pricing " + idpricing + " id product " + idproduct);
                        }
                        
                        
                        ProductItemBean components[] = (ProductItemBean[])productBean.getProductItemBeanList().toArray(new ProductItemBean[0]);
                        for(int st = 0; st < components.length; st++) {
                            ProductBean pd = components[st].getItemProductBean();
                            CounterSalesProductBean itemProduct = new CounterSalesProductBean();
                            itemProduct.setProductType(itemSales.getProductType());
                            itemProduct.setProductID(pd.getProductID());
                            itemProduct.setInventory(pd.getInventory());
                            itemProduct.setQtyUnit(components[st].getQtySale());
                            itemProduct.setQtyOrder(Qty * components[st].getQtySale());
                            itemProduct.setQtyKiv(Qty * components[st].getQtySale());
                            itemProduct.setProductBean(pd);
                            itemSales.addProduct(itemProduct);
                            
                            System.out.println("3c. masuk item product inventory " + pd.getProductID() + " unit " + components[st].getQtySale() );
                        }
                        
                        sales.addItem(itemSales);
                        totalQtyOrder += Qty;
                        
                    }  // end of Qty > 0)
                    
                }  // end of Qty not null
                
            }  // end of for - next
            
            sales.setRemark(request.getParameter("Remark"));
            sales.setTotalBv1(totalBv1);
            // sales.setTotalBv2(totalBv2);
            sales.setTotalBv3(totalBv3);
            sales.setTotalBv4(totalBv4);
            // sales.setTotalBv4(idrate);
            // sales.setTotalBv5(totalBv5);
            // nilai total discunt unit
            sales.setTotalBv5(totalDiscountAmt);
            
            // just entry - next harus diubah
            String quant = request.getParameter("Qty_1");
            if (quant.isEmpty())
                quant = "0";
            
            double quant1 = Double.valueOf((quant).trim()).doubleValue();
            
            String quant2 = request.getParameter("Foc_1");
            if (quant2.isEmpty())
                quant2 = "0";
            
            double quant3 = Double.valueOf((quant2).trim()).doubleValue();
            
            // String productBrand = request.getParameter("brand");
            // String productItem = request.getParameter("icode_1");
            
            sales.setShipReceiver(brand.toString());
            sales.setShipAddress1(kode.toString());
            sales.setShipRemark(kode2.toString());
            
            sales.setShipCountry(jum.toString());
            sales.setShipRegion(harga.toString());
            sales.setShipState(disc.toString());
            
            System.out.println(" StringBuffer 2 kode : " + kode + " kode 2 : " + kode2 + " brand : " + brand + " harga : " + harga );
            
            sales.setTotalBv2(quant1);
            sales.setTotalBv3(quant3);
            
            parseSalesMiscCharges(sales, returnBean, request);
            
            sales.setBvSalesAmount(utilsMgr.roundDouble(totalBvSalesAmt, 2));
            sales.setNonBvSalesAmount(utilsMgr.roundDouble(totalNoBvSalesAmt, 2));
            sales.setNetSalesAmount(utilsMgr.roundDouble(totalGrossSalesAmt + sales.getMiscAmount(), 2));
            sales.setChiSalesAmount(utilsMgr.roundDouble(totalChiSalesAmt + sales.getMiscAmount(), 2));
            sales.setCorpSalesAmount(utilsMgr.roundDouble(totalCorpSalesAmt, 2));
            parseSalesPayment(sales, returnBean, request);
            
            
            // sementara dihide, krn ada Sales Invoice Return
            /*
            if(sales.getNetSalesAmount() > 0.0D) {
                if(sales.getPaymentTender() < sales.getNetSalesAmount())
                    returnBean.addError((new StringBuilder("Payment is not tally with the Net Total Sales ")).append(sales.getNetSalesAmount()).toString());
            } else
                if(sales.getPaymentTender() > 0.0D)
                    returnBean.addError((new StringBuilder("No payment for the Sales Order, Net Total Sales is ")).append(sales.getNetSalesAmount()).toString());
             */
            
        } catch(Exception ex) {
            returnBean.addError("error disini "+ ex.getMessage());
        }
        
    }
    
    
    private void parseSalesMiscChargesAsal(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            String deliveryAmtStr = request.getParameter("DeliveryAmount");
            System.out.println("8. Nilai deliveryAmtStr " + deliveryAmtStr);
            
            if(deliveryAmtStr != null && deliveryAmtStr.length() > 0 && !deliveryAmtStr.equals("null"))
                try {
                    sales.setDeliveryAmount(-Double.parseDouble(deliveryAmtStr));
                } catch(Exception ex) {
                    returnBean.addError("Invalid Delivery Charges");
                }
            
            String discountAmtStr = request.getParameter("DiscountAmount");
            String discountRateStr = request.getParameter("DiscountRate");
            
            System.out.println("9. Nilai discountAmtStr " + discountAmtStr);
            System.out.println("10. Nilai discountRateStr " + discountRateStr);
            
            if(discountAmtStr != null && discountAmtStr.length() > 0 && !discountAmtStr.equals("null")) {
                try {
                    sales.setDiscountAmount(-Double.parseDouble(discountAmtStr));
                } catch(Exception ex) {
                    returnBean.addError("Invalid Discount Amount");
                }
                if(discountRateStr != null)
                    try {
                        double discountRate = Double.parseDouble(discountRateStr);
                        sales.setDiscountRate(discountRate);
                    } catch(Exception ex) {
                        returnBean.addError("Invalid Discount Rate");
                    }
            }
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void parseSalesMiscCharges(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            String deliveryAmtStr = request.getParameter("DeliveryAmount");
            // System.out.println("8. Nilai deliveryAmtStr " + deliveryAmtStr);
            
            if(deliveryAmtStr != null && deliveryAmtStr.length() > 0 && !deliveryAmtStr.equals("null"))
                try {
                    sales.setDeliveryAmount(-Double.parseDouble(deliveryAmtStr));
                } catch(Exception ex) {
                    returnBean.addError("Invalid Delivery Charges");
                }
            
            String discountVoucher = request.getParameter("icode_");
            String discountAmtStr = request.getParameter("diskonvoucher");
            String discountRateStr = request.getParameter("DiscountRate");
            
            System.out.println("9. Nilai discountAmtStr " + discountAmtStr + " Voucher : "+discountVoucher );
            System.out.println("10. Nilai discountRateStr " + discountRateStr);
            
            if(discountAmtStr != null && discountAmtStr.length() > 0 && !discountAmtStr.equals("null")) {
                try {
                    sales.setDiscountAmount(-Double.parseDouble(discountAmtStr));
                    sales.setCustomerIdentityNo(discountVoucher);
                    
                } catch(Exception ex) {
                    returnBean.addError("Invalid Discount Amount");
                }
                if(discountRateStr != null)
                    try {
                        double discountRate = Double.parseDouble(discountRateStr);
                        sales.setDiscountRate(discountRate);
                    } catch(Exception ex) {
                        returnBean.addError("Invalid Discount Rate");
                    }
            }
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    
    private void parseSalesVoidForm(CounterSalesOrderBean voidBean, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            String cancelBonus = request.getParameter("CancelBonus");
            if(cancelBonus != null && cancelBonus.equals("Y"))
                voidBean.setCancelBonus(true);
            voidBean.setAdjstRemark(request.getParameter("AdjstRemark"));
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void parseSalesRefundForm(CounterSalesOrderBean voidBean, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            double deductAmt = 0.0D;
            String cancelBonus = request.getParameter("CancelBonus");
            if(cancelBonus != null && cancelBonus.equals("Y"))
                voidBean.setCancelBonus(true);
            voidBean.setAdjstRemark(request.getParameter("AdjstRemark"));
            String mgmtAmtStr = request.getParameter("MgmtAmount");
            if(mgmtAmtStr != null && mgmtAmtStr.length() > 0 && !mgmtAmtStr.equals("null"))
                try {
                    voidBean.setMgmtAmount(-Double.parseDouble(mgmtAmtStr));
                    deductAmt += voidBean.getMgmtAmount();
                } catch(Exception ex) {
                    returnBean.addError("Invalid Management Deduction");
                }
            voidBean.setNetSalesAmount(voidBean.getNetSalesAmount() + deductAmt);
            // remark, krn payment = 0
            // parseSalesPayment(voidBean, returnBean, request);
            // buat fungsi insert quota ...
            
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void parseSalesPayment(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        double totalPayTender = 0.0D;
        try {
            ArrayList paymentList = new ArrayList();
            OutletManager mgr = new OutletManager();
            
            //System.out.println(1);
            
            StringBuffer card = new StringBuffer();
            StringBuffer edc = new StringBuffer();
            StringBuffer visa = new StringBuffer();
            StringBuffer jum = new StringBuffer();
            StringBuffer curr = new StringBuffer();
            StringBuffer rate = new StringBuffer();
            
            String puter = request.getParameter("puteri");
            int puteri = Integer.parseInt(request.getParameter("puteri"));
            String voucher = "";
             
            for(int i=0; i<puteri; i++) {
                //System.out.println(2);
                String paymode = request.getParameter("paymode_" + i);
                //System.out.println("2a" + paymode);
                
                String[] paymodeArray = paymode.split(">");                
                String paymodeDesc = paymodeArray[0];
                String paymodeCode  = paymodeArray[1];
                String paymodeEdc  = paymodeArray[2];
                String paymodeTime  = paymodeArray[3];
                int paymodeGroup  = Integer.parseInt(paymodeArray[4]);
                
                CounterSalesPaymentBean paymentBean = new CounterSalesPaymentBean();
                paymentBean.setPaymodeCode(paymodeCode);
                paymentBean.setPaymodeDesc(paymodeDesc);
                paymentBean.setPaymodeEdc(paymodeEdc);
                paymentBean.setPaymodeTime(paymodeTime);
                paymentBean.setPaymodeGroup(paymodeGroup);                
                //rubah dulu dari 20,000  ke double 20000
                String jumlah = request.getParameter("amount_" + i);
                
                
                if(jumlah != null && jumlah.length() > 0 && paymode.length() > 0) {
                    
                    double d = Double.valueOf((jumlah).trim()).doubleValue();
                    
                    // for admin collection
                    jum.append(jumlah).append((new StringBuilder("\r\n "))).toString();
                    card.append(paymodeDesc).append((new StringBuilder("\r\n "))).toString();
                    edc.append(paymodeEdc).append((new StringBuilder("\r\n "))).toString();
                    visa.append(paymodeTime).append((new StringBuilder("\r\n "))).toString();
                    
                    // double d = Double.valueOf(request.getParameter("amount_" + i).trim()).doubleValue();
                    System.out.println("double d = " + d);
                    paymentBean.setAmount(d);
                    
                    System.out.println("2c");
                    
                    paymentBean.setPaymodeExpired(request.getParameter("expired_" + i));
                    System.out.println("2d");
                    paymentBean.setPaymodeOwner(request.getParameter("owner_" + i));
                    
                    String currency = request.getParameter("currency_" + i);
                    //System.out.println("2a" + paymode);
                    String[] currencyArray = currency.split(">");
                    
                    String currencyDesc = currencyArray[0];
                    String currencyAmount  = currencyArray[1];
                    
                    System.out.println("check nilai currencyDesc " + currencyDesc + " currencyAmount " + currencyAmount);
                    // curr.append(currencyDesc.concat("-").concat(currencyAmount)).append((new StringBuilder("\r\n "))).toString();
                    curr.append(currencyDesc).append((new StringBuilder("\r\n "))).toString();
                    rate.append(currencyAmount).append((new StringBuilder("\r\n "))).toString();
                    
                    double d2 = Double.valueOf((currencyAmount).trim()).doubleValue();
                    
                    paymentBean.setCurrency(currencyDesc);
                    paymentBean.setRate(d2);
                    
                    
                    System.out.println("2e");
                    
                    // isi refNo
                    String refno = request.getParameter("refNo_" + i);
                    
                    if(refno.length() > 16 ) {
                        String chek  = request.getParameter("refNo_" + i).substring(1,1);
                        
                        System.out.println("2ee");
                        
                        if (chek.equalsIgnoreCase("B")) {
                            paymentBean.setRefNo(request.getParameter("refNo_" + i).substring(2,18));
                        }else{
                            paymentBean.setRefNo(request.getParameter("refNo_" + i).substring(1,17));
                        }
                        
                    }
                    
                    else{
                        paymentBean.setRefNo(request.getParameter("refNo_" + i));
                    }
                    
                    
                    if(i==0 && paymodeDesc.equalsIgnoreCase("VOUCHER")) {
                        voucher  = request.getParameter("refNo_" + i);
                    }
                    
                    // standart
                    if (refno.isEmpty())
                        paymentBean.setRefNo(" ");                    
                    
                    System.out.println("2f");
                    paymentBean.setStatus(sales.getStatus());
                    System.out.println("2g");
                    paymentList.add(paymentBean);
                    System.out.println("2h");
                    // totalPayTender += paymentBean.getAmount();
                    totalPayTender += paymentBean.getAmount() * d2 ;
                    System.out.println("2i");
                    
                } // end of null
                
            }
            //System.out.println(3);
            
            
            if(!paymentList.isEmpty()) {
                System.out.println(4);
                
                // mulai insert payment
                sales.addPayment((CounterSalesPaymentBean[])paymentList.toArray(new CounterSalesPaymentBean[0]));
                if(totalPayTender > sales.getNetSalesAmount()) {
                    // System.out.println(5);
                    
                    double payChange = totalPayTender - sales.getNetSalesAmount();
                    sales.setPaymentChange(payChange);
                }
            }
            System.out.println(6);
            
            sales.setPaymentTender(totalPayTender);
            // sales.setPaymentRemark(request.getParameter("PaymentRemark"));
            sales.setPaymentRemark(rate.toString());
            
            if(voucher.length() > 0 && voucher != null) {
                
                String keterangan = "U";
                // update di createdocument
                // updateVoucherSerial(sales, voucher, keterangan);
                System.out.println("cek update voucher di payment " + voucher);                
                sales.setShipFromStoreCode(keterangan.concat("-").concat(voucher));
            } else {
                sales.setShipFromStoreCode("");
            }
            
            sales.setShipZipcode(card.toString());
            sales.setShipAddress2(edc.toString());
            
            System.out.println(" StringBuffer 2 card : " + card + " edc : " + edc + " time : " + visa + " sales.setShipFromStoreCode "+sales.getShipFromStoreCode() );
            
            sales.setShipContact(visa.toString());
            sales.setShipCity(jum.toString());
            sales.setShipExpedition(curr.toString());
            
        } catch(Exception ex) {
            returnBean.addError("Di parseSalesPayment errornya ? " + ex.getMessage());
            // returnBean.addError(ex.getMessage());
        }
    }
    
    private void parseSalesOrderFormHE(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        double qtyFoc = 0;
        
        int totalQtyOrder = 0;
        double totalBv1 = 0.0D;
        double totalBv2 = 0.0D;
        double totalBv3 = 0.0D;
        double totalBv4 = 0.0D;
        double totalBv5 = 0.0D;
        double totalBvSalesAmt = 0.0D;
        double totalNoBvSalesAmt = 0.0D;
        double totalGrossSalesAmt = 0.0D;
        double totalChiSalesAmt = 0.0D;
        double totalCorpSalesAmt = 0.0D;
        
        double totalDiscountAmt = 0.0D;
        
        try {
            resetSales(sales);
            ProductManager productMgr = new ProductManager();
            ProductPricingManager pricingMgr = new ProductPricingManager();
            UtilsManager utilsMgr = new UtilsManager();
            
            //String irate = request.getParameter("irate");
            //System.out.println("01. nilai irate " + irate);
            
            String tanggal = request.getParameter("tanggal");
            System.out.println("01. nilai bonusdate " + tanggal);
            
            System.out.println("1. mulai for ");
            
            StringBuffer kode = new StringBuffer();
            StringBuffer kode2 = new StringBuffer();
            
            StringBuffer brand = new StringBuffer();
            StringBuffer jum = new StringBuffer();
            StringBuffer harga = new StringBuffer();
            StringBuffer disc = new StringBuffer();
            
            // Update KIT, variable : ulangi_kit2
            String ulang1 = request.getParameter("ulangi_kit2");
            int ulangi1 = Integer.parseInt(request.getParameter("ulangi_kit2"));
            System.out.println(" nilai ulang1 " + ulangi1);                        
                        
            // Update KIT, variable : ulangi_kit2
            String ulang = request.getParameter("ulangi_kit2");
            int ulangi = Integer.parseInt(request.getParameter("ulangi_kit2"));
            System.out.println(" nilai ulang " + ulangi);
            
            for(int i=1;i<ulangi ;i++) {
                String productSerial = "";
                String productCode = "";
                String quantity = request.getParameter("Qty_" + i);
                productSerial = request.getParameter("icode_" + i);
                String quantity1 = "";
                
                String irate = request.getParameter("irate_" + i);
                System.out.println("01. nilai irate " + irate);
                                
                if(i>5) {
                    if (quantity.isEmpty() || quantity == null || quantity.equalsIgnoreCase("0")) {
                        quantity = "1";
                        quantity1 = "0";
                    }else{
                        quantity1 = quantity;
                    }
                    
                } else {
                    if (quantity.isEmpty() || quantity == null)
                        quantity = "";
                }
                
                if (productSerial.isEmpty() || productSerial == null)
                    productSerial = "";
                
                if (productCode.isEmpty() || productCode == null)
                    productCode = "";
                
                System.out.println("2. Item Serial "+productSerial+ " Item Product "+productCode+ "  Qty " + quantity);
                
                if(quantity != null && quantity.length() > 0 && productSerial != null && productSerial.length() > 0) {
                    int Qty = Integer.parseInt(quantity);
                    String diskon = request.getParameter("Foc_" + i);
                    
                    if (diskon.isEmpty() || diskon == null)
                        diskon = "0";
                    System.out.println("3. mulai Foc " + diskon);
                    
                    // productSerial = request.getParameter("icode_" + i);
                    // if (productSerial.isEmpty() || productSerial == null)
                    // productSerial = "";
                    
                    productCode = productMgr.getIdProduct(productSerial).getProductCode();
                    
                    // if (productCode.isEmpty() || productCode == null)
                    //    productCode = "";
                    
                    System.out.println(" productCode "+productCode);
                    double Disc1 = Double.valueOf((diskon).trim()).doubleValue();
                    
                    System.out.println("3. nilai diskon " + Disc1 + " icode "+productSerial + " productCode "+productCode);
                    kode.append(productSerial).append((new StringBuilder("\r\n"))).toString();
                    kode2.append(productCode).append((new StringBuilder("\r\n"))).toString();
                    
                    if(i>5) {
                        jum.append(quantity1).append((new StringBuilder("\r\n"))).toString();
                    }else{
                        jum.append(quantity).append((new StringBuilder("\r\n"))).toString();
                    }
                    
                    disc.append(diskon).append((new StringBuilder("\r\n"))).toString();
                    
                    String Unitsales = request.getParameter("isales_" + i);
                    if (Unitsales.isEmpty() || Unitsales == null)
                        Unitsales = "";
                    
                    int idproduct = productMgr.getIdProduct(productSerial).getProductID();
                    String skuproduct = productMgr.getIdProduct(productSerial).getSkuCode();
                    String descproduct = productMgr.getIdProduct(productSerial).getDefaultDesc();
                    int idign = productMgr.getIdProduct(productSerial).getProductIGN();
                    int idcat = productMgr.getIdProduct(productSerial).getCatID();
                    
                    // tuk HE                    
                    
                    int idpricing = pricingMgr.getIdProductPricingUpdateHE(productCode, Sys.getDateFormater().format(sales.getBonusDate()), sales.getTrxTime(), sales.getSellerID()).getPricingID();
                    
                    double pricerate = 0;
                    if(request.getParameter("irateCcy_"+i) != null && !request.getParameter("irateCcy_"+i).trim().equalsIgnoreCase("")){
                        pricerate = ppm.getRateMultiCurrency(request.getParameter("irateCcy_"+i).trim()).getSymbol(); //Updated By Mila 2016-04-05
                    }else{
                        pricerate = 0.0d;
                    } 
                    
                    System.out.println("3a. nilai icode " + productSerial + " productCode : " + productCode + " nilai isales " + Unitsales + " nilai pricerate " + pricerate);
                    
                    if(Qty > 0) {
                        ProductBean productBean = productMgr.getProductSet(idproduct, getLoginUser().getLocale().toString());
                        ProductPricingBean priceBean = pricingMgr.getProductPricingHE(productCode, idpricing);
                        harga.append((priceBean.getPrice() - (priceBean.getPrice() * priceBean.getBv1())) * pricerate).append((new StringBuilder("\r\n"))).toString();
                        brand.append(productBean.getProductCategory().getName()).append((new StringBuilder("\r\n"))).toString();
                        
                        productBean.setCurrentPricing(priceBean);
                        CounterSalesItemBean itemSales = new CounterSalesItemBean();
                        itemSales.setPricingID(idpricing);
                        itemSales.setProductID(idproduct);
                        itemSales.setInventory(productBean.getInventory());
                        itemSales.setQtyOrder(Qty);
                        
                        itemSales.setProductIGN(idign);
                        itemSales.setProductCat(idcat);
                        itemSales.setProductCode(productCode);
                        itemSales.setProductSKU(skuproduct);
                        itemSales.setProductDesc(descproduct);
                        
                        System.out.println(" nilai idign " + idign + " idcat : " + idcat + " skuproduct " + skuproduct + " descproduct " + descproduct);
                        
                        // chek kit
                        String qty_kit = request.getParameter("Qty_" + i);
                        
                        if(i>5 && qty_kit.equalsIgnoreCase("0")) {
                            itemSales.setDeliveryStatus(0);
                        }else {
                            itemSales.setDeliveryStatus(20);
                        }
                        
                        // itemSales.setDeliveryStatus(sales.getDeliveryStatus());
                        
                        itemSales.setProductBean(productBean);
                        
                        if(Qty > 0) {
                            // nilai rate
                            itemSales.setBv1(pricerate);
                            itemSales.setBv2(Qty);
                            itemSales.setBv3(0.0D);
                            itemSales.setBv4(0.0D);
                            itemSales.setBv5(0.0D);
                            
                            //itemSales.setUnitPrice(priceBean.getPrice());
                            //itemSales.setUnitNetPrice((priceBean.getPrice()*Qty*pricerate) - Disc1);
                            
                            itemSales.setUnitPrice((priceBean.getPrice() - (priceBean.getPrice() * priceBean.getBv1())));
                            itemSales.setUnitNetPrice(( (priceBean.getPrice() - (priceBean.getPrice() * priceBean.getBv1())) *Qty*pricerate) - Disc1);
                            
                            itemSales.setUnitDiscount(Disc1);
                            itemSales.setUnitSales(Unitsales);
                            
                            double chiItemUnitPrice = getTypeUnit(productBean.getSkuCode(), itemSales.getUnitPrice(), itemSales.getBv1(), 2);
                            double coprItemUnitPrice = getTypeUnit(productBean.getSkuCode(), itemSales.getUnitPrice(), itemSales.getBv1(), 3);
                            
                            itemSales.setChiUnitPrice(chiItemUnitPrice);
                            itemSales.setCorpUnitPrice(coprItemUnitPrice);
                            
                            totalGrossSalesAmt += (double)((Qty * itemSales.getUnitPrice() * pricerate) - Disc1) ;
                            totalChiSalesAmt += (double)((Qty * chiItemUnitPrice * pricerate) - Disc1);
                            totalCorpSalesAmt += (double)((Qty * coprItemUnitPrice * pricerate) - Disc1);
                            
                            totalDiscountAmt += (double)Disc1 * 1;
                            
                            double qtyAmt = (double)((Qty * itemSales.getUnitPrice() * pricerate) - Disc1) ;
                            // if(itemSales.getBv1() > 0.0D)
                            totalBvSalesAmt += qtyAmt;
                            //else
                            totalNoBvSalesAmt += qtyAmt;
                            
                            itemSales.setProductType(0);
                            
                            System.out.println("3b. masuk item id pricing " + idpricing + " id product " + idproduct);
                        }
                        
                        
                        ProductItemBean components[] = (ProductItemBean[])productBean.getProductItemBeanList().toArray(new ProductItemBean[0]);
                        for(int st = 0; st < components.length; st++) {
                            ProductBean pd = components[st].getItemProductBean();
                            CounterSalesProductBean itemProduct = new CounterSalesProductBean();
                            itemProduct.setProductType(itemSales.getProductType());
                            itemProduct.setProductID(pd.getProductID());
                            itemProduct.setInventory(pd.getInventory());
                            itemProduct.setQtyUnit(components[st].getQtySale());
                            itemProduct.setQtyOrder(Qty * components[st].getQtySale());
                            
                            // chek kit
                            if(i > 5 && qty_kit.equalsIgnoreCase("0")) {
                                itemProduct.setQtyKiv(1);
                                // System.out.println(" sampai sini ga yah : " + itemProduct.getQtyKiv());
                                
                            }else {
                                itemProduct.setQtyKiv(Qty * components[st].getQtySale());
                            }
                            
                            // itemProduct.setQtyKiv(Qty * components[st].getQtySale());
                            
                            itemProduct.setProductBean(pd);
                            itemSales.addProduct(itemProduct);
                            
                            System.out.println("3c. masuk item product inventory " + pd.getProductID() + " unit " + components[st].getQtySale() );
                        }
                        
                        sales.addItem(itemSales);
                        totalQtyOrder += Qty;
                        
                    }  // end of Qty > 0)
                    
                }  // end of Qty not null
                
            }  // end of for - next
            
            sales.setRemark(request.getParameter("Remark"));
            sales.setTotalBv1(totalBv1);
            
            sales.setTotalBv3(totalBv3);
            sales.setTotalBv4(totalBv4);
            sales.setTotalBv5(totalDiscountAmt);
            
            // just entry - next harus diubah
            String quant = request.getParameter("Qty_1");
            if (quant.isEmpty() || quant == null)
                quant = "0";
            
            double quant1 = Double.valueOf((quant).trim()).doubleValue();
            
            String quant2 = request.getParameter("Foc_1");
            if (quant2.isEmpty() || quant2 == null)
                quant2 = "0";
            
            double quant3 = Double.valueOf((quant2).trim()).doubleValue();
            
            
            sales.setShipReceiver(brand.toString());
            sales.setShipAddress1(kode.toString());
            sales.setShipRemark(kode2.toString());
            
            sales.setShipCountry(jum.toString());
            sales.setShipRegion(harga.toString());
            sales.setShipState(disc.toString());
            
            System.out.println(" StringBuffer 2 kode : " + kode + " kode 2 : " + kode2 + " brand : " + brand + " harga : " + harga );
            
            sales.setTotalBv2(quant1);
            sales.setTotalBv3(quant3);
            
            parseSalesMiscCharges(sales, returnBean, request);
            
            sales.setBvSalesAmount(utilsMgr.roundDouble(totalBvSalesAmt, 2));
            sales.setNonBvSalesAmount(utilsMgr.roundDouble(totalNoBvSalesAmt, 2));
            sales.setNetSalesAmount(utilsMgr.roundDouble(totalGrossSalesAmt + sales.getMiscAmount(), 2));
            sales.setChiSalesAmount(utilsMgr.roundDouble(totalChiSalesAmt + sales.getMiscAmount(), 2));
            sales.setCorpSalesAmount(utilsMgr.roundDouble(totalCorpSalesAmt, 2));
            parseSalesPayment(sales, returnBean, request);
            
            
            // sementara dihide, krn ada Sales Invoice Return
            /*
            if(sales.getNetSalesAmount() > 0.0D) {
                if(sales.getPaymentTender() < sales.getNetSalesAmount())
                    returnBean.addError((new StringBuilder("Payment is not tally with the Net Total Sales ")).append(sales.getNetSalesAmount()).toString());
            } else
                if(sales.getPaymentTender() > 0.0D)
                    returnBean.addError((new StringBuilder("No payment for the Sales Order, Net Total Sales is ")).append(sales.getNetSalesAmount()).toString());
             */
            
        } catch(Exception ex) {
            returnBean.addError("error disini parseSalesOrderFormHE "+ ex.getMessage());
        }
        
    }
    
    private void createAccumulation()
    {
            // Create Akumulasi Product            
            // Nilai Awal :            
            /*             
            String code0 = "test";
            int jum0 = 0;
            int nomor = 0;
            int no = 0;
            int status = 0;
             
            int[] urut1;
            urut1 = new int[15];
            String[] kode1;
            kode1 = new String[15];
            int[] jumlah1;
            jumlah1 = new int[15];
             
            for (int y=1; y < ulangi1 ; y ++) {
             
                String code1 = request.getParameter("icode_" + y);
                if (code1.isEmpty() || code1 == null)
                    code1 = "";
             
                if(!code1.equalsIgnoreCase("")) {
                    no++;
                    String jum1 = request.getParameter("Qty_" + y);
                    if (jum1.isEmpty() || jum1 == null)
                        jum1 = "0";
                    int jum2 = Integer.parseInt(jum1);
             
                    System.out.println("Looping ke-"+no+" kode : "+code1+ " Jumlah="+jum2+" Nilai kode awal :"+code0);
             
                    // beda
                    if(!code1.equalsIgnoreCase(code0)) {
             
                        if(no==1) {
                            // nilai array
                                urut1[0]=no;
                                kode1[0]=code1;
                                jumlah1[0]=jum2;
             
                                code0 = kode1[0];
                                System.out.println("Masuk array [0], kode : "+code1+ " Jumlah="+jum2+" Nilai kode awal :"+code0);
             
                        }else{
             
                            // find item di array
                            for (int x=0; x < kode1.length ; x++) {
                                if(kode1[x] == null)
                                    kode1[x] = "";
             
                                if(!kode1[x].equalsIgnoreCase("")) {
             
                                   // Looping ke-6 kode : EBL-BOX Jumlah=1 Nilai kode awal :EBL-GRTCRD
                                   // chek awal update 1, code1 : EBL-BOX  kode1[x] =A055727 Nilai kode awal :EBL-GRTCRD looping ke6
                                   //
                                   // if(no==6)
                                   // {
                                   //    System.out.println("chek awal update 11, code1 : "+code1+ " kode1[x] ="+kode1[x]+" Nilai kode awal :"+code0+" looping ke"+no);
                                   // }
                                   //
             
                                    if(! kode1[x].equalsIgnoreCase(code1)) {
                                        // insert
                                        nomor++;
                                        urut1[nomor] = nomor ;
                                        kode1[nomor] = code1 ;
                                        jumlah1[nomor] = jum2 ;
                                        status = 1;
             
                                        code0 = kode1[nomor];
                                        System.out.println("Masuk Array["+(nomor)+"], kode : "+code1+" Jumlah="+jumlah1[nomor]+" Nilai kode awal :"+code0) ;
                                        break;
                                    }
             
                                } // filter
                            } // end for
             
                        } // if no>1
             
                    }else{
             
                        // find item di array
                        for (int x=0; x < kode1.length ; x++) {
                            if(kode1[x] == null)
                                kode1[x] = "";
             
                            if(!kode1[x].equalsIgnoreCase("")) {
                                // ketemu
                                if(!kode1[x].equalsIgnoreCase("") && kode1[x].trim().equalsIgnoreCase(code1) ) {
                                    // update
                                    jumlah1[x] = jumlah1[x] + jum2;
                                    code0 = kode1[x];
                                    System.out.println("Masuk update 2, kode : "+code0+ " Jumlah="+jumlah1[x]+" Nilai kode awal :"+code0);
                                    break;
             
                                }
             
                            }  // filter
                        }
             
             
             
                    }
             
                } // filter
             
            }
             
            // print nilai akhir array
            for (int x=0; x < kode1.length ; x++) {
             
                if(kode1[x] == null)
                    kode1[x] = "";
             
                if(!kode1[x].equalsIgnoreCase("")) {
                    System.out.println("Nilai kode1-"+x+" = "+kode1[x]+ " Jumlah-"+x+" = "+jumlah1[x]);
                }
            }
             
             */
            
            /*
            int no = 0;
            int nomor = 0;
            String code = "";
            int qty1 = 0;
            String code1 = "";
            int status2 = 0;
             
            int[] urut;
            urut = new int[10];
            String[] kode1;
            kode1 = new String[10];
            int[] jumlah1;
            jumlah1 = new int[10];
             
            for (int y=1; y < ulangi1 ; y ++) {
             
                String code_a     = request.getParameter("icode_" + y);
                if (code_a.isEmpty() || code_a == null)
                    code_a = "";
                String code_c = "";
             
                if(!code_a.equalsIgnoreCase("")) {
             
                    no++;
                    String code_b     = request.getParameter("icode_" + y);
                    String quantity_a = request.getParameter("Qty_" + y);
                    if (quantity_a.isEmpty() || quantity_a == null)
                        quantity_a = "0";
                    int jumlah2 = Integer.parseInt(quantity_a);
                    System.out.println("Masuk Pilihan, looping ="+no+ " code_b= "+code_b+" quantity_a = "+jumlah2 );
             
             
                    // find item di array
                    for (int x=0; x < kode1.length ; x++) {
                        if(kode1[x] == null)
                            kode1[x] = "";
             
                        if(!kode1[x].equalsIgnoreCase("") && kode1[x].trim().equalsIgnoreCase(code_b) ) {
                            code = kode1[x];
                            // update before
                            jumlah1[x] = jumlah1[x] + jumlah2;
                            status2 = 1;
                            System.out.println("Masuk change "+code_b+ " Update nilai Jumlah= "+jumlah1[x]+ " Status= "+ status2);
                            continue;
             
                        } else {
                            status2 = 0;
                        }
             
                    }
             
                    // kondisi beda
                    if(!code_b.equalsIgnoreCase(code)) {
             
                        if(!code.equalsIgnoreCase("")) {
                            if(no > 1 && status2 < 1) {
             
             
                                // find item di array
                                for (int x=0; x < kode1.length ; x++) {
                                    if(kode1[x] == null)
                                        kode1[x] = "";
             
                                    if(!kode1[x].equalsIgnoreCase("") && kode1[x].trim().equalsIgnoreCase(code_b) ) {
                                        code = kode1[x];
                                        // update before
                                        jumlah1[x] = jumlah1[x] + jumlah2;
                                        status2 = 1;
                                        System.out.println("Masuk change 2 "+code_b+ " Update nilai Jumlah= "+jumlah1[x]+ " Status= "+ status2);
                                        continue;
             
                                    } else {
                                        status2 = 0;
             
                                nomor++;
                                urut[nomor-1] = nomor ;
                                kode1[nomor-1] = code1 ;
                                jumlah1[nomor-1] = qty1 ;
                                System.out.println("Masuk Array A, urut="+nomor+ " code1="+code1+" qty1= "+qty1+ " status2 : "+status2+ " Nilai no :"+no);
             
                                    }
             
                                }
             
             
             
                                nomor++;
                                urut[nomor-1] = nomor ;
                                kode1[nomor-1] = code1 ;
                                jumlah1[nomor-1] = qty1 ;
                                System.out.println("Masuk Array A, urut="+nomor+ " code1="+code1+" qty1= "+qty1+ " status2 : "+status2+ " Nilai no :"+no);
             
                            }
             
                        }
             
                        code = code_b;
                        qty1  = jumlah2;
                        code1 = code_b;
             
                    }
                    // kondisi sama
                    else{
                        // chek nilai code1
             
                        if(!code1.equalsIgnoreCase(code_b)) {
                            qty1  = qty1 + jumlah2;
                            code = code_b;
                        }else{
             
                            qty1  = qty1 + jumlah2;
                            code1 = code_b;
                        }
             
                    } // end if
             
                }  // !code_a.equalsIgnoreCase("")
             
             
            } // end for itemSales
             
            nomor++;
            // masukin array
            if(status2 > 0) {
                urut[nomor-1] = nomor ;
                kode1[nomor-1] = code1 ;
                jumlah1[nomor-1] = qty1 ;
                System.out.println("Masuk Array C , urut="+nomor+ " code1="+code1+" qty1= "+qty1);
             
            } else {
                // update nilai akhir array
                // jumlah1[nomor-2] = jumlah1[nomor-2] + qty1;
                jumlah1[nomor-2] = jumlah1[nomor-2] + 1;
                System.out.println("update akhir, urut="+(nomor-2)+" jumlah1[nomor-2] = "+jumlah1[nomor-2]);
            }
             
             
            // print nilai akhir array
            for (int x=0; x < kode1.length ; x++) {
             
                if(!kode1[x].equalsIgnoreCase("")) {
                    System.out.println("Nilai kode1-"+x+" = "+kode1[x]+ " Jumlah-"+x+" = "+jumlah1[x]);
                }
            }
             
             */
            //   akhir akumulasi
        
    }

    private void parseSalesOrderFormHEForce(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        double qtyFoc = 0;
        
        int totalQtyOrder = 0;
        double totalBv1 = 0.0D;
        double totalBv2 = 0.0D;
        double totalBv3 = 0.0D;
        double totalBv4 = 0.0D;
        double totalBv5 = 0.0D;
        double totalBvSalesAmt = 0.0D;
        double totalNoBvSalesAmt = 0.0D;
        double totalGrossSalesAmt = 0.0D;
        double totalChiSalesAmt = 0.0D;
        double totalCorpSalesAmt = 0.0D;
        
        double totalDiscountAmt = 0.0D;
        
        try {
            resetSales(sales);
            ProductManager productMgr = new ProductManager();
            ProductPricingManager pricingMgr = new ProductPricingManager();
            UtilsManager utilsMgr = new UtilsManager();
            
            //String irate = request.getParameter("irate");
            //System.out.println("01. nilai irate " + irate);
            
            String tanggal = request.getParameter("tanggal");
            System.out.println("01. nilai bonusdate " + tanggal);
            
            System.out.println("1. mulai for ");
            
            StringBuffer kode = new StringBuffer();
            StringBuffer kode2 = new StringBuffer();
            
            StringBuffer brand = new StringBuffer();
            StringBuffer jum = new StringBuffer();
            StringBuffer harga = new StringBuffer();
            StringBuffer disc = new StringBuffer();
            
            // Update KIT, variable : ulangi_kit2
            String ulang = request.getParameter("ulangi_kit2");
            int ulangi = Integer.parseInt(request.getParameter("ulangi_kit2"));
            System.out.println(" nilai ulang " + ulangi);
            
            for(int i=1;i<ulangi ;i++) {
                String productSerial = "";
                String productCode = "";
                String quantity1 = "";
                String quantity = request.getParameter("Qty_" + i);
                productSerial = request.getParameter("icode_" + i);
                
                String irate = request.getParameter("irate_" + i);
                System.out.println("01. nilai irate " + irate);
                
                if(i>5) {
                    if (quantity.isEmpty() || quantity == null || quantity.equalsIgnoreCase("0")) {
                        quantity = "1";
                        quantity1 = "0";
                    }else{
                        quantity1 = quantity;
                    }
                    
                } else {
                    if (quantity.isEmpty() || quantity == null)
                        quantity = "";
                }
                
                if (productSerial.isEmpty() || productSerial == null)
                    productSerial = "";
                
                if (productCode.isEmpty() || productCode == null)
                    productCode = "";
                
                System.out.println("2. Item Serial "+productSerial+ " Item Product "+productCode+ "  Qty " + quantity);
                
                if(quantity != null && quantity.length() > 0 && productSerial != null && productSerial.length() > 0) {
                    int Qty = Integer.parseInt(quantity);
                    String diskon = request.getParameter("Foc_" + i);
                    
                    if (diskon.isEmpty() || diskon == null)
                        diskon = "0";
                    System.out.println("3. mulai Foc " + diskon);
                    
                    // productSerial = request.getParameter("icode_" + i);
                    // if (productSerial.isEmpty() || productSerial == null)
                    //    productSerial = "";
                    
                    productCode = productMgr.getIdProduct(productSerial).getProductCode();
                    
                    
                    System.out.println(" productCode "+productCode);
                    double Disc1 = Double.valueOf((diskon).trim()).doubleValue();
                    
                    System.out.println("3. nilai diskon " + Disc1 + " icode "+productSerial + " productCode "+productCode);
                    kode.append(productSerial).append((new StringBuilder("\r\n"))).toString();
                    kode2.append(productCode).append((new StringBuilder("\r\n"))).toString();
                    
                    if(1>5) {
                        jum.append(quantity1).append((new StringBuilder("\r\n"))).toString();
                    }else{
                        jum.append(quantity).append((new StringBuilder("\r\n"))).toString();
                    }
                    
                    disc.append(diskon).append((new StringBuilder("\r\n"))).toString();
                    
                    String Unitsales = request.getParameter("isales_" + i);
                    if (Unitsales.isEmpty() || Unitsales == null)
                        Unitsales = "";
                    
                    int idproduct = productMgr.getIdProduct(productSerial).getProductID();
                    String skuproduct = productMgr.getIdProduct(productSerial).getSkuCode();
                    String descproduct = productMgr.getIdProduct(productSerial).getDefaultDesc();
                    int idign = productMgr.getIdProduct(productSerial).getProductIGN();
                    int idcat = productMgr.getIdProduct(productSerial).getCatID();
                    
                    // tuk HE Force
                    int idpricing = pricingMgr.getIdProductPricingUpdateHEForce(productCode, Sys.getDateFormater().format(sales.getBonusDate()), sales.getTrxTime(), sales.getSellerID()).getPricingID();
                    //double pricerate = Double.valueOf(request.getParameter("irate").trim()).doubleValue();
                    double pricerate = 0;
                    if(request.getParameter("irateCcy_"+i) != null && !request.getParameter("irateCcy_"+i).trim().equalsIgnoreCase("")){
                        pricerate = ppm.getRateMultiCurrency(request.getParameter("irateCcy_"+i).trim()).getSymbol(); //Updated By Mila 2016-04-05
                    }else{
                        pricerate = 0.0d;
                    } 
                   
                    System.out.println("3a. nilai icode " + productSerial + " productCode : " + productCode + " nilai isales " + Unitsales + " nilai pricerate " + pricerate);
                    
                    if(Qty > 0) {
                        ProductBean productBean = productMgr.getProductSet(idproduct, getLoginUser().getLocale().toString());
                        ProductPricingBean priceBean = pricingMgr.getProductPricingHE(productCode, idpricing);
                        harga.append((priceBean.getPrice() - (priceBean.getPrice() * priceBean.getBv1())) * pricerate).append((new StringBuilder("\r\n"))).toString();
                        brand.append(productBean.getProductCategory().getName()).append((new StringBuilder("\r\n"))).toString();
                        
                        productBean.setCurrentPricing(priceBean);
                        CounterSalesItemBean itemSales = new CounterSalesItemBean();
                        itemSales.setPricingID(idpricing);
                        itemSales.setProductID(idproduct);
                        itemSales.setInventory(productBean.getInventory());
                        itemSales.setQtyOrder(Qty);
                        
                        itemSales.setProductIGN(idign);
                        itemSales.setProductCat(idcat);
                        itemSales.setProductCode(productCode);
                        itemSales.setProductSKU(skuproduct);
                        itemSales.setProductDesc(descproduct);
                        
                        System.out.println(" nilai idign " + idign + " idcat : " + idcat + " skuproduct " + skuproduct + " descproduct " + descproduct);
                        
                        // chek kit
                        String qty_kit = request.getParameter("Qty_" + i);
                        if(i>5 && qty_kit.equalsIgnoreCase("0")) {
                            itemSales.setDeliveryStatus(0);
                        }else {
                            itemSales.setDeliveryStatus(20);
                        }
                        
                        // itemSales.setDeliveryStatus(sales.getDeliveryStatus());
                        
                        itemSales.setProductBean(productBean);
                        
                        if(Qty > 0) {
                            // nilai rate
                            itemSales.setBv1(pricerate);
                            itemSales.setBv2(Qty);
                            itemSales.setBv3(0.0D);
                            itemSales.setBv4(0.0D);
                            itemSales.setBv5(0.0D);
                            
                            // itemSales.setUnitPrice(priceBean.getPrice());
                            // itemSales.setUnitNetPrice((priceBean.getPrice()*Qty*pricerate) - Disc1);
                            
                            itemSales.setUnitPrice((priceBean.getPrice() - (priceBean.getPrice() * priceBean.getBv1())));
                            itemSales.setUnitNetPrice(( (priceBean.getPrice() - (priceBean.getPrice() * priceBean.getBv1())) *Qty*pricerate) - Disc1);
                            
                            itemSales.setUnitDiscount(Disc1);
                            itemSales.setUnitSales(Unitsales);
                            
                            double chiItemUnitPrice = getTypeUnit(productBean.getSkuCode(), itemSales.getUnitPrice(), itemSales.getBv1(), 2);
                            double coprItemUnitPrice = getTypeUnit(productBean.getSkuCode(), itemSales.getUnitPrice(), itemSales.getBv1(), 3);
                            
                            itemSales.setChiUnitPrice(chiItemUnitPrice);
                            itemSales.setCorpUnitPrice(coprItemUnitPrice);
                            
                            totalGrossSalesAmt += (double)((Qty * itemSales.getUnitPrice() * pricerate) - Disc1) ;
                            totalChiSalesAmt += (double)((Qty * chiItemUnitPrice * pricerate) - Disc1);
                            totalCorpSalesAmt += (double)((Qty * coprItemUnitPrice * pricerate) - Disc1);
                            
                            totalDiscountAmt += (double)Disc1 * 1;
                            
                            double qtyAmt = (double)((Qty * itemSales.getUnitPrice() * pricerate) - Disc1) ;
                            // if(itemSales.getBv1() > 0.0D)
                            totalBvSalesAmt += qtyAmt;
                            //else
                            totalNoBvSalesAmt += qtyAmt;
                            
                            itemSales.setProductType(0);
                            
                            System.out.println("3b. masuk item id pricing " + idpricing + " id product " + idproduct);
                        }
                        
                        
                        ProductItemBean components[] = (ProductItemBean[])productBean.getProductItemBeanList().toArray(new ProductItemBean[0]);
                        for(int st = 0; st < components.length; st++) {
                            ProductBean pd = components[st].getItemProductBean();
                            CounterSalesProductBean itemProduct = new CounterSalesProductBean();
                            itemProduct.setProductType(itemSales.getProductType());
                            itemProduct.setProductID(pd.getProductID());
                            itemProduct.setInventory(pd.getInventory());
                            itemProduct.setQtyUnit(components[st].getQtySale());
                            itemProduct.setQtyOrder(Qty * components[st].getQtySale());
                            
                            // chek kit
                            if(i > 5 && qty_kit.equalsIgnoreCase("0")) {
                                itemProduct.setQtyKiv(1);
                                // System.out.println(" sampai sini ga yah : " + itemProduct.getQtyKiv());
                                
                            }else {
                                itemProduct.setQtyKiv(Qty * components[st].getQtySale());
                            }
                            
                            // itemProduct.setQtyKiv(Qty * components[st].getQtySale());
                            
                            itemProduct.setProductBean(pd);
                            itemSales.addProduct(itemProduct);
                            
                            System.out.println("3c. masuk item product inventory " + pd.getProductID() + " unit " + components[st].getQtySale() );
                        }
                        
                        sales.addItem(itemSales);
                        totalQtyOrder += Qty;
                        
                    }  // end of Qty > 0)
                    
                }  // end of Qty not null
                
            }  // end of for - next
            
            sales.setRemark(request.getParameter("Remark"));
            sales.setTotalBv1(totalBv1);
            
            sales.setTotalBv3(totalBv3);
            sales.setTotalBv4(totalBv4);
            sales.setTotalBv5(totalDiscountAmt);
            
            // just entry - next harus diubah
            String quant = request.getParameter("Qty_1");
            if (quant.isEmpty() || quant == null)
                quant = "0";
            
            double quant1 = Double.valueOf((quant).trim()).doubleValue();
            
            String quant2 = request.getParameter("Foc_1");
            if (quant2.isEmpty() || quant2 == null)
                quant2 = "0";
            
            double quant3 = Double.valueOf((quant2).trim()).doubleValue();
            
            
            sales.setShipReceiver(brand.toString());
            sales.setShipAddress1(kode.toString());
            sales.setShipRemark(kode2.toString());
            
            sales.setShipCountry(jum.toString());
            sales.setShipRegion(harga.toString());
            sales.setShipState(disc.toString());
            
            System.out.println(" StringBuffer 2 kode : " + kode + " kode 2 : " + kode2 + " brand : " + brand + " harga : " + harga );
            
            sales.setTotalBv2(quant1);
            sales.setTotalBv3(quant3);
            
            parseSalesMiscCharges(sales, returnBean, request);
            
            sales.setBvSalesAmount(utilsMgr.roundDouble(totalBvSalesAmt, 2));
            sales.setNonBvSalesAmount(utilsMgr.roundDouble(totalNoBvSalesAmt, 2));
            sales.setNetSalesAmount(utilsMgr.roundDouble(totalGrossSalesAmt + sales.getMiscAmount(), 2));
            sales.setChiSalesAmount(utilsMgr.roundDouble(totalChiSalesAmt + sales.getMiscAmount(), 2));
            sales.setCorpSalesAmount(utilsMgr.roundDouble(totalCorpSalesAmt, 2));
            parseSalesPayment(sales, returnBean, request);
            
            
            // sementara dihide, krn ada Sales Invoice Return
            /*
            if(sales.getNetSalesAmount() > 0.0D) {
                if(sales.getPaymentTender() < sales.getNetSalesAmount())
                    returnBean.addError((new StringBuilder("Payment is not tally with the Net Total Sales ")).append(sales.getNetSalesAmount()).toString());
            } else
                if(sales.getPaymentTender() > 0.0D)
                    returnBean.addError((new StringBuilder("No payment for the Sales Order, Net Total Sales is ")).append(sales.getNetSalesAmount()).toString());
             */
            
        } catch(Exception ex) {
            returnBean.addError("error disini parseSalesOrderFormHEForce"+ ex.getMessage());
        }
        
    }
    
    private void parseSalesOrderFormHEForceReturn(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        double qtyFoc = 0;
        
        int totalQtyOrder = 0;
        double totalBv1 = 0.0D;
        double totalBv2 = 0.0D;
        double totalBv3 = 0.0D;
        double totalBv4 = 0.0D;
        double totalBv5 = 0.0D;
        double totalBvSalesAmt = 0.0D;
        double totalNoBvSalesAmt = 0.0D;
        double totalGrossSalesAmt = 0.0D;
        double totalChiSalesAmt = 0.0D;
        double totalCorpSalesAmt = 0.0D;
        
        double totalDiscountAmt = 0.0D;
        
        try {
            resetSales(sales);
            ProductManager productMgr = new ProductManager();
            ProductPricingManager pricingMgr = new ProductPricingManager();
            UtilsManager utilsMgr = new UtilsManager();
            
            //String irate = request.getParameter("irate");
            //System.out.println("01. nilai irate " + irate);
            
            String tanggal = request.getParameter("tanggal");
            System.out.println("01. nilai bonusdate " + tanggal);
            
            System.out.println("1. mulai for ");
            
            StringBuffer kode = new StringBuffer();
            StringBuffer kode2 = new StringBuffer();
            
            StringBuffer brand = new StringBuffer();
            StringBuffer jum = new StringBuffer();
            StringBuffer harga = new StringBuffer();
            StringBuffer disc = new StringBuffer();
            
            // Update KIT, variable : ulangi_kit2
            String ulang = request.getParameter("ulangi_kit2");
            int ulangi = Integer.parseInt(request.getParameter("ulangi_kit2"));
            System.out.println(" nilai ulang " + ulangi);
            
            for(int i=1;i<ulangi ;i++) {
                String productSerial = "";
                String productCode = "";
                String quantity1 = "";
                String quantity = request.getParameter("Qty_" + i);
                productSerial = request.getParameter("icode_" + i);
                
                String irate = request.getParameter("irate_" + i);
                System.out.println("01. nilai irate " + irate);
            
                
                //String irate = request.getParameter("irate_" + i);
                //System.out.println("01. nilai irate " + irate);
                
                if(i>5) {
                    if (quantity.isEmpty() || quantity == null || quantity.equalsIgnoreCase("0")) {
                        quantity = "1";
                        quantity1 = "0";
                    }else{
                        quantity1 = quantity;
                    }
                    
                } else {
                    if (quantity.isEmpty() || quantity == null)
                        quantity = "";
                }
                
                if (productSerial.isEmpty() || productSerial == null)
                    productSerial = "";
                
                if (productCode.isEmpty() || productCode == null)
                    productCode = "";
                
                System.out.println("2. Item Serial "+productSerial+ " Item Product "+productCode+ "  Qty " + quantity);
                
                if(quantity != null && quantity.length() > 0 && productSerial != null && productSerial.length() > 0) {
                    int Qty = Integer.parseInt(quantity);
                    String diskon = request.getParameter("Foc_" + i);
                    
                    if (diskon.isEmpty() || diskon == null)
                        diskon = "0";
                    System.out.println("3. mulai Foc " + diskon);
                    
                    // productSerial = request.getParameter("icode_" + i);
                    // if (productSerial.isEmpty() || productSerial == null)
                    //    productSerial = "";
                    
                    productCode = productMgr.getIdProduct(productSerial).getProductCode();                    
                    
                    System.out.println(" productCode "+productCode);
                    double Disc1 = Double.valueOf((diskon).trim()).doubleValue();
                    
                    System.out.println("3. nilai diskon " + Disc1 + " icode "+productSerial + " productCode "+productCode);
                    kode.append(productSerial).append((new StringBuilder("\r\n"))).toString();
                    kode2.append(productCode).append((new StringBuilder("\r\n"))).toString();
                    
                    if(1>5) {
                        jum.append(quantity1).append((new StringBuilder("\r\n"))).toString();
                    }else{
                        jum.append(quantity).append((new StringBuilder("\r\n"))).toString();
                    }
                    
                    disc.append(diskon).append((new StringBuilder("\r\n"))).toString();
                    
                    String Unitsales = request.getParameter("isales_" + i);
                    if (Unitsales.isEmpty() || Unitsales == null)
                        Unitsales = "";
                    
                    int idproduct = productMgr.getIdProduct(productSerial).getProductID();
                    String skuproduct = productMgr.getIdProduct(productSerial).getSkuCode();
                    String descproduct = productMgr.getIdProduct(productSerial).getDefaultDesc();
                    int idign = productMgr.getIdProduct(productSerial).getProductIGN();
                    int idcat = productMgr.getIdProduct(productSerial).getCatID();
                    
                    // tuk HE Force
                    int idpricing = pricingMgr.getIdProductPricingUpdateHEForce(productCode, Sys.getDateFormater().format(sales.getBonusDate()), sales.getTrxTime(), sales.getSellerID()).getPricingID();
                    //double pricerate = Double.valueOf(request.getParameter("irate").trim()).doubleValue();
                    double pricerate = 0;
                    if(request.getParameter("irateCcy_"+i) != null && !request.getParameter("irateCcy_"+i).trim().equalsIgnoreCase("")){
                        pricerate = ppm.getRateMultiCurrency(request.getParameter("irateCcy_"+i).trim()).getSymbol(); //Updated By Mila 2016-04-05
                    }else{
                        pricerate = 0.0d;
                    } 
                    
                    System.out.println("3a. nilai icode " + productSerial + " productCode : " + productCode + " nilai isales " + Unitsales + " nilai pricerate " + pricerate);
                    
                    if(Qty > 0) {
                        ProductBean productBean = productMgr.getProductSet(idproduct, getLoginUser().getLocale().toString());
                        ProductPricingBean priceBean = pricingMgr.getProductPricingHE(productCode, idpricing);
                        harga.append((priceBean.getPrice() - (priceBean.getPrice() * priceBean.getBv1())) * pricerate).append((new StringBuilder("\r\n"))).toString();
                        brand.append(productBean.getProductCategory().getName()).append((new StringBuilder("\r\n"))).toString();
                        
                        productBean.setCurrentPricing(priceBean);
                        CounterSalesItemBean itemSales = new CounterSalesItemBean();
                        itemSales.setPricingID(idpricing);
                        itemSales.setProductID(idproduct);
                        itemSales.setInventory(productBean.getInventory());
                        itemSales.setQtyOrder(Qty);
                        
                        itemSales.setProductIGN(idign);
                        itemSales.setProductCat(idcat);
                        itemSales.setProductCode(productCode);
                        itemSales.setProductSKU(skuproduct);
                        itemSales.setProductDesc(descproduct);
                        
                        System.out.println(" nilai idign " + idign + " idcat : " + idcat + " skuproduct " + skuproduct + " descproduct " + descproduct);
                        
                        // chek kit
                        String qty_kit = request.getParameter("Qty_" + i);
                        if(i>5 && qty_kit.equalsIgnoreCase("0")) {
                            itemSales.setDeliveryStatus(0);
                        }else {
                            itemSales.setDeliveryStatus(20);
                        }
                        
                        // itemSales.setDeliveryStatus(sales.getDeliveryStatus());
                        
                        itemSales.setProductBean(productBean);
                        
                        if(Qty > 0) {
                            // nilai rate
                            itemSales.setBv1(pricerate);
                            itemSales.setBv2(Qty);
                            itemSales.setBv3(0.0D);
                            itemSales.setBv4(0.0D);
                            itemSales.setBv5(0.0D);
                            
                            // itemSales.setUnitPrice(priceBean.getPrice());
                            // itemSales.setUnitNetPrice((priceBean.getPrice()*Qty*pricerate) - Disc1);
                            
                            itemSales.setUnitPrice((priceBean.getPrice() - (priceBean.getPrice() * priceBean.getBv1())));
                            itemSales.setUnitNetPrice(( (priceBean.getPrice() - (priceBean.getPrice() * priceBean.getBv1())) *Qty*pricerate) - Disc1);
                            
                            itemSales.setUnitDiscount(Disc1);
                            itemSales.setUnitSales(Unitsales);
                            
                            double chiItemUnitPrice = getTypeUnit(productBean.getSkuCode(), itemSales.getUnitPrice(), itemSales.getBv1(), 2);
                            double coprItemUnitPrice = getTypeUnit(productBean.getSkuCode(), itemSales.getUnitPrice(), itemSales.getBv1(), 3);
                            
                            itemSales.setChiUnitPrice(chiItemUnitPrice);
                            itemSales.setCorpUnitPrice(coprItemUnitPrice);
                            
                            totalGrossSalesAmt += (double)((Qty * itemSales.getUnitPrice() * pricerate) - Disc1) ;
                            totalChiSalesAmt += (double)((Qty * chiItemUnitPrice * pricerate) - Disc1);
                            totalCorpSalesAmt += (double)((Qty * coprItemUnitPrice * pricerate) - Disc1);
                            
                            totalDiscountAmt += (double)Disc1 * 1;
                            
                            double qtyAmt = (double)((Qty * itemSales.getUnitPrice() * pricerate) - Disc1) ;
                            // if(itemSales.getBv1() > 0.0D)
                            totalBvSalesAmt += qtyAmt;
                            //else
                            totalNoBvSalesAmt += qtyAmt;
                            
                            itemSales.setProductType(0);
                            
                            System.out.println("3b. masuk item id pricing " + idpricing + " id product " + idproduct);
                        }                        
                        
                        ProductItemBean components[] = (ProductItemBean[])productBean.getProductItemBeanList().toArray(new ProductItemBean[0]);
                        for(int st = 0; st < components.length; st++) {
                            ProductBean pd = components[st].getItemProductBean();
                            CounterSalesProductBean itemProduct = new CounterSalesProductBean();
                            itemProduct.setProductType(itemSales.getProductType());
                            itemProduct.setProductID(pd.getProductID());
                            itemProduct.setInventory(pd.getInventory());
                            itemProduct.setQtyUnit(components[st].getQtySale());
                            itemProduct.setQtyOrder(Qty * components[st].getQtySale());
                            
                            // chek kit
                            if(i > 5 && qty_kit.equalsIgnoreCase("0")) {
                                itemProduct.setQtyKiv(1);
                                // System.out.println(" sampai sini ga yah : " + itemProduct.getQtyKiv());
                                
                            }else {
                                itemProduct.setQtyKiv(Qty * components[st].getQtySale());
                            }
                            
                            // itemProduct.setQtyKiv(Qty * components[st].getQtySale());
                            
                            itemProduct.setProductBean(pd);
                            itemSales.addProduct(itemProduct);
                            
                            System.out.println("3c. masuk item product inventory " + pd.getProductID() + " unit " + components[st].getQtySale() );
                        }
                        
                        sales.addItem(itemSales);
                        totalQtyOrder += Qty;
                        
                    }  // end of Qty > 0)
                    
                }  // end of Qty not null
                
            }  // end of for - next
            
            sales.setRemark(request.getParameter("Remark"));
            sales.setAdjstRemark(request.getParameter("Remark"));
            sales.setTotalBv1(totalBv1);
            
            sales.setTotalBv3(totalBv3);
            sales.setTotalBv4(totalBv4);
            sales.setTotalBv5(totalDiscountAmt);
            
            // just entry - next harus diubah
            String quant = request.getParameter("Qty_1");
            if (quant.isEmpty() || quant == null)
                quant = "0";
            
            double quant1 = Double.valueOf((quant).trim()).doubleValue();
            
            String quant2 = request.getParameter("Foc_1");
            if (quant2.isEmpty() || quant2 == null)
                quant2 = "0";
            
            double quant3 = Double.valueOf((quant2).trim()).doubleValue();
                        
            sales.setShipReceiver(brand.toString());
            sales.setShipAddress1(kode.toString());
            sales.setShipRemark(kode2.toString());
            
            sales.setShipCountry(jum.toString());
            sales.setShipRegion(harga.toString());
            sales.setShipState(disc.toString());
            
            System.out.println(" StringBuffer 2 kode : " + kode + " kode 2 : " + kode2 + " brand : " + brand + " harga : " + harga );
            
            sales.setTotalBv2(quant1);
            sales.setTotalBv3(quant3);
            
            parseSalesMiscCharges(sales, returnBean, request);
            
            sales.setBvSalesAmount(utilsMgr.roundDouble(totalBvSalesAmt, 2));
            sales.setNonBvSalesAmount(utilsMgr.roundDouble(totalNoBvSalesAmt, 2));
            sales.setNetSalesAmount(utilsMgr.roundDouble(totalGrossSalesAmt + sales.getMiscAmount(), 2));
            sales.setChiSalesAmount(utilsMgr.roundDouble(totalChiSalesAmt + sales.getMiscAmount(), 2));
            sales.setCorpSalesAmount(utilsMgr.roundDouble(totalCorpSalesAmt, 2));
            
            // parseSalesPayment(sales, returnBean, request);
                        
            // sementara dihide, krn ada Sales Invoice Return
            /*
            if(sales.getNetSalesAmount() > 0.0D) {
                if(sales.getPaymentTender() < sales.getNetSalesAmount())
                    returnBean.addError((new StringBuilder("Payment is not tally with the Net Total Sales ")).append(sales.getNetSalesAmount()).toString());
            } else
                if(sales.getPaymentTender() > 0.0D)
                    returnBean.addError((new StringBuilder("No payment for the Sales Order, Net Total Sales is ")).append(sales.getNetSalesAmount()).toString());
             */
            
        } catch(Exception ex) {
            returnBean.addError("error Return Force disini "+ ex.getMessage());
        }
        
    }
    
    private void parseDeliveryBean(DeliveryOrderBean doBean, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            doBean.setShippingAddressBean(new AddressBean());
            getRequestParser().parse(doBean, request);
            getRequestParser().parse(doBean.getShippingAddressBean(), request);
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void parseFullDeliveryOrderForm(CounterSalesOrderBean salesBean, DeliveryOrderBean doBean, MvcReturnBean returnBean) {
        try {
            CounterSalesItemBean itemList[] = salesBean.getItemArray();
            for(int i = 0; i < itemList.length; i++) {
                
                CounterSalesItemBean itemSales = itemList[i];
                DeliveryItemBean itemDo = new DeliveryItemBean();
                itemDo.setProductID(itemSales.getProductID());
                itemDo.setProductType(itemSales.getProductType());
                itemDo.setInventory(itemSales.getInventory());
                itemDo.setMaster(doBean);
                
                // kit
                if(itemSales.getDeliveryStatus() == 20)
                    doBean.addItem(itemDo);
                
                // System.out.println("3. masuk parseFullDeliveryOrderForm " + itemSales.getProductID());
                
                CounterSalesProductBean productList[] = itemSales.getProductArray();
                for(int j = 0; j < productList.length; j++) {
                    CounterSalesProductBean itemProduct = productList[j];
                    
                    if(itemSales.getDeliveryStatus() == 0) {
                        itemProduct.setQtyKiv(1);
                        // System.out.println("itemProduct.setQtyKiv(1)  " + itemProduct.getQtyKiv());
                    }else{
                        itemProduct.setQtyKiv(0);
                    }
                    
                    // itemProduct.setQtyKiv(0);
                    
                    DeliveryProductBean doProduct = new DeliveryProductBean();
                    doProduct.setProductID(itemProduct.getProductID());
                    doProduct.setProductType(itemProduct.getProductType());
                    doProduct.setInventory(itemProduct.getInventory());
                    doProduct.setQty(itemProduct.getQtyOrder());
                    doProduct.setQtyKiv(itemProduct.getQtyKiv());
                    itemDo.addProduct(doProduct);
                }
                
            }
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void parseDeliveryOrderForm(CounterSalesOrderBean salesBean, DeliveryOrderBean doBean, MvcReturnBean returnBean, HttpServletRequest request, boolean checkInventory) {
        Connection conn;
        InventoryManager_1 invMgr;
        HashMap invMap;
        boolean isError;
        int totalIssue;
        conn = null;
        invMgr = null;
        invMap = null;
        isError = false;
        totalIssue = 0;
        try {
            resetDelivery(doBean);
            ProductManager productMgr = new ProductManager();
            if(checkInventory) {
                conn = getConnection();
                invMap = new HashMap();
                invMgr = getInventoryManager(conn);
            }
            String qty[] = request.getParameterValues("PrdtQtyIssued");
            CounterSalesItemBean itemSales[] = salesBean.getItemArray();
            for(int i = 0; i < itemSales.length; i++) {
                DeliveryItemBean itemDo = null;
                CounterSalesProductBean itemProduct[] = itemSales[i].getProductArray();
                ProductBean productBean = productMgr.getProduct(itemSales[i].getProductID());
                for(int k = 0; k < itemProduct.length; k++) {
                    // tambah tuk KIT
                    if(itemSales[i].getDeliveryStatus() == 0) {
                        
                        int issueQty = 0;
                        int qtyKiv = 0;
                        String prdtCode = itemProduct[k].getProductBean().getProductCode();
                        try {
                            String key = request.getParameter((new StringBuilder(String.valueOf(itemSales[i].getProductID()))).append("*@").append(itemProduct[k].getProductID()).append("*@F").append(itemSales[i].getProductType()).toString());
                            issueQty = Integer.parseInt(qty[Integer.parseInt(key)]);
                            qtyKiv = itemProduct[k].getQtyKiv();
                            totalIssue += issueQty;
                            
                            System.out.println(" itemSales[i]= " + itemSales[i].getSeq() + " itemSales[i]= " + itemSales[i].getSalesID() + " itemSales[i].getProductID()= "+ itemSales[i].getProductID() + " productBean= " + productBean.getProductCode() + " itemSales[i].getDeliveryStatus()="+itemSales[i].getDeliveryStatus()+ " qtyKiv= "+qtyKiv+" issueQty= "+issueQty);
                            
                            
                        } catch(Exception exception) { }
                        
                        if(issueQty > 0) {
                            // sementara diremark, valid di JSP aja
                            
                            if(issueQty > qtyKiv) {
                                isError = true;
                                returnBean.addError((new StringBuilder("Invalid Qty Issue of Product ")).append(prdtCode).append(" -> Qty Issue: ").append(issueQty).append(" > ").append(" Qty Left: ").append(qtyKiv).toString());
                            }
                            
                            if(checkInventory) {
                                int balance = 0;
                                String prdtIDStr = String.valueOf(itemProduct[k].getProductID());
                                if(invMap.containsKey(prdtIDStr))
                                    balance = ((Integer)invMap.get(prdtIDStr)).intValue();
                                else
                                    balance = invMgr.getProductBalance(itemProduct[k].getProductID(), doBean.getShipByOutletID(), null);
                                if(issueQty > balance)
                                    returnBean.addError((new StringBuilder("Not enough stock of Product ")).append(prdtCode).append(" for delivery. Current Stock Balance is ").append(balance).toString());
                                else
                                    balance -= issueQty;
                                invMap.put(prdtIDStr, new Integer(balance));
                            }
                            if(!isError) {
                                if(itemDo == null) {
                                    itemDo = new DeliveryItemBean();
                                    itemDo.setProductID(itemSales[i].getProductID());
                                    itemDo.setProductType(itemSales[i].getProductType());
                                    itemDo.setInventory(productBean.getInventory());
                                    itemDo.setMaster(doBean);
                                    doBean.addItem(itemDo);
                                }
                                ProductBean component = productMgr.getProduct(itemProduct[k].getProductID());
                                DeliveryProductBean doProduct = new DeliveryProductBean();
                                doProduct.setProductID(itemProduct[k].getProductID());
                                doProduct.setProductType(itemProduct[k].getProductType());
                                doProduct.setInventory(component.getInventory());
                                doProduct.setQty(issueQty);
                                doProduct.setQtyKiv(itemProduct[k].getQtyKiv() - issueQty);
                                itemDo.addProduct(doProduct);
                            }
                        }
                    }
                    
                }  // tambahan tuk kit
                
            }
            
            if(totalIssue == 0)
                returnBean.addError("Total issue is ZERO. Failed to procceed.");
        } catch(Exception e) {
            Log.error(e);
            returnBean.addError(e.getMessage());
        }
        
        releaseConnection(conn);
        if(invMgr != null)
            invMgr = null;
    }
    
    private void parseVoidDeliveryBean(DeliveryOrderBean voidBean, String adjstRemark)
    throws Exception {
        voidBean.setAdjstRemark(adjstRemark);
        voidBean.setAdjstRefNo(voidBean.getTrxDocNo());
        voidBean.setAdjstDeliveryID(voidBean.getDeliveryID().intValue());
        voidBean.setTrxDate(new Date());
        voidBean.setTrxTime(new Time((new Date()).getTime()));
        voidBean.setTrxDocType("GRN");
        voidBean.setTrxDocName("Good Return Note");
        voidBean.setTrxGroup(30);
        voidBean.setStatus(-10);
        voidBean.setDeliveryID(null);
        voidBean.setTrxDocNo(null);
        voidBean.resetMvcInfo();
    }
    
    private void parseVoidDeliveryForm(DeliveryOrderBean voidBean, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            
            String adjstRemark = request.getParameter("AdjstRemark");
            
            if(adjstRemark != null || adjstRemark.isEmpty() )
                 adjstRemark = "FORCE RETURN";
            
            parseVoidDeliveryBean(voidBean, adjstRemark);
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    public void parseSalesDeliveryStatus(CounterSalesOrderBean sales, DeliveryOrderBean delivery)
    throws MvcException {
        int Seq = 0;
        int Seq1 = 0;
        boolean isActive = delivery.getStatus() == 30;
        
        System.out.println("Masuk parseSalesDeliveryStatus bro ...");
        try {
            DeliveryItemBean itemDo[] = delivery.getItemArray();
            System.out.println("DeliveryItemBean :");
            for(int i = 0; i < itemDo.length; i++) {
                System.out.println("1. itemDo["+i+"], getDeliveryID :"+itemDo[i].getDeliveryID()+" getSeq : "+itemDo[i].getSeq()+" getProductSet : "+itemDo[i].getProductSet()+" getProductID : "+itemDo[i].getProductID()+" delivery.getItemSet : "+delivery.getItemSet()+" delivery.getSalesID : "+delivery.getSalesID());
                
                CounterSalesItemBean aItem = null;
                CounterSalesItemBean itemSales[] = sales.getItemArray();
                
                System.out.println("CounterSalesItemBean :");
                for(int y = 0; y < itemSales.length; y++) {
                    System.out.println(" 2. itemSales["+y+"], getDeliveryStatus :"+itemSales[y].getDeliveryStatus()+" getProductSet() :"+itemSales[y].getProductSet()+" getSeq() :"+itemSales[y].getSeq()+" getProductID : "+itemSales[y].getProductID());
                    
                    // if(itemSales[y].getProductID() != itemDo[i].getProductID() || itemSales[y].getProductType() != itemDo[i].getProductType())
                    // ganti tuk kit
                    if(itemSales[y].getProductID() != itemDo[i].getProductID() || itemSales[y].getDeliveryStatus() == 20 || itemSales[y].getDeliveryStatus() != 0 || itemSales[y].getSeq().intValue() == Seq)
                        continue;
                    
                    aItem = itemSales[y];
                    // kit
                    Seq = itemSales[y].getSeq().intValue();
                    System.out.println("3. aItem ke-"+y+" :"+aItem.getSeq()+" ,"+aItem.getProductSet()+" ,"+aItem.getProductID()+" Seq :"+Seq);
                    break;
                }
                
                DeliveryProductBean productDo[] = itemDo[i].getProductArray();
                
                System.out.println("DeliveryProductBean :");
                for(int j = 0; j < productDo.length; j++)
                    
                    if(productDo[j].getQty() > 0) {
                    
                    CounterSalesProductBean aProduct = null;
                    CounterSalesProductBean productSales[] = aItem.getProductArray();
                    int cek = 0;
                    
                    System.out.println("4. productDo[j].getSeq() :"+productDo[j].getSeq()+ " productDo[j].getDeliveryItemID() : "+productDo[j].getDeliveryItemID()+ " productDo[j].getProductID() :"+productDo[j].getProductID()+" productDo[j].getQty() :"+productDo[j].getQty());
                    
                    System.out.println("CounterSalesProductBean :");
                    for(int z = 0; z < productSales.length; z++) {
                        
                        System.out.println("5. productSales[z].getSeq() : "+productSales[z].getSeq()+" productSales[z].getSalesItemID() :"+ productSales[z].getSalesItemID()+ " productSales[z].getProductID() :"+ productSales[z].getProductID() + " productSales[z].getQtyOrder() :"+ productSales[z].getQtyOrder());
                        
                        // if(productSales[z].getProductID() != productDo[j].getProductID() || productSales[z].getProductType() != productDo[j].getProductType())
                        // ganti tuk kit
                        if(productSales[z].getProductID() != productDo[j].getProductID() || productSales[z].getQtyKiv() == 0 && productSales[z].getSeq().intValue() == Seq1)
                            continue;
                        
                        aProduct = productSales[z];
                        Seq1 = productSales[z].getSeq().intValue();
                        
                        System.out.println("6. productSales[z].getSeq() : "+productSales[z].getSeq()+" productSales[z].getSalesItemID() :"+ productSales[z].getSalesItemID()+ " productSales[z].getProductID() :"+ productSales[z].getProductID() + " productSales[z].getQtyKiv() :"+ productSales[z].getQtyKiv()+" Seq1 :"+Seq1);
                        
                        // kit
                        // if(aProduct.getSalesItemID() == Seq && cek != 1)
                        // {
                        
                        
                        if(isActive) {
                            aProduct.setQtyKiv(aProduct.getQtyKiv() - productDo[j].getQty());
                            System.out.println("7. Masuk isActive T "+(aProduct.getQtyKiv() - productDo[j].getQty()));
                        }else{
                            aProduct.setQtyKiv(aProduct.getQtyKiv() + productDo[j].getQty());
                            System.out.println("7. Masuk isActive F "+(aProduct.getQtyKiv() - productDo[j].getQty()));
                        }
                        
                        // tandai proses
                        // aProduct.setQtyOnHand(20);
                        // }
                        
                        break;
                        
                        
                    }
                    // } //
                    }
                
            }
            
            boolean isCompleted = true;
            boolean isPending = false;
            int totalQtyOrder = 0;
            int totalQtyKiv = 0;
            CounterSalesItemBean itemSales[] = sales.getItemArray();
            
            System.out.println("CounterSalesItemBean :");
            for(int y = 0; y < itemSales.length; y++) {
                boolean isItemCompleted = false;
                int itemDoStatus = 0;
                CounterSalesProductBean productSales[] = itemSales[y].getProductArray();
                
                // kit
                // if(itemSales[y].getSeq() == Seq)
                // {
                System.out.println("CounterSalesProductBean :");
                for(int z = 0; z < productSales.length; z++) {
                    
                    if(productSales[z].getQtyKiv() != 0)
                        isCompleted = false;
                    if(productSales[z].getQtyKiv() == 0)
                        isItemCompleted = true;
                    totalQtyOrder += productSales[z].getQtyOrder();
                    totalQtyKiv += productSales[z].getQtyKiv();
                    
                    System.out.println("productSales[z].getQtyKiv() : "+productSales[z].getQtyKiv()+" isCompleted "+isCompleted+" totalQtyOrder : "+totalQtyOrder+" totalQtyKiv : "+totalQtyKiv);
                }
                
                //}
                
                if(isItemCompleted)
                    itemDoStatus = 20;
                else
                    itemDoStatus = 0;
                
                itemSales[y].setDeliveryStatus(itemDoStatus);
                
                System.out.println("8. productSales[z].getSeq() : "+itemSales[y].getSeq()+" productSales[z].getSalesItemID() :"+ itemSales[y].getSalesID()+ " productSales[z].getProductID() :"+ itemSales[y].getProductID()+ " itemSales[y].setDeliveryStatus :"+itemSales[y].getDeliveryStatus());
            }
            
            if(isCompleted) {
                sales.setDeliveryStatus(20);
            } else {
                if(totalQtyOrder == totalQtyKiv)
                    isPending = true;
                if(isPending)
                    sales.setDeliveryStatus(0);
                else
                    sales.setDeliveryStatus(10);
            }
            
            System.out.println("9. setDeliveryStatus = "+sales.getDeliveryStatus()+ " getTrxDocNo "+sales.getTrxDocNo());
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
    }
    
    private DeliveryOrderBean createDeliveryOrderBean(CounterSalesOrderBean salesBean, boolean combineSales, boolean copySalesShipping)
    throws Exception {
        DeliveryOrderBean bean = new DeliveryOrderBean();
        if(combineSales) {
            bean.setGenerateTrxDocNo(false);
            bean.setTrxDocCode(salesBean.getTrxDocCode());
            bean.setTrxDocNo(salesBean.getTrxDocNo());
            // bean.setTrxDocType(salesBean.getTrxDocType());
            // bean.setTrxDocName(salesBean.getTrxDocName());
            bean.setTrxDocType("DT");
            bean.setTrxDocName("Delivery Note");
        } else {
            bean.setTrxDocType("DT");
            bean.setTrxDocName("Delivery Note");
        }
        if(copySalesShipping) {
            bean.setShipOption(salesBean.getShipOption());
            bean.setShipByOutletID(salesBean.getShipByOutletID());
            bean.setShipByStoreCode(salesBean.getShipByStoreCode());
            bean.setShipFromOutletID(salesBean.getShipFromOutletID());
            bean.setShipFromStoreCode(salesBean.getShipFromStoreCode());
            bean.setShipReceiver(salesBean.getShipReceiver());
            bean.setShipContact(salesBean.getShipContact());
            bean.setShipRemark(salesBean.getShipRemark());
            bean.setShippingAddressBean(salesBean.getShippingAddressBean());
        }
        if(salesBean.getSalesID() != null)
            bean.setSalesID(salesBean.getSalesID().intValue());
        bean.setTrxDate(new Date());
        bean.setTrxTime(new Time((new Date()).getTime()));
        bean.setTrxGroup(10);
        bean.setStatus(30);
        bean.setSalesRefNo(salesBean.getTrxDocNo());
        bean.setCustomerSeq(salesBean.getCustomerSeq());
        bean.setCustomerID(salesBean.getCustomerID());
        bean.setCustomerType(salesBean.getCustomerType());
        bean.setCustomerName(salesBean.getCustomerName());
        bean.setCustomerIdentityNo(salesBean.getCustomerIdentityNo());
        bean.setCustomerContact(salesBean.getCustomerContact());
        return bean;
    }
    
    private DeliveryOrderBean createDeliveryOrderBeanStock(CounterSalesOrderBean salesBean, boolean combineSales, boolean copySalesShipping)
    throws Exception {
        DeliveryOrderBean bean = new DeliveryOrderBean();
        if(combineSales) {
            bean.setGenerateTrxDocNo(false);
            bean.setTrxDocCode(salesBean.getTrxDocCode());
            bean.setTrxDocNo(salesBean.getTrxDocNo());
            bean.setTrxDocType(salesBean.getTrxDocType());
            bean.setTrxDocName(salesBean.getTrxDocName());
        } else {
            bean.setTrxDocType("DO");
            bean.setTrxDocName("Delivery Order");
        }
        if(copySalesShipping) {
            bean.setShipOption(salesBean.getShipOption());
            bean.setShipByOutletID(salesBean.getShipByOutletID());
            bean.setShipByStoreCode(salesBean.getShipByStoreCode());
            bean.setShipFromOutletID(salesBean.getShipFromOutletID());
            bean.setShipFromStoreCode(salesBean.getShipFromStoreCode());
            bean.setShipReceiver(salesBean.getShipReceiver());
            bean.setShipContact(salesBean.getShipContact());
            bean.setShipRemark(salesBean.getShipRemark());
            bean.setShippingAddressBean(salesBean.getShippingAddressBean());
        }
        if(salesBean.getSalesID() != null)
            bean.setSalesID(salesBean.getSalesID().intValue());
        bean.setTrxDate(new Date());
        bean.setTrxTime(new Time((new Date()).getTime()));
        bean.setTrxGroup(10);
        bean.setStatus(30);
        bean.setSalesRefNo(salesBean.getTrxDocNo());
        bean.setCustomerSeq(salesBean.getCustomerSeq());
        bean.setCustomerID(salesBean.getCustomerID());
        bean.setCustomerType(salesBean.getCustomerType());
        bean.setCustomerName(salesBean.getCustomerName());
        bean.setCustomerIdentityNo(salesBean.getCustomerIdentityNo());
        bean.setCustomerContact(salesBean.getCustomerContact());
        return bean;
    }
    
    private PurchaseOrderBean createPurchaseBean(CounterSalesOrderBean sales)
    throws Exception {
        PurchaseOrderBean bean = new PurchaseOrderBean();
        bean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
        bean.setBonusDate(sales.getBonusDate());
        bean.setBonusPeriodID(sales.getBonusPeriodID());
        bean.setRefNo(sales.getTrxDocNo());
        bean.setRefType(sales.getTrxDocType());
        bean.setTrxType("DS");
        bean.setTrxGroup(10);
        bean.setPriceCode(sales.getPriceCode());
        bean.setLocalCurrency(sales.getLocalCurrency());
        bean.setLocalCurrencyName(sales.getLocalCurrencyName());
        bean.setLocalCurrencySymbol(sales.getLocalCurrencySymbol());
        bean.setBaseCurrency(sales.getBaseCurrency());
        bean.setBaseCurrencyName(sales.getBaseCurrencyName());
        bean.setBaseCurrencySymbol(sales.getBaseCurrencySymbol());
        bean.setBaseCurrencyRate(sales.getBaseCurrencyRate());
        bean.setSellerSeq(sales.getSellerSeq());
        bean.setSellerID(sales.getSellerID());
        bean.setSellerType(sales.getSellerType());
        bean.setSellerTypeStatus(sales.getSellerTypeStatus());
        bean.setSellerHomeBranchID(sales.getSellerHomeBranchID());
        bean.setServiceAgentSeq(sales.getServiceAgentSeq());
        bean.setServiceAgentID(sales.getServiceAgentID());
        bean.setServiceAgentType(sales.getServiceAgentType());
        bean.setBonusEarnerSeq(sales.getBonusEarnerSeq());
        bean.setBonusEarnerID(sales.getBonusEarnerID());
        bean.setBonusEarnerType(sales.getBonusEarnerType());
        bean.setTotalBv1(sales.getTotalBv1());
        bean.setTotalBv2(sales.getTotalBv2());
        bean.setTotalBv3(sales.getTotalBv3());
        bean.setTotalBv4(sales.getTotalBv4());
        bean.setTotalBv5(sales.getTotalBv5());
        bean.setBvSalesAmount(sales.getBvSalesAmount());
        bean.setNonBvSalesAmount(sales.getNonBvSalesAmount());
        bean.setNetSalesAmount(sales.getNetSalesAmount());
        bean.setRemark(sales.getRemark());
        bean.setProcessStatus(20);
        bean.setStatus(10);
        if(sales.getItemArray().length > 0) {
            CounterSalesItemBean itemArray[] = sales.getItemArray();
            for(int i = 0; i < itemArray.length; i++) {
                PurchaseItemBean item = new PurchaseItemBean();
                bean.addItem(item);
                item.setMaster(bean);
                item.setPricingID(itemArray[i].getPricingID());
                item.setProductID(itemArray[i].getProductID());
                item.setProductType(itemArray[i].getProductType());
                item.setQtyOrder(itemArray[i].getQtyOrder());
                item.setUnitPrice(itemArray[i].getUnitPrice());
                item.setBv1(itemArray[i].getBv1());
                item.setBv2(itemArray[i].getBv2());
                item.setBv3(itemArray[i].getBv3());
                item.setBv4(itemArray[i].getBv4());
                item.setBv5(itemArray[i].getBv5());
                CounterSalesProductBean prdtArray[] = itemArray[i].getProductArray();
                for(int j = 0; j < prdtArray.length; j++) {
                    PurchaseProductBean prdt = new PurchaseProductBean();
                    item.addProduct(prdt);
                    prdt.setMaster(item);
                    prdt.setProductID(prdtArray[j].getProductID());
                    prdt.setProductType(prdtArray[j].getProductType());
                    prdt.setQtyUnit(prdtArray[j].getQtyUnit());
                    prdt.setQtyOrder(prdtArray[j].getQtyOrder());
                }
                
            }
            
        }
        return bean;
    }
    
    private BvWalletBean createBvWalletBean(CounterSalesOrderBean sales, boolean salesIn)
    throws Exception {
        BvWalletBean bean = new BvWalletBean();
        bean.setTrxDate(sales.getTrxDate());
        bean.setTrxTime(new Time(sales.getTrxTime().getTime()));
        bean.setBonusDate(sales.getBonusDate());
        bean.setPeriodID(sales.getBonusPeriodID());
        bean.setReferenceNo(sales.getTrxDocNo());
        bean.setReferenceType(sales.getTrxDocType());
        bean.setWalletType(1);
        bean.setSellerID(sales.getSellerID());
        bean.setSellerType(sales.getSellerType());
        if(sales.getSellerTypeStatus().equals("O"))
            bean.setSellerTypeStatus("O");
        else
            if(sales.getSellerTypeStatus().equals("S"))
                bean.setSellerTypeStatus("S");
        bean.setOwnerID(sales.getBonusEarnerID());
        bean.setOwnerName(sales.getBonusEarnerName());
        bean.setCurrencyCode(sales.getLocalCurrency());
        bean.setUniversalCurrencyCode(sales.getBaseCurrency());
        bean.setUniversalCurrencyRate(sales.getBaseCurrencyRate());
        if(salesIn) {
            bean.setTrxType("ISAL");
            bean.setBvIn(sales.getTotalBv1());
            bean.setBvIn1(sales.getTotalBv2());
            bean.setBvIn2(sales.getTotalBv3());
            bean.setBvIn3(sales.getTotalBv4());
            bean.setBvIn4(sales.getTotalBv5());
            bean.setFullAmountIn(sales.getNetSalesAmount());
            bean.setBvAmountIn(sales.getBvSalesAmount());
        } else {
            bean.setTrxType("OSAL");
            bean.setBvOut(sales.getTotalBv1());
            bean.setBvOut1(sales.getTotalBv2());
            bean.setBvOut2(sales.getTotalBv3());
            bean.setBvOut3(sales.getTotalBv4());
            bean.setBvOut4(sales.getTotalBv5());
            bean.setFullAmountOut(sales.getNetSalesAmount());
            bean.setBvAmountOut(sales.getBvSalesAmount());
        }
        bean.setStd_createBy(sales.getStd_createBy());
        bean.setStd_createDate(sales.getStd_createDate());
        bean.setStd_createTime(sales.getStd_createTime());
        return bean;
    }
    
    private QuotaWalletBean createSellerQuotaWalletBean(CounterSalesOrderBean sales, boolean salesIn)
    throws Exception {
        QuotaWalletBean bean = new QuotaWalletBean();
        bean.setTrxDate(sales.getTrxDate());
        bean.setTrxTime(new Time(sales.getTrxTime().getTime()));
        bean.setReferenceNo(sales.getTrxDocNo());
        bean.setReferenceType(sales.getTrxDocType());
        bean.setOwnerID(sales.getSellerID());
        bean.setCurrencyCode(sales.getLocalCurrency());
        bean.setUniversalCurrencyCode(sales.getBaseCurrency());
        bean.setUniversalCurrencyRate(sales.getBaseCurrencyRate());
        if(salesIn) {
            bean.setTrxType("ISAL");
            bean.setBvIn(sales.getTotalBv1());
            bean.setFullAmountIn(sales.getNetSalesAmount());
            bean.setBvAmountIn(sales.getBvSalesAmount());
        } else {
            bean.setTrxType("OSAL");
            bean.setBvOut(sales.getTotalBv1());
            bean.setFullAmountOut(sales.getNetSalesAmount());
            bean.setBvAmountOut(sales.getBvSalesAmount());
        }
        return bean;
    }
    
    private QuotaWalletBean createBuyerQuotaWalletBean(CounterSalesOrderBean sales, boolean salesIn)
    throws Exception {
        QuotaWalletBean bean = new QuotaWalletBean();
        bean.setTrxDate(sales.getTrxDate());
        bean.setTrxTime(new Time(sales.getTrxTime().getTime()));
        bean.setReferenceNo(sales.getTrxDocNo());
        bean.setReferenceType(sales.getTrxDocType());
        bean.setOwnerID(sales.getCustomerID());
        bean.setCurrencyCode(sales.getLocalCurrency());
        bean.setUniversalCurrencyCode(sales.getBaseCurrency());
        bean.setUniversalCurrencyRate(sales.getBaseCurrencyRate());
        if(salesIn) {
            bean.setTrxType("ISAL");
            bean.setBvIn(sales.getTotalBv1());
            bean.setFullAmountIn(sales.getNetSalesAmount());
            bean.setBvAmountIn(sales.getBvSalesAmount());
        } else {
            bean.setTrxType("OSAL");
            bean.setBvOut(sales.getTotalBv1());
            bean.setFullAmountOut(sales.getNetSalesAmount());
            bean.setBvAmountOut(sales.getBvSalesAmount());
        }
        return bean;
    }
    
    private void resetSales(CounterSalesOrderBean bean) {
        if(bean != null) {
            if(bean.getFormSet() != null && bean.getFormSet().size() > 0)
                bean.getFormSet().clear();
            if(bean.getPaymentSet() != null && bean.getPaymentSet().size() > 0)
                bean.getPaymentSet().clear();
            if(bean.getItemSet() != null && bean.getItemSet().size() > 0)
                bean.getItemSet().clear();
        }
    }
    
    private void resetDelivery(DeliveryOrderBean bean) {
        if(bean != null && bean.getItemSet() != null && bean.getItemSet().size() > 0)
            bean.getItemSet().clear();
    }
    
    private boolean checkNewMemberSalesInput(MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            
            parseSalesBean(sales, returnBean, request);
            checkNewSalesInput(sales, returnBean, request);
            checkBonusPeriodInfo(sales, returnBean, request);
            checkMemberInfoByMobile1(sales, returnBean, request);
            checkBonusEarnerInfo(sales, returnBean, request);
            
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
        return !returnBean.hasErrorMessages();
    }
    
    private boolean checkNewNormalSalesInput(MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            
            
            String noid = request.getParameter("custID");
            String alamat = request.getParameter("CustAlamat");
            
            // CRM Card
            // String idCust = request.getParameter("CustomerCRM");
            // String segmenCust = request.getParameter("CustomerSegmentation");
            
            System.out.println("No 1 : masuk checkNewNormalSalesInput " + noid + "  CustAlamat : " +alamat );
            
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            
            parseSalesBean(sales, returnBean, request);
            checkNewSalesInput(sales, returnBean, request);
            checkBonusPeriodInfo(sales, returnBean, request);
            
            if (noid != null && noid.length() > 0) {
                checkMemberInfo(sales, returnBean, request);
                System.out.println("No 2 : masuk sini checkMemberInfo " + noid);
                
            }else {
                checkMemberInfoByMobile2(sales, returnBean, request);
                System.out.println("No 3 : masuk sini checkMemberInfoByMobile2 " + noid);
            }
            
            checkBonusEarnerInfo(sales, returnBean, request);
            
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
        return !returnBean.hasErrorMessages();
    }
    
    
    
    private boolean checkNewStockistSalesInput(MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            parseSalesBean(sales, returnBean, request);
            checkNewSalesInput(sales, returnBean, request);
            checkStockistInfo(sales, returnBean);
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
        System.out.println("Trap 2 : chek nilai sales " + returnBean);
        return !returnBean.hasErrorMessages();
    }
    
    private boolean checkNewMobileSalesInput(MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            parseSalesBean(sales, returnBean, request);
            checkNewSalesInput(sales, returnBean, request);
            checkMobileInfo(sales, returnBean);
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
        System.out.println("Trap 2 : chek nilai sales " + returnBean);
        return !returnBean.hasErrorMessages();
    }
    
    private boolean checkNewSalesInput(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        checkSellerInfo(sales, returnBean, request);
        if(sales.getSellerTypeStatus().equals("S"))
            checkSellerQuotaWalletBalance(sales.getSellerID(), 0.0D, returnBean);
        checkTrxDateInfo(sales, returnBean);
        checkPriceCodeInfo(sales, returnBean);
        checkSalesShippingInfo(sales, returnBean);
        // tambah
        // checkMemberInfo(sales, returnBean);
        System.out.println("masuk di checkNewSalesInput, sales.getServiceAgentID = " + sales.getServiceAgentID());
        
        return !returnBean.hasErrorMessages();
    }
    
    private void checkSellerInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            String salesman = request.getParameter("Salesman");
            
            OutletBean bean = getSeller(sales.getSellerID());
            sales.setServiceAgentID(salesman);
            sales.setSellerSeq(bean.getSeqID());
            sales.setSellerID(bean.getOutletID());
            sales.setSellerType(bean.getType());
            sales.setSellerHomeBranchID(bean.getHomeBranchID());
            sales.setTrxDocCode(bean.getDocCode());
            sales.setSellerTypeStatus(bean.isStockist() ? "S" : "O");
            sales.setSellerBean(bean);
            
            System.out.println("masuk di checkSellerInfo, salesman = " + sales.getServiceAgentID());
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void checkMemberInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            
            String noid = request.getParameter("custID");
            String alamat = request.getParameter("CustAlamat");
            
            // CRM Card
            // String idCust = request.getParameter("IdCrm");
            String segmenCust = request.getParameter("SegmentationCrm");
            
            if(segmenCust == null)
                segmenCust = "";
            
            System.out.println("No 11 : masuk checkMemberInfo " + noid + " segmenCust : "+segmenCust);
            
            // MemberBean member = getMember(sales.getCustomerID(), false);
            MemberBean member = getMember(noid, false);
            sales.setCustomerSeq(member.getMemberSeq());
            sales.setCustomerLucky(0);
            sales.setCustomerID(member.getMemberID());
            
            sales.setCustomerType(member.getType());
            sales.setCustomerName(member.getName());
            sales.setCustomerContact(member.getContactInfo());
            sales.setCustomerAddressBean(member.getAddress());
            sales.setCustomerTypeStatus("D");
            sales.setCustomerMemberBean(member);
            sales.setServiceAgentType(segmenCust);
            
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void checkMemberInfoByMobile1(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            
            // String chek = request.getParameter("CustID");
            
            // System.out.println("Check sales.setCustomerID OK  = " + chek);
            
            MemberBean member = getMember(sales.getCustomerID(), false);
            
            if (member == null ) {
                
                String noid = request.getParameter("IdCust");
                String alamat = request.getParameter("CustAlamat");
                String nama = request.getParameter("NmCust");
                // for HighEnd
                sales.setCustomerID((new StringBuilder("T")).append(sales.getCustomerContact()).toString());
                sales.setCustomerLucky(10);
                sales.setCustomerName(nama);
                
                // sales.setCustomerRemark(request.getParameter("CustomerDeposit"));
                // sales.setAdjstRefNo(request.getParameter("InvoiceReturn"));
                
                sales.setCustomerType("N");
                sales.setCustomerTypeStatus("N");
                
                sales.setCustomerAddressBean(new AddressBean());
                
                
            }else {
                sales.setCustomerLucky(20);
                sales.setCustomerSeq(member.getMemberSeq());
                sales.setCustomerID(member.getMemberID());
                
                System.out.println("Check sales.setCustomerID OK  = " + member.getMemberID());
                
                sales.setCustomerType(member.getType());
                sales.setCustomerName(member.getName());
                sales.setCustomerContact(member.getContactInfo());
                sales.setCustomerAddressBean(member.getAddress());
                sales.setCustomerTypeStatus("D");
                sales.setCustomerMemberBean(member);
            }
            
            sales.setCustomerRemark(request.getParameter("CustomerDeposit"));
            sales.setAdjstRefNo(request.getParameter("InvoiceReturn"));
            
            
            
            System.out.println("No 22 : masuk checkMemberInfoByMobile " + sales.getCustomerID() + "  nama " +sales.getCustomerName() + " Lucky " + sales.getCustomerLucky());
            
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    
    private void checkMemberInfoByMobile2(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        try {
            
            MemberBean member = getMemberByMobile(sales.getCustomerContact(), false);
            
            if (member == null) {
                
                String noid = request.getParameter("IdCust");
                String alamat = request.getParameter("CustAlamat");
                String nama = request.getParameter("NmCust");
                // FOR HE
                sales.setCustomerID((new StringBuilder("T")).append(sales.getCustomerContact()).toString());
                sales.setCustomerLucky(10);
                sales.setCustomerName(nama);
                
                // sales.setCustomerRemark(request.getParameter("CustomerDeposit"));
                // sales.setAdjstRefNo(request.getParameter("InvoiceReturn"));
                
                sales.setCustomerType("N");
                sales.setCustomerTypeStatus("N");
                
                sales.setCustomerAddressBean(new AddressBean());
                
                
            }else {
                sales.setCustomerLucky(20);
                sales.setCustomerSeq(member.getMemberSeq());
                sales.setCustomerID(member.getMemberID());
                
                System.out.println("Check sales.setCustomerID OK  = " + member.getMemberID());
                
                sales.setCustomerType(member.getType());
                sales.setCustomerName(member.getName());
                sales.setCustomerContact(member.getContactInfo());
                sales.setCustomerAddressBean(member.getAddress());
                sales.setCustomerTypeStatus("D");
                sales.setCustomerMemberBean(member);
            }
            
            sales.setCustomerRemark(request.getParameter("CustomerDeposit"));
            sales.setAdjstRefNo(request.getParameter("InvoiceReturn"));
            
            // CRM
            String segmenCust = request.getParameter("SegmentationCrm");
            
            if(segmenCust == null)
                segmenCust = "";
            
            sales.setServiceAgentType(segmenCust);
            
            System.out.println("No 22 : masuk checkMemberInfoByMobile " + sales.getCustomerID() + "  nama " +sales.getCustomerName() + " Lucky " + sales.getCustomerLucky());
            
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void checkMemberRetail(CounterSalesOrderBean sales, MvcReturnBean returnBean) {
        try {
            MemberBean member = getMemberByMobile(sales.getCustomerContact(), false);
            sales.setCustomerSeq(member.getMemberSeq());
            sales.setCustomerID(member.getMemberID());
            sales.setCustomerType(member.getType());
            sales.setCustomerName(member.getName());
            sales.setCustomerContact(member.getContactInfo());
            sales.setCustomerAddressBean(member.getAddress());
            sales.setCustomerTypeStatus("D");
            sales.setCustomerMemberBean(member);
            
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    
    private void checkSalesmenInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean) {
        try {
            MemberBean member = getMember(sales.getCustomerID(), false);
            sales.setCustomerSeq(member.getMemberSeq());
            sales.setCustomerID(member.getMemberID());
            sales.setCustomerType(member.getType());
            sales.setCustomerName(member.getName());
            sales.setCustomerContact(member.getContactInfo());
            sales.setCustomerAddressBean(member.getAddress());
            sales.setCustomerTypeStatus("D");
            sales.setCustomerMemberBean(member);
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
/*
    private void checkBonusEarnerInfoAwal(CounterSalesOrderBean sales, MvcReturnBean returnBean)
    {
        try
        {
            MemberBean bonusEarner = null;
            if(sales.getBonusEarnerID().equalsIgnoreCase(sales.getCustomerID()))
                bonusEarner = sales.getCustomerMemberBean();
            else
                bonusEarner = getMember(sales.getBonusEarnerID(), true);
 
            sales.setBonusEarnerSeq(bonusEarner.getMemberSeq());
            sales.setBonusEarnerID(bonusEarner.getMemberID());
            sales.setBonusEarnerType(bonusEarner.getType());
            sales.setBonusEarnerName(bonusEarner.getName());
            sales.setBonusEarnerBean(bonusEarner);
        }
        catch(Exception ex)
        {
            returnBean.addError(ex.getMessage());
        }
    }
 */
    
    private void checkBonusEarnerInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        
        try {
            String salesman1 = request.getParameter("Salesman");
            
            String[] salesman1Array = salesman1.split(" - ");
            String salesman = salesman1Array[0];
            
            SalesmanBean bonusEarner = null;
            if(sales.getBonusEarnerID().equalsIgnoreCase(sales.getCustomerID()))
                bonusEarner = sales.getCustomerSalesmanBean();
            else
                // bonusEarner = getSalesman(sales.getBonusEarnerID(), true);
                bonusEarner = getSalesman(salesman, true);
            
            sales.setBonusEarnerSeq(bonusEarner.getMemberSeq());
            sales.setBonusEarnerID(bonusEarner.getMemberID());
            sales.setBonusEarnerType(bonusEarner.getType());
            sales.setBonusEarnerName(bonusEarner.getFirstName().trim().concat(" ").concat(bonusEarner.getName()).trim().concat(" ").concat(bonusEarner.getLastName()).trim());
            sales.setBonusEarnerBean(bonusEarner);
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void checkCustomerInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean,  HttpServletRequest request) {
        
        String noid = request.getParameter("IdCust");
        String alamat = request.getParameter("CustAlamat");
        String nama = request.getParameter("NmCust");
        
        System.out.println("No 2 : masuk checkCustomerInfo " + noid + "  CustAlamat " +alamat + "  nama " +nama);
        
        if(noid == null || noid.isEmpty()) {
            // FOR HE
            sales.setCustomerID((new StringBuilder("T")).append(sales.getCustomerContact()).toString());
            sales.setCustomerLucky(10);
            
        }else {
            sales.setCustomerID(noid);
            sales.setCustomerLucky(20);
        }
        
       /*
        if(sales.getCustomerID() == null || sales.getCustomerID().isEmpty()) {
        
            sales.setCustomerID((new StringBuilder("FR-")).append(sales.getCustomerContact()).toString());
            sales.setCustomerLucky(10);
        
        }else {
            sales.setCustomerID(request.getParameter("CustomerID"));
            sales.setCustomerLucky(20);
        }
        
        if(sales.getCustomerName() == null) {
            sales.setCustomerName(request.getParameter("CustomerName"));
        
        }
        
        */
        
        sales.setCustomerName(nama);
        
        System.out.println("Customer Lucky "+ sales.getCustomerLucky() + "Check Customer ID " + sales.getCustomerID() + "  Nama "+ sales.getCustomerName());
        
        sales.setCustomerRemark(request.getParameter("CustomerDeposit"));
        sales.setAdjstRefNo(request.getParameter("InvoiceReturn"));
        
        sales.setCustomerType("N");
        sales.setCustomerTypeStatus("N");
        
        sales.setCustomerAddressBean(new AddressBean());
        
    }
    
    private void checkBonusPeriodInfoHE(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        BonusPeriodManager bonusPeriodManager = new BonusPeriodManager();
        boolean isBonusDateActive = false;
        try {
            Date bonusDate = Sys.parseDate(request.getParameter("BonusDate"));
            isBonusDateActive = bonusPeriodManager.isBonusPeriodActive(new java.sql.Date(bonusDate.getTime()), 50);
            if(isBonusDateActive) {
                sales.setBonusDate(bonusDate);
                sales.setBonusPeriodID(Sys.getDateFormater().format(bonusDate));
                
                ProductPricingManager pricingMgr = new ProductPricingManager();
                double rate = pricingMgr.getRateUpdate(Sys.getDateFormater().format(sales.getBonusDate())).getSymbol();
                // sales.setTotalBv4(rate);
                sales.setBaseCurrencyRate(rate);
                
                double rate2 = pricingMgr.getRateUpdate2(Sys.getDateFormater().format(sales.getBonusDate())).getSymbol();
                // sales.setTotalBv4(rate);
                sales.setBaseCurrencyRate2(rate2);
                
                double rate3 = 0D;
                // sales.setTotalBv4(rate);
                sales.setBaseCurrencyRate3(rate3);
                
                
            } else {
                returnBean.addError("Initial Date is closed for sales");
            }
        } catch(Exception e) {
            returnBean.addError("Invalid Initial Date Format");
        }
    }
    
    private void checkStockistInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean) {
        try {
            OutletBean bean = getStockist(sales.getCustomerID());
            sales.setCustomerSeq(bean.getSeqID());
            sales.setCustomerID(bean.getOutletID());
            sales.setCustomerType(bean.getType());
            sales.setCustomerName(bean.getName());
            sales.setCustomerContact("");
            sales.setCustomerAddressBean(new AddressBean());
            sales.setCustomerTypeStatus("S");
            sales.setCustomerStockistBean(bean);
            System.out.println("masuk di checkSellerInfo dengan getStockist(sales.getCustomerID()) " + getStockist(sales.getCustomerID()) + "sales.setCustomerID(bean.getOutletID())" +bean.getOutletID());
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void checkMobileInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean) {
        try {
            OutletBean bean = getMobile(sales.getCustomerID());
            sales.setCustomerSeq(bean.getSeqID());
            sales.setCustomerID(bean.getOutletID());
            sales.setCustomerType(bean.getType());
            sales.setCustomerName(bean.getName());
            sales.setCustomerContact("");
            sales.setCustomerAddressBean(new AddressBean());
            sales.setCustomerTypeStatus("S");
            sales.setCustomerStockistBean(bean);
            System.out.println("masuk di checkSellerInfo dengan getStockist(sales.getCustomerID()) " + getStockist(sales.getCustomerID()) + "sales.setCustomerID(bean.getOutletID())" +bean.getOutletID());
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void checkTrxDateInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean) {
        try {
            sales.setTrxDate(Sys.parseDate(sales.getTrxDateStr()));
        } catch(Exception e) {
            if(sales.getTrxDateStr() != null && sales.getTrxDateStr().length() > 0)
                returnBean.addError("Fail to parse Trx Date");
            else
                sales.setTrxDate(new Date());
        }
        sales.setTrxTime(new Time((new Date()).getTime()));
    }
    
    private void checkBonusPeriodInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean) {
        if(sales.getBonusPeriodID() == null)
            returnBean.addError("No Bonus Period ID specified");
    }
    
    private void checkBonusPeriodInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean, HttpServletRequest request) {
        BonusPeriodManager bonusPeriodManager = new BonusPeriodManager();
        boolean isBonusDateActive = false;
        try {
            Date bonusDate = Sys.parseDate(request.getParameter("BonusDate"));
            isBonusDateActive = bonusPeriodManager.isBonusPeriodActive(new java.sql.Date(bonusDate.getTime()), 50);
            if(isBonusDateActive) {
                sales.setBonusDate(bonusDate);
                sales.setBonusPeriodID(Sys.getDateFormater().format(bonusDate));
                
                System.out.println("masuk check-1 " + bonusDate + " Periode ID "+ Sys.getDateFormater().format(bonusDate) );
                
                ProductPricingManager pricingMgr = new ProductPricingManager();
                double rate = pricingMgr.getRateUpdate(Sys.getDateFormater().format(sales.getBonusDate())).getSymbol();
                // sales.setTotalBv4(rate);
                sales.setBaseCurrencyRate(rate);
                
                double rate2 = pricingMgr.getRateUpdate2(Sys.getDateFormater().format(sales.getBonusDate())).getSymbol();
                // sales.setTotalBv4(rate);
                sales.setBaseCurrencyRate2(rate2);
                
                double rate3 = 0D;
                // sales.setTotalBv4(rate);
                sales.setBaseCurrencyRate3(rate3);
                
            } else {
                returnBean.addError("Initial Date is closed for sales");
            }
        } catch(Exception e) {
            // sementara
            System.out.println("masuk check-2 " + isBonusDateActive );
            returnBean.addError("Invalid Initial Date Format or Table Rate not Updated ");
        }
    }
    
    
    private void checkPriceCodeInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean) {
        if(sales.getPriceCode() == null)
            returnBean.addError("No Price Code is specified");
        try {
            PriceCodeBean priceCodeBean = getPriceCode(sales.getPriceCode());
            CurrencyBean bean = priceCodeBean.getCurrencyBean();
            sales.setLocalCurrency(bean.getCode());
            sales.setLocalCurrencyName(bean.getName());
            sales.setLocalCurrencySymbol(bean.getSymbol());
            sales.setPriceCodeBean(priceCodeBean);
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
    }
    
    private void checkSalesShippingInfo(CounterSalesOrderBean sales, MvcReturnBean returnBean) {
        try {
            int shipOption = Integer.parseInt(sales.getShipOptionStr());
            sales.setShipOption(shipOption);
        } catch(Exception e) {
            returnBean.addError("Fail to get Shipping Option");
        }
        if(sales.getShipByOutletID() == null) {
            returnBean.addError("No Delivery By ID is specified");
            return;
        }
        try {
            OutletBean shipBy = getShipper(sales.getShipByOutletID());
            if(shipBy != null) {
                sales.setShipByOutletID(shipBy.getOutletID());
                OutletStoreBean shipByStore = shipBy.getSalesStore();
                sales.setShipByStoreCode(shipBy.getSalesStoreCode());
            } else {
                returnBean.addError((new StringBuilder("No Delivery By found -> ")).append(sales.getShipByOutletID()).toString());
            }
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
        return;
    }
    
    private void checkDeliveryShippingInfo(DeliveryOrderBean bean, MvcReturnBean returnBean) {
        try {
            int shipOption = Integer.parseInt(bean.getShipOptionStr());
            bean.setShipOption(shipOption);
        } catch(Exception e) {
            returnBean.addError("Fail to get Shipping Option");
        }
        if(bean.getShipByOutletID() == null) {
            returnBean.addError("No Delivery By ID is specified");
            return;
        }
        try {
            OutletBean shipBy = getShipper(bean.getShipByOutletID());
            if(shipBy != null) {
                bean.setShipByOutletID(shipBy.getOutletID());
                bean.setTrxDocCode(shipBy.getDocCode());
                OutletStoreBean shipByStore = shipBy.getSalesStore();
                bean.setShipByStoreCode(shipBy.getSalesStoreCode());
            } else {
                returnBean.addError((new StringBuilder("No Delivery By found -> ")).append(bean.getShipByOutletID()).toString());
            }
        } catch(Exception ex) {
            returnBean.addError(ex.getMessage());
        }
        return;
    }
    
// Start summary sales report
    private MvcReturnBean searchSummarySalesReport(HttpServletRequest request)
    throws MvcException{
        
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            boolean formDetail = request.getParameter("detail") != null;
            boolean isPrint = request.getParameter("print") != null;
            boolean isAdminUser = true;
            if(getLoginUser().getUserGroupType() == 10)
                isAdminUser = false;
            if(!isAdminUser)
                formSubmitted = true;
            if(formSubmitted) {
                Date trxDtFrom = null;
                Date trxDtTo = null;
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " AND cso.cso_status <> 50 AND cso.cso_status <> -10 ";
                String orderby = "order by cso.cso_bonus_earnername, pcd.pcd_desc";
                String userOrderby = request.getParameter("OrderBy");
                if(userOrderby != null && userOrderby.length() > 0)
                    orderby = (new StringBuilder(String.valueOf(orderby))).append(",").append(userOrderby).append(" asc").toString();
                cond.setOrderby(orderby);
                String limits = request.getParameter("Limits");
                if(limits != null && limits.length() > 0)
                    cond.setLimitConditions((new StringBuilder(" limit 0, ")).append(limits).toString());
                String trxDtFromStr = request.getParameter("TrxDateFrom");
                String trxDtToStr = request.getParameter("TrxDateTo");
                try {
                    trxDtFrom = Sys.parseDate(trxDtFromStr);
                } catch(Exception exception) { }
                try {
                    trxDtTo = Sys.parseDate(trxDtToStr);
                } catch(Exception exception1) { }
                if(trxDtFrom != null) {
                    java.sql.Date sqlDtFrom = new java.sql.Date(trxDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxdate >= '").append(sqlDtFrom).append("'").toString();
                }
                if(trxDtTo != null) {
                    java.sql.Date sqlDtTo = new java.sql.Date(trxDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxdate <= '").append(sqlDtTo).append("'").toString();
                }
                String sellerID = request.getParameter("SellerID");
                if(sellerID == null && isAdminUser)
                    sellerID = getLoginUser().getOutletID();
                if(sellerID != null && sellerID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_sellerid = '").append(sellerID.trim()).append("' ").toString();
                String status = request.getParameter("Status");
                if(status != null && status.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_status = ").append(status).toString();
                String trxDocNo = request.getParameter("TrxDocNo");
                if(trxDocNo != null && trxDocNo.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxdocno LIKE '%").append(trxDocNo.trim()).append("%' ").toString();
                String trxType = request.getParameter("TrxType");
                if(trxType != null && trxType.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxtype = '").append(trxType.trim()).append("' ").toString();
                String custID = null;
                if(isAdminUser)
                    custID = request.getParameter("CustomerID");
                else
                    custID = getLoginUser().getUserId();
                if(custID != null && custID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_custid LIKE '%").append(custID.trim()).append("%' ").toString();
                String custName = request.getParameter("CustomerName");
                if(custName != null && custName.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_cust_name LIKE '%").append(custName.trim()).append("%' ").toString();
                String bonusPeriod = request.getParameter("BonusPeriodID");
                if(bonusPeriod != null && bonusPeriod.length() > 0) {
                    String bulan = bonusPeriod.trim().substring(5, 7).toString();
                    String tahun = bonusPeriod.trim().substring(0, 4).toString();
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and year(cso.cso_bonusperiodid) = '").append(tahun.trim()).append("' ").append(" and month(cso.cso_bonusperiodid) = '").append(bulan.trim()).append("' ").toString();
                    System.out.println("Tahun " + tahun + " bulan " + bulan + " conditions " + conditions);
                }
                String doStatus = request.getParameter("DeliveryStatus");
                if(doStatus != null && doStatus.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_delivery_status = ").append(doStatus).toString();
                cond.setConditions(conditions);
                returnBean.addReturnObject("SummaryReportDetail", isPrint ? ((Object [] ) (getSummarySalesReportDetail(cond))) : ((Object []) (getSummarySalesReportDetail(cond))));
                returnBean.addReturnObject("SummarySalesReport", isPrint ? ((Object []) (getSummarySalesReport(cond))) : ((Object []) (getSummarySalesReport(cond))));
            }
            //returnBean.addReturnObject("AdjstCounterSalesOrderBean", getSalesOrderByAdjstID(orderBean.getSalesID()));
            returnBean.addReturnObject("TrxTypeList", getMapForSalesTypes());
            returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
            boolean showAny = isAdminUser;
            returnBean.addReturnObject("BonusPeriodList", getMapForSalesBonusPeriod(showAny));
            returnBean.addReturnObject("ConfirmBonusPeriodList", getConfirmedBonusPeriodList());
            returnBean.addReturnObject("DeliveryStatusList", getMapForSalesDeliveryStatus());
            returnBean.addReturnObject("StatusList", getMapForSalesStatus());
            returnBean.addReturnObject("OrderBy", getMapForSalesOrderBy(isAdminUser));
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
            //returnBean.addReturnObject("SalesList",order.getSalesID());
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        
        try{
            
        }catch(Exception e){
            Log.error(e);
            returnBean.addError(e.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private MvcReturnBean searchSummarySalesReportPayment(HttpServletRequest request)
    throws MvcException{
        MvcReturnBean returnBean = new MvcReturnBean();
        //   CounterSalesOrderBean order = null;
        try {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            boolean formDetail = request.getParameter("detail") != null;
            boolean isPrint = request.getParameter("print") != null;
            boolean isAdminUser = true;
            if(getLoginUser().getUserGroupType() == 10)
                isAdminUser = false;
            if(!isAdminUser)
                formSubmitted = true;
            if(formSubmitted) {
                Date trxDtFrom = null;
                Date trxDtTo = null;
                String trxDtFromStr = request.getParameter("TrxDateFrom");
                String trxDtToStr = request.getParameter("TrxDateTo");
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " AND cso.cso_status <> 50 AND cso.cso_status <> -10 AND cso.cso_trxdate between '" + trxDtFromStr +"' AND '"+trxDtToStr +"' ";
                String groupby = " GROUP BY csp.csm_paymodeedc,csp.csm_paymodetime,csp.csm_currency, cso.cso_trxdate";
                String orderby = " ORDER BY csp.csm_paymodeedc,csp.csm_paymodetime,csp.csm_currency, cso.cso_trxdocno";
                String userOrderby = request.getParameter("OrderBy");
                String userGroupby = request.getParameter("GroupBy");
                if(userOrderby != null && userOrderby.length() > 0)
                    orderby = (new StringBuilder(String.valueOf(orderby))).append(",").append(userOrderby).append(" asc").toString();
                cond.setOrderby(orderby);
                if(userGroupby != null && userGroupby.length() > 0)
                    groupby = (new StringBuilder(String.valueOf(groupby))).append(",").append(userGroupby).toString();
                cond.setGroupby(groupby);
                String limits = request.getParameter("Limits");
                if(limits != null && limits.length() > 0)
                    cond.setLimitConditions((new StringBuilder(" limit 0, ")).append(limits).toString());
                
                try {
                    trxDtFrom = (Date) Sys.parseDate(trxDtFromStr);
                    trxDtTo = (Date) Sys.parseDate(trxDtToStr);
                } catch(Exception exception1) { }
                if(trxDtFrom != null){
                    java.sql.Date sqlDtFrom = new java.sql.Date(trxDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxdate >= '").append(sqlDtFrom).append("'").toString();
                    // cond.setConditions(conditions);
                }
                if(trxDtTo != null) {
                    java.sql.Date sqlDtTo = new java.sql.Date(trxDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxdate <= '").append(sqlDtTo).append("'").toString();
                    // cond.setConditions(conditions);
                }
                cond.setConditions(conditions);
                returnBean.addReturnObject("SummaryReportPaymentDetail", isPrint ? ((Object [] ) (getSummarySalesReportPaymentDetail(cond))) : ((Object []) (getSummarySalesReportPaymentDetail(cond))));
                returnBean.addReturnObject("SummaryReportPayment", isPrint ? ((Object []) (getSummarySalesReportPayment(cond))) : ((Object []) (getSummarySalesReportPayment(cond))));
            }
            returnBean.addReturnObject("TrxTypeList", getMapForSalesTypes());
            returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
            boolean showAny = isAdminUser;
            returnBean.addReturnObject("BonusPeriodList", getMapForSalesBonusPeriod(showAny));
            returnBean.addReturnObject("ConfirmBonusPeriodList", getConfirmedBonusPeriodList());
            returnBean.addReturnObject("DeliveryStatusList", getMapForSalesDeliveryStatus());
            returnBean.addReturnObject("StatusList", getMapForSalesStatus());
            returnBean.addReturnObject("OrderBy", getMapForSalesOrderBy(isAdminUser));
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        
        try{
            
        }catch(Exception e){
            Log.error(e);
            returnBean.addError(e.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private MvcReturnBean searchSummarySalesReturnReportByBrand(HttpServletRequest request)
    throws MvcException{
        
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            boolean isPrint = request.getParameter("print") != null;
            boolean isAdminUser = true;
            if(getLoginUser().getUserGroupType() == 10)
                isAdminUser = false;
            if(!isAdminUser)
                formSubmitted = true;
            if(formSubmitted) {
                Date trxDtFrom = null;
                Date trxDtTo = null;
                String trxDtFromStr = request.getParameter("TrxDateFrom");
                String trxDtToStr = request.getParameter("TrxDateTo");
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " AND cso.cso_status = 60 AND cso.cso_trxdate between '" + trxDtFromStr +"' AND '"+trxDtToStr +"' ";
                String orderby = " order by pcd.pcd_desc,pm.pmp_producttype";
                String groupby = "  group by pcd.pcd_desc,pm.pmp_producttype";
                String userOrderby = request.getParameter("OrderBy");
                String userGroupby = request.getParameter("GroupBy");
                if(userOrderby != null && userOrderby.length() > 0)
                    orderby = (new StringBuilder(String.valueOf(orderby))).append(",").append(userOrderby).append(" asc").toString();
                cond.setOrderby(orderby);
                if(userGroupby != null && userGroupby.length() > 0)
                    groupby = (new StringBuilder(String.valueOf(groupby))).append(",").append(userGroupby).toString();
                cond.setGroupby(groupby);
                String limits = request.getParameter("Limits");
                
                try {
                    trxDtFrom = (Date) Sys.parseDate(trxDtFromStr);
                } catch(Exception exception) { }
                try {
                    trxDtTo = (Date) Sys.parseDate(trxDtToStr);
                } catch(Exception exception1) { }
                if(trxDtFrom != null) {
                    java.sql.Date sqlDtFrom = new java.sql.Date(trxDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxdate >= '").append(sqlDtFrom).append("'").toString();
                }
                if(trxDtTo != null) {
                    java.sql.Date sqlDtTo = new java.sql.Date(trxDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxdate <= '").append(sqlDtTo).append("'").toString();
                }
                String sellerID = request.getParameter("SellerID");
                if(sellerID == null && isAdminUser)
                    sellerID = getLoginUser().getOutletID();
                if(sellerID != null && sellerID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_sellerid = '").append(sellerID.trim()).append("' ").toString();
                String status = request.getParameter("Status");
                if(status != null && status.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_status = ").append(status).toString();
                String custID = null;
                if(isAdminUser)
                    custID = request.getParameter("CustomerID");
                else
                    custID = getLoginUser().getUserId();
                if(custID != null && custID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_custid LIKE '%").append(custID.trim()).append("%' ").toString();
                String custName = request.getParameter("CustomerName");
                if(custName != null && custName.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_cust_name LIKE '%").append(custName.trim()).append("%' ").toString();
                String bonusPeriod = request.getParameter("BonusPeriodID");
                
                String doStatus = request.getParameter("DeliveryStatus");
                if(doStatus != null && doStatus.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_delivery_status = ").append(doStatus).toString();
                cond.setConditions(conditions);
                returnBean.addReturnObject("SummarySalesReturnReportByBrandDetail", isPrint ? ((Object [] ) (getSummarySalesReturnReportByBrandDetail(cond))) : ((Object []) (getSummarySalesReturnReportByBrandDetail(cond))));
                returnBean.addReturnObject("SummarySalesReturnReportByBrand", isPrint ? ((Object []) (getSummarySalesReturnReportByBrand(cond))) : ((Object []) (getSummarySalesReturnReportByBrand(cond))));
            }
            returnBean.addReturnObject("TrxTypeList", getMapForSalesTypes());
            returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
            boolean showAny = isAdminUser;
            returnBean.addReturnObject("BonusPeriodList", getMapForSalesBonusPeriod(showAny));
            returnBean.addReturnObject("ConfirmBonusPeriodList", getConfirmedBonusPeriodList());
            returnBean.addReturnObject("DeliveryStatusList", getMapForSalesDeliveryStatus());
            returnBean.addReturnObject("StatusList", getMapForSalesStatus());
            returnBean.addReturnObject("OrderBy", getMapForSalesOrderBy(isAdminUser));
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
            //returnBean.addReturnObject("SalesList",order.getSalesID());
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        
        try{
            
        }catch(Exception e){
            Log.error(e);
            returnBean.addError(e.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private MvcReturnBean searchSummarySalesReportBrandCategory(HttpServletRequest request)
    throws MvcException{
        
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            boolean formSubmitted = request.getParameter("SubmitData") != "";
            boolean isPrint = request.getParameter("print") != null;
            boolean isAdminUser = true;
            if(getLoginUser().getUserGroupType() == 10)
                isAdminUser = false;
            if(!isAdminUser)
                formSubmitted = true;
            if(formSubmitted) {
                String trxDtFromStr = request.getParameter("TrxDateFrom");
                String trxDtToStr = request.getParameter("TrxDateTo");
                String submit = request.getParameter("SubmitData");
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " AND cso.cso_status <> 50 AND cso.cso_status <> 10 AND cso.cso_trxdate between '" + trxDtFromStr +"' AND '"+trxDtToStr +"' ";
                String orderby = " order by pcd.pcd_desc,pm.pmp_producttype";
                String groupby = "  group by pcd.pcd_desc,pm.pmp_producttype";
                String userOrderby = request.getParameter("OrderBy");
                String userGroupby = request.getParameter("GroupBy");
                if(userOrderby != null && userOrderby.length() > 0)
                    orderby = (new StringBuilder(String.valueOf(orderby))).append(",").append(userOrderby).append(" asc").toString();
                cond.setOrderby(orderby);
                if(userGroupby != null && userGroupby.length() > 0)
                    groupby = (new StringBuilder(String.valueOf(groupby))).append(",").append(userGroupby).toString();
                cond.setGroupby(groupby);
                String limits = request.getParameter("Limits");
                String sellerID = request.getParameter("SellerID");
                if(sellerID == null && isAdminUser)
                    sellerID = getLoginUser().getOutletID();
                if(sellerID != null && sellerID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_sellerid = '").append(sellerID.trim()).append("' ").toString();
                String status = request.getParameter("Status");
                if(status != null && status.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_status = ").append(status).toString();
                String custID = null;
                if(isAdminUser)
                    custID = request.getParameter("CustomerID");
                else
                    custID = getLoginUser().getUserId();
                if(custID != null && custID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_custid LIKE '%").append(custID.trim()).append("%' ").toString();
                String custName = request.getParameter("CustomerName");
                if(custName != null && custName.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_cust_name LIKE '%").append(custName.trim()).append("%' ").toString();
                String bonusPeriod = request.getParameter("BonusPeriodID");
                
                String doStatus = request.getParameter("DeliveryStatus");
                if(doStatus != null && doStatus.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_delivery_status = ").append(doStatus).toString();
                cond.setConditions(conditions);
                System.out.println("statusnya _"+submit);
                returnBean.addReturnObject("SummaryReportBrandCategoryDetail", isPrint ? ((Object [] ) (getSummarySalesReportBrandCategoryDetail(cond))) : ((Object []) (getSummarySalesReportBrandCategoryDetail(cond))));
                returnBean.addReturnObject("SummaryReportBrandCategory", isPrint ? ((Object []) (getSummarySalesReportBrandCategory(cond))) : ((Object []) (getSummarySalesReportBrandCategory(cond))));
            }
            returnBean.addReturnObject("TrxTypeList", getMapForSalesTypes());
            returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
            boolean showAny = isAdminUser;
            returnBean.addReturnObject("BonusPeriodList", getMapForSalesBonusPeriod(showAny));
            returnBean.addReturnObject("ConfirmBonusPeriodList", getConfirmedBonusPeriodList());
            returnBean.addReturnObject("DeliveryStatusList", getMapForSalesDeliveryStatus());
            returnBean.addReturnObject("StatusList", getMapForSalesStatus());
            returnBean.addReturnObject("OrderBy", getMapForSalesOrderBy(isAdminUser));
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
            //returnBean.addReturnObject("SalesList",order.getSalesID());
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        
        try{
            
        }catch(Exception e){
            Log.error(e);
            returnBean.addError(e.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    public CounterSalesItemBean[] getSummarySalesReportBrandCategory(SQLConditionsBean conditions)
    throws MvcException {
        CounterSalesItemBean bean[];
        Connection conn;
        bean = EMPTY_SALES_ITEM_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSummarySalesReportBrandCategory(conditions);
            if(!list.isEmpty())
                bean = (CounterSalesItemBean[])list.toArray(bean);
            System.out.println("already passed try getSummarySalesReportBrandCategory " + bean.length);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public CounterSalesOrderBean[] getSummarySalesReportBrandCategoryDetail(SQLConditionsBean conditions)
    throws MvcException{
        CounterSalesOrderBean beans[];
        Connection conn;
        beans = EMPTY_SALES_ORDER_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSummarySalesReportBrandCategoryDetail(conditions);
            if(!list.isEmpty())
                beans = (CounterSalesOrderBean[])list.toArray(beans);
            System.out.println("already passed try getSummarySalesReportBrandCategoryDetail " + beans.length);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    public CounterSalesOrderBean[] getSummarySalesReturnReportByBrandDetail(SQLConditionsBean conditions)
    throws MvcException{
        CounterSalesOrderBean beans[];
        Connection conn;
        beans = EMPTY_SALES_ORDER_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSummarySalesReturnReportByBrandDetail(conditions);
            if(!list.isEmpty())
                beans = (CounterSalesOrderBean[])list.toArray(beans);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    public CounterSalesItemBean[] getSummarySalesReturnReportByBrand(SQLConditionsBean conditions)
    throws MvcException {
        CounterSalesItemBean beans[];
        Connection conn;
        beans = EMPTY_SALES_ITEM_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSummarySalesReturnReportByBrand(conditions);
            if(!list.isEmpty())
                beans = (CounterSalesItemBean[])list.toArray(beans);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    // summary report payment
    public CounterSalesPaymentBean[] getSummarySalesReportPayment(SQLConditionsBean conditions)
    throws MvcException{
        CounterSalesPaymentBean beans [];
        Connection conn;
        beans = EMPTY_SALES_PAYMENT_ARRAY;
        conn = null;
        try{
            conn = getConnection();
            ArrayList list = getBroker(conn).getSummarySalesReportPayment(conditions);
            if(!list.isEmpty())
                beans = (CounterSalesPaymentBean[])list.toArray(beans);
            
        }catch(Exception e){
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }
    
    public CounterSalesPaymentBean[] getSummarySalesReportPaymentDetail(SQLConditionsBean conditions)
    throws MvcException{
        CounterSalesPaymentBean beans [];
        Connection conn;
        beans = EMPTY_SALES_PAYMENT_ARRAY;
        conn = null;
        try{
            conn = getConnection();
            ArrayList list = getBroker(conn).getSummarySalesReportPaymentDetail(conditions);
            if(!list.isEmpty())
                beans = (CounterSalesPaymentBean[])list.toArray(beans);
            
        }catch(Exception e){
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }
// End Summary Sales Report
    
    private MvcReturnBean searchSalesSelection(HttpServletRequest request)
    throws MvcException {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            boolean isPrint = request.getParameter("print") != null;
            boolean isAdminUser = true;
            if(getLoginUser().getUserGroupType() == 10)
                isAdminUser = false;
            if(!isAdminUser)
                formSubmitted = true;
            if(formSubmitted) {
                Date trxDtFrom = null;
                Date trxDtTo = null;
                Date docDtFrom = null;
                Date docDtTo = null;
                
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " where cso_status <> -10 ";
                String orderby = " order by cso_seller_typestatus asc ";
                String userOrderby = request.getParameter("OrderBy");
                if(userOrderby != null && userOrderby.length() > 0)
                    orderby = (new StringBuilder(String.valueOf(orderby))).append(",").append(userOrderby).append(" asc").toString();
                cond.setOrderby(orderby);
                
                String limits = request.getParameter("Limits");
                if(limits != null && limits.length() > 0)
                    cond.setLimitConditions((new StringBuilder(" limit 0, ")).append(limits).toString());
                String trxDtFromStr = request.getParameter("TrxDateFrom");
                String trxDtToStr = request.getParameter("TrxDateTo");
                try {
                    trxDtFrom = Sys.parseDate(trxDtFromStr);
                } catch(Exception exception) { }
                
                try {
                    trxDtTo = Sys.parseDate(trxDtToStr);
                } catch(Exception exception1) { }
                
                if(trxDtFrom != null) {
                    java.sql.Date sqlDtFrom = new java.sql.Date(trxDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdate >= '").append(sqlDtFrom).append("'").toString();
                }
                if(trxDtTo != null) {
                    java.sql.Date sqlDtTo = new java.sql.Date(trxDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdate <= '").append(sqlDtTo).append("'").toString();
                }
                
                String docDtFromStr = request.getParameter("DocDateFrom");
                String docDtToStr = request.getParameter("DocDateTo");
                try {
                    docDtFrom = Sys.parseDate(docDtFromStr);
                } catch(Exception exception) { }
                
                try {
                    docDtTo = Sys.parseDate(docDtToStr);
                } catch(Exception exception1) { }
                
                if(docDtFrom != null) {
                    java.sql.Date sqlDtFrom1 = new java.sql.Date(docDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_bonusdate >= '").append(sqlDtFrom1).append("'").toString();
                }
                if(docDtTo != null) {
                    java.sql.Date sqlDtTo1 = new java.sql.Date(docDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_bonusdate <= '").append(sqlDtTo1).append("'").toString();
                }
                
                String sellerID = request.getParameter("SellerID");
                if(sellerID == null && isAdminUser)
                    sellerID = getLoginUser().getOutletID();
                if(sellerID != null && sellerID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_sellerid = '").append(sellerID.trim()).append("' ").toString();
                String status = request.getParameter("Status");
                if(status != null && status.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_status = ").append(status).toString();
                
                String salesman = request.getParameter("Salesman");
                System.out.println("Salesman : "+ salesman);
                if(salesman != null && salesman.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_bonus_earnerid = '").append(salesman.trim().substring(0,5)).append("' ").toString();
                
                String trxDocNo = request.getParameter("TrxDocNo");
                if(trxDocNo != null && trxDocNo.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdocno LIKE '%").append(trxDocNo.trim()).append("%' ").toString();
                String trxType = request.getParameter("TrxType");
                if(trxType != null && trxType.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxtype = '").append(trxType.trim()).append("' ").toString();
                String custID = null;
                if(isAdminUser)
                    custID = request.getParameter("CustomerID");
                else
                    custID = getLoginUser().getUserId();
                if(custID != null && custID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_custid LIKE '%").append(custID.trim()).append("%' ").toString();
                String custName = request.getParameter("CustomerName");
                if(custName != null && custName.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_cust_name LIKE '%").append(custName.trim()).append("%' ").toString();
                String bonusPeriod = request.getParameter("BonusPeriodID");
                if(bonusPeriod != null && bonusPeriod.length() > 0) {
                    String bulan = bonusPeriod.trim().substring(5, 7).toString();
                    String tahun = bonusPeriod.trim().substring(0, 4).toString();
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and year(cso_bonusperiodid) = '").append(tahun.trim()).append("' ").append(" and month(cso_bonusperiodid) = '").append(bulan.trim()).append("' ").toString();
                    System.out.println("Tahun " + tahun + " bulan " + bulan + " conditions " + conditions);
                }
                String doStatus = request.getParameter("DeliveryStatus");
                if(doStatus != null && doStatus.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_delivery_status = ").append(doStatus).toString();
                cond.setConditions(conditions);
                returnBean.addReturnObject("SalesList", isPrint ? ((Object []) (getFullSalesList(cond))) : ((Object []) (getSalesList(cond))));
            }
            returnBean.addReturnObject("TrxTypeList", getMapForSalesTypes());
            returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
            boolean showAny = isAdminUser;
            returnBean.addReturnObject("BonusPeriodList", getMapForSalesBonusPeriod(showAny));
            returnBean.addReturnObject("ConfirmBonusPeriodList", getConfirmedBonusPeriodList());
            returnBean.addReturnObject("DeliveryStatusList", getMapForSalesDeliveryStatus());
            returnBean.addReturnObject("StatusList", getMapForSalesStatus());
            returnBean.addReturnObject("OrderBy", getMapForSalesOrderBy(isAdminUser));
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
            
            boolean showAny2 = true;
            returnBean.addReturnObject("StaffList", getStaff(showAny2, getLoginUser().getOutletID()));
            
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    public MvcReturnBean searchImportSales(HttpServletRequest request)
    throws MvcException {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            String batch_code = request.getParameter("BatchNo");
            if(batch_code != null && batch_code.length() > 0) {
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = (new StringBuilder(" where cso_batchcode = '")).append(batch_code).append("' ").toString();
                String orderby = " order by cso_trxdocno asc ";
                cond.setOrderby(orderby);
                cond.setConditions(conditions);
                returnBean.addReturnObject("SalesList", getSalesList(cond));
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private MvcReturnBean searchIssueDeliveryList(HttpServletRequest request)
    throws MvcException {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            Date trxDtFrom = null;
            Date trxDtTo = null;
            SQLConditionsBean cond = new SQLConditionsBean();
            String conditions = (new StringBuilder(" where cso_status = 30 and cso_process_status = 20 and cso_delivery_status < 20 and cso_ship_by_outletid = '")).append(getLoginUser().getOutletID()).append("' ").toString();
            String orderby = request.getParameter("OrderBy");
            if(orderby != null && orderby.length() > 0)
                cond.setOrderby((new StringBuilder(" order by ")).append(orderby).append(" asc").toString());
            String trxDtFromStr = request.getParameter("TrxDateFrom");
            String trxDtToStr = request.getParameter("TrxDateTo");
            if(trxDtFromStr != null)
                try {
                    trxDtFrom = Sys.parseDate(trxDtFromStr);
                } catch(Exception exception) { } else
                    trxDtFrom = new Date();
            if(trxDtFromStr != null)
                try {
                    trxDtTo = Sys.parseDate(trxDtToStr);
                } catch(Exception exception1) { } else
                    trxDtTo = new Date();
            if(trxDtFrom != null) {
                java.sql.Date sqlDtFrom = new java.sql.Date(trxDtFrom.getTime());
                conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdate >= '").append(sqlDtFrom).append("'").toString();
            }
            if(trxDtTo != null) {
                java.sql.Date sqlDtTo = new java.sql.Date(trxDtTo.getTime());
                conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdate <= '").append(sqlDtTo).append("'").toString();
            }
            String trxDocNo = request.getParameter("TrxDocNo");
            if(trxDocNo != null && trxDocNo.length() > 0)
                conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdocno LIKE '%").append(trxDocNo.trim()).append("%' ").toString();
            String trxType = request.getParameter("TrxType");
            if(trxType != null && trxType.length() > 0)
                conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxtype = '").append(trxType.trim()).append("' ").toString();
            String custID = request.getParameter("CustomerID");
            if(custID != null && custID.length() > 0)
                conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_custid LIKE '%").append(custID.trim()).append("%' ").toString();
            String custName = request.getParameter("CustomerName");
            if(custName != null && custName.length() > 0)
                conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_cust_name LIKE '%").append(custName.trim()).append("%' ").toString();
            cond.setConditions(conditions);
            returnBean.addReturnObject("SalesList", getSalesList(cond));
            returnBean.addReturnObject("OrderBy", getMapForSalesOrderBy(true));
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    public CounterSalesOrderBean[] getSalesList(SQLConditionsBean conditions)
    throws MvcException {
        CounterSalesOrderBean beans[];
        Connection conn;
        beans = EMPTY_SALES_ORDER_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSalesList(conditions);
            if(!list.isEmpty())
                beans = (CounterSalesOrderBean[])list.toArray(beans);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    public CounterSalesOrderBean[] getFullSalesList(SQLConditionsBean conditions)
    throws MvcException {
        CounterSalesOrderBean beans[];
        Connection conn;
        beans = EMPTY_SALES_ORDER_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getFullSalesList(conditions);
            if(!list.isEmpty())
                beans = (CounterSalesOrderBean[])list.toArray(beans);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }
    
    public CounterSalesOrderBean getSalesOrderSet(Long salesID, String locale)
    throws MvcException {
        CounterSalesOrderBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getSalesOrder(salesID);
            if(bean != null) {
                parseSalesChildsFromDB(bean, locale);
                ArrayList formList = getBroker(conn).getSalesFormList(salesID);
                if(!formList.isEmpty())
                    bean.setFormArray((CounterSalesFormBean[])formList.toArray(EMPTY_SALES_FORM_ARRAY));
                ArrayList paymentList = getBroker(conn).getSalesPaymentList(salesID);
                if(!paymentList.isEmpty())
                    bean.setPaymentArray((CounterSalesPaymentBean[])paymentList.toArray(EMPTY_SALES_PAYMENT_ARRAY));
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public CounterSalesOrderBean getSalesOrder(Long salesID)
    throws MvcException {
        CounterSalesOrderBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getSalesOrder(salesID);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public CounterSalesOrderBean getSalesOrderByAdjstID(Long adjSalesID)
    throws MvcException {
        CounterSalesOrderBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getAdjstSalesOrder(adjSalesID);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    protected void parseSalesChildsFromDB(CounterSalesOrderBean bean, String locale)
    throws Exception {
        boolean parseLocale;
        ProductManager mgr;
        Connection conn;
        parseLocale = false;
        mgr = null;
        conn = null;
        try {
            conn = getConnection();
            if(bean != null) {
                if(locale != null && locale.length() > 0) {
                    mgr = new ProductManager(conn);
                    parseLocale = true;
                }
                ArrayList itemList = getBroker(conn).getSalesItemList(bean.getSalesID());
                
                // System.out.println("Chek itemList "+itemList.toString());
                
                if(!itemList.isEmpty()) {
                    for(int i = 0; i < itemList.size(); i++) {
                        CounterSalesItemBean itemBean = (CounterSalesItemBean)itemList.get(i);
                        itemBean.setMaster(bean);
                        bean.addItem(itemBean);
                        if(parseLocale) {
                            ProductBean product = mgr.getProduct(itemBean.getProductID(), locale);
                            itemBean.setProductBean(product);
                        }
                        ArrayList productList = getBroker(conn).getSalesProductList(itemBean.getSeq());
                        
                        // System.out.println("Chek productList "+productList.toString());
                        
                        if(!productList.isEmpty()) {
                            for(int j = 0; j < productList.size(); j++) {
                                CounterSalesProductBean pBean = (CounterSalesProductBean)productList.get(j);
                                pBean.setMaster(itemBean);
                                itemBean.addProduct(pBean);
                                if(parseLocale && getLoginUser() != null) {
                                    ProductBean component = mgr.getProduct(pBean.getProductID(), getLoginUser().getLocale().toString());
                                    pBean.setProductBean(component);
                                }
                            }
                            
                        }
                    }
                    
                }
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return;
    }
    
    public MvcReturnBean addStockistSalesSubmission(String stockistID, ArrayList salesList, LoginUserBean loginUser, MvcReturnBean returnBean) {
        if(returnBean == null)
            returnBean = new MvcReturnBean();
        setLoginUser(loginUser);
        try {
            double submissionValue = 0.0D;
            for(int i = 0; i < salesList.size(); i++) {
                CounterSalesOrderBean sales = (CounterSalesOrderBean)salesList.get(i);
                sales.setSellerTypeStatus("S");
                // sales.setTrxDocType("CB");
                sales.setTrxDocType("IN");
                sales.setTrxDocName("Cash Bill");
                sales.setTrxType("DS");
                sales.setTrxGroup(10);
                sales.setProcessStatus(20);
                sales.setDeliveryStatus(20);
                sales.setStatus(30);
                sales.setShipOption(10);
                sales.setImmediateDelivery("Y");
                sales.setDisplayDelivery("N");
                DeliveryOrderBean doBean = createDeliveryOrderBean(sales, true, true);
                parseFullDeliveryOrderForm(sales, doBean, returnBean);
                sales.setDeliveryOrderBean(doBean);
                submissionValue += sales.getTotalBv1();
            }
            
            checkSellerQuotaWalletBalance(stockistID, submissionValue, returnBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = insertStockistSalesSubmission(salesList);
            else
                returnBean.fail();
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private boolean insertStockistSalesSubmission(ArrayList salesList)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            for(int i = 0; i < salesList.size(); i++) {
                CounterSalesOrderBean sales = (CounterSalesOrderBean)salesList.get(i);
                status = insertSalesRecord(conn, sales);
                DeliveryOrderBean doBean = sales.getDeliveryOrderBean();
                doBean.setTrxDocNo(sales.getTrxDocNo());
                doBean.setSalesRefNo(sales.getTrxDocNo());
                doBean.setSalesID(sales.getSalesID().intValue());
                status = insertDeliveryRecord(conn, doBean);
                status = stockOutSellerInventory(conn, doBean);
                if(sales.getBonusPeriodID() != null && sales.getTotalBv1() > 0.0D) {
                    PurchaseOrderBean purchase = createPurchaseBean(sales);
                    status = (new PurchaseManager(conn)).insertPurchase(purchase);
                    BvWalletBean bvWallet = createBvWalletBean(sales, true);
                    long l1 = (new BvWalletManager(conn)).insertDistributorBvItem(bvWallet);
                }
                QuotaWalletBean quotaWallet = createSellerQuotaWalletBean(sales, false);
                quotaWallet.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                long l = (new QuotaWalletManager(conn)).insertQuotaRecord(quotaWallet);
            }
            
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private MvcReturnBean addNewMemberSalesFullDeliveryStock(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("DS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(20);
            sales.setStatus(30);
            sales.setImmediateDelivery("Y");
            sales.setDisplayDelivery("N");
            parseSalesOrderForm(sales, returnBean, request);
            DeliveryOrderBean doBean = createDeliveryOrderBeanStock(sales, true, true);
            parseFullDeliveryOrderForm(sales, doBean, returnBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = insertMemberSalesFullDeliveryStock(sales, doBean);
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError("error di add new " + ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private MvcReturnBean addNewMemberSalesFullDelivery(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("DS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(20);
            sales.setStatus(30);
            sales.setImmediateDelivery("Y");
            sales.setDisplayDelivery("N");
            parseSalesOrderForm(sales, returnBean, request);
            DeliveryOrderBean doBean = createDeliveryOrderBean(sales, true, true);
            parseFullDeliveryOrderForm(sales, doBean, returnBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = insertMemberSalesFullDelivery(sales, doBean);
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private boolean insertMemberSalesFullDelivery(CounterSalesOrderBean sales, DeliveryOrderBean doBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            status = insertSalesRecord(conn, sales);
            if(status) {
                doBean.setTrxDocNo(sales.getTrxDocNo());
                doBean.setSalesRefNo(sales.getTrxDocNo());
                doBean.setSalesID(sales.getSalesID().intValue());
            }
            status = insertDeliveryRecord(conn, doBean);
            status = stockOutSellerInventory(conn, doBean);
            if(sales.getBonusPeriodID() != null && sales.getTotalBv1() > 0.0D) {
                PurchaseOrderBean purchase = createPurchaseBean(sales);
                status = (new PurchaseManager(conn)).insertPurchase(purchase);
                BvWalletBean bvWallet = createBvWalletBean(sales, true);
                long l1 = (new BvWalletManager(conn)).insertDistributorBvItem(bvWallet);
            }
            if(sales.getSellerTypeStatus().equals("S")) {
                QuotaWalletBean quotaWallet = createSellerQuotaWalletBean(sales, false);
                quotaWallet.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                long l = (new QuotaWalletManager(conn)).insertQuotaRecord(quotaWallet);
            }
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean insertMemberSalesFullDeliveryStock(CounterSalesOrderBean sales, DeliveryOrderBean doBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            status = insertSalesRecord(conn, sales);
            if(status) {
                doBean.setTrxDocNo(sales.getTrxDocNo());
                doBean.setSalesRefNo(sales.getTrxDocNo());
                doBean.setSalesID(sales.getSalesID().intValue());
            }
            status = insertDeliveryRecord(conn, doBean);
            status = stockOutSellerInventory(conn, doBean);
            if(sales.getBonusPeriodID() != null && sales.getTotalBv1() > 0.0D) {
                PurchaseOrderBean purchase = createPurchaseBean(sales);
                status = (new PurchaseManager(conn)).insertPurchase(purchase);
                BvWalletBean bvWallet = createBvWalletBean(sales, true);
                long l1 = (new BvWalletManager(conn)).insertDistributorBvItem(bvWallet);
            }
            if(sales.getSellerTypeStatus().equals("S")) {
                QuotaWalletBean quotaWallet = createSellerQuotaWalletBean(sales, false);
                quotaWallet.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                long l = (new QuotaWalletManager(conn)).insertQuotaRecord(quotaWallet);
            }
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    
    private MvcReturnBean addNewNormalSalesFullDelivery(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("NS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(20);
            sales.setStatus(30);
            sales.setImmediateDelivery("Y");
            sales.setDisplayDelivery("N");
            
            // tambahan tuk Sales Invoice Return
            String invoice = request.getParameter("InvoiceReturn");
            if (invoice != null && invoice.length() > 0){
                sales.setAdjstRefNo(invoice); 
            }
            
            // ambil dari parameter screen
            parseSalesOrderForm(sales, returnBean, request);
            DeliveryOrderBean doBean = createDeliveryOrderBean(sales, true, true);
            parseFullDeliveryOrderForm(sales, doBean, returnBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                // mulai insert 02
                // status = insertNormalSalesFullDelivery(sales, doBean);
                
                // update krn Sales Invoice Return
                if (invoice != null && invoice.length() > 0) {
                status = insertNormalSalesFullDeliveryReturn(sales, doBean);
                }else {
                status = insertNormalSalesFullDelivery(sales, doBean);
                
                if(sales.getCustomerLucky()==10) {
                    
                    System.out.println("Masuk Insert Custumer 1");
                    
                    MemberBean member = new MemberBean();
                    
                    // member.setMemberID((new StringBuilder("FR-")).append(sales.getCustomerContact()).toString());
                    member.setMemberID(sales.getCustomerID());
                    member.setName(sales.getCustomerName());
                    member.setMobileNo(sales.getCustomerContact());
                    member.setJoinDate(sales.getTrxDate());
                    
                    LoginUserBean loginuser = getLoginUser();
                    member.setBonusTree(0);
                    member.setBonusRank(0);
                    member.setStatus(10);
                    member.setHomeBranchID(loginuser.getOutletID());
                    member.setStd_createBy(loginuser.getUserId());
                    member.setRegister(0);
                    member.setOriginalID("");
                    status = addMember(member);
                    
                }
                
                }
            
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
                
            } else {
                returnBean.fail();
            }
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    //Updated By Ferdi 2015-06-04
    private String getDoubleSerialNmbr(CounterSalesOrderBean sales, MvcReturnBean returnBean)
    {
        CounterSalesItemBean salesItemList[] = sales.getItemArray();
        ArrayList serialNmbrList = new ArrayList();
        ArrayList doubleList = new ArrayList();
        String doubleSerialNmbr = "";

        for(int i = 0;i < salesItemList.length;i++)
        {
            String serialNmbr = salesItemList[i].getProductSKU();

            if(serialNmbrList.contains(serialNmbr)) doubleList.add(serialNmbr);

            serialNmbrList.add(i, serialNmbr);
        }

        if(doubleList.size() > 0)
        {
            for(int i = 0; i < doubleList.size(); i++)
            {
                doubleSerialNmbr += doubleList.get(i).toString() + "<br>";
            }
        }
        
        return doubleSerialNmbr;
    }
    //End Updated
       
    private MvcReturnBean addNewNormalSalesFullDeliveryHE(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("NS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setStatus(30);
            sales.setCustomerRemark("Normal");
            
            // Update terkait KIT
            // Check Status Delivery, if full 1 else 0
            
            String sdelivery = request.getParameter("status");
            System.out.println("status : "+sdelivery);
            
            if (sdelivery.equalsIgnoreCase("1")) {
                sales.setDeliveryStatus(20);
                sales.setImmediateDelivery("Y");
                sales.setDisplayDelivery("N");
            }else {
                sales.setDeliveryStatus(10);
                sales.setImmediateDelivery("N");
                sales.setDisplayDelivery("N");
            }
            
            // tambahan tuk Sales Invoice Return
            String invoice = request.getParameter("InvoiceReturn");
            if (invoice != null && invoice.length() > 0)
                sales.setAdjstRefNo(invoice);
            
            // ambil dari parameter screen
            parseSalesOrderFormHE(sales, returnBean, request);
            System.out.println("selesai parseSalesOrderFormHE ");
            
            //Updated By Ferdi 2015-06-04
            //Validasi Double Input Serial Number
            String doubleSerialNmbr = getDoubleSerialNmbr(sales, returnBean);
            
            if(doubleSerialNmbr.equalsIgnoreCase(""))
            {
                // if Status Delivery 1
                DeliveryOrderBean doBean = createDeliveryOrderBean(sales, true, true);
                parseFullDeliveryOrderForm(sales, doBean, returnBean);

                System.out.println("selesai parseFullDeliveryOrderForm ");

                boolean status = !returnBean.hasErrorMessages();
                if(status)
                    // mulai insert 02
                    // update krn Sales Invoice Return
                    if (invoice != null && invoice.length() > 0) {
                    //status = insertNormalSalesFullDeliveryReturn(sales, doBean);
                    status = insertNormalSalesFullDeliveryReturn(sales, doBean);
                    }else {
                    status = insertNormalSalesFullDelivery(sales, doBean);                
                    }

                System.out.println("selesai insertNormalSalesFullDelivery ");

                String noid1 = request.getParameter("custID");

                // if (noid == null) if(sales.getCustomerLucky()==10) {

                if(sales.getCustomerLucky()==10) {
                    System.out.println("Masuk Insert Custumer 1" + sales.getCustomerLucky() + "NoID : "+ noid1 );

                    MemberBean member = new MemberBean();

                    // member.setMemberID((new StringBuilder("FR-")).append(sales.getCustomerContact()).toString());
                    member.setMemberID(sales.getCustomerID());
                    member.setName(sales.getCustomerName());
                    member.setMobileNo(sales.getCustomerContact());
                    member.setJoinDate(sales.getTrxDate());

                    LoginUserBean loginuser = getLoginUser();
                    member.setBonusTree(0);
                    member.setBonusRank(0);
                    member.setStatus(10);
                    member.setHomeBranchID(loginuser.getOutletID());
                    member.setStd_createBy(loginuser.getUserId());
                    member.setRegister(0);
                    member.setOriginalID("");
                    status = addMember(member);

                }else{

                    System.out.println("Masuk Insert Custumer 1" + sales.getCustomerLucky() + "NoID : "+ noid1 );
                    status = true;
                }
                // }

                if(status) {
                    returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                    returnBean.done();

                } else {
                    returnBean.fail();
                }
            }
            else
            {
                returnBean.fail();
                returnBean.addError("Double Input Item :<br><br>" + doubleSerialNmbr);
            }
            //End Updated  
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    //Updated By Mila 2016-04-06 Untuk digunakan sbg method SIR
    private MvcReturnBean addNewNormalSalesFullDeliveryHESIR(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("NS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setStatus(30);
            sales.setCustomerRemark("Normal");
            
            // Update terkait KIT
            // Check Status Delivery, if full 1 else 0
            
            String sdelivery = request.getParameter("status");
            System.out.println("status : "+sdelivery);
            
            if (sdelivery.equalsIgnoreCase("1")) {
                sales.setDeliveryStatus(20);
                sales.setImmediateDelivery("Y");
                sales.setDisplayDelivery("N");
            }else {
                sales.setDeliveryStatus(10);
                sales.setImmediateDelivery("N");
                sales.setDisplayDelivery("N");
            }
            
            // tambahan tuk Sales Invoice Return
            String invoice = request.getParameter("InvoiceReturn");
            if (invoice != null && invoice.length() > 0)
                sales.setAdjstRefNo(invoice);
            
            // ambil dari parameter screen
            parseSalesOrderFormHE(sales, returnBean, request);
            System.out.println("selesai parseSalesOrderFormHE ");
            
            //Updated By Ferdi 2015-06-04
            //Validasi Double Input Serial Number
            String doubleSerialNmbr = getDoubleSerialNmbr(sales, returnBean);
            
            if(doubleSerialNmbr.equalsIgnoreCase(""))
            {
                // if Status Delivery 1
                DeliveryOrderBean doBean = createDeliveryOrderBean(sales, true, true);
                parseFullDeliveryOrderForm(sales, doBean, returnBean);

                System.out.println("selesai parseFullDeliveryOrderForm ");

                boolean status = !returnBean.hasErrorMessages();
                if(status)
                    // mulai insert 02
                    // update krn Sales Invoice Return
                    if (invoice != null && invoice.length() > 0) {
                    //status = insertNormalSalesFullDeliveryReturn(sales, doBean);
                    status = insertNormalSalesFullDeliveryReturn(sales, doBean);
                    }else {
                    status = insertNormalSalesFullDeliverySIR(sales, doBean);                
                    }

                System.out.println("selesai insertNormalSalesFullDelivery SIR");

                String noid1 = request.getParameter("custID");

                // if (noid == null) if(sales.getCustomerLucky()==10) {

                if(sales.getCustomerLucky()==10) {
                    System.out.println("Masuk Insert Custumer 1" + sales.getCustomerLucky() + "NoID : "+ noid1 );

                    MemberBean member = new MemberBean();

                    // member.setMemberID((new StringBuilder("FR-")).append(sales.getCustomerContact()).toString());
                    member.setMemberID(sales.getCustomerID());
                    member.setName(sales.getCustomerName());
                    member.setMobileNo(sales.getCustomerContact());
                    member.setJoinDate(sales.getTrxDate());

                    LoginUserBean loginuser = getLoginUser();
                    member.setBonusTree(0);
                    member.setBonusRank(0);
                    member.setStatus(10);
                    member.setHomeBranchID(loginuser.getOutletID());
                    member.setStd_createBy(loginuser.getUserId());
                    member.setRegister(0);
                    member.setOriginalID("");
                    status = addMember(member);

                }else{

                    System.out.println("Masuk Insert Custumer 1" + sales.getCustomerLucky() + "NoID : "+ noid1 );
                    status = true;
                }
                // }

                if(status) {
                    returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                    returnBean.done();

                } else {
                    returnBean.fail();
                }
            }
            else
            {
                returnBean.fail();
                returnBean.addError("Double Input Item :<br><br>" + doubleSerialNmbr);
            }
            //End Updated  
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private MvcReturnBean addNewNormalSalesFullDeliveryHEForce(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("NS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(20);
            sales.setStatus(30);
            sales.setImmediateDelivery("Y");
            sales.setDisplayDelivery("N");
            
            sales.setCustomerRemark("Force");            
            // Update terkait KIT
            // Check Status Delivery, if full 1 else 0
            
            String sdelivery = request.getParameter("status");
            System.out.println("status : "+sdelivery);
            
            if (sdelivery.equalsIgnoreCase("1")) {
                sales.setDeliveryStatus(20);
                sales.setImmediateDelivery("Y");
                sales.setDisplayDelivery("N");
            }else {
                sales.setDeliveryStatus(10);
                sales.setImmediateDelivery("N");
                sales.setDisplayDelivery("N");
            }
            
            // tambahan tuk Sales Invoice Return
            String invoice = request.getParameter("InvoiceReturn");
            if (invoice != null && invoice.length() > 0)
                sales.setAdjstRefNo(invoice);
            
            // ambil dari parameter screen
            parseSalesOrderFormHEForce(sales, returnBean, request);
            
            //Updated By Ferdi 2015-06-04
            //Validasi Double Input Serial Number
            String doubleSerialNmbr = getDoubleSerialNmbr(sales, returnBean);
            
            if(doubleSerialNmbr.equalsIgnoreCase(""))
            {
                DeliveryOrderBean doBean = createDeliveryOrderBean(sales, true, true);
                parseFullDeliveryOrderForm(sales, doBean, returnBean);
                boolean status = !returnBean.hasErrorMessages();
                if(status)
                    // mulai insert 02
                    // status = insertNormalSalesFullDelivery(sales, doBean);

                    // update krn Sales Invoice Return
                    if (invoice != null && invoice.length() > 0) {
                    status = insertNormalSalesFullDeliveryReturn(sales, doBean);
                    }else {
                    status = insertNormalSalesFullDelivery(sales, doBean);
                    // loss
                    }

                String noid1 = request.getParameter("custID");

                // if (noid == null) if(sales.getCustomerLucky()==10) {

                if(sales.getCustomerLucky()==10) {
                    System.out.println("Masuk Insert Custumer 1" + sales.getCustomerLucky() + "NoID : "+ noid1 );

                    MemberBean member = new MemberBean();

                    // member.setMemberID((new StringBuilder("FR-")).append(sales.getCustomerContact()).toString());
                    member.setMemberID(sales.getCustomerID());
                    member.setName(sales.getCustomerName());
                    member.setMobileNo(sales.getCustomerContact());
                    member.setJoinDate(sales.getTrxDate());

                    LoginUserBean loginuser = getLoginUser();
                    member.setBonusTree(0);
                    member.setBonusRank(0);
                    member.setStatus(10);
                    member.setHomeBranchID(loginuser.getOutletID());
                    member.setStd_createBy(loginuser.getUserId());
                    member.setRegister(0);
                    member.setOriginalID("");
                    status = addMember(member);

                }else{

                    System.out.println("Masuk Insert Custumer 1" + sales.getCustomerLucky() + "NoID : "+ noid1 );
                    status = true;
                }
                // }

                if(status) {
                    returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                    returnBean.done();

                } else {
                    returnBean.fail();
                }
            }
            else
            {
                returnBean.fail();
                returnBean.addError("Double Input Item :<br><br>" + doubleSerialNmbr);
            }
            //End Updated
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private MvcReturnBean addNewNormalSalesFullDeliveryHEForceReturn(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
                        
            sales.setAdjstSalesID(0);
            // sales.setAdjstRefNo("RFORCE".concat(new Date().toString()));
            sales.setAdjstRefNo("RETURN-FORCE");
            sales.setBonusDate(new Date());
            sales.setTrxDate(new Date());
            sales.setTrxTime(new Time((new Date()).getTime()));
            
            sales.setTrxDocType("SR");
            sales.setTrxDocName("Sales Return");
            sales.setTrxType("NS");
            sales.setTrxGroup(40);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(20);
            sales.setStatus(-10);

            // sales.setPaymentArray(null);
            // sales.setSalesID(null);
            // sales.setTrxDocNo(null);
            // sales.resetMvcInfo();
            
            sales.setImmediateDelivery("Y");
            sales.setDisplayDelivery("N");
            
            sales.setCustomerRemark("ForceReturn");
            
            String sdelivery = request.getParameter("status");
            System.out.println("status : "+sdelivery);
            
            if (sdelivery.equalsIgnoreCase("1")) {
                sales.setDeliveryStatus(20);
                sales.setImmediateDelivery("Y");
                sales.setDisplayDelivery("N");
            }else {
                sales.setDeliveryStatus(10);
                sales.setImmediateDelivery("N");
                sales.setDisplayDelivery("N");
            }
            
            // tambahan tuk Sales Invoice Return
            String invoice = request.getParameter("InvoiceReturn");
            if (invoice != null && invoice.length() > 0)
                sales.setAdjstRefNo(invoice);
            
            // ambil dari parameter screen
            parseSalesOrderFormHEForceReturn(sales, returnBean, request);
            
            DeliveryOrderBean doBean = createDeliveryOrderBean(sales, true, true);
            parseFullDeliveryOrderForm(sales, doBean, returnBean);
            
            // voidDelivery(sales, doBean, returnBean, request);
            
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                // mulai insert 02
                // status = insertNormalSalesFullDelivery(sales, doBean);
                
                // update krn Sales Invoice Return
                if (invoice != null && invoice.length() > 0) {
                status = insertNormalSalesFullDeliveryReturn(sales, doBean);
                }else {
                status = insertNormalSalesFullDeliveryForceReturn(sales, doBean);
                // loss
                }
            
            String noid1 = request.getParameter("custID");
            
            // if (noid == null) if(sales.getCustomerLucky()==10) {
            
            if(sales.getCustomerLucky()==10) {
                System.out.println("Masuk Insert Custumer 1" + sales.getCustomerLucky() + "NoID : "+ noid1 );
                
                MemberBean member = new MemberBean();
                
                // member.setMemberID((new StringBuilder("FR-")).append(sales.getCustomerContact()).toString());
                member.setMemberID(sales.getCustomerID());
                member.setName(sales.getCustomerName());
                member.setMobileNo(sales.getCustomerContact());
                member.setJoinDate(sales.getTrxDate());
                
                LoginUserBean loginuser = getLoginUser();
                member.setBonusTree(0);
                member.setBonusRank(0);
                member.setStatus(10);
                member.setHomeBranchID(loginuser.getOutletID());
                member.setStd_createBy(loginuser.getUserId());
                member.setRegister(0);
                member.setOriginalID("");
                status = addMember(member);
                
            }else{
                
                System.out.println("Masuk Insert Custumer 1" + sales.getCustomerLucky() + "NoID : "+ noid1 );
                status = true;
            }
            // }
            
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
                
            } else {
                returnBean.fail();
            }
            
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }

    private void refundSales(CounterSalesOrderBean originBean, MvcReturnBean returnBean, HttpServletRequest request) {
        if(originBean.getStatus() != 30) {
            returnBean.addError("The sales trx has been returned");
            returnBean.fail();
            return;
        }
        try {
            CounterSalesOrderBean voidBean = getSalesOrderSet(originBean.getSalesID(), null);
            voidBean.setAdjstSalesID(voidBean.getSalesID().intValue());
            voidBean.setAdjstRefNo(voidBean.getTrxDocNo());
            // update tuk return dilain hari, tapi doc date ikut now()
            voidBean.setBonusDate(new Date());
            voidBean.setTrxDate(new Date());
            voidBean.setTrxTime(new Time((new Date()).getTime()));
            // voidBean.setTrxDocType("CN");
            voidBean.setTrxDocType("SR");
            voidBean.setTrxDocName("Sales Return");
            voidBean.setTrxGroup(40);
            voidBean.setStatus(-10);
            voidBean.setPaymentArray(null);
            voidBean.setSalesID(null);
            voidBean.setTrxDocNo(null);
            voidBean.resetMvcInfo();
            
            // ambil variable voucher
            String cek = originBean.getShipFromStoreCode();
            if(cek == null)
               cek = "";
            
            if(cek != null) {
                String voucher0 = cek.trim();
                if(voucher0.length() > 0) {
                    int pan = voucher0.length();
                    String voucher1 = voucher0.substring(2,pan);
                    // String voucher2 = voucher1.replaceAll("/","','");
                    // String voucher3 = "('".concat(voucher2).concat("')");
                    String keterangan = "R";
                    voidBean.setShipFromStoreCode(keterangan.concat("-").concat(voucher1));
                    // pindah ke create document
                    // updateVoucherSerial(originBean, voucher1, keterangan);
                    System.out.println("cek setShipExpedition di Return " + keterangan.concat("-").concat(voucher1));
                }
            } else {
                voidBean.setShipFromStoreCode("");
            }
            
            
            parseSalesRefundForm(voidBean, returnBean, request);
            CounterSalesFormBean formList[] = voidBean.getFormArray();
            for(int i = 0; i < formList.length; i++)
                formList[i].setStatus(-10);
            
            originBean.setStatus(60);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = voidSalesRecord(originBean, voidBean);
            if(status)
                returnBean.done();
            else
                returnBean.fail();
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return;
    }
    
    private MvcReturnBean addNewNormalSalesFullDeliveryReturn(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("NS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(20);
            sales.setStatus(30);
            sales.setImmediateDelivery("Y");
            sales.setDisplayDelivery("N");
            // ambil dari parameter screen
            parseSalesOrderForm(sales, returnBean, request);
            DeliveryOrderBean doBean = createDeliveryOrderBean(sales, true, true);
            parseFullDeliveryOrderForm(sales, doBean, returnBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                // mulai insert 02
                status = insertNormalSalesFullDelivery(sales, doBean);
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
        
    private MvcReturnBean addNewStaffSalesFullDelivery(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("WS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(20);
            sales.setStatus(30);
            sales.setImmediateDelivery("Y");
            sales.setDisplayDelivery("N");
            parseSalesOrderForm(sales, returnBean, request);
            DeliveryOrderBean doBean = createDeliveryOrderBean(sales, true, true);
            parseFullDeliveryOrderForm(sales, doBean, returnBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = insertNormalSalesFullDelivery(sales, doBean);
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
       
    private boolean insertNormalSalesFullDelivery(CounterSalesOrderBean sales, DeliveryOrderBean doBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            System.out.println(" mulai insert 01 ");
            status = insertSalesRecord(conn, sales);
            System.out.println(" selesai insert 02 ");
            if(status) {
                doBean.setTrxDocNo(sales.getTrxDocNo());
                doBean.setSalesRefNo(sales.getTrxDocNo());
                doBean.setSalesID(sales.getSalesID().intValue());
            }
            status = insertDeliveryRecord(conn, doBean);
            System.out.println(" selesai insert 03 ");
            status = stockOutSellerInventory(conn, doBean);
            System.out.println(" selesai insert 04 ");
            // update Voucher & PIN
            status = updateOutletVoucher(sales.getCustomerIdentityNo(), sales.getCustomerID());
            // status = deleteTablePIN(sales.getCustomerID());    
            System.out.println(" selesai insert 05 ");
            
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    //Updated By Mila 2016-04-06 SIR
    private boolean insertNormalSalesFullDeliverySIR(CounterSalesOrderBean sales, DeliveryOrderBean doBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            System.out.println(" mulai insert 01 ");
            status = insertSalesRecordSIR(conn, sales);
            System.out.println(" selesai insert 02 ");
            if(status) {
                doBean.setTrxDocNo(sales.getTrxDocNo());
                doBean.setSalesRefNo(sales.getTrxDocNo());
                doBean.setSalesID(sales.getSalesID().intValue());
            }
            status = insertDeliveryRecord(conn, doBean);
            System.out.println(" selesai insert 03 ");
            status = stockOutSellerInventory(conn, doBean);
            System.out.println(" selesai insert 04 ");
            // update Voucher & PIN
            status = updateOutletVoucher(sales.getCustomerIdentityNo(), sales.getCustomerID());
            // status = deleteTablePIN(sales.getCustomerID());    
            System.out.println(" selesai insert 05 ");
            
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean insertNormalSalesFullDeliveryForceReturn(CounterSalesOrderBean sales, DeliveryOrderBean doBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            // mulai insert 03
            status = insertSalesRecordForceReturn(conn, sales);
            if(status) {
                doBean.setTrxDocNo("RFORCE".concat(sales.getSalesID().toString()));
                doBean.setSalesRefNo(sales.getTrxDocNo());
                doBean.setSalesID(sales.getSalesID().intValue());
                
        doBean.setTrxDocType("GRN");
        doBean.setTrxDocName("Good Return Note");
        doBean.setTrxGroup(30);
        doBean.setStatus(-10);
        doBean.setAdjstRefNo(sales.getTrxDocNo());
        
            }
            status = insertDeliveryRecord(conn, doBean);
            status = stockInSellerInventoryForceReturn(conn, doBean, sales);
            // update Voucher & PIN
            status = updateOutletVoucher(sales.getCustomerIdentityNo(), sales.getCustomerID());
            // status = deleteTablePIN(sales.getCustomerID());            
            
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean insertNormalSalesFullDeliveryReturn(CounterSalesOrderBean sales, DeliveryOrderBean doBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            //mulai insert 03
            //status = insertSalesRecordReturn(conn, sales);
            status = insertSalesRecord(conn, sales);
            if(status) {
                doBean.setTrxDocNo(sales.getTrxDocNo());
                doBean.setSalesRefNo(sales.getTrxDocNo());
                doBean.setSalesID(sales.getSalesID().intValue());                
            }
            status = insertDeliveryRecord(conn, doBean);
            status = stockOutSellerInventoryReturn(conn, doBean, sales);
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private MvcReturnBean addNewMemberSales(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("DS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(0);
            sales.setStatus(30);
            parseSalesOrderForm(sales, returnBean, request);
            if(sales.getSellerTypeStatus().equals("S"))
                checkSellerQuotaWalletBalance(sales.getSellerID(), sales.getTotalBv1(), returnBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = insertMemberSales(sales);
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private MvcReturnBean addNewMobileSales(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("DS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(0);
            sales.setStatus(30);
            parseSalesOrderForm(sales, returnBean, request);
            if(sales.getSellerTypeStatus().equals("S"))
                checkSellerQuotaWalletBalance(sales.getSellerID(), sales.getTotalBv1(), returnBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = insertMobileSales(sales);
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private boolean insertMemberSales(CounterSalesOrderBean sales)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            status = insertSalesRecord(conn, sales);
            if(sales.getBonusPeriodID() != null && sales.getTotalBv1() > 0.0D) {
                PurchaseOrderBean purchase = createPurchaseBean(sales);
                status = (new PurchaseManager(conn)).insertPurchase(purchase);
                BvWalletBean bvWallet = createBvWalletBean(sales, true);
                long l1 = (new BvWalletManager(conn)).insertDistributorBvItem(bvWallet);
            }
            if(sales.getSellerTypeStatus().equals("S")) {
                QuotaWalletBean quotaWallet = createSellerQuotaWalletBean(sales, false);
                quotaWallet.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                long l = (new QuotaWalletManager(conn)).insertQuotaRecord(quotaWallet);
            }
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean insertMobileSales(CounterSalesOrderBean sales)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            status = insertSalesRecord(conn, sales);
            if(sales.getBonusPeriodID() != null && sales.getTotalBv1() > 0.0D) {
                PurchaseOrderBean purchase = createPurchaseBean(sales);
                status = (new PurchaseManager(conn)).insertPurchase(purchase);
                BvWalletBean bvWallet = createBvWalletBean(sales, true);
                long l1 = (new BvWalletManager(conn)).insertDistributorBvItem(bvWallet);
            }
            
            if(sales.getSellerTypeStatus().equals("S")) {
                QuotaWalletBean quotaWallet = createSellerQuotaWalletBean(sales, false);
                quotaWallet.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                long l = (new QuotaWalletManager(conn)).insertQuotaRecord(quotaWallet);
            }
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private MvcReturnBean addNewStockistSales(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            sales.setTrxDocType("SDO");
            sales.setTrxDocName("Stockist DO");
            sales.setTrxType("SS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(0);
            sales.setStatus(30);
            sales.setImmediateDelivery("Y");
            sales.setDisplayDelivery("Y");
            parseSalesOrderForm(sales, returnBean, request);
            if(sales.getSellerTypeStatus().equals("S"))
                checkSellerQuotaWalletBalance(sales.getSellerID(), sales.getTotalBv1(), returnBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                System.out.println("chek nilai sales.getTotalBv1() " + sales.getTotalBv1());
            status = insertStockistSales(sales);
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private boolean insertStockistSales(CounterSalesOrderBean sales)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            status = insertSalesRecord(conn, sales);
            QuotaWalletBean quotaWallet = createBuyerQuotaWalletBean(sales, true);
            quotaWallet.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
            long seqIDBv = (new QuotaWalletManager(conn)).insertQuotaRecord(quotaWallet);
            
            if(sales.getTotalBv1() > 0.0D && sales.getSellerTypeStatus().equals("S")) {
                QuotaWalletBean quotaWallet2 = createSellerQuotaWalletBean(sales, false);
                quotaWallet2.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                long l = (new QuotaWalletManager(conn)).insertQuotaRecord(quotaWallet2);
                System.out.println("chek nilai sales.getTotalBv1() " + sales.getTotalBv1());
            }
            
            commitTransaction();
        } catch(Exception ex) {
            rollBackTransaction();
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private MvcReturnBean addNewNormalSales(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("NS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(0);
            sales.setStatus(30);
            parseSalesOrderForm(sales, returnBean, request);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = insertNormalSales(sales);
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private MvcReturnBean addNewStaffSales(HttpServletRequest request) {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            CounterSalesOrderBean sales = getSalesInfoFromSession(request);
            // sales.setTrxDocType("CB");
            sales.setTrxDocType("IN");
            sales.setTrxDocName("Cash Bill");
            sales.setTrxType("WS");
            sales.setTrxGroup(10);
            sales.setProcessStatus(20);
            sales.setDeliveryStatus(0);
            sales.setStatus(30);
            parseSalesOrderForm(sales, returnBean, request);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = insertNormalSales(sales);
            if(status) {
                returnBean.addReturnObject("SalesID", sales.getSalesID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private boolean insertNormalSales(CounterSalesOrderBean sales)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            status = insertSalesRecord(conn, sales);
        } catch(Exception ex) {
            status = false;
            Log.error(ex);
            throw new Exception(ex);
        }
        
        releaseConnection(conn);
        return status;
    }
    
    private void voidSales(CounterSalesOrderBean originBean, MvcReturnBean returnBean, HttpServletRequest request) {
        if(originBean.getStatus() != 30) {
            returnBean.addError("The sales trx has been voided");
            returnBean.fail();
            return;
        }
        try {
            CounterSalesOrderBean voidBean = getSalesOrderSet(originBean.getSalesID(), null);
            voidBean.setAdjstSalesID(voidBean.getSalesID().intValue());
            voidBean.setAdjstRefNo(voidBean.getTrxDocNo());
            voidBean.setTrxDate(new Date());
            voidBean.setTrxTime(new Time((new Date()).getTime()));
            voidBean.setTrxDocType("CN");
            voidBean.setTrxDocName("Sales Void");
            voidBean.setTrxGroup(30);
            voidBean.setStatus(-10);
            voidBean.setSalesID(null);
            voidBean.setTrxDocNo(null);
            voidBean.resetMvcInfo();
            
            // ambil variable voucher
            String cek = originBean.getShipFromStoreCode();            
            if(cek == null)
               cek = "";
            
            if(cek != null) {
                String voucher0 = cek.trim();
                if(voucher0.length() > 0) {
                    int pan = voucher0.length();
                    String voucher1 = voucher0.substring(2,pan);
                    String keterangan = "V";
                    voidBean.setShipFromStoreCode(keterangan.concat("-").concat(voucher1));
                    // pindah ke createdocument
                    // updateVoucherSerial(originBean, voucher1, keterangan);
                    System.out.println("cek setShipExpedition di Void " + keterangan.concat("-").concat(voucher1));
                }
            } else {
                voidBean.setShipFromStoreCode("");
            }            
            
            parseSalesVoidForm(voidBean, returnBean, request);
            CounterSalesFormBean formList[] = voidBean.getFormArray();
            for(int i = 0; i < formList.length; i++)
                formList[i].setStatus(-10);
            
            CounterSalesPaymentBean paymentList[] = voidBean.getPaymentArray();
            for(int i = 0; i < paymentList.length; i++)
                paymentList[i].setStatus(-10);
            
            originBean.setStatus(50);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = voidSalesRecord(originBean, voidBean);
            if(status)
                returnBean.done();
            else
                returnBean.fail();
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return;
    }
       
    private void invoiceReturnSales(CounterSalesOrderBean originBean, MvcReturnBean returnBean, HttpServletRequest request) {
        if(originBean.getStatus() != 40) {
            returnBean.addError("The sales trx has not been returned");
            returnBean.fail();
            return;
        }
        try {
            CounterSalesOrderBean voidBean = getSalesOrderSet(originBean.getSalesID(), null);
            
            /*
            voidBean.setAdjstSalesID(voidBean.getSalesID().intValue());
            voidBean.setAdjstRefNo(voidBean.getTrxDocNo());
            voidBean.setTrxDate(new Date());
            voidBean.setTrxTime(new Time((new Date()).getTime()));
            voidBean.setTrxDocType("CN");
            voidBean.setTrxDocName("Sales Return");
            voidBean.setTrxGroup(40);
            voidBean.setStatus(-10);
            voidBean.setPaymentArray(null);
            voidBean.setSalesID(null);
            voidBean.setTrxDocNo(null);
            voidBean.resetMvcInfo();
             */
            // parseSalesRefundForm(voidBean, returnBean, request);
            parseSalesOrderForm(voidBean, returnBean, request);
            
            CounterSalesFormBean formList[] = voidBean.getFormArray();
            for(int i = 0; i < formList.length; i++)
                formList[i].setStatus(-10);
            
            originBean.setStatus(60);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = voidSalesRecord(originBean, voidBean);
            if(status)
                returnBean.done();
            else
                returnBean.fail();
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return;
    }
    
    
    
    private boolean voidSalesRecord(CounterSalesOrderBean originBean, CounterSalesOrderBean voidBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            status = getBroker(conn).voidSalesRecord(originBean.getSalesID(), getLoginUser().getUserId(), originBean.getStatus());
            status = voidSalesDeliveryActiveList(conn, originBean);
            status = insertSalesRecord(conn, voidBean);
            // tambahan balikin voucher, dipindah ke create document
            // status = updateVoidOutletVoucher(originBean.getCustomerIdentityNo());
            if(voidBean.getBonusPeriodID() != null && voidBean.getBonusPeriodID().length() > 0 && voidBean.isCancelBonus()) {
                PurchaseManager mgr = new PurchaseManager(conn);
                PurchaseOrderBean purchaseBean = mgr.getPurchaseOrder(originBean.getTrxDocNo());
                if(purchaseBean != null) {
                    purchaseBean.parseModificationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                    purchaseBean.setStatus(20);
                    purchaseBean.setAdjustRemark(voidBean.getAdjstRemark());
                    purchaseBean.setAdjustBy(getLoginUser().getUserId());
                    purchaseBean.setAdjustDate(voidBean.getTrxDate());
                    purchaseBean.setAdjustTime(voidBean.getTrxTime());
                    mgr.updatePurchase(purchaseBean);
                }
                BvWalletBean bvWallet = createBvWalletBean(originBean, false);
                long l2 = (new BvWalletManager(conn)).insertDistributorBvItem(bvWallet);
            }
            if(originBean.getCustomerTypeStatus().equals("S")) {
                QuotaWalletBean quotaWallet = createBuyerQuotaWalletBean(originBean, false);
                quotaWallet.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                long l = (new QuotaWalletManager(conn)).insertQuotaRecord(quotaWallet);
            }
            if(originBean.getSellerTypeStatus().equals("S")) {
                QuotaWalletBean quotaWallet = createSellerQuotaWalletBean(originBean, true);
                quotaWallet.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                long l1 = (new QuotaWalletManager(conn)).insertQuotaRecord(quotaWallet);
            }
            commitTransaction();
        } catch(Exception e) {
            rollBackTransaction();
            status = false;
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean voidSalesDeliveryActiveList(Connection conn, CounterSalesOrderBean salesBean)
    throws Exception {
        boolean status = false;
        DeliveryOrderBean activeDoList[] = getActiveDeliveryListBySales(salesBean.getSalesID());
        for(int i = 0; i < activeDoList.length; i++) {
            DeliveryOrderBean voidBean = getDeliverySet(activeDoList[i].getDeliveryID(), null);
            parseVoidDeliveryBean(voidBean, salesBean.getAdjstRemark());
            status = insertDeliveryRecord(conn, voidBean);
            status = getBroker(conn).voidDeliveryRecord(activeDoList[i].getDeliveryID(), getLoginUser().getUserId());
            status = stockInSellerInventory(conn, voidBean);
            if(salesBean.getCustomerTypeStatus().equals("S"))
                status = stockOutBuyerInventory(conn, voidBean);
        }
        
        return status;
    }
    
    private boolean insertSalesRecord(Connection conn, CounterSalesOrderBean sales)
    throws Exception {
        boolean status = false;
        sales.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
        
        System.out.println("mulai insertSalesRecord ");
        
        status = getBroker(conn).insertSalesRecord(sales);
        
        System.out.println("selesai insertSalesRecord ");
        
        if(sales.getItemArray().length > 0)
            status = getBroker(conn).insertSalesItem(sales.getItemArray(), sales.getSalesID());
        if(sales.getFormArray().length > 0)
            status = getBroker(conn).insertSalesForm(sales.getFormArray(), sales.getSalesID());
        if(sales.getPaymentArray().length > 0)
            // mulai insert 05
            status = getBroker(conn).insertSalesPayment(sales.getPaymentArray(), sales.getSalesID());        
        status = generateSalesTrxDocNo(sales);
        return status;
    }
    
    //Updated By Mila 2016-06-04 SIR
    private boolean insertSalesRecordSIR(Connection conn, CounterSalesOrderBean sales)
    throws Exception {
        boolean status = false;
        boolean flagGrater = false;
        sales.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
        
        System.out.println("mulai insertSalesRecord SIR");
        
        status = getBroker(conn).insertSalesRecord(sales);
        
        System.out.println("selesai insertSalesRecord SIR");
        
        if(sales.getItemArray().length > 0)
            status = getBroker(conn).insertSalesItem(sales.getItemArray(), sales.getSalesID());
        if(sales.getFormArray().length > 0)
            status = getBroker(conn).insertSalesForm(sales.getFormArray(), sales.getSalesID());
        if(sales.getPaymentArray().length > 0)
            // mulai insert 05
           if(sales.getPaymentTender() >= sales.getDeliveryAmount()){
                flagGrater = true;
           }
           status = getBroker(conn).insertSalesPaymentSIR(sales.getPaymentArray(), sales.getSalesID(), sales.getNetSalesAmount(), flagGrater);        
        status = generateSalesTrxDocNo(sales);
        return status;
    }

    private boolean insertSalesRecordForceReturn(Connection conn, CounterSalesOrderBean sales)
    throws Exception {
        boolean status = false;
        sales.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
        status = getBroker(conn).insertSalesRecordForceReturn(sales);
        if(sales.getItemArray().length > 0)
            status = getBroker(conn).insertSalesItem(sales.getItemArray(), sales.getSalesID());
        if(sales.getFormArray().length > 0)
            status = getBroker(conn).insertSalesForm(sales.getFormArray(), sales.getSalesID());
        
        status = generateSalesTrxDocNo(sales);
        return status;
    }
    
    private boolean insertSalesRecordReturn(Connection conn, CounterSalesOrderBean sales)
    throws Exception {
        boolean status = false;
        
        sales.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
        status = getBroker(conn).insertSalesRecord(sales);
        if(sales.getItemArray().length > 0)
            // mulai insert 04
            status = getBroker(conn).insertSalesItem(sales.getItemArray(), sales.getSalesID());
        if(sales.getFormArray().length > 0)
            status = getBroker(conn).insertSalesForm(sales.getFormArray(), sales.getSalesID());
        if(sales.getPaymentArray().length > 0)
            // mulai insert 05
            status = getBroker(conn).insertSalesPayment(sales.getPaymentArray(), sales.getSalesID());
        status = generateSalesTrxDocNo(sales);
        status = updateSalesTrxGroup(sales, sales.getAdjstRefNo());
        return status;
    }
    
    private boolean addMember(MemberBean member)
    throws MvcException {
        boolean status;
        Connection conn;
        if(member == null)
            throw new IllegalArgumentException("No member specified");
        status = false;
        conn = null;
        try {
            System.out.println("Masuk Insert Custumer 2");
            
            conn = getConnection();
            member.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
            status = getBroker(conn).quickRegisterMember(member);
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean updateSalesTrxGroup(CounterSalesOrderBean sales, String trxDocNo)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            // String trxDocNo = (String)DocumentFactory.getDocumentMgr(sales.getTrxDocCode(), sales.getTrxDocType(), "Sequence Basis").getDocumentNo();
            // String trxDocNo = sales.setTrxDocNo(trxDocNo);
            status = getBroker(conn).updateSalesTrxGroup(trxDocNo);
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    
    private boolean generateSalesTrxDocNoAwal(CounterSalesOrderBean sales)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            String trxDocNo = (String)DocumentFactory.getDocumentMgr(sales.getTrxDocCode(), sales.getTrxDocType(), "Sequence Basis").getDocumentNo1(); //Updated By Ferdi 2015-01-20
            sales.setTrxDocNo(trxDocNo);
            status = getBroker(conn).updateSalesTrxDocNo(trxDocNo, sales.getSalesID());
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean generateSalesTrxDocNo(CounterSalesOrderBean sales)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            // String trxDocNo = (String)DocumentFactory.getDocumentMgr(sales.getTrxDocCode(), sales.getTrxDocType(), "Sequence Basis").getDocumentNo();
            String butik = "";
            int panjang = 0;
            String kode = Integer.toString(sales.getSellerSeq());
            panjang = kode.length();
            
            if(panjang==1) {
                butik = "0".concat(kode);
            }else{
                butik = kode;
            }
            String trxDocNo = (String)DocumentFactory.getDocumentMgr(butik, sales.getTrxDocType(), "Sequence Basis").getDocumentNo1(); //Updated By Ferdi 2015-01-20
            sales.setTrxDocNo(trxDocNo);
            status = getBroker(conn).updateSalesTrxDocNo(trxDocNo, sales.getSalesID());
            
            System.out.println("selesai updateSalesTrxDocNo ");
            
            // for update voucher
            String cek = "";
            cek = (sales.getShipFromStoreCode() == null ? "" : sales.getShipFromStoreCode()) ;

            if(cek.length() > 0) {
                int pan = cek.length();
                String keterangan = cek.substring(0,1);
                System.out.println("Masuk sini, cek Keterangan : " + keterangan);                
                String voucher1 = cek.substring(2,pan);
                // String keterangan = "I";
                updateVoucherSerial(sales, voucher1, keterangan);
                System.out.println("cek Gab voucher3 " + voucher1);
            }
           
            
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean updateSalesDeliveryStatus(Connection conn, CounterSalesOrderBean sales)
    throws MvcException {
        boolean status = false;
        try {
            sales.parseModificationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
            status = getBroker(conn).updateSalesDeliveryStatus(sales);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        return status;
    }
    
    private MvcReturnBean searchDeliverySelection(HttpServletRequest request)
    throws MvcException {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            if(formSubmitted) {
                Date trxDtFrom = null;
                Date trxDtTo = null;
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " where dod_status <> -10 ";
                String deliverystatus = request.getParameter("Status");
                if(deliverystatus.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and dod_status = ").append(deliverystatus).append(" ").toString();
                String orderby = request.getParameter("OrderBy");
                if(orderby != null && orderby.length() > 0)
                    cond.setOrderby((new StringBuilder(" order by ")).append(orderby).append(" asc").toString());
                String limits = request.getParameter("Limits");
                if(limits != null && limits.length() > 0)
                    cond.setLimitConditions((new StringBuilder(" limit 0, ")).append(limits).toString());
                String trxDtFromStr = request.getParameter("TrxDateFrom");
                String trxDtToStr = request.getParameter("TrxDateTo");
                try {
                    trxDtFrom = Sys.parseDate(trxDtFromStr);
                } catch(Exception exception) { }
                try {
                    trxDtTo = Sys.parseDate(trxDtToStr);
                } catch(Exception exception1) { }
                if(trxDtFrom != null) {
                    java.sql.Date sqlDtFrom = new java.sql.Date(trxDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and dod_trxdate >= '").append(sqlDtFrom).append("'").toString();
                }
                if(trxDtTo != null) {
                    java.sql.Date sqlDtTo = new java.sql.Date(trxDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and dod_trxdate <= '").append(sqlDtTo).append("'").toString();
                }
                String shipByOutletID = request.getParameter("ShipByOutletID");
                if(shipByOutletID == null)
                    shipByOutletID = getLoginUser().getOutletID();
                if(shipByOutletID != null && shipByOutletID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and dod_ship_by_outletid = '").append(shipByOutletID.trim()).append("' ").toString();
                String trxDocNo = request.getParameter("TrxDocNo");
                if(trxDocNo != null && trxDocNo.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and dod_trxdocno LIKE '%").append(trxDocNo.trim()).append("%' ").toString();
                String salesTrxDocNo = request.getParameter("SalesTrxDocNo");
                if(salesTrxDocNo != null && salesTrxDocNo.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and dod_salesrefno LIKE '%").append(salesTrxDocNo.trim()).append("%' ").toString();
                String custID = request.getParameter("CustomerID");
                if(custID != null && custID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and dod_custid LIKE '%").append(custID.trim()).append("%' ").toString();
                String custName = request.getParameter("CustomerName");
                if(custName != null && custName.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and dod_cust_name LIKE '%").append(custName.trim()).append("%' ").toString();
                String doStatus = request.getParameter("DeliveryStatus");
                if(doStatus != null && doStatus.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and dod_status = ").append(doStatus).toString();
                cond.setConditions(conditions);
                returnBean.addReturnObject("DeliveryList", getDeliveryList(cond));
            }
            returnBean.addReturnObject("DeliveryStatusList", getMapForDeliveryStatus());
            returnBean.addReturnObject("OrderBy", getMapForDeliveryOrderBy());
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    private DeliveryOrderBean[] getDeliveryList(SQLConditionsBean conditions)
    throws MvcException {
        DeliveryOrderBean beans[];
        Connection conn;
        beans = EMPTY_DELIVERY_ORDER_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getDeliveryList(conditions);
            if(!list.isEmpty())
                beans = (DeliveryOrderBean[])list.toArray(beans);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    public DeliveryOrderBean[] getActiveDeliveryListBySales(Long salesID)
    throws MvcException {
        DeliveryOrderBean beans[];
        Connection conn;
        beans = EMPTY_DELIVERY_ORDER_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            SQLConditionsBean condBean = new SQLConditionsBean();
            condBean.setOrderby(" order by dod_deliveryid asc");
            String conditions = (new StringBuilder(" where dod_status = 30 and dod_salesid = ")).append(salesID).toString();
            condBean.setConditions(conditions);
            ArrayList list = getBroker(conn).getDeliveryList(condBean);
            beans = (DeliveryOrderBean[])list.toArray(beans);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }
    
    public DeliveryOrderBean[] getDeliveryHistoryBySales(Long salesID)
    throws MvcException {
        DeliveryOrderBean beans[];
        Connection conn;
        beans = EMPTY_DELIVERY_ORDER_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            SQLConditionsBean condBean = new SQLConditionsBean();
            condBean.setOrderby(" order by dod_deliveryid asc");
            String conditions = (new StringBuilder(" where dod_status <> -10 and dod_salesid = ")).append(salesID).toString();
            condBean.setConditions(conditions);
            ArrayList list = getBroker(conn).getDeliveryList(condBean);
            beans = (DeliveryOrderBean[])list.toArray(beans);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    public DeliveryOrderBean getDeliveryByAdjstDeliveryID(Long adjDeliveryID)
    throws MvcException {
        DeliveryOrderBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getDeliveryByAdjstDeliveryID(adjDeliveryID);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public DeliveryOrderBean getDeliveryByDocNo(String trxDocNo, String locale)
    throws MvcException {
        DeliveryOrderBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getDeliveryByDocNo(trxDocNo);
            parseDeliveryChildsFromDB(bean, locale);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    public DeliveryOrderBean getDeliverySet(Long deliveryID, String locale)
    throws MvcException {
        DeliveryOrderBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getDelivery(deliveryID);
            parseDeliveryChildsFromDB(bean, locale);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    private void parseDeliveryChildsFromDB(DeliveryOrderBean bean, String locale)
    throws Exception {
        boolean parseLocale;
        ProductManager mgr;
        Connection conn;
        parseLocale = false;
        mgr = null;
        conn = null;
        try {
            conn = getConnection();
            if(bean != null) {
                if(locale != null && locale.length() > 0) {
                    mgr = new ProductManager(conn);
                    parseLocale = true;
                }
                ArrayList itemList = getBroker(conn).getDeliveryItemList(bean.getDeliveryID());
                if(!itemList.isEmpty()) {
                    for(int i = 0; i < itemList.size(); i++) {
                        DeliveryItemBean itemBean = (DeliveryItemBean)itemList.get(i);
                        itemBean.setMaster(bean);
                        bean.addItem(itemBean);
                        if(parseLocale) {
                            ProductBean product = mgr.getProduct(itemBean.getProductID(), locale);
                            itemBean.setProductBean(product);
                        }
                        ArrayList productList = getBroker(conn).getDeliveryProductList(itemBean.getSeq());
                        if(!productList.isEmpty()) {
                            for(int j = 0; j < productList.size(); j++) {
                                DeliveryProductBean pBean = (DeliveryProductBean)productList.get(j);
                                pBean.setMaster(itemBean);
                                itemBean.addProduct(pBean);
                                if(parseLocale) {
                                    ProductBean component = mgr.getProduct(pBean.getProductID(), getLoginUser().getLocale().toString());
                                    pBean.setProductBean(component);
                                }
                            }
                            
                        }
                    }
                    
                }
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return;
    }
    
    private void issueDeliveryOrder(CounterSalesOrderBean salesBean, MvcReturnBean returnBean, HttpServletRequest request, boolean checkInventory, boolean combineSales, boolean copySalesShipping) {
        try {
            DeliveryOrderBean doBean = createDeliveryOrderBean(salesBean, combineSales, copySalesShipping);
            if(!copySalesShipping) {
                parseDeliveryBean(doBean, returnBean, request);
                checkDeliveryShippingInfo(doBean, returnBean);
            }
            parseDeliveryOrderForm(salesBean, doBean, returnBean, request, checkInventory);
            parseSalesDeliveryStatus(salesBean, doBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = insertDelivery(salesBean, doBean);
            if(status) {
                returnBean.addReturnObject("SalesID", salesBean.getSalesID().toString());
                returnBean.addReturnObject("DeliveryID", doBean.getDeliveryID().toString());
                returnBean.done();
            } else {
                returnBean.fail();
            }
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
    }
    
    private boolean insertDelivery(CounterSalesOrderBean salesBean, DeliveryOrderBean doBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            // status = insertDeliveryRecord(conn, doBean);
            status = insertDeliveryRecordUpdate(conn, doBean, salesBean);
            status = stockOutSellerInventory(conn, doBean);
            if(salesBean.getCustomerTypeStatus().equals("S"))
                status = stockInBuyerInventory(conn, doBean);
            status = updateSalesDeliveryStatus(conn, salesBean);
            commitTransaction();
        } catch(Exception e) {
            rollBackTransaction();
            status = false;
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return status;
    }
    
    private void voidDelivery(CounterSalesOrderBean salesBean, DeliveryOrderBean originBean, MvcReturnBean returnBean, HttpServletRequest request) {
        if(salesBean.getStatus() != 30) {
            returnBean.addError("The sales trx has been voided");
            returnBean.fail();
            return;
        }
        if(originBean.getStatus() != 30) {
            returnBean.addError("The delivery trx has been voided");
            returnBean.fail();
            return;
        }
        try {
            DeliveryOrderBean voidBean = getDeliverySet(originBean.getDeliveryID(), null);
            
            parseVoidDeliveryForm(voidBean, returnBean, request);
            
            parseSalesDeliveryStatus(salesBean, voidBean);
            boolean status = !returnBean.hasErrorMessages();
            if(status)
                status = voidDeliveryRecord(salesBean, originBean, voidBean);
            if(status)
                returnBean.done();
            else
                returnBean.fail();
        } catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return;
    }
    
    private boolean voidDeliveryRecord(CounterSalesOrderBean salesBean, DeliveryOrderBean originBean, DeliveryOrderBean voidBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection(false);
            status = getBroker(conn).voidDeliveryRecord(originBean.getDeliveryID(), getLoginUser().getUserId());
            status = insertDeliveryRecord(conn, voidBean);
            status = stockInSellerInventory(conn, voidBean);
            if(salesBean.getCustomerTypeStatus().equals("S"))
                status = stockOutBuyerInventory(conn, voidBean);
            status = updateSalesDeliveryStatus(conn, salesBean);
            commitTransaction();
        } catch(Exception e) {
            rollBackTransaction();
            status = false;
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean insertDeliveryRecord(Connection conn, DeliveryOrderBean doBean)
    throws Exception {
        boolean status = false;
        doBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
        status = getBroker(conn).insertDeliveryRecord(doBean);
        if(doBean.getItemArray().length > 0)
            status = getBroker(conn).insertDeliveryItem(doBean.getItemArray(), doBean.getDeliveryID());
        status = generateDeliveryTrxDocNo(doBean);
        return status;
    }
    
    private boolean insertDeliveryRecordUpdate(Connection conn, DeliveryOrderBean doBean, CounterSalesOrderBean salesBean)
    throws Exception {
        boolean status = false;
        doBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
        status = getBroker(conn).insertDeliveryRecord(doBean);
        if(doBean.getItemArray().length > 0)
            status = getBroker(conn).insertDeliveryItem(doBean.getItemArray(), doBean.getDeliveryID());
        status = generateDeliveryTrxDocNoUpdate(salesBean, doBean);
        return status;
    }
    
    private boolean updateDeliveryCombineSales(CounterSalesOrderBean salesBean, DeliveryOrderBean doBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).updateDeliveryCombineSales(salesBean, doBean.getDeliveryID());
        } catch(Exception e) {
            status = false;
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean generateDeliveryTrxDocNo(DeliveryOrderBean doBean)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            if(doBean.isGenerateTrxDocNo()) {
                String trxDocNo = (String)DocumentFactory.getDocumentMgr(doBean.getTrxDocCode(), doBean.getTrxDocType(), "Sequence Basis").getDocumentNo1(); //Updated By Ferdi 2015-01-20
                doBean.setTrxDocNo(trxDocNo);
                status = getBroker(conn).updateDeliveryTrxDocNo(trxDocNo, doBean.getDeliveryID());
            }
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean generateDeliveryTrxDocNoUpdate(CounterSalesOrderBean salesBean, DeliveryOrderBean doBean)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            if(doBean.isGenerateTrxDocNo()) {
                // String trxDocNo = (String)DocumentFactory.getDocumentMgr(doBean.getTrxDocCode(), doBean.getTrxDocType(), "Sequence Basis").getDocumentNo();
                String butik = "";
                int panjang = 0;
                String kode = Integer.toString(salesBean.getSellerSeq());
                panjang = kode.length();
                
                if(panjang==1) {
                    butik = "0".concat(kode);
                }else{
                    butik = kode;
                }
                // String trxDocNo = (String)DocumentFactory.getDocumentMgr(doBean.getTrxDocCode(), doBean.getTrxDocType(), "Sequence Basis").getDocumentNo();
                
                String trxDocNo = (String)DocumentFactory.getDocumentMgr(butik, doBean.getTrxDocType(), "Sequence Basis").getDocumentNo1(); //Updated By Ferdi 2015-01-20
                
                doBean.setTrxDocNo(trxDocNo);
                status = getBroker(conn).updateDeliveryTrxDocNo(trxDocNo, doBean.getDeliveryID());
            }
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    
    public InventoryManager_1 getInventoryManager(Connection conn) {
        if(invMgr == null)
            invMgr = new InventoryManager_1(conn);
        return invMgr;
    }
    
    public void fillUpProductBalanceForSales(String shipByOutletID, String shipByStoreCode, ProductBean list[])
    throws MvcException {
        Connection conn = null;
        try {
            conn = getConnection();
            for(int i = 0; i < list.length; i++) {
                ProductBean bean = list[i];
                if(bean.getType().equalsIgnoreCase("S")) {
                    int balance = getInventoryManager(conn).getProductBalance(bean.getProductID(), shipByOutletID, shipByStoreCode);
                    bean.setQtyOnHand(balance);
                }
            }
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return;
    }
    
    public void fillUpProductBalanceForDelivery(CounterSalesOrderBean salesBean)
    throws MvcException {
        Connection conn;
        if(salesBean == null)
            return;
        conn = null;
        try {
            conn = getConnection();
            CounterSalesItemBean itemSales[] = salesBean.getItemArray();
            for(int i = 0; i < itemSales.length; i++) {
                CounterSalesProductBean productSales[] = itemSales[i].getProductArray();
                for(int j = 0; j < productSales.length; j++) {
                    CounterSalesProductBean component = productSales[j];
                    int balance = getInventoryManager(conn).getProductBalance(component.getProductID(), salesBean.getShipByOutletID(), salesBean.getShipByStoreCode());
                    component.setQtyOnHand(balance);
                }
                
            }
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return;
    }
    
    protected boolean stockOutSellerInventory(Connection conn, DeliveryOrderBean delivery)
    throws Exception {
        boolean status = false;
        Date today = new Date();
        int salesID = delivery.getSalesID();
        int deliveryID = Integer.valueOf(delivery.getDeliveryID().toString()).intValue();
        OutletBean invOwner = (new OutletManager(conn)).getRecord(delivery.getShipByOutletID());
        OutletStoreBean invStore = (new OutletStoreManager(conn)).getOutletStore(delivery.getShipByStoreCode());
        DeliveryItemBean itemDo[] = delivery.getItemArray();
        for(int i = 0; i < itemDo.length; i++) {
            DeliveryProductBean productDo[] = itemDo[i].getProductArray();
            for(int j = 0; j < productDo.length; j++)
                // if(productDo[j].getQty() > 0) {
                // for kit
                if(productDo[j].getQty() > 0 && productDo[j].getQtyKiv() == 0) {
                
                // System.out.println("chek nilai productDo[j].getQtyKiv() : "+productDo[j].getQtyKiv());
                
                boolean isInvCtrl = productDo[j].getInventory().equals("Y");
                if(isInvCtrl) {
                    
                    InventoryBean sellerInv = new InventoryBean();
                    sellerInv.setProductID(productDo[j].getProductID());
                    sellerInv.setProductType(productDo[j].getProductType());
                    sellerInv.setTotalOut(productDo[j].getQty());
                    sellerInv.setTrnxType("SKO");
                    sellerInv.setStatus(100);
                    sellerInv.setSalesID(salesID);
                    sellerInv.setDeliveryID(deliveryID);
                    sellerInv.setOwnerID(invOwner.getOutletID());
                    sellerInv.setOwnerType(invOwner.getType());
                    sellerInv.setStoreCode(invStore.getStoreID());
                    sellerInv.setTrnxDocNo(delivery.getTrxDocNo());
                    sellerInv.setTrnxDocType(delivery.getTrxDocType());
                    sellerInv.setTrnxDate(today);
                    sellerInv.setTrnxTime(today);
                    sellerInv.setRemark((new StringBuilder("Sales Ref: ")).append(delivery.getSalesRefNo()).append(", Delivery Ref: ").append(delivery.getTrxDocNo()).toString());
                    sellerInv.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                    status = getInventoryManager(conn).addRecord(sellerInv);                    
                    
                }
                }
            
        }
        
        if(invMgr != null)
            invMgr = null;
        return status;
    }    
    protected boolean stockOutSellerInventoryReturn(Connection conn, DeliveryOrderBean delivery, CounterSalesOrderBean sales)
    throws Exception {
        boolean status = false;
        Date today = new Date();
        int salesID = delivery.getSalesID();
        int deliveryID = Integer.valueOf(delivery.getDeliveryID().toString()).intValue();
        OutletBean invOwner = (new OutletManager(conn)).getRecord(delivery.getShipByOutletID());
        OutletStoreBean invStore = (new OutletStoreManager(conn)).getOutletStore(delivery.getShipByStoreCode());
        DeliveryItemBean itemDo[] = delivery.getItemArray();
        for(int i = 0; i < itemDo.length; i++) {
            DeliveryProductBean productDo[] = itemDo[i].getProductArray();
            for(int j = 0; j < productDo.length; j++)
                // if(productDo[j].getQty() > 0) {
                // for kit
                if(productDo[j].getQty() > 0 && productDo[j].getQtyKiv() == 0) {
                
                // System.out.println("chek nilai productDo[j].getQtyKiv() : "+productDo[j].getQtyKiv());
                
                boolean isInvCtrl = productDo[j].getInventory().equals("Y");
                if(isInvCtrl) {
                    
                    InventoryBean sellerInv = new InventoryBean();
                    sellerInv.setProductID(productDo[j].getProductID());
                    sellerInv.setProductType(productDo[j].getProductType());
                    sellerInv.setTotalOut(productDo[j].getQty());
                    sellerInv.setTrnxType("SKO");
                    sellerInv.setStatus(100);
                    sellerInv.setSalesID(salesID);
                    sellerInv.setDeliveryID(deliveryID);
                    sellerInv.setOwnerID(invOwner.getOutletID());
                    sellerInv.setOwnerType(invOwner.getType());
                    sellerInv.setStoreCode(invStore.getStoreID());
                    sellerInv.setTrnxDocNo(delivery.getTrxDocNo());
                    sellerInv.setTrnxDocType(delivery.getTrxDocType());
                    sellerInv.setTrnxDate(today);
                    sellerInv.setTrnxTime(today);
                    sellerInv.setRemark((new StringBuilder("Sales Ref: ")).append(delivery.getSalesRefNo()).append(", Delivery Ref: ").append(delivery.getTrxDocNo()).toString());
                    sellerInv.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                    status = getInventoryManager(conn).addRecord(sellerInv);                    
                    
                }
                }
            
        }
        
        if(invMgr != null)
            invMgr = null;
        return status;
    }
    
    protected boolean stockInSellerInventory(Connection conn, DeliveryOrderBean delivery)
    throws Exception {
        boolean status = false;
        Date today = new Date();
        int salesID = delivery.getSalesID();
        int deliveryID = Integer.valueOf(delivery.getDeliveryID().toString()).intValue();
        
        System.out.println(" chek delivery.getShipByOutletID() " + delivery.getShipByOutletID());
        
        OutletBean invOwner = (new OutletManager()).getRecord(delivery.getShipByOutletID());
        
        System.out.println(" chek delivery.getShipByOutletID() " + delivery.getShipByOutletID());
        
        OutletStoreBean invStore = (new OutletStoreManager()).getOutletStore(delivery.getShipByStoreCode());
        
        DeliveryItemBean itemDo[] = delivery.getItemArray();
        
        System.out.println(" chek sini 1 ");
        
        for(int i = 0; i < itemDo.length; i++) {
            
            System.out.println(" chek sini 2 ");
            
            DeliveryProductBean productDo[] = itemDo[i].getProductArray();
            for(int j = 0; j < productDo.length; j++)
                if(productDo[j].getQty() > 0) {
                boolean isInvCtrl = productDo[j].getInventory().equals("Y");
                
                System.out.println(" chek sini 3 ");
                
                if(isInvCtrl) {
                    InventoryBean sellerInv = new InventoryBean();
                    sellerInv.setProductID(productDo[j].getProductID());
                    sellerInv.setProductType(productDo[j].getProductType());
                    sellerInv.setTotalIn(productDo[j].getQty());
                    sellerInv.setTrnxType("SKI");
                    sellerInv.setStatus(100);
                    sellerInv.setSalesID(salesID);
                    sellerInv.setDeliveryID(deliveryID);
                    
                    System.out.println(" chek invOwner.getOutletID() " + invOwner.getOutletID());
                    
                    sellerInv.setOwnerID(invOwner.getOutletID());
                    
                    sellerInv.setOwnerType(invOwner.getType());
                    
                    sellerInv.setStoreCode(invStore.getStoreID());
                    
                    sellerInv.setTrnxDocNo(delivery.getTrxDocNo());
                    sellerInv.setTrnxDocType(delivery.getTrxDocType());
                    sellerInv.setTrnxDate(today);
                    sellerInv.setTrnxTime(today);
                    sellerInv.setRemark((new StringBuilder("Sales Ref: ")).append(delivery.getSalesRefNo()).append(", Delivery Ref: ").append(delivery.getTrxDocNo()).toString());
                    sellerInv.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                    status = getInventoryManager(conn).addRecord(sellerInv);
                }
                }
            
        }
        
        if(invMgr != null)
            invMgr = null;
        return status;
    }       
    
    protected boolean stockInSellerInventoryForceReturn(Connection conn, DeliveryOrderBean delivery, CounterSalesOrderBean sales)
    throws Exception {
        boolean status = false;
        Date today = new Date();
        int salesID = delivery.getSalesID();
        int deliveryID = Integer.valueOf(delivery.getDeliveryID().toString()).intValue();
              
        System.out.println(" chek delivery.getShipByOutletID() " + delivery.getShipByOutletID());
        
        OutletBean invOwner = (new OutletManager()).getRecord(delivery.getShipByOutletID());
        
        System.out.println(" chek delivery.getShipByOutletID() " + delivery.getShipByOutletID());
        
        OutletStoreBean invStore = (new OutletStoreManager()).getOutletStore(delivery.getShipByStoreCode());
        
        DeliveryItemBean itemDo[] = delivery.getItemArray();
        
        System.out.println(" chek sini 1 ");
        
        for(int i = 0; i < itemDo.length; i++) {
            
            System.out.println(" chek sini 2 ");
            
            DeliveryProductBean productDo[] = itemDo[i].getProductArray();
            for(int j = 0; j < productDo.length; j++)
                if(productDo[j].getQty() > 0) {
                boolean isInvCtrl = productDo[j].getInventory().equals("Y");
                
                System.out.println(" chek sini 3 ");
                
                if(isInvCtrl) {
                    InventoryBean sellerInv = new InventoryBean();
                    sellerInv.setProductID(productDo[j].getProductID());
                    sellerInv.setProductType(productDo[j].getProductType());
                    sellerInv.setTotalIn(productDo[j].getQty());
                    sellerInv.setTrnxType("SKI");
                    sellerInv.setStatus(100);
                    sellerInv.setSalesID(salesID);
                    sellerInv.setDeliveryID(deliveryID);
                    
                    System.out.println(" chek invOwner.getOutletID() " + invOwner.getOutletID());
                    
                    sellerInv.setOwnerID(invOwner.getOutletID());
                    
                    sellerInv.setOwnerType(invOwner.getType());
                    
                    sellerInv.setStoreCode(invStore.getStoreID());
                    sellerInv.setTrnxDocNo("RFORCE".concat(sales.getSalesID().toString()));
                    // sellerInv.setTrnxDocNo(delivery.getTrxDocNo());
                    sellerInv.setTrnxDocType("GRN");
                    sellerInv.setTrnxDate(today);
                    sellerInv.setTrnxTime(today);
                    sellerInv.setRemark((new StringBuilder("Sales Ref: ")).append(delivery.getSalesRefNo()).append(", Delivery Ref: ").append(delivery.getTrxDocNo()).toString());
                    sellerInv.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                    status = getInventoryManager(conn).addRecord(sellerInv);
                }
                }
            
        }
        
        if(invMgr != null)
            invMgr = null;
        return status;
    }
    
    protected boolean stockInBuyerInventory(Connection conn, DeliveryOrderBean delivery)
    throws Exception {
        boolean status = false;
        Date today = new Date();
        int salesID = delivery.getSalesID();
        int deliveryID = Integer.valueOf(delivery.getDeliveryID().toString()).intValue();
        OutletBean invOwner = (new OutletManager()).getRecord(delivery.getCustomerID());
        OutletStoreBean invStore = (new OutletStoreManager()).getOutletStore(delivery.getCustomerID());
        DeliveryItemBean itemDo[] = delivery.getItemArray();
        for(int i = 0; i < itemDo.length; i++) {
            DeliveryProductBean productDo[] = itemDo[i].getProductArray();
            for(int j = 0; j < productDo.length; j++)
                if(productDo[j].getQty() > 0) {
                InventoryBean invBean = new InventoryBean();
                invBean.setProductID(productDo[j].getProductID());
                invBean.setProductType(productDo[j].getProductType());
                invBean.setTotalIn(productDo[j].getQty());
                invBean.setTrnxType("SKI");
                invBean.setStatus(100);
                invBean.setSalesID(salesID);
                invBean.setDeliveryID(deliveryID);
                invBean.setOwnerID(invOwner.getOutletID());
                invBean.setOwnerType(invOwner.getType());
                invBean.setStoreCode(invStore.getStoreID());
                invBean.setTrnxDocNo(delivery.getTrxDocNo());
                invBean.setTrnxDocType(delivery.getTrxDocType());
                invBean.setTrnxDate(today);
                invBean.setTrnxTime(today);
                invBean.setRemark((new StringBuilder("Sales Ref: ")).append(delivery.getSalesRefNo()).append(", Delivery Ref: ").append(delivery.getTrxDocNo()).toString());
                invBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                status = getInventoryManager(conn).addRecord(invBean);
                }
            
        }
        
        if(invMgr != null)
            invMgr = null;
        return status;
    }
    
    protected boolean stockOutBuyerInventory(Connection conn, DeliveryOrderBean delivery)
    throws Exception {
        boolean status = false;
        Date today = new Date();
        int salesID = delivery.getSalesID();
        int deliveryID = Integer.valueOf(delivery.getDeliveryID().toString()).intValue();
        OutletBean invOwner = (new OutletManager(conn)).getRecord(delivery.getCustomerID());
        OutletStoreBean invStore = (new OutletStoreManager(conn)).getOutletStore(delivery.getCustomerID());
        DeliveryItemBean itemDo[] = delivery.getItemArray();
        for(int i = 0; i < itemDo.length; i++) {
            DeliveryProductBean productDo[] = itemDo[i].getProductArray();
            for(int j = 0; j < productDo.length; j++)
                if(productDo[j].getQty() > 0) {
                InventoryBean invBean = new InventoryBean();
                invBean.setProductID(productDo[j].getProductID());
                invBean.setProductType(productDo[j].getProductType());
                invBean.setTotalOut(productDo[j].getQty());
                invBean.setTrnxType("SKO");
                invBean.setStatus(100);
                invBean.setSalesID(salesID);
                invBean.setDeliveryID(deliveryID);
                invBean.setOwnerID(invOwner.getOutletID());
                invBean.setOwnerType(invOwner.getType());
                invBean.setStoreCode(invStore.getStoreID());
                invBean.setTrnxDocNo(delivery.getTrxDocNo());
                invBean.setTrnxDocType(delivery.getTrxDocType());
                invBean.setTrnxDate(today);
                invBean.setTrnxTime(today);
                invBean.setRemark((new StringBuilder("Sales Ref: ")).append(delivery.getSalesRefNo()).append(", Delivery Ref: ").append(delivery.getTrxDocNo()).toString());
                invBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                status = getInventoryManager(conn).addRecord(invBean);
                }
            
        }
        
        if(invMgr != null)
            invMgr = null;
        return status;
    }
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginUser) {
        setLoginUser(loginUser);
        MvcReturnBean returnBean = null;
        boolean formSubmitted = request.getParameter("SubmitData") != null;
        try {
            switch(taskId) {
                default:
                    break;
                    
                case 101001:
                case 101021:
                case 205001:
                case 205006:
                {
                    returnBean = new MvcReturnBean();
                    boolean next = false;
                    int nextTaskID = 0;
                    switch(taskId) {
                        case 101001:
                            nextTaskID = 0x18a8a;
                            break;
                            
                        case 101021:
                            nextTaskID = 0x18a9e;
                            break;
                            
                        case 205001:
                            nextTaskID = 0x320ca;
                            break;
                            
                        case 205006:
                            nextTaskID = 0x320cf;
                            break;
                            
                    }
                    
                    if(formSubmitted) {
                        request.getSession().removeAttribute("C@8Jb#p985468");
                        if(checkNewMemberSalesInput(returnBean, request)) {
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath(Sys.getControllerURL(nextTaskID, request));
                            next = true;
                        } else {
                            returnBean.fail();
                        }
                    }
                    
                    if(!next)
                        preparePreSalesPage(returnBean, request, taskId);
                    break;
                }
                
                case 101003:
                case 101005:
                case 101023:
                /*
                case 101036:
                case 101038:
                 */
                    //he
                case 101054:
                case 101056:
                case 101058:
                    
                case 101025:
                {
                    returnBean = new MvcReturnBean();
                    boolean next = false;
                    int nextTaskID = 0;
                    switch(taskId) {
                        case 101003:
                            nextTaskID = 0x18a8c;
                            break;
                            
                        case 101023:
                            nextTaskID = 0x18aa0;
                            break;
                            
                       /*
                        case 101036:
                            nextTaskID = 0x18aad;
                            break;
                        
                        case 101038:
                            nextTaskID = 0x18aaf;
                            break;
                        */
                            //he
                        case 101054:
                            nextTaskID = 0x18abf;
                            break;
                            
                        case 101056:
                            nextTaskID = 0x18ac1;
                            break;

                        case 101058:
                            nextTaskID = 0x18ac3;
                            break;
                            
                        case 101005:
                            nextTaskID = 0x18a8e;
                            break;
                            
                        case 101025:
                            nextTaskID = 0x18aa2;
                            break;
                    }
                    
                    if(formSubmitted) {
                        request.getSession().removeAttribute("C@8Jb#p985468");
                        if(checkNewNormalSalesInput(returnBean, request)) {
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath(Sys.getControllerURL(nextTaskID, request));
                            next = true;
                        } else {
                            returnBean.fail();
                        }
                    }
                    if(!next)
                        preparePreSalesPage(returnBean, request, taskId);
                    break;
                }
                
                case 101036:
                case 101038:
                {
                    returnBean = new MvcReturnBean();
                    boolean next = false;
                    int nextTaskID = 0;
                    switch(taskId) {
                        
                        case 101036:
                            nextTaskID = 0x18aad;
                            break;
                            
                        case 101038:
                            nextTaskID = 0x18aaf;
                            break;
                    }
                    
                    if(formSubmitted) {
                        request.getSession().removeAttribute("C@8Jb#p985468");
                        if(checkNewMemberSalesInput(returnBean, request)) {
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath(Sys.getControllerURL(nextTaskID, request));
                            next = true;
                        } else {
                            returnBean.fail();
                        }
                    }
                    if(!next)
                        preparePreSalesPage(returnBean, request, taskId);
                    break;
                }
                
                
                case 101002:
                case 101004:
                case 101006:
                case 101022:
                    
                case 101037:
                case 101039:
                    
                case 101024:
                    // he
                case 101055:
                case 101057:
               
                case 101059:
                     
                case 101026:
                case 205002:
                case 205007:
                {
                    boolean next = false;
                    // int nextTaskID = taskId != 0x320ca ? 0x18a8f : 0x320cb;
                    // Maksudnya  apakah taskId <> 0x320ca, jika Ya maka nextTaskID = 0x18a8f (ELSE)  nextTaskID = 0x320cb
                    
                    int nextTaskID = 0;
                    if (taskId == 205007 | taskId == 205002) {
                        nextTaskID = 0x320cb;
                    } else {
                        nextTaskID = 0x18a8f;
                    }
                    
                    if(formSubmitted) {
                        switch(taskId) {
                            case 101002:
                            case 205002:
                                returnBean = addNewMemberSales(request);
                                break;
                                
                            case 205007:
                                returnBean = addNewMemberSalesFullDeliveryStock(request);
                                break;
                                
                            case 101004:
                                returnBean = addNewNormalSales(request);
                                break;
                                
                            case 101006:
                                returnBean = addNewStaffSales(request);
                                break;
                                
                            case 101022:
                                returnBean = addNewMemberSalesFullDelivery(request);
                                break;
                                
                                // mulai insert 01
                                
                            case 101037:
                                // case 101039:
                                
                            case 101024:
                                returnBean = addNewNormalSalesFullDelivery(request);
                                break;
                                
                                // he
                                
                            case 101039:
                                returnBean = addNewNormalSalesFullDeliveryHESIR(request);
                                break;
                            case 101055:
                                returnBean = addNewNormalSalesFullDeliveryHE(request);
                                break;
                                
                            case 101057:
                                returnBean = addNewNormalSalesFullDeliveryHEForce(request);
                                break;

                            case 101059:
                                returnBean = addNewNormalSalesFullDeliveryHEForceReturn(request);
                                break;
                                
                            case 101026:
                                returnBean = addNewStaffSalesFullDelivery(request);
                                break;
                        }
                        
                        if(returnBean.getTaskStatus() == 1) {
                            String newSalesID = (String)returnBean.getReturnObject("SalesID");
                            request.getSession().removeAttribute("C@8Jb#p985468");
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(nextTaskID, request)))).append("&SalesID=").append(newSalesID).toString());
                            next = true;
                        }
                    }
                    
                    if(returnBean == null)
                        returnBean = new MvcReturnBean();
                    if(!next)
                        prepareSalesOrderPage(returnBean, request, taskId);
                    break;
                }
                
                case 101019:
                {
                    returnBean = new MvcReturnBean();
                    boolean next = false;
                    if(formSubmitted) {
                        request.getSession().removeAttribute("C@8Jb#p985468");
                        if(checkNewStockistSalesInput(returnBean, request)) {
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath(Sys.getControllerURL(0x18a9c, request));
                            next = true;
                        } else {
                            returnBean.fail();
                        }
                    }
                    if(!next)
                        preparePreSalesPage(returnBean, request, taskId);
                    break;
                }
                
                case 205026:
                {
                    returnBean = new MvcReturnBean();
                    boolean next = false;
                    if(formSubmitted) {
                        request.getSession().removeAttribute("C@8Jb#p985468");
                        if(checkNewMobileSalesInput(returnBean, request)) {
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath(Sys.getControllerURL(0x320e3, request));
                            next = true;
                        } else {
                            returnBean.fail();
                        }
                    }
                    if(!next)
                        preparePreSalesPage(returnBean, request, taskId);
                    break;
                }
                
                case 101020:
                case 205027:
                {
                    boolean next = false;
                    int nextTaskID = 0;
                    switch(taskId) {
                        case 101020:
                            nextTaskID = 0x18ac5;
                            break;
                            
                        case 205027:
                            nextTaskID = 0x320e4;
                            break;
                    }
                    
                    if(formSubmitted) {
                        returnBean = addNewStockistSales(request);
                        if(returnBean.getTaskStatus() == 1) {
                            String newSalesID = (String)returnBean.getReturnObject("SalesID");
                            request.getSession().removeAttribute("C@8Jb#p985468");
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(nextTaskID, request)))).append("&SalesID=").append(newSalesID).toString());
                            next = true;
                        }
                    }
                    if(returnBean == null)
                        returnBean = new MvcReturnBean();
                    if(!next)
                        prepareSalesOrderPage(returnBean, request, taskId);
                    break;
                }
                
                // mobile : 0x320e4
                
                case 101007:
                case 101029:
                case 101030:
                case 205003:
                case 205029:
                case 300032:
                {
                    returnBean = new MvcReturnBean();
                    CounterSalesOrderBean bean = null;
                    
                    OutletBean outlet = null;
                    
                    String salesID = request.getParameter("SalesID");
                    if(salesID != null && salesID.trim().length() > 0)
                        bean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                    
                    if(bean != null) {
                        if(bean.getStatus() != 30)
                            returnBean.addReturnObject("AdjstCounterSalesOrderBean", getSalesOrderByAdjstID(bean.getSalesID()));
                    } else {
                        returnBean.setSysMessage("Record not found.");
                    }
                    
                    returnBean.addReturnObject("CounterSalesOrderBean", bean);
                    returnBean.addReturnObject("Outlet", getRecord(bean.getSellerID()));
                    if(formSubmitted) {
                        System.out.println("--------Submitted 101007 ");                            
                    }
                    break;
                }
                
                case 101008:
                case 101027:
                case 101028:
                case 101035:
                case 205004:
                case 300031:
                    
                case 101050:
                case 101051:
                case 101052:
                case 101053:
                {
                    returnBean = searchSalesSelection(request);
                    break;
                }
                
                /* Awal
                case 101806:
                {
                    returnBean = searchSummarySalesReport(request);
                    if(TASKID_VIEW_SALES == 0x18a8f)
                        // returnBean = detailSummarySalesReport(productId);
                        //   detailSummarySalesReport(CounterSalesItemBean item);
                 
                        break;
                }
                 
                case 101807:
                {
                    returnBean = searchSummarySalesReportPayment(request);
                    break;
                }
                 
                case 101809:
                case 101808:
                {
                    if(taskId==101809){
                        returnBean = searchSummarySalesReturnReportByBrand(request);
                    }else if(taskId==101808){
                        returnBean = searchSummarySalesReportBrandCategory(request);
                    }
                }
                 */
                
                case 101806: //mila
                {
                    returnBean = new MvcReturnBean();
                    
                    boolean isPrint = request.getParameter("print") != null;
                    boolean isAdminUser = true;
                    Date trxDtFrom = null;
                    Date trxDtTo = null;
                    String trxDtFromStr = request.getParameter("TrxDateFrom");
                    String trxDtToStr = request.getParameter("TrxDateTo");
                    String selection = request.getParameter("selection");
                    SQLConditionsBean cond = new SQLConditionsBean();
                    String conditions = " AND cso.cso_status <>-10 AND csi.csi_unit_price <> 0 AND cso.cso_status<>40 AND cso.cso_status<>50 AND cso.cso_status<>60 AND cso.cso_trxdate between '" + trxDtFromStr +"' AND '"+trxDtToStr +"' ";
                    String orderby = " order by cso_seller_typestatus, pmp_catid, pmp_productcode";
                    String groupby = "  group by pcd.pcd_desc,pm.pmp_producttype";
                    String userOrderby = request.getParameter("OrderBy");
                    String userGroupby = request.getParameter("GroupBy");
                    if(userOrderby != null && userOrderby.length() > 0)
                        orderby = (new StringBuilder(String.valueOf(orderby))).append(",").append(userOrderby).append(" asc").toString();
                    cond.setOrderby(orderby);
                    if(userGroupby != null && userGroupby.length() > 0)
                        groupby = (new StringBuilder(String.valueOf(groupby))).append(",").append(userGroupby).toString();
                    cond.setGroupby(groupby);
                    String limits = request.getParameter("Limits");
                    
                    try {
                        trxDtFrom = (Date) Sys.parseDate(trxDtFromStr);
                    } catch(Exception exception) { }
                    try {
                        trxDtTo = (Date) Sys.parseDate(trxDtToStr);
                    } catch(Exception exception1) { }
                    if(trxDtFrom != null) {
                        java.sql.Date sqlDtFrom = new java.sql.Date(trxDtFrom.getTime());
                        conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxdate >= '").append(sqlDtFrom).append("'").toString();
                    }
                    if(trxDtTo != null) {
                        java.sql.Date sqlDtTo = new java.sql.Date(trxDtTo.getTime());
                        conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso.cso_trxdate <= '").append(sqlDtTo).append("'").toString();
                    }
                    cond.setConditions(conditions);
                    
                    returnBean.addReturnObject("SummarySalesReport", isPrint ? ((Object []) (getSummarySalesReport(cond))) : ((Object []) (getSummarySalesReport(cond))));
                    returnBean.addReturnObject("SummarySalesReportDetail", isPrint ? ((Object [] ) (getSummarySalesReportDetail(cond))) : ((Object []) (getSummarySalesReportDetail(cond))));
                    
                    break;
                }
                
                case 101807://mila
                {
                    returnBean = searchSummarySalesReportPayment(request);
                    break;
                }
                case 101808:
                {
                    returnBean = searchSummarySalesReportBrandCategory(request);
                    break;
                }
                case 101809:
                {
                    returnBean = searchSummarySalesReturnReportByBrand(request);
                    break;
                }
                
                case 101012:
                case 101014:
                {
                    returnBean = searchSalesSelectionDetail(request);
                    break;
                }
                
                case 101009:
                case 101010:
                case 101011:
                case 101015:
                case 205005:
                {
                    returnBean = new MvcReturnBean();
                    boolean next = false;
                    CounterSalesOrderBean originBean = null;
                    String salesID = request.getParameter("SalesID");
                    int nextTaskID = taskId != 0x320cd && taskId != 0x320ce ? 0x18a8f : 0x320cb;
                    if(formSubmitted) {
                        originBean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                        
                        if(taskId == 0x18a97 || taskId == 0x320ce)
                            refundSales(originBean, returnBean, request);
                        else
                            voidSales(originBean, returnBean, request);
                        
                        if(returnBean.getTaskStatus() == 1) {
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(nextTaskID, request)))).append("&SalesID=").append(salesID).toString());
                            next = true;
                        }
                        
                        
                        
                    }
                    
                    if(next)
                        break;
                    
                    if(salesID != null && salesID.trim().length() > 0)
                        originBean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                    
                    //  || (originBean.getTrxGroup() != 10 && originBean.getAdjstRefNo().isEmpty() )
                    
                    if(originBean != null) {
                        
                        if (taskId == 0x18a97 || taskId == 0x320ce)
                            returnBean.addReturnObject("PaymentModeList", getPaymentModeList(originBean.getSellerTypeStatus(), originBean.getSellerID(), originBean.getSellerHomeBranchID()));
                        
                    } else {
                        returnBean.addError("Record not Sales Return ");
                    }
                    
                    returnBean.addReturnObject("CounterSalesOrderBean", originBean);
                    returnBean.addReturnObject("TaskID", String.valueOf(taskId));
                    returnBean.addReturnObject("ConfirmBonusPeriodList", getConfirmedBonusPeriodList());
                    break;
                }
                
                case 101016:
                {
                    returnBean = new MvcReturnBean();
                    boolean next = false;
                    CounterSalesOrderBean originBean = null;
                    String salesID = request.getParameter("SalesID");
                    int nextTaskID = taskId != 0x320cd && taskId != 0x320ce ? 0x18a8f : 0x320cb;
                    if(formSubmitted) {
                        originBean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                        if(taskId == 0x18a98)
                            refundSales(originBean, returnBean, request);
                        else
                            voidSales(originBean, returnBean, request);
                        if(returnBean.getTaskStatus() == 1) {
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(nextTaskID, request)))).append("&SalesID=").append(salesID).toString());
                            next = true;
                        }
                    }
                    if(next)
                        break;
                    if(salesID != null && salesID.trim().length() > 0)
                        originBean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                    if(originBean != null) {
                        if(taskId == 0x18a97 || taskId == 0x320ce)
                            returnBean.addReturnObject("PaymentModeList", getPaymentModeList(originBean.getSellerTypeStatus(), originBean.getSellerID(), originBean.getSellerHomeBranchID()));
                    } else {
                        returnBean.addError("Record not found.");
                    }
                    returnBean.addReturnObject("CounterSalesOrderBean", originBean);
                    returnBean.addReturnObject("TaskID", String.valueOf(taskId));
                    returnBean.addReturnObject("ConfirmBonusPeriodList", getConfirmedBonusPeriodList());
                    break;
                }
                
                case 102001:
                case 205051:
                {
                    returnBean = searchIssueDeliveryList(request);
                    break;
                }
                
                case 101061:
                case 205028:
                case 102002:
                case 205052:
                {
                    returnBean = new MvcReturnBean();
                    returnBean.addReturnObject("TaskID", String.valueOf(taskId));
                    int nextTaskID = 0;
                    boolean next = false;
                    boolean checkInventory = false;
                    boolean combineSales = false;
                    CounterSalesOrderBean salesBean = null;
                    String salesID = request.getParameter("SalesID");
                    switch(taskId) {
                        case 102002:
                            nextTaskID = 0x18e74;
                            checkInventory = false;
                            combineSales = false;
                            break;
                            
                        case 205052:
                            nextTaskID = 0x320fe;
                            checkInventory = false;
                            combineSales = false;
                            break;
                            
                        case 101061:
                            nextTaskID = 0x18a8f;
                            checkInventory = false;
                            combineSales = true;
                            break;
                            
                        case 205028:
                            nextTaskID = 0x320e5;
                            checkInventory = false;
                            combineSales = true;
                            break;
                    }
                    
                    if(formSubmitted) {
                        salesBean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                        issueDeliveryOrder(salesBean, returnBean, request, checkInventory, combineSales, false);
                        if(returnBean.getTaskStatus() == 1) {
                            String newDeliveryID = (String)returnBean.getReturnObject("DeliveryID");
                            request.getSession().removeAttribute("C@8Jb#p985468");
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(nextTaskID, request)))).append("&DeliveryID=").append(newDeliveryID).append("&SalesID=").append(salesID).toString());
                        }
                    }
                    if(next)
                        break;
                    if(salesID != null && salesID.trim().length() > 0)
                        salesBean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                    if(salesBean != null) {
                        fillUpProductBalanceForDelivery(salesBean);
                        returnBean.addReturnObject("CounterSalesOrderBean", salesBean);
                    } else {
                        returnBean.addError("Record not found.");
                    }
                    break;
                }
                
                case 102004:
                case 205054:
                {
                    returnBean = new MvcReturnBean();
                    CounterSalesOrderBean salesBean = null;
                    DeliveryOrderBean doBean = null;
                    DeliveryOrderBean adjstDoBean = null;
                    String deliveryID = request.getParameter("DeliveryID");
                    if(deliveryID != null && deliveryID.trim().length() > 0)
                        doBean = getDeliverySet(new Long(deliveryID), getLoginUser().getLocale().toString());
                    if(doBean != null) {
                        salesBean = getSalesOrderSet(new Long(doBean.getSalesID()), null);
                        returnBean.addReturnObject("CounterSalesOrderBean", salesBean);
                        
                        // returnBean.addReturnObject("Outlet", getRecord(salesBean.getSellerID()));
                        
                        if(doBean.getStatus() == 50)
                            returnBean.addReturnObject("AdjstDeliveryBean", getDeliveryByAdjstDeliveryID(doBean.getDeliveryID()));
                        returnBean.addReturnObject("DeliveryOrderBean", doBean);
                    } else {
                        returnBean.addError("Record not found.");
                    }
                    break;
                }
                
                case 102003:
                case 205053:
                {
                    returnBean = searchDeliverySelection(request);
                    break;
                }
                
                case 102005:
                case 205055:
                {
                    returnBean = new MvcReturnBean();
                    boolean next = false;
                    int nextTaskID = taskId != 0x320ff ? 0x18e74 : 0x320fe;
                    CounterSalesOrderBean salesBean = null;
                    DeliveryOrderBean originBean = null;
                    String deliveryID = request.getParameter("DeliveryID");
                    if(formSubmitted) {
                        originBean = getDeliverySet(new Long(deliveryID), getLoginUser().getLocale().toString());
                        salesBean = getSalesOrderSet(new Long(originBean.getSalesID()), null);
                        voidDelivery(salesBean, originBean, returnBean, request);
                        if(returnBean.getTaskStatus() == 1) {
                            returnBean.setTaskStatus(3);
                            returnBean.setAlternateReturnMethod(2);
                            returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(nextTaskID, request)))).append("&DeliveryID=").append(deliveryID).toString());
                            next = true;
                        }
                    }
                    if(next)
                        break;
                    if(deliveryID != null && deliveryID.trim().length() > 0)
                        originBean = getDeliverySet(new Long(deliveryID), getLoginUser().getLocale().toString());
                    if(originBean != null) {
                        salesBean = getSalesOrderSet(new Long(originBean.getSalesID()), null);
                        returnBean.addReturnObject("CounterSalesOrderBean", salesBean);
                        returnBean.addReturnObject("DeliveryOrderBean", originBean);
                    } else {
                        returnBean.addError("Record not found.");
                    }
                    break;
                }
                
                case 101031:
                case 101032:
                case 101033:
                case 101034:
                case 101040:
                case 101047:
                case 101048:
                case 101049:
                case 205021:
                case 205025:
                {
                    returnBean = new MvcReturnBean();
                    CounterSalesOrderBean bean = null;
                    
                    OutletBean outlet = null;
                    
                    String salesID = request.getParameter("SalesID");
                    if(salesID != null && salesID.trim().length() > 0)
                        bean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                    if(bean != null) {
                        if(taskId == 0x18ab8) {
                            DeliveryOrderBean doBean = getDeliveryByDocNo(bean.getTrxDocNo(), getLoginUser().getLocale().toString());
                            returnBean.addReturnObject("DeliveryOrderBean", doBean);
                        }
                    } else {
                        returnBean.setSysMessage("Record not found.");
                    }
                    returnBean.addReturnObject("CounterSalesOrderBean", bean);
                    
                    returnBean.addReturnObject("Outlet", getRecord(bean.getSellerID()));
                    
                    break;
                }
                
                case 101043:
                case 205022:
                {
                    String salesID = request.getParameter("SalesID");
                    
                    OutletBean outlet = null;
                    
                    if(salesID != null && salesID.trim().length() > 0) {
                        CounterSalesOrderBean bean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                        returnBean = new MvcReturnBean();
                        returnBean.addReturnObject("CounterSalesOrderBean", bean);
                        
                        returnBean.addReturnObject("Outlet", getRecord(bean.getSellerID()));
                    }
                    
                    
                    break;
                }
                
                case 101045:
                case 101046:
                case 205023:
                case 205024:
                {
                    returnBean = new MvcReturnBean();
                    CounterSalesOrderBean bean = null;
                    DeliveryOrderBean doBean = null;
                    DeliveryOrderBean doAdjstBean = null;
                    String salesID = request.getParameter("SalesID");
                    if(salesID != null && salesID.trim().length() > 0)
                        bean = getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                    String deliveryID = request.getParameter("DeliveryID");
                    if(deliveryID != null && deliveryID.trim().length() > 0)
                        doBean = getDeliverySet(new Long(deliveryID), getLoginUser().getLocale().toString());
                    if(doBean != null)
                        doAdjstBean = getDeliverySet(new Long(doBean.getAdjstDeliveryID()), null);
                    else
                        returnBean.setSysMessage("Record not found.");
                    returnBean.addReturnObject("CounterSalesOrderBean", bean);
                    returnBean.addReturnObject("DeliveryOrderBean", doBean);
                    returnBean.addReturnObject("AdjstDeliveyOrderBean", doAdjstBean);
                    
                    returnBean.addReturnObject("Outlet", getRecord(bean.getSellerID()));
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
    
    public double getTypeUnit(String productCode, double unit, double pv, int type) {
        double percentage = 0.0D;
        if(productCode.equalsIgnoreCase("888888") || productCode.equalsIgnoreCase("888889") || productCode.equalsIgnoreCase("888890") || productCode.equalsIgnoreCase("888891")) {
            if(type == 2)
                percentage = 0.59999999999999998D;
            else
                if(type == 3)
                    percentage = 0.40000000000000002D;
        } else
            if(productCode.equalsIgnoreCase("888893") || productCode.equalsIgnoreCase("888894") || productCode.equalsIgnoreCase("888895") || productCode.equalsIgnoreCase("888896") || productCode.equalsIgnoreCase("888897") || productCode.equalsIgnoreCase("888898") || productCode.equalsIgnoreCase("888899")) {
            if(type == 2)
                percentage = 0.29999999999999999D;
            else
                if(type == 3)
                    percentage = 0.69999999999999996D;
            } else
                if(type == 2) {
            if(pv == 0.0D)
                percentage = 1.0D;
            else
                percentage = 0.59999999999999998D;
                } else
                    if(type == 3)
                        if(pv == 0.0D)
                            percentage = 0.0D;
                        else
                            percentage = 0.40000000000000002D;
        return percentage != 0.0D ? unit * percentage : 0.0D;
    }
    
    private MvcReturnBean searchSalesSelectionDetail(HttpServletRequest request)
    throws MvcException {
        MvcReturnBean returnBean = new MvcReturnBean();
        try {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            boolean isPrint = request.getParameter("print") != null;
            boolean isAdminUser = true;
            if(getLoginUser().getUserGroupType() == 10)
                isAdminUser = false;
            if(!isAdminUser)
                formSubmitted = true;
            if(formSubmitted) {
                Date trxDtFrom = null;
                Date trxDtTo = null;
                SQLConditionsBean cond = new SQLConditionsBean();
                String conditions = " where cso_status <> -10 ";
                String orderby = " order by cso_seller_typestatus, pmp_catid, pmp_productcode";
                String userOrderby = request.getParameter("OrderBy");
                if(userOrderby != null && userOrderby.length() > 0)
                    orderby = (new StringBuilder(String.valueOf(orderby))).append(",").append(userOrderby).append(" asc").toString();
                cond.setOrderby(orderby);
                String limits = request.getParameter("Limits");
                if(limits != null && limits.length() > 0)
                    cond.setLimitConditions((new StringBuilder(" limit 0, ")).append(limits).toString());
                String trxDtFromStr = request.getParameter("TrxDateFrom");
                String trxDtToStr = request.getParameter("TrxDateTo");
                try {
                    trxDtFrom = Sys.parseDate(trxDtFromStr);
                } catch(Exception exception) { }
                try {
                    trxDtTo = Sys.parseDate(trxDtToStr);
                } catch(Exception exception1) { }
                if(trxDtFrom != null) {
                    java.sql.Date sqlDtFrom = new java.sql.Date(trxDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdate >= '").append(sqlDtFrom).append("'").toString();
                }
                if(trxDtTo != null) {
                    java.sql.Date sqlDtTo = new java.sql.Date(trxDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdate <= '").append(sqlDtTo).append("'").toString();
                }
                String sellerID = request.getParameter("SellerID");
                if(sellerID == null && isAdminUser)
                    sellerID = getLoginUser().getOutletID();
                if(sellerID != null && sellerID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_sellerid = '").append(sellerID.trim()).append("' ").toString();
                String status = request.getParameter("Status");
                if(status != null && status.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_status = ").append(status).toString();
                String trxDocNo = request.getParameter("TrxDocNo");
                if(trxDocNo != null && trxDocNo.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdocno LIKE '%").append(trxDocNo.trim()).append("%' ").toString();
                
                String trxType = request.getParameter("TrxType");
                if(trxType != null && trxType.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxtype = '").append(trxType.trim()).append("' ").toString();
                String custID = null;
                
                // Apr 2011 tambah Seller type
                String trxSellerType = request.getParameter("TrxSellerType");
                if(trxSellerType != null && trxSellerType.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_seller_typestatus = '").append(trxSellerType.trim()).append("' ").toString();
                
                String category = request.getParameter("CatID");
                if(category != null && category.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and pmp_catid = '").append(category.trim()).append("' ").toString();
                
                if(isAdminUser)
                    custID = request.getParameter("CustomerID");
                else
                    custID = getLoginUser().getUserId();
                if(custID != null && custID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_custid LIKE '%").append(custID.trim()).append("%' ").toString();
                String custName = request.getParameter("CustomerName");
                if(custName != null && custName.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_cust_name LIKE '%").append(custName.trim()).append("%' ").toString();
                String bonusPeriod = request.getParameter("BonusPeriodID");
                if(bonusPeriod != null && bonusPeriod.length() > 0) {
                    String bulan = bonusPeriod.trim().substring(5, 7).toString();
                    String tahun = bonusPeriod.trim().substring(0, 4).toString();
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and year(cso_bonusperiodid) = '").append(tahun.trim()).append("' ").append(" and month(cso_bonusperiodid) = '").append(bulan.trim()).append("' ").toString();
                    System.out.println("Tahun " + tahun + " bulan " + bulan + " conditions " + conditions);
                }
                String doStatus = request.getParameter("DeliveryStatus");
                if(doStatus != null && doStatus.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_delivery_status = ").append(doStatus).toString();
                cond.setConditions(conditions);
                
                // returnBean.addReturnObject("SalesListDetail", isPrint ? ((Object []) (getFullSalesListDetail(cond))) : ((Object []) (getSalesListDetail(cond))));
                returnBean.addReturnObject("SalesListDetail", ((Object []) (getFullSalesListDetail(cond))) );
            }
            
            returnBean.addReturnObject("TrxTypeList", getMapForSalesTypes());
            returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
            
            returnBean.addReturnObject("TrxSellerTypeList", getMapForSalesSellerTypes());
            returnBean.addReturnObject("CatList2", getMapForCategoryTypes());
            
            boolean showAny = isAdminUser;
            returnBean.addReturnObject("BonusPeriodList", getMapForSalesBonusPeriod(showAny));
            returnBean.addReturnObject("ConfirmBonusPeriodList", getConfirmedBonusPeriodList());
            returnBean.addReturnObject("DeliveryStatusList", getMapForSalesDeliveryStatus());
            returnBean.addReturnObject("StatusList", getMapForSalesStatus());
            returnBean.addReturnObject("OrderBy", getMapForSalesOrderBy(isAdminUser));
            returnBean.addReturnObject("ShowRecords", getMapForRecords(false));
            // returnBean.addReturnObject("CatList2", getCat2(showAny));
        }
        
        catch(Exception ex) {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    public CounterSalesOrderBeanDetail[] getFullSalesListDetail(SQLConditionsBean conditions)
    throws MvcException {
        CounterSalesOrderBeanDetail beans[];
        Connection conn;
        beans = EMPTY_SALES_ORDER_ARRAY_DETAIL;
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getFullSalesListDetail(conditions);
            if(!list.isEmpty())
                beans = (CounterSalesOrderBeanDetail[])list.toArray(beans);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }
    
    private FIFOMap getMapForSalesSellerTypes()
    throws Exception {
        FIFOMap map = new FIFOMap();
        map.put("", "Any");
        map.put("O", "Outlet Sales");
        map.put("S", "Stockist Sales");
        return map;
    }
    
    private FIFOMap getMapForCategoryTypes()
    throws Exception {
        FIFOMap map = new FIFOMap();
        map.put("", "ALL");
        map.put("1", "GUOZHEN");
        map.put("2", "KECANTIKAN");
        map.put("3", "BISNIS");
        map.put("4", "PENUNJANG");
        return map;
    }
    
    public CounterSalesOrderBean getSalesTrxDoc(String string) {
        return null;
    }
    
    private boolean updateOutletVoucher(String voucherNo, String customerNo)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).updateOutletVoucher(voucherNo, customerNo);
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean deleteTablePIN(String customerNo)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).deleteTablePIN(customerNo);
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean updateVoidOutletVoucher(String voucherNo)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).updateVoidOutletVoucher(voucherNo);
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
    public CounterSalesPaymentBean[] getPaymentModeList2()
    throws MvcException {
        CounterSalesPaymentBean plist[];
        Connection conn;
        plist = new CounterSalesPaymentBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getPaymentModeList2();
            if(!list.isEmpty())
                plist = (CounterSalesPaymentBean[])list.toArray(new CounterSalesPaymentBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return plist;
    }
    
    
    public OutletBean getRecord(String id)
    throws Exception {
        OutletBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getRecord(id);
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return bean;
    }
    
    // summary sales report
    public CounterSalesItemBean[] getSummarySalesReport(SQLConditionsBean conditions)
    throws MvcException {
        CounterSalesItemBean beans[];
        Connection conn;
        beans = EMPTY_SALES_ITEM_ARRAY;
        conn = null;
        try {
            conn = getConnection();
            ArrayList list2 = getBroker(conn).getSummarySalesReport(conditions);
            if(!list2.isEmpty())
                beans = (CounterSalesItemBean[])list2.toArray(beans);
            //  String earnerName = bean[bean.length].getBonusEarnerName();
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return beans;
    }
    
    public CounterSalesItemBean[] getSummarySalesReportDetail(SQLConditionsBean conditions)
    throws MvcException {
        CounterSalesItemBean beans[];
        Connection conn;
        beans = EMPTY_SALES_ITEM_ARRAY;
        conn = null;
        try{
            conn = getConnection();
            ArrayList list = getBroker(conn).getSummarySalesReportDetail(conditions);
            if(!list.isEmpty())
                beans = (CounterSalesItemBean[])list.toArray(beans);
        }catch(Exception e){
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }
    // summary sales report

    private boolean updateVoucherSerial(CounterSalesOrderBean sales, String query, String keterangan)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).updateVoucherSerial(sales, query, keterangan);
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }

    public boolean updateRemark(String salesID, String remark)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        
        try {
            conn = getConnection();
            status = getBroker(conn).updateRemark(salesID, remark);
            
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
   public String getEreceiptStatus(Long salesID)
    throws MvcException {
        String result;
        Connection conn;
        result = null;
        conn = null;
        
        try {
            conn = getConnection();
            result = getBroker(conn).getEreceiptStatus(salesID);
            
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return result;
    } 
}
